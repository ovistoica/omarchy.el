;;; omarchy.el --- Emacs integration for Omarchy Linux  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ovidiu Stoica

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1"))
;; Keywords: faces, tools, convenience

;;; Commentary:
;;
;; Keeps Emacs' theme and default font synchronized with Omarchy Linux
;; (https://omarchy.org) via the `omarchy-*' CLIs.  Provides interactive
;; pickers over the system's theme/font lists and thin wrappers around
;; common Omarchy toggles (night light, waybar, lock screen, screenshot,
;; terminal at cwd).
;;
;; Usage:
;;
;;   (require 'omarchy)
;;   (setq omarchy-default-theme 'modus-operandi)
;;   (omarchy-init)
;;
;; On non-Omarchy systems the package loads cleanly: interactive commands
;; no-op with a message, and `omarchy-init' applies `omarchy-default-theme'
;; as a fallback.
;;
;; Companion shell hooks in ~/.config/omarchy/hooks/{theme-set,font-set}
;; call back into Emacs via:
;;
;;   emacsclient -e "(omarchy-apply-theme \"$THEME_NAME\")"
;;   emacsclient -e "(omarchy-apply-font  \"$FONT_NAME\")"

;;; Code:

(require 'subr-x)

(defgroup omarchy nil
  "Integration with Omarchy Linux."
  :group 'environment
  :prefix "omarchy-")

;;; Customization

(defcustom omarchy-default-theme nil
  "Fallback Emacs theme symbol when Omarchy is unavailable or lookup fails.
Set this to a theme that is guaranteed to be loadable in your config."
  :type '(choice (const :tag "None" nil) symbol))

(defcustom omarchy-default-font "Iosevka Nerd Font Mono"
  "Fallback font family name when Omarchy reports no current font."
  :type 'string)

(defcustom omarchy-theme-map
  '(("Catppuccin"       . catppuccin-mocha)
    ("Catppuccin Latte" . catppuccin-latte)
    ("Ethereal"         . ethereal)
    ("Everforest"       . everforest)
    ("Flexoki Light"    . flexoki-light)
    ("Gruvbox"          . gruvbox)
    ("Kanagawa"         . kanagawa)
    ("Matte Black"      . matte-black)
    ("Nord"             . nord)
    ("Osaka Jade"       . osaka-jade)
    ("Ristretto"        . ristretto)
    ("Rose Pine"        . rose-pine)
    ("Tokyo Night"      . tokyo-night))
  "Map an Omarchy theme name to an Emacs theme symbol or a thunk.
Keys are the exact display names reported by `omarchy-theme-list'.
Values are either a theme symbol loaded via `load-theme', or a thunk
called for its side effects (useful when a theme needs setup such as
a flavor variable before loading).

All bundled themes in the default value are provided by this package
and derived from Modus via `modus-themes-theme', so they ship with
full Magit/Org/Eglot/tree-sitter coverage out of the box."
  :type '(alist :key-type string :value-type sexp))

;;; Predicates

(defvar omarchy--available nil
  "Cached result of `omarchy-available-p'.")

(defvar omarchy--available-cached nil
  "Non-nil once `omarchy--available' has been computed.")

(defun omarchy-available-p ()
  "Return non-nil if Omarchy CLIs are available on this system."
  (unless omarchy--available-cached
    (setq omarchy--available (and (eq system-type 'gnu/linux)
                                  (executable-find "omarchy-theme-current")
                                  t)
          omarchy--available-cached t))
  omarchy--available)

;;; Shell helpers

(defun omarchy--run (program &rest args)
  "Run PROGRAM with ARGS synchronously and return trimmed stdout, or nil.
Returns nil if PROGRAM is not on PATH."
  (when (executable-find program)
    (with-temp-buffer
      (let ((exit (apply #'call-process program nil t nil args)))
        (when (eq exit 0)
          (let ((out (string-trim (buffer-string))))
            (unless (string-empty-p out) out)))))))

(defun omarchy--run-async (program &rest args)
  "Run PROGRAM with ARGS fully detached from Emacs.
Uses a `setsid'-wrapped shell so child processes the script
backgrounds (e.g. waybar) survive after the script exits."
  (if (executable-find program)
      (let ((cmd (mapconcat #'shell-quote-argument (cons program args) " ")))
        (call-process "setsid" nil 0 nil "sh" "-c"
                      (concat cmd " </dev/null >/dev/null 2>&1 &")))
    (message "omarchy: %s not found on PATH" program)))

;;; State queries

(defun omarchy-current-theme ()
  "Return the theme name currently selected in Omarchy, or nil."
  (omarchy--run "omarchy-theme-current"))

(defun omarchy-current-font ()
  "Return the font family currently selected in Omarchy, or nil."
  (omarchy--run "omarchy-font-current"))

(defun omarchy--split-lines (s)
  "Split S on newlines, dropping empty entries."
  (when s
    (seq-remove #'string-empty-p (split-string s "\n"))))

(defun omarchy-list-themes ()
  "Return the list of Omarchy theme names."
  (omarchy--split-lines (omarchy--run "omarchy-theme-list")))

(defun omarchy-list-fonts ()
  "Return the list of Omarchy font family names."
  (omarchy--split-lines (omarchy--run "omarchy-font-list")))

;;; System-modifying

(defun omarchy-set-theme (name)
  "Ask Omarchy to switch the system theme to NAME.
Omarchy broadcasts the change to its own hooks; if the theme-set hook
calls back into Emacs via emacsclient, `omarchy-apply-theme' will run
once.  Do not call `omarchy-apply-theme' from here."
  (interactive (list (completing-read "Omarchy theme: " (omarchy-list-themes) nil t)))
  (omarchy--run-async "omarchy-theme-set" name))

(defun omarchy-set-font (name)
  "Ask Omarchy to switch the system font to NAME."
  (interactive (list (completing-read "Omarchy font: " (omarchy-list-fonts) nil t)))
  (omarchy--run-async "omarchy-font-set" name))

;;; Apply to Emacs only (entry points for the shell hooks)

(defun omarchy--raw-load-theme (theme)
  "Disable all enabled themes, then load THEME with `no-confirm'."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme :no-confirm))

(defun omarchy--lookup-theme (name)
  "Look up NAME in `omarchy-theme-map', case-insensitively and
with `-' ↔ ` ' equivalence.  Return the mapping value, or nil."
  (let ((norm (lambda (s) (downcase (replace-regexp-in-string "[-_ ]+" " " s)))))
    (cdr (seq-find (lambda (cell) (string= (funcall norm (car cell))
                                           (funcall norm name)))
                   omarchy-theme-map))))

(defun omarchy-apply-theme (theme-spec)
  "Apply THEME-SPEC to Emacs.
THEME-SPEC may be a string (looked up in `omarchy-theme-map'; if absent,
treated as a bare theme name and `intern'ed), a symbol (loaded
directly), or a function (called for side effects)."
  (interactive "sTheme: ")
  (let ((handler (if (stringp theme-spec)
                     (or (omarchy--lookup-theme theme-spec)
                         (intern theme-spec))
                   theme-spec)))
    (condition-case err
        (cond
         ((functionp handler) (funcall handler) (message "Theme set to %s" theme-spec))
         ((symbolp handler)   (omarchy--raw-load-theme handler)
                              (message "Theme set to %s" handler)))
      (error
       (message "omarchy: failed to load theme %S: %s"
                theme-spec (error-message-string err))
       (when omarchy-default-theme
         (omarchy--raw-load-theme omarchy-default-theme))))))

(defun omarchy-apply-font (font &optional height)
  "Set the Emacs default face family to FONT at HEIGHT.
When HEIGHT is omitted, the face's current `:height' is preserved so
that callers such as Fontaine that manage size independently are not
clobbered.  No-op when FONT is not in `font-family-list' (e.g. when
called before a display connection exists)."
  (interactive "sFont: ")
  (when (and font (member font (font-family-list)))
    (set-face-attribute 'default nil
                        :font font
                        :height (or height (face-attribute 'default :height)))
    (message "Font set to %s" font)))

;;; Interactive pickers

(defun omarchy-theme-pick ()
  "Pick a theme from the Omarchy list and apply it system-wide.
On non-Omarchy systems, apply directly to Emacs via
`omarchy-apply-theme' on the picked name."
  (interactive)
  (if (omarchy-available-p)
      (omarchy-set-theme
       (completing-read "Omarchy theme: " (omarchy-list-themes) nil t))
    (omarchy-apply-theme
     (completing-read "Theme: "
                      (mapcar #'car omarchy-theme-map)
                      nil t))))

(defun omarchy-font-pick ()
  "Pick a font from the Omarchy list and apply it system-wide.
On non-Omarchy systems, apply directly to Emacs."
  (interactive)
  (if (omarchy-available-p)
      (omarchy-set-font
       (completing-read "Omarchy font: " (omarchy-list-fonts) nil t))
    (omarchy-apply-font
     (read-string "Font: " omarchy-default-font))))

;;; Quick toggles / commands

(defun omarchy-toggle-nightlight ()
  "Toggle the Omarchy night-light filter."
  (interactive)
  (omarchy--run-async "omarchy-toggle-nightlight"))

(defun omarchy-toggle-waybar ()
  "Toggle the Omarchy Waybar status bar."
  (interactive)
  (omarchy--run-async "omarchy-toggle-waybar"))

(defun omarchy-screenshot ()
  "Invoke the Omarchy screenshot command."
  (interactive)
  (omarchy--run-async "omarchy-cmd-screenshot"))

(defun omarchy-lock-screen ()
  "Lock the screen via Omarchy."
  (interactive)
  (omarchy--run-async "omarchy-lock-screen"))

(defun omarchy-terminal-at-cwd ()
  "Open a terminal in the current buffer's directory via Omarchy."
  (interactive)
  (let ((default-directory (or (and buffer-file-name
                                    (file-name-directory buffer-file-name))
                               default-directory)))
    (omarchy--run-async "omarchy-cmd-terminal-cwd")))

;;; Shell hook installation

(defcustom omarchy-hooks-directory
  (expand-file-name "omarchy/hooks" (or (getenv "XDG_CONFIG_HOME") "~/.config"))
  "Directory where Omarchy looks for `theme-set' and `font-set' hooks."
  :type 'directory)

(defconst omarchy--hook-script-template
  "#!/usr/bin/env bash
# %s
# Managed by omarchy.el — safe to edit, but `M-x omarchy-install-hooks'
# will overwrite this file.  Omarchy invokes the script with the new
# %s as $1; forward that to any running Emacs server.

NAME=\"$1\"

if command -v emacsclient >/dev/null 2>&1 && pgrep -x emacs >/dev/null; then
    emacsclient -e \"(%s \\\"$NAME\\\")\" >/dev/null 2>&1
fi
"
  "Bash template used to generate theme-set / font-set hook scripts.
The three %s placeholders receive (1) a human-readable hook name,
(2) the argument description, and (3) the Emacs function to call.")

(defun omarchy--write-hook (filename description arg-name fn)
  "Write FILENAME in `omarchy-hooks-directory' calling FN via emacsclient.
DESCRIPTION is the first comment line; ARG-NAME labels the argument.
Creates the directory if needed and makes the script executable.
Returns the full path written."
  (let ((path (expand-file-name filename omarchy-hooks-directory)))
    (make-directory omarchy-hooks-directory :parents)
    (with-temp-file path
      (insert (format omarchy--hook-script-template description arg-name fn)))
    (set-file-modes path #o755)
    path))

;;;###autoload
(defun omarchy-install-hooks ()
  "Install shell hook scripts that forward Omarchy theme/font changes to Emacs.
Writes two executable files in `omarchy-hooks-directory':

  theme-set   calls `omarchy-apply-theme' with the new theme name.
  font-set    calls `omarchy-apply-font'  with the new font name.

Overwrites existing files.  Returns the list of paths written."
  (interactive)
  (let ((theme-hook (omarchy--write-hook
                     "theme-set"
                     "Omarchy theme-set hook for Emacs integration"
                     "theme name" "omarchy-apply-theme"))
        (font-hook  (omarchy--write-hook
                     "font-set"
                     "Omarchy font-set hook for Emacs integration"
                     "font family" "omarchy-apply-font")))
    (message "omarchy: installed hooks in %s" omarchy-hooks-directory)
    (list theme-hook font-hook)))

;;; Entry point

(defun omarchy--sync-from-system ()
  "Apply the current Omarchy font and theme to Emacs.
Safe to call only once a display connection exists (otherwise
`omarchy-apply-font' will silently skip)."
  (when-let* ((font (omarchy-current-font)))
    (omarchy-apply-font font))
  (when-let* ((theme (omarchy-current-theme)))
    (omarchy-apply-theme theme)))

(defun omarchy--daemon-first-frame-sync ()
  "Run `omarchy--sync-from-system' once a graphical frame attaches.
Self-removes after the first successful run.  Needed in daemon mode
where `font-family-list' is empty until a client frame brings a
display connection."
  (when (display-graphic-p)
    (remove-hook 'server-after-make-frame-hook
                 #'omarchy--daemon-first-frame-sync)
    (omarchy--sync-from-system)))

;;;###autoload
(defun omarchy-init ()
  "Initialize Omarchy integration.
On non-Omarchy systems apply `omarchy-default-theme' and return.
In daemon mode defer the sync until the first graphical frame attaches.
Otherwise sync immediately."
  (cond
   ((not (omarchy-available-p))
    (when omarchy-default-theme
      (omarchy--raw-load-theme omarchy-default-theme)))
   ((and (daemonp) (not (display-graphic-p)))
    (add-hook 'server-after-make-frame-hook
              #'omarchy--daemon-first-frame-sync))
   (t
    (omarchy--sync-from-system))))

(provide 'omarchy)
;;; omarchy.el ends here

;;; hackerman-theme.el --- Hackerman, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Hackerman for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 hackerman theme
;; (/usr/share/omarchy/themes/hackerman/colors.toml), whose upstream
;; Neovim counterpart is bjarneo/hackerman.nvim.
;;
;; A green-on-near-black "terminal" palette: every ANSI slot upstream is
;; a shade of green or cyan, with two desaturated blues (blue/magenta)
;; as the only cool accents.  Because upstream's `red' is itself green,
;; a soft red (`hack-alert') is derived here for diagnostics and diff
;; removals -- otherwise errors would be indistinguishable from success.

;;; Code:

(require 'omarchy-themes)

(defconst hackerman-palette-partial
  '(;; Core surfaces
    (bg-main       "#0b0c16")  ; background
    (bg-dim        "#06060c")  ; darker_background
    (bg-alt        "#151828")  ; lighter_background
    (bg-active     "#1f253a")  ; selection
    (bg-inactive   "#080910")  ; dark_background
    (border        "#2d3450")  ; muted

    ;; Foregrounds
    (fg-main       "#ddf7ff")  ; foreground
    (fg-dim        "#6a6e95")  ; dark_foreground
    (fg-alt        "#b5c5db")  ; light_foreground
    (cursor        "#ddf7ff")  ; bright_foreground

    ;; Hackerman named slots
    (hack-accent   "#82fb9c")  ; accent
    (hack-green    "#4fe88f")
    (hack-mint     "#50f7a3")  ; orange
    (hack-teal     "#50f7d4")  ; yellow
    (hack-cyan     "#7cf8f7")
    (hack-blue     "#829dd4")
    (hack-magenta  "#86a7df")
    (hack-lime     "#50f872")  ; red
    (hack-moss     "#287b51")  ; brown
    (hack-comment  "#6a6e95")
    (hack-alert    "#e0736b")  ; derived: no warm colour upstream

    ;; Modus primary color slots
    (red           "#50f872")
    (red-warmer    "#50f7a3")
    (red-cooler    "#4fe88f")
    (red-faint     "#287b51")
    (red-intense   "#85ff9d")
    (green         "#4fe88f")
    (green-warmer  "#50f7a3")
    (green-cooler  "#50f7d4")
    (green-faint   "#287b51")
    (green-intense "#9cf7c2")
    (yellow        "#50f7d4")
    (yellow-warmer "#50f7a3")
    (yellow-cooler "#7cf8f7")
    (yellow-faint  "#287b51")
    (yellow-intense "#a4ffec")
    (blue          "#829dd4")
    (blue-warmer   "#86a7df")
    (blue-cooler   "#7cf8f7")
    (blue-faint    "#6a6e95")
    (blue-intense  "#c4d2ed")
    (magenta       "#86a7df")
    (magenta-warmer "#86a7df")
    (magenta-cooler "#829dd4")
    (magenta-faint "#6a6e95")
    (magenta-intense "#cddbf4")
    (cyan          "#7cf8f7")
    (cyan-warmer   "#50f7d4")
    (cyan-cooler   "#829dd4")
    (cyan-faint    "#287b51")
    (cyan-intense  "#d1fffe")

    ;; Diff backgrounds
    (bg-added            "#17342c")
    (bg-added-faint      "#122222")
    (bg-added-refine     "#1f4e3a")
    (bg-added-intense    "#286849")
    (fg-added            "#4fe88f")
    (fg-added-intense    "#8fefc1")

    (bg-removed          "#311f25")
    (bg-removed-faint    "#20161e")
    (bg-removed-refine   "#4b2b30")
    (bg-removed-intense  "#64373a")
    (fg-removed          "#e0736b")
    (fg-removed-intense  "#dfaeae")

    (bg-changed          "#202638")
    (bg-changed-faint    "#171a29")
    (bg-changed-refine   "#2f384f")
    (bg-changed-intense  "#3d4966")
    (fg-changed          "#829dd4")
    (fg-changed-intense  "#abc6e7"))
  "Hackerman base colors, in Modus palette format.")

(defconst hackerman-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         hack-accent)
    (builtin         hack-cyan)
    (constant        hack-teal)
    (fnname          hack-blue)
    (fnname-call     hack-blue)
    (name            hack-blue)
    (type            hack-mint)
    (variable        hack-magenta)
    (variable-use    hack-magenta)
    (identifier      hack-magenta)
    (property        hack-cyan)
    (property-use    hack-cyan)
    (string          hack-green)
    (docstring       hack-moss)
    (comment         hack-comment)
    (preprocessor    hack-cyan)
    (operator        fg-main)
    (punctuation     fg-alt)
    (rx-construct    hack-teal)
    (rx-backslash    hack-cyan)

    ;; ---- Status / diagnostics ----
    (err             hack-alert)
    (warning         hack-teal)
    (info            hack-blue)
    (note            hack-cyan)
    (success         hack-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              hack-alert)
    (modeline-warning          hack-teal)
    (modeline-info             hack-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     hack-accent)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            hack-accent)
    (bg-search-current         hack-green)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      hack-blue)
    (link-symbolic             hack-cyan)
    (cursor                    hack-accent)
    (prompt                    hack-accent)

    ;; ---- Headings ----
    (fg-heading-0              hack-accent)
    (fg-heading-1              hack-green)
    (fg-heading-2              hack-cyan)
    (fg-heading-3              hack-blue)
    (fg-heading-4              hack-mint)
    (fg-heading-5              hack-teal)
    (fg-heading-6              hack-magenta)
    (fg-heading-7              hack-lime)
    (fg-heading-8              fg-alt))
  "Semantic slot mappings for Hackerman.")

(defconst hackerman-palette
  (modus-themes-generate-palette
   hackerman-palette-partial
   nil
   modus-themes-vivendi-palette
   hackerman-palette-mappings-partial)
  "Complete Hackerman palette for use with `modus-themes-theme'.")

(defcustom hackerman-palette-overrides nil
  "User-level palette overrides for the Hackerman theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar hackerman-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,hack-magenta :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,hack-magenta :slant normal)))
    `(help-argument-name           ((,c :foreground ,hack-magenta :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar hackerman-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'hackerman
   'omarchy-themes
   "Hackerman, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'hackerman-palette
   'hackerman-palette-overrides
   'hackerman-custom-faces
   'hackerman-custom-variables)

(provide 'hackerman-theme)
;;; hackerman-theme.el ends here

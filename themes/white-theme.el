;;; white-theme.el --- White, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; White for Emacs, derived from Modus Operandi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 white theme
;; (/usr/share/omarchy/themes/white/colors.toml), which ships no editor
;; plugin of its own.
;;
;; Pure #ffffff paper with pure #000000 text (contrast 21:1); syntax is
;; a ladder of near-black grays (#1a1a1a to #4a4a4a) with #6e6e6e
;; comments, all at 5:1 or better against the background.  Upstream's
;; `light_foreground'/`bright_foreground' are both #000000, so `fg-alt'
;; is derived one step lighter.  Diagnostics and diffs use two derived,
;; heavily desaturated signal colours (`wh-alert', `wh-ok') so errors
;; and diff hunks remain distinguishable in an achromatic theme.

;;; Code:

(require 'omarchy-themes)

(defconst white-palette-partial
  '(;; Core surfaces
    (bg-main       "#ffffff")  ; background
    (bg-dim        "#f5f5f5")  ; dark_background
    (bg-alt        "#e8e8e8")  ; darker_background
    (bg-active     "#c0c0c0")  ; selection / lighter_background
    (bg-inactive   "#f5f5f5")
    (border        "#c0c0c0")

    ;; Foregrounds
    (fg-main       "#000000")  ; foreground
    (fg-dim        "#808080")  ; muted
    (fg-alt        "#333333")  ; derived: light_foreground == foreground
    (cursor        "#000000")  ; bright_foreground

    ;; White named slots
    (wh-blue       "#1a1a1a")
    (wh-red        "#2a2a2a")
    (wh-magenta    "#2e2e2e")
    (wh-green      "#3a3a3a")
    (wh-cyan       "#3e3e3e")
    (wh-yellow     "#4a4a4a")
    (wh-accent     "#6e6e6e")
    (wh-comment    "#6e6e6e")
    (wh-muted      "#808080")
    (wh-alert      "#8f2f2f")  ; derived signal colour
    (wh-ok         "#2f6a3f")  ; derived signal colour

    ;; Modus primary color slots
    (red           "#2a2a2a")
    (red-warmer    "#2e2e2e")
    (red-cooler    "#1a1a1a")
    (red-faint     "#666666")
    (red-intense   "#1b1b1b")
    (green         "#3a3a3a")
    (green-warmer  "#4a4a4a")
    (green-cooler  "#3e3e3e")
    (green-faint   "#717171")
    (green-intense "#262626")
    (yellow        "#4a4a4a")
    (yellow-warmer "#4a4a4a")
    (yellow-cooler "#3e3e3e")
    (yellow-faint  "#7d7d7d")
    (yellow-intense "#303030")
    (blue          "#1a1a1a")
    (blue-warmer   "#2e2e2e")
    (blue-cooler   "#1a1a1a")
    (blue-faint    "#5a5a5a")
    (blue-intense  "#111111")
    (magenta       "#2e2e2e")
    (magenta-warmer "#2a2a2a")
    (magenta-cooler "#1a1a1a")
    (magenta-faint "#696969")
    (magenta-intense "#1e1e1e")
    (cyan          "#3e3e3e")
    (cyan-warmer   "#4a4a4a")
    (cyan-cooler   "#3a3a3a")
    (cyan-faint    "#747474")
    (cyan-intense  "#282828")

    ;; Diff backgrounds
    (bg-added            "#e6ede8")
    (bg-added-faint      "#f3f6f3")
    (bg-added-refine     "#d1ded5")
    (bg-added-intense    "#bccfc2")
    (fg-added            "#2f6a3f")
    (fg-added-intense    "#1a3a23")

    (bg-removed          "#f2e6e6")
    (bg-removed-faint    "#f8f3f3")
    (bg-removed-refine   "#e6d1d1")
    (bg-removed-intense  "#dbbcbc")
    (fg-removed          "#8f2f2f")
    (fg-removed-intense  "#4f1a1a")

    (bg-changed          "#e6eaf2")
    (bg-changed-faint    "#f3f4f8")
    (bg-changed-refine   "#d1d8e6")
    (bg-changed-intense  "#bcc7db")
    (fg-changed          "#2f4f8f")
    (fg-changed-intense  "#1a2b4f"))
  "White base colors, in Modus palette format.")

(defconst white-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         wh-blue)
    (builtin         wh-cyan)
    (constant        wh-magenta)
    (fnname          wh-red)
    (fnname-call     wh-red)
    (name            wh-red)
    (type            wh-cyan)
    (variable        fg-main)
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        wh-yellow)
    (property-use    wh-yellow)
    (string          wh-green)
    (docstring       wh-accent)
    (comment         wh-comment)
    (preprocessor    wh-magenta)
    (operator        fg-main)
    (punctuation     wh-yellow)
    (rx-construct    wh-cyan)
    (rx-backslash    wh-red)

    ;; ---- Status / diagnostics ----
    (err             wh-alert)
    (warning         wh-yellow)
    (info            wh-blue)
    (note            wh-cyan)
    (success         wh-ok)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-alt)
    (modeline-err              wh-alert)
    (modeline-warning          wh-yellow)
    (modeline-info             wh-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   wh-muted)
    (fg-line-number-active     fg-main)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-dim)
    (bg-paren-match            bg-active)
    (fg-paren-match            fg-main)
    (bg-search-current         bg-active)
    (bg-search-lazy            bg-alt)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      wh-blue)
    (link-symbolic             wh-cyan)
    (cursor                    fg-main)
    (prompt                    wh-blue)

    ;; ---- Headings ----
    (fg-heading-0              fg-main)
    (fg-heading-1              wh-blue)
    (fg-heading-2              wh-red)
    (fg-heading-3              wh-magenta)
    (fg-heading-4              wh-green)
    (fg-heading-5              wh-cyan)
    (fg-heading-6              wh-yellow)
    (fg-heading-7              wh-accent)
    (fg-heading-8              fg-alt))
  "Semantic slot mappings for White.")

(defconst white-palette
  (modus-themes-generate-palette
   white-palette-partial
   nil
   modus-themes-operandi-palette
   white-palette-mappings-partial)
  "Complete White palette for use with `modus-themes-theme'.")

(defcustom white-palette-overrides nil
  "User-level palette overrides for the White theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar white-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar white-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'white
   'omarchy-themes
   "White, derived from Modus Operandi."
   'light
   'modus-themes-operandi-palette
   'white-palette
   'white-palette-overrides
   'white-custom-faces
   'white-custom-variables)

(provide 'white-theme)
;;; white-theme.el ends here

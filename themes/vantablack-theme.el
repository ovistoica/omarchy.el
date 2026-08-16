;;; vantablack-theme.el --- Vantablack, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Vantablack for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 vantablack theme
;; (/usr/share/omarchy/themes/vantablack/colors.toml), which ships no
;; editor plugin of its own.
;;
;; Pure #000000 canvas with pure #ffffff text (contrast 21:1); syntax is
;; a ladder of grays from #ececec down to #7a7a7a, all at 4.8:1 or
;; better against the background.  Upstream has no `bg' step below
;; #000000 and repeats `selection' as `lighter_background', so `bg-alt'
;; is derived a notch below `selection' to keep the region visible over
;; `hl-line'.  Diagnostics and diffs use two derived, heavily
;; desaturated signal colours (`vb-alert', `vb-ok') so errors and diff
;; hunks remain distinguishable in an otherwise achromatic theme.

;;; Code:

(require 'omarchy-themes)

(defconst vantablack-palette-partial
  '(;; Core surfaces
    (bg-main       "#000000")  ; background
    (bg-dim        "#070707")  ; darker_background
    (bg-alt        "#111111")  ; derived: lighter_background == selection
    (bg-active     "#1a1a1a")  ; selection
    (bg-inactive   "#090909")  ; dark_background
    (border        "#505050")  ; dark_foreground

    ;; Foregrounds
    (fg-main       "#ffffff")  ; foreground
    (fg-dim        "#7a7a7a")  ; muted
    (fg-alt        "#ececec")  ; light_foreground
    (cursor        "#ffffff")  ; bright_foreground

    ;; Vantablack named slots
    (vb-silver     "#ececec")
    (vb-yellow     "#cecece")
    (vb-orange     "#b9b9b9")
    (vb-green      "#b6b6b6")
    (vb-cyan       "#b0b0b0")
    (vb-red        "#a4a4a4")
    (vb-magenta    "#9b9b9b")
    (vb-blue       "#8d8d8d")  ; accent
    (vb-comment    "#7a7a7a")  ; muted
    (vb-brown      "#5c5c5c")
    (vb-alert      "#c98a8a")  ; derived signal colour
    (vb-ok         "#8fbf9f")  ; derived signal colour

    ;; Modus primary color slots
    (red           "#a4a4a4")
    (red-warmer    "#b9b9b9")
    (red-cooler    "#9b9b9b")
    (red-faint     "#767676")
    (red-intense   "#c4c4c4")
    (green         "#b6b6b6")
    (green-warmer  "#cecece")
    (green-cooler  "#b0b0b0")
    (green-faint   "#838383")
    (green-intense "#d0d0d0")
    (yellow        "#cecece")
    (yellow-warmer "#b9b9b9")
    (yellow-cooler "#b0b0b0")
    (yellow-faint  "#949494")
    (yellow-intense "#dfdfdf")
    (blue          "#8d8d8d")
    (blue-warmer   "#9b9b9b")
    (blue-cooler   "#b0b0b0")
    (blue-faint    "#666666")
    (blue-intense  "#b5b5b5")
    (magenta       "#9b9b9b")
    (magenta-warmer "#b9b9b9")
    (magenta-cooler "#8d8d8d")
    (magenta-faint "#707070")
    (magenta-intense "#bebebe")
    (cyan          "#b0b0b0")
    (cyan-warmer   "#b6b6b6")
    (cyan-cooler   "#8d8d8d")
    (cyan-faint    "#7f7f7f")
    (cyan-intense  "#cccccc")

    ;; Diff backgrounds
    (bg-added            "#1a221d")
    (bg-added-faint      "#0e1310")
    (bg-added-refine     "#2b3930")
    (bg-added-intense    "#3c5043")
    (fg-added            "#8fbf9f")
    (fg-added-intense    "#c1dcca")

    (bg-removed          "#241919")
    (bg-removed-faint    "#140e0e")
    (bg-removed-refine   "#3c2929")
    (bg-removed-intense  "#543a3a")
    (fg-removed          "#c98a8a")
    (fg-removed-intense  "#e1bfbf")

    (bg-changed          "#1a1e24")
    (bg-changed-faint    "#0e1114")
    (bg-changed-refine   "#2b323c")
    (bg-changed-intense  "#3c4754")
    (fg-changed          "#8fa8c9")
    (fg-changed-intense  "#c1cfe1"))
  "Vantablack base colors, in Modus palette format.")

(defconst vantablack-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         vb-yellow)
    (builtin         vb-cyan)
    (constant        vb-orange)
    (fnname          vb-silver)
    (fnname-call     vb-silver)
    (name            vb-silver)
    (type            vb-cyan)
    (variable        fg-main)
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        vb-magenta)
    (property-use    vb-magenta)
    (string          vb-green)
    (docstring       vb-comment)
    (comment         vb-comment)
    (preprocessor    vb-blue)
    (operator        fg-main)
    (punctuation     vb-magenta)
    (rx-construct    vb-orange)
    (rx-backslash    vb-yellow)

    ;; ---- Status / diagnostics ----
    (err             vb-alert)
    (warning         vb-yellow)
    (info            vb-blue)
    (note            vb-cyan)
    (success         vb-ok)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-alt)
    (modeline-err              vb-alert)
    (modeline-warning          vb-yellow)
    (modeline-info             vb-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   vb-brown)
    (fg-line-number-active     vb-silver)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            fg-main)
    (bg-search-current         vb-silver)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      vb-cyan)
    (link-symbolic             vb-blue)
    (cursor                    fg-main)
    (prompt                    vb-silver)

    ;; ---- Headings ----
    (fg-heading-0              fg-main)
    (fg-heading-1              vb-silver)
    (fg-heading-2              vb-yellow)
    (fg-heading-3              vb-orange)
    (fg-heading-4              vb-green)
    (fg-heading-5              vb-cyan)
    (fg-heading-6              vb-magenta)
    (fg-heading-7              vb-red)
    (fg-heading-8              vb-blue))
  "Semantic slot mappings for Vantablack.")

(defconst vantablack-palette
  (modus-themes-generate-palette
   vantablack-palette-partial
   nil
   modus-themes-vivendi-palette
   vantablack-palette-mappings-partial)
  "Complete Vantablack palette for use with `modus-themes-theme'.")

(defcustom vantablack-palette-overrides nil
  "User-level palette overrides for the Vantablack theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar vantablack-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar vantablack-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'vantablack
   'omarchy-themes
   "Vantablack, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'vantablack-palette
   'vantablack-palette-overrides
   'vantablack-custom-faces
   'vantablack-custom-variables)

(provide 'vantablack-theme)
;;; vantablack-theme.el ends here

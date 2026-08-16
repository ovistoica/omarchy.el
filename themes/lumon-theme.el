;;; lumon-theme.el --- Lumon, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Lumon for Emacs, derived from Modus Vivendi via `modus-themes-theme'.
;; Mirrors the Omarchy 4 lumon theme
;; (/usr/share/omarchy/themes/lumon/colors.toml), whose upstream Neovim
;; counterpart is omacom-io/lumon.nvim.
;;
;; Every upstream ANSI slot is a shade of Lumon blue, so syntax stays
;; monochromatic by design.  Two off-palette signal colours (`lum-alert'
;; and `lum-ok') are derived here for diagnostics and diffs, which would
;; otherwise be indistinguishable from ordinary text.

;;; Code:

(require 'omarchy-themes)

(defconst lumon-palette-partial
  '(;; Core surfaces
    (bg-main       "#16242d")  ; background
    (bg-dim        "#0b1216")  ; darker_background
    (bg-alt        "#1b2d40")  ; lighter_background
    (bg-active     "#243d56")  ; selection
    (bg-inactive   "#101b21")  ; dark_background
    (border        "#304860")  ; muted

    ;; Foregrounds
    (fg-main       "#d6e2ee")  ; foreground
    (fg-dim        "#4d86b0")  ; dark_foreground
    (fg-alt        "#98b8d2")  ; derived: light_foreground == foreground
    (cursor        "#f2fcff")  ; bright_foreground

    ;; Lumon named slots
    (lum-accent    "#8bc9eb")  ; accent / orange / magenta
    (lum-blue      "#6fb8e3")  ; blue / active_tab_background
    (lum-cyan      "#b4e4f6")
    (lum-sky       "#6fa4c9")  ; yellow
    (lum-steel     "#5e95bc")  ; green
    (lum-deep      "#4d86b0")  ; red / dark_foreground
    (lum-slate     "#456475")  ; brown
    (lum-glow      "#f2fcff")  ; bright_blue / active_border_color
    (lum-alert     "#d98a80")  ; derived: no warm colour upstream
    (lum-ok        "#6fbf9a")  ; derived: no green upstream

    ;; Modus primary color slots
    (red           "#4d86b0")
    (red-warmer    "#5e95bc")
    (red-cooler    "#4d86b0")
    (red-faint     "#3e6b8b")
    (red-intense   "#73a6cb")
    (green         "#5e95bc")
    (green-warmer  "#6fa4c9")
    (green-cooler  "#6fb8e3")
    (green-faint   "#456475")
    (green-intense "#86b7d8")
    (yellow        "#6fa4c9")
    (yellow-warmer "#8bc9eb")
    (yellow-cooler "#6fb8e3")
    (yellow-faint  "#456475")
    (yellow-intense "#9dcae5")
    (blue          "#6fb8e3")
    (blue-warmer   "#8bc9eb")
    (blue-cooler   "#b4e4f6")
    (blue-faint    "#4d86b0")
    (blue-intense  "#f2fcff")
    (magenta       "#8bc9eb")
    (magenta-warmer "#8bc9eb")
    (magenta-cooler "#6fb8e3")
    (magenta-faint "#4d86b0")
    (magenta-intense "#b1d8ee")
    (cyan          "#b4e4f6")
    (cyan-warmer   "#8bc9eb")
    (cyan-cooler   "#6fb8e3")
    (cyan-faint    "#456475")
    (cyan-intense  "#d1eef8")

    ;; Diff backgrounds
    (bg-added            "#264041")
    (bg-added-faint      "#1f3438")
    (bg-added-refine     "#31524e")
    (bg-added-intense    "#3b655b")
    (fg-added            "#6fbf9a")
    (fg-added-intense    "#9dcfc0")

    (bg-removed          "#39363c")
    (bg-removed-faint    "#2a2e35")
    (bg-removed-refine   "#504346")
    (bg-removed-intense  "#684f50")
    (fg-removed          "#d98a80")
    (fg-removed-intense  "#d8b2b2")

    (bg-changed          "#263f4e")
    (bg-changed-faint    "#1f333f")
    (bg-changed-refine   "#315064")
    (bg-changed-intense  "#3b6279")
    (fg-changed          "#6fb8e3")
    (fg-changed-intense  "#9dcbe8"))
  "Lumon base colors, in Modus palette format.")

(defconst lumon-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         lum-accent)
    (builtin         lum-cyan)
    (constant        lum-cyan)
    (fnname          lum-blue)
    (fnname-call     lum-blue)
    (name            lum-blue)
    (type            lum-sky)
    (variable        fg-alt)
    (variable-use    fg-alt)
    (identifier      fg-alt)
    (property        lum-sky)
    (property-use    lum-sky)
    (string          lum-steel)
    (docstring       lum-steel)
    (comment         lum-deep)
    (preprocessor    lum-accent)
    (operator        fg-main)
    (punctuation     fg-alt)
    (rx-construct    lum-cyan)
    (rx-backslash    lum-accent)

    ;; ---- Status / diagnostics ----
    (err             lum-alert)
    (warning         lum-accent)
    (info            lum-blue)
    (note            lum-cyan)
    (success         lum-ok)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              lum-alert)
    (modeline-warning          lum-accent)
    (modeline-info             lum-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     lum-accent)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            lum-glow)
    (bg-search-current         lum-blue)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      lum-blue)
    (link-symbolic             lum-cyan)
    (cursor                    lum-glow)
    (prompt                    lum-accent)

    ;; ---- Headings ----
    (fg-heading-0              lum-glow)
    (fg-heading-1              lum-accent)
    (fg-heading-2              lum-blue)
    (fg-heading-3              lum-cyan)
    (fg-heading-4              lum-steel)
    (fg-heading-5              lum-sky)
    (fg-heading-6              fg-alt)
    (fg-heading-7              lum-deep)
    (fg-heading-8              lum-cyan))
  "Semantic slot mappings for Lumon.")

(defconst lumon-palette
  (modus-themes-generate-palette
   lumon-palette-partial
   nil
   modus-themes-vivendi-palette
   lumon-palette-mappings-partial)
  "Complete Lumon palette for use with `modus-themes-theme'.")

(defcustom lumon-palette-overrides nil
  "User-level palette overrides for the Lumon theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar lumon-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-alt :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-alt :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-alt :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar lumon-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'lumon
   'omarchy-themes
   "Lumon, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'lumon-palette
   'lumon-palette-overrides
   'lumon-custom-faces
   'lumon-custom-variables)

(provide 'lumon-theme)
;;; lumon-theme.el ends here

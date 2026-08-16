;;; last-horizon-theme.el --- Last Horizon, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Last Horizon for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 last-horizon theme
;; (/usr/share/omarchy/themes/last-horizon/colors.toml), whose editor
;; counterpart upstream is rikkarth's "Ship at Sea".
;;
;; A near-black canvas with a small, low-saturation set of dusk colours:
;; a rose accent, a warm salmon, muted teal, lavender and pale sky blue.
;; Upstream ships no `orange'/`brown' and repeats every colour in its
;; `bright_*' slots, so the Modus `-intense' variants are lightened
;; toward the foreground and the `-faint' ones darkened toward the
;; background.

;;; Code:

(require 'omarchy-themes)

(defconst last-horizon-palette-partial
  '(;; Core surfaces
    (bg-main       "#0c0b0c")  ; background
    (bg-dim        "#060606")  ; darker_background
    (bg-alt        "#1a1718")  ; derived: lighter_background == background
    (bg-active     "#584e51")  ; selection
    (bg-inactive   "#090809")  ; dark_background
    (border        "#584e51")  ; muted

    ;; Foregrounds
    (fg-main       "#fafcfb")  ; foreground
    (fg-dim        "#584e51")  ; dark_foreground
    (fg-alt        "#cfd3cd")  ; light_foreground
    (cursor        "#e2dddc")  ; bright_foreground

    ;; Last Horizon named slots
    (lh-rose       "#b59790")  ; accent / blue
    (lh-red        "#c38b7b")
    (lh-plum       "#6b5e73")  ; yellow
    (lh-teal       "#87a9b0")  ; green
    (lh-lavender   "#a5a0b6")  ; cyan / active_tab_background
    (lh-sky        "#c4d8e2")  ; magenta
    (lh-slate      "#8a8588")  ; hyprland active border
    (lh-mist       "#d6d3de")  ; active_border_color
    (lh-comment    "#584e51")

    ;; Modus primary color slots
    (red           "#c38b7b")
    (red-warmer    "#c38b7b")
    (red-cooler    "#b59790")
    (red-faint     "#90675c")
    (red-intense   "#d6b3a8")
    (green         "#87a9b0")
    (green-warmer  "#87a9b0")
    (green-cooler  "#a5a0b6")
    (green-faint   "#657d82")
    (green-intense "#afc6ca")
    (yellow        "#6b5e73")
    (yellow-warmer "#b59790")
    (yellow-cooler "#6b5e73")
    (yellow-faint  "#504756")
    (yellow-intense "#9d95a3")
    (blue          "#b59790")
    (blue-warmer   "#c38b7b")
    (blue-cooler   "#a5a0b6")
    (blue-faint    "#86706b")
    (blue-intense  "#cdbab5")
    (magenta       "#c4d8e2")
    (magenta-warmer "#a5a0b6")
    (magenta-cooler "#c4d8e2")
    (magenta-faint "#909fa6")
    (magenta-intense "#d7e5eb")
    (cyan          "#a5a0b6")
    (cyan-warmer   "#c4d8e2")
    (cyan-cooler   "#87a9b0")
    (cyan-faint    "#7a7686")
    (cyan-intense  "#c3c0ce")

    ;; Diff backgrounds
    (bg-added            "#22272a")
    (bg-added-faint      "#181b1c")
    (bg-added-refine     "#313a3d")
    (bg-added-intense    "#404d51")
    (fg-added            "#87a9b0")
    (fg-added-intense    "#bbced2")

    (bg-removed          "#2d2220")
    (bg-removed-faint    "#1e1817")
    (bg-removed-refine   "#43312d")
    (bg-removed-intense  "#59413b")
    (fg-removed          "#c38b7b")
    (fg-removed-intense  "#dcbeb5")

    (bg-changed          "#28262b")
    (bg-changed-faint    "#1b1a1d")
    (bg-changed-refine   "#3a383f")
    (bg-changed-intense  "#4c4a53")
    (fg-changed          "#a5a0b6")
    (fg-changed-intense  "#cbc9d5"))
  "Last Horizon base colors, in Modus palette format.")

(defconst last-horizon-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         lh-rose)
    (builtin         lh-lavender)
    (constant        lh-red)
    (fnname          lh-sky)
    (fnname-call     lh-sky)
    (name            lh-sky)
    (type            lh-lavender)
    (variable        fg-alt)
    (variable-use    fg-alt)
    (identifier      fg-alt)
    (property        lh-lavender)
    (property-use    lh-lavender)
    (string          lh-teal)
    (docstring       lh-slate)
    (comment         lh-comment)
    (preprocessor    lh-red)
    (operator        fg-main)
    (punctuation     fg-alt)
    (rx-construct    lh-sky)
    (rx-backslash    lh-red)

    ;; ---- Status / diagnostics ----
    (err             lh-red)
    (warning         lh-rose)
    (info            lh-lavender)
    (note            lh-sky)
    (success         lh-teal)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              lh-red)
    (modeline-warning          lh-rose)
    (modeline-info             lh-lavender)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     lh-rose)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            lh-mist)
    (bg-search-current         lh-rose)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      lh-sky)
    (link-symbolic             lh-lavender)
    (cursor                    lh-mist)
    (prompt                    lh-rose)

    ;; ---- Headings ----
    (fg-heading-0              lh-sky)
    (fg-heading-1              lh-rose)
    (fg-heading-2              lh-teal)
    (fg-heading-3              lh-lavender)
    (fg-heading-4              lh-red)
    (fg-heading-5              lh-sky)
    (fg-heading-6              lh-mist)
    (fg-heading-7              lh-slate)
    (fg-heading-8              fg-alt))
  "Semantic slot mappings for Last Horizon.")

(defconst last-horizon-palette
  (modus-themes-generate-palette
   last-horizon-palette-partial
   nil
   modus-themes-vivendi-palette
   last-horizon-palette-mappings-partial)
  "Complete Last Horizon palette for use with `modus-themes-theme'.")

(defcustom last-horizon-palette-overrides nil
  "User-level palette overrides for the Last Horizon theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar last-horizon-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-alt :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-alt :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-alt :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar last-horizon-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'last-horizon
   'omarchy-themes
   "Last Horizon, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'last-horizon-palette
   'last-horizon-palette-overrides
   'last-horizon-custom-faces
   'last-horizon-custom-variables)

(provide 'last-horizon-theme)
;;; last-horizon-theme.el ends here

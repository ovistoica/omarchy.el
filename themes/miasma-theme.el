;;; miasma-theme.el --- Miasma, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Miasma for Emacs, derived from Modus Vivendi via `modus-themes-theme'.
;; Mirrors the Omarchy 4 miasma theme
;; (/usr/share/omarchy/themes/miasma/colors.toml), itself a port of
;; xero/miasma.nvim.
;;
;; A warm, low-contrast earth palette on neutral gray: olive keywords,
;; moss-green strings, gold and rust accents.  Upstream repeats every
;; colour in its `bright_*' slots, so the Modus `-intense' variants are
;; lightened toward the foreground and the `-faint' ones darkened toward
;; the background.

;;; Code:

(require 'omarchy-themes)

(defconst miasma-palette-partial
  '(;; Core surfaces
    (bg-main       "#222222")  ; background
    (bg-dim        "#121212")  ; darker_background
    (bg-alt        "#2c2c2c")  ; lighter_background
    (bg-active     "#383838")  ; selection
    (bg-inactive   "#191919")  ; dark_background
    (border        "#666666")  ; muted

    ;; Foregrounds
    (fg-main       "#c2c2b0")  ; foreground
    (fg-dim        "#555555")  ; dark_foreground
    (fg-alt        "#8a8a7e")  ; light_foreground
    (cursor        "#c2c2b0")  ; bright_foreground

    ;; Miasma named slots
    (mia-olive     "#78824b")  ; accent / blue
    (mia-gold      "#c9a554")  ; cyan
    (mia-orange    "#b36d43")  ; yellow
    (mia-rust      "#bb7744")  ; magenta
    (mia-brown     "#8d6242")  ; orange
    (mia-green     "#5f875f")
    (mia-earth     "#685742")  ; red
    (mia-bark      "#463121")  ; brown
    (mia-muted     "#8a8a7e")
    (mia-comment   "#666666")

    ;; Modus primary color slots
    (red           "#685742")
    (red-warmer    "#8d6242")
    (red-cooler    "#685742")
    (red-faint     "#544839")
    (red-intense   "#bb7744")
    (green         "#5f875f")
    (green-warmer  "#78824b")
    (green-cooler  "#5f875f")
    (green-faint   "#4e6b4e")
    (green-intense "#829c7b")
    (yellow        "#b36d43")
    (yellow-warmer "#8d6242")
    (yellow-cooler "#c9a554")
    (yellow-faint  "#8a583a")
    (yellow-intense "#c9a554")
    (blue          "#78824b")
    (blue-warmer   "#8d6242")
    (blue-cooler   "#5f875f")
    (blue-faint    "#606740")
    (blue-intense  "#92986e")
    (magenta       "#bb7744")
    (magenta-warmer "#bb7744")
    (magenta-cooler "#8d6242")
    (magenta-faint "#905f3a")
    (magenta-intense "#bd916a")
    (cyan          "#c9a554")
    (cyan-warmer   "#b36d43")
    (cyan-cooler   "#78824b")
    (cyan-faint    "#9a8046")
    (cyan-intense  "#c7af74")

    ;; Diff backgrounds
    (bg-added            "#2d342d")
    (bg-added-faint      "#282c28")
    (bg-added-refine     "#344034")
    (bg-added-intense    "#3c4c3c")
    (fg-added            "#5f875f")
    (fg-added-intense    "#8ca283")

    (bg-removed          "#3e3128")
    (bg-removed-faint    "#312a25")
    (bg-removed-refine   "#503b2c")
    (bg-removed-intense  "#624630")
    (fg-removed          "#bb7744")
    (fg-removed-intense  "#be9975")

    (bg-changed          "#403a2b")
    (bg-changed-faint    "#332f27")
    (bg-changed-refine   "#544931")
    (bg-changed-intense  "#685937")
    (fg-changed          "#c9a554")
    (fg-changed-intense  "#c6b27d"))
  "Miasma base colors, in Modus palette format.")

(defconst miasma-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         mia-olive)
    (builtin         mia-gold)
    (constant        mia-rust)
    (fnname          mia-gold)
    (fnname-call     mia-gold)
    (name            mia-gold)
    (type            mia-orange)
    (variable        fg-main)
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        mia-brown)
    (property-use    mia-brown)
    (string          mia-green)
    (docstring       mia-green)
    (comment         mia-comment)
    (preprocessor    mia-rust)
    (operator        fg-main)
    (punctuation     mia-muted)
    (rx-construct    mia-gold)
    (rx-backslash    mia-orange)

    ;; ---- Status / diagnostics ----
    (err             mia-rust)
    (warning         mia-gold)
    (info            mia-olive)
    (note            mia-brown)
    (success         mia-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              mia-rust)
    (modeline-warning          mia-gold)
    (modeline-info             mia-olive)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   fg-dim)
    (fg-line-number-active     mia-gold)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            mia-gold)
    (bg-search-current         mia-gold)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      mia-olive)
    (link-symbolic             mia-green)
    (cursor                    fg-main)
    (prompt                    mia-gold)

    ;; ---- Headings ----
    (fg-heading-0              mia-gold)
    (fg-heading-1              mia-olive)
    (fg-heading-2              mia-green)
    (fg-heading-3              mia-rust)
    (fg-heading-4              mia-orange)
    (fg-heading-5              mia-gold)
    (fg-heading-6              mia-brown)
    (fg-heading-7              mia-muted)
    (fg-heading-8              fg-alt))
  "Semantic slot mappings for Miasma.")

(defconst miasma-palette
  (modus-themes-generate-palette
   miasma-palette-partial
   nil
   modus-themes-vivendi-palette
   miasma-palette-mappings-partial)
  "Complete Miasma palette for use with `modus-themes-theme'.")

(defcustom miasma-palette-overrides nil
  "User-level palette overrides for the Miasma theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar miasma-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar miasma-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'miasma
   'omarchy-themes
   "Miasma, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'miasma-palette
   'miasma-palette-overrides
   'miasma-custom-faces
   'miasma-custom-variables)

(provide 'miasma-theme)
;;; miasma-theme.el ends here

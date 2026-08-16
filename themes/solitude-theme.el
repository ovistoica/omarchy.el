;;; solitude-theme.el --- Solitude, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Solitude for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 solitude theme
;; (/usr/share/omarchy/themes/solitude/colors.toml), whose upstream
;; Neovim counterpart is ficcdaf/ashen.nvim.
;;
;; A cold slate monochrome lit by a single ember red (`sol-ember',
;; upstream `bright_red') used for keywords, errors and diff removals.
;; Upstream's `bright_green'/`bright_magenta' are darker than their plain
;; counterparts, so the Modus `-intense' variants are lightened here
;; instead; `sol-comment' lightens `muted' enough to read as text, and
;; the diff greens/blues are desaturated derivations.

;;; Code:

(require 'omarchy-themes)

(defconst solitude-palette-partial
  '(;; Core surfaces
    (bg-main       "#101315")  ; background
    (bg-dim        "#080a0b")  ; darker_background
    (bg-alt        "#1d2224")  ; derived: lighter_background == background
    (bg-active     "#343d41")  ; selection
    (bg-inactive   "#0c0e10")  ; dark_background
    (border        "#4b4e55")  ; muted

    ;; Foregrounds
    (fg-main       "#cacccc")  ; foreground
    (fg-dim        "#4b4e55")  ; dark_foreground
    (fg-alt        "#cbc2be")  ; light_foreground
    (cursor        "#a5aeb4")  ; bright_foreground

    ;; Solitude named slots
    (sol-ember     "#de6145")  ; bright_red
    (sol-accent    "#798186")  ; accent / blue
    (sol-pearl     "#d9dbdc")  ; yellow
    (sol-sand      "#c9c2b4")  ; bright_yellow
    (sol-mist      "#9fa5a9")  ; green
    (sol-gray      "#aeaeae")  ; magenta
    (sol-slate     "#707070")  ; cyan
    (sol-steel     "#565d60")  ; red
    (sol-silver    "#a8adb0")  ; active_border_color
    (sol-comment   "#6b7276")  ; derived: muted lightened to read as text

    ;; Modus primary color slots
    (red           "#565d60")
    (red-warmer    "#de6145")
    (red-cooler    "#565d60")
    (red-faint     "#42484b")
    (red-intense   "#de6145")
    (green         "#9fa5a9")
    (green-warmer  "#c9c2b4")
    (green-cooler  "#9fa5a9")
    (green-faint   "#777c80")
    (green-intense "#aeb3b5")
    (yellow        "#d9dbdc")
    (yellow-warmer "#c9c2b4")
    (yellow-cooler "#d9dbdc")
    (yellow-faint  "#a1a3a4")
    (yellow-intense "#e8eaea")
    (blue          "#798186")
    (blue-warmer   "#798186")
    (blue-cooler   "#707070")
    (blue-faint    "#5d6367")
    (blue-intense  "#a5aeb4")
    (magenta       "#aeaeae")
    (magenta-warmer "#c9c2b4")
    (magenta-cooler "#9a9a9a")
    (magenta-faint "#828383")
    (magenta-intense "#c4c4c4")
    (cyan          "#707070")
    (cyan-warmer   "#798186")
    (cyan-cooler   "#707070")
    (cyan-faint    "#555657")
    (cyan-intense  "#909090")

    ;; Diff backgrounds
    (bg-added            "#252d2b")
    (bg-added-faint      "#1c2221")
    (bg-added-refine     "#333f3a")
    (bg-added-intense    "#425048")
    (fg-added            "#86a58f")
    (fg-added-intense    "#a5b7aa")

    (bg-removed          "#35211e")
    (bg-removed-faint    "#251b1a")
    (bg-removed-refine   "#4e2a23")
    (bg-removed-intense  "#673429")
    (fg-removed          "#de6145")
    (fg-removed-intense  "#d59182")

    (bg-changed          "#272b2f")
    (bg-changed-faint    "#1d2024")
    (bg-changed-refine   "#363b41")
    (bg-changed-intense  "#454c53")
    (fg-changed          "#8f9aa8")
    (fg-changed-intense  "#aab0b8"))
  "Solitude base colors, in Modus palette format.")

(defconst solitude-palette-mappings-partial
  '(;; ---- Syntax ----
    (keyword         sol-ember)
    (builtin         sol-sand)
    (constant        sol-sand)
    (fnname          sol-pearl)
    (fnname-call     sol-pearl)
    (name            sol-pearl)
    (type            sol-mist)
    (variable        fg-main)
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        sol-gray)
    (property-use    sol-gray)
    (string          sol-mist)
    (docstring       sol-comment)
    (comment         sol-comment)
    (preprocessor    sol-accent)
    (operator        fg-main)
    (punctuation     sol-gray)
    (rx-construct    sol-sand)
    (rx-backslash    sol-ember)

    ;; ---- Status / diagnostics ----
    (err             sol-ember)
    (warning         sol-sand)
    (info            sol-accent)
    (note            sol-gray)
    (success         sol-mist)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              sol-ember)
    (modeline-warning          sol-sand)
    (modeline-info             sol-accent)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     sol-ember)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            sol-ember)
    (bg-search-current         sol-ember)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      sol-accent)
    (link-symbolic             sol-mist)
    (cursor                    sol-silver)
    (prompt                    sol-ember)

    ;; ---- Headings ----
    (fg-heading-0              sol-pearl)
    (fg-heading-1              sol-ember)
    (fg-heading-2              sol-sand)
    (fg-heading-3              sol-mist)
    (fg-heading-4              sol-gray)
    (fg-heading-5              sol-accent)
    (fg-heading-6              sol-silver)
    (fg-heading-7              sol-slate)
    (fg-heading-8              fg-alt))
  "Semantic slot mappings for Solitude.")

(defconst solitude-palette
  (modus-themes-generate-palette
   solitude-palette-partial
   nil
   modus-themes-vivendi-palette
   solitude-palette-mappings-partial)
  "Complete Solitude palette for use with `modus-themes-theme'.")

(defcustom solitude-palette-overrides nil
  "User-level palette overrides for the Solitude theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar solitude-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar solitude-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'solitude
   'omarchy-themes
   "Solitude, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'solitude-palette
   'solitude-palette-overrides
   'solitude-custom-faces
   'solitude-custom-variables)

(provide 'solitude-theme)
;;; solitude-theme.el ends here

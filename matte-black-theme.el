;;; matte-black-theme.el --- Matte Black, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Matte Black for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the highlight spec from
;; tahayvr/matteblack.nvim.
;;
;; Keyword/Statement/Tag -> green, Function/Identifier -> crimson/amber,
;; Constant -> amber, String -> fg1 (neutral), Number/Character -> gold,
;; Type/StorageClass/PreProc -> yellow, Operator -> fg2,
;; Comment -> muted italic.

;;; Code:

(require 'omarchy-themes)

(defconst matte-black-palette-partial
  '(;; Core surfaces
    (bg-main       "#121212")  ; bg1
    (bg-dim        "#0d0d0d")  ; bg0
    (bg-alt        "#212121")  ; bg3
    (bg-active     "#262626")  ; bg4
    (bg-inactive   "#0d0d0d")
    (border        "#333333")  ; bg2

    ;; Foregrounds
    (fg-main       "#eaeaea")  ; fg1
    (fg-dim        "#8a8a8d")  ; comment / fg3
    (fg-alt        "#bebebe")  ; fg2
    (cursor        "#ffffff")

    ;; Matte Black named slots
    (mb-red        "#b91c1c")
    (mb-crimson    "#dc2626")
    (mb-orange     "#f59e0b")
    (mb-amber      "#d97706")
    (mb-yellow     "#fbbf24")
    (mb-gold       "#efbf04")
    (mb-green      "#059669")
    (mb-teal       "#10b981")
    (mb-blue       "#3b82f6")
    (mb-purple     "#8d20b2")
    (mb-cyan       "#1ea7a0")
    (mb-pink       "#f87171")
    (mb-magenta    "#b027de")
    (mb-comment    "#8a8a8d")
    (mb-fg2        "#bebebe")
    (mb-fg3        "#8a8a8d")

    ;; Modus primary color slots
    (red           "#b91c1c")
    (red-warmer    "#dc2626")
    (red-cooler    "#b91c1c")
    (red-faint     "#b91c1c")
    (red-intense   "#dc2626")
    (green         "#059669")
    (green-warmer  "#10b981")
    (green-cooler  "#10b981")
    (green-faint   "#059669")
    (green-intense "#10b981")
    (yellow        "#fbbf24")
    (yellow-warmer "#f59e0b")
    (yellow-cooler "#efbf04")
    (yellow-faint  "#d97706")
    (yellow-intense "#fbbf24")
    (blue          "#3b82f6")
    (blue-warmer   "#8d20b2")
    (blue-cooler   "#1ea7a0")
    (blue-faint    "#3b82f6")
    (blue-intense  "#3b82f6")
    (magenta       "#b027de")
    (magenta-warmer "#b027de")
    (magenta-cooler "#8d20b2")
    (magenta-faint "#b027de")
    (magenta-intense "#b027de")
    (cyan          "#1ea7a0")
    (cyan-warmer   "#10b981")
    (cyan-cooler   "#1ea7a0")
    (cyan-faint    "#1ea7a0")
    (cyan-intense  "#1ea7a0")

    ;; Diff backgrounds — minimal
    (bg-added            "#1a2e24")
    (bg-added-faint      "#13221b")
    (bg-added-refine     "#264635")
    (bg-added-intense    "#365e47")
    (fg-added            "#10b981")
    (fg-added-intense    "#46d4a7")

    (bg-removed          "#38191e")
    (bg-removed-faint    "#2a1316")
    (bg-removed-refine   "#522329")
    (bg-removed-intense  "#6d2f37")
    (fg-removed          "#dc2626")
    (fg-removed-intense  "#f06262")

    (bg-changed          "#3a2c13")
    (bg-changed-faint    "#2b2010")
    (bg-changed-refine   "#55401c")
    (bg-changed-intense  "#715527")
    (fg-changed          "#f59e0b")
    (fg-changed-intense  "#fcc056"))
  "Matte Black base colors, in Modus palette format.")

(defconst matte-black-palette-mappings-partial
  '(;; ---- Syntax (matches matteblack.nvim) ----
    (keyword         mb-green)        ; Keyword, Statement, Conditional, Repeat, Exception
    (builtin         mb-yellow)       ; PreProc, Macro, Define, PreCondit
    (constant        mb-amber)        ; Constant
    (fnname          mb-crimson)      ; Function
    (fnname-call     mb-crimson)
    (name            mb-crimson)
    (type            mb-yellow)       ; Type, StorageClass, Structure, Typedef
    (variable        mb-amber)        ; Identifier -> amber
    (variable-use    mb-amber)
    (identifier      mb-amber)
    (property        mb-amber)
    (property-use    mb-amber)
    (string          fg-main)         ; String -> fg1
    (docstring       mb-comment)      ; docstring -> muted
    (comment         mb-comment)      ; italic
    (preprocessor    mb-yellow)
    (operator        mb-fg2)          ; Operator -> fg2
    (punctuation     mb-fg3)          ; Delimiter -> fg3
    (rx-construct    mb-yellow)
    (rx-backslash    mb-gold)

    ;; ---- Status / diagnostics ----
    (err             mb-crimson)
    (warning         mb-amber)
    (info            mb-gold)
    (note            mb-blue)
    (success         mb-teal)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              mb-crimson)
    (modeline-warning          mb-amber)
    (modeline-info             mb-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     mb-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 border)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            mb-orange)
    (bg-search-current         mb-orange)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      mb-orange)
    (link-symbolic             mb-amber)
    (cursor                    fg-main)
    (prompt                    mb-orange)

    ;; ---- Headings ----
    (fg-heading-0              mb-orange)
    (fg-heading-1              mb-yellow)
    (fg-heading-2              mb-crimson)
    (fg-heading-3              mb-amber)
    (fg-heading-4              mb-teal)
    (fg-heading-5              mb-orange)
    (fg-heading-6              mb-gold)
    (fg-heading-7              mb-green)
    (fg-heading-8              mb-fg2))
  "Semantic slot mappings for Matte Black.")

(defconst matte-black-palette
  (modus-themes-generate-palette
   matte-black-palette-partial
   nil
   modus-themes-vivendi-palette
   matte-black-palette-mappings-partial)
  "Complete Matte Black palette for use with `modus-themes-theme'.")

(defcustom matte-black-palette-overrides nil
  "User-level palette overrides for the Matte Black theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'modus-themes)

;; Matte Black italicizes comments; variables plain amber.
(defvar matte-black-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,mb-amber :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,mb-amber :slant normal)))
    `(help-argument-name           ((,c :foreground ,mb-amber :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar matte-black-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'matte-black
   'omarchy-themes
   "Matte Black, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'matte-black-palette
   'matte-black-palette-overrides
   'matte-black-custom-faces
   'matte-black-custom-variables))

(provide 'matte-black-theme)
;;; matte-black-theme.el ends here

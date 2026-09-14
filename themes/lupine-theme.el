;;; lupine-theme.el --- Lupine, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Lupine for Emacs, derived from Modus Operandi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 `aether' Neovim rendering
;; of /usr/share/omarchy/themes/lupine/colors.toml.
;;
;; Keyword -> bright_magenta, Function -> blue, Type -> yellow,
;; Constant -> bright_yellow, Number/Boolean -> orange, String -> green,
;; @property -> bright_cyan, Builtin/PreProc -> cyan,
;; Operator/Identifier -> foreground, Comment -> muted italic,
;; DiagnosticError -> bright_red, DiagnosticWarn -> yellow.
;;
;; Near-white paper with an all-cool palette: lupin blues, violets and a
;; single magenta-pink standing in for `red'.  Upstream has no green, so
;; `lup-ok' is derived for success states and diff additions; the Modus
;; `-intense' variants darken rather than brighten, since upstream's
;; `bright_*' colours are too light to read on #fafafa.

;;; Code:

(require 'omarchy-themes)

(defconst lupine-palette-partial
  '(;; Core surfaces
    (bg-main       "#fafafa")  ; background
    (bg-dim        "#ececec")  ; dark_background
    (bg-alt        "#f5f5f5")  ; lighter_background
    (bg-active     "#d0d0d0")  ; selection
    (bg-inactive   "#dedede")  ; darker_background
    (border        "#9e9e9e")  ; muted

    ;; Foregrounds
    (fg-main       "#212121")  ; foreground
    (fg-dim        "#757575")  ; dark_foreground
    (fg-alt        "#424242")  ; light_foreground
    (cursor        "#000000")  ; bright_foreground

    ;; Lupine named slots
    (lup-blue      "#3264eb")  ; accent
    (lup-azure     "#026fde")  ; yellow / orange
    (lup-sky       "#0c67de")  ; cyan
    (lup-violet    "#4a2fd0")  ; green
    (lup-purple    "#8a4ad7")  ; magenta
    (lup-pink      "#c900c4")  ; red
    (lup-navy      "#013a6f")  ; brown
    (lup-fuchsia   "#f930fb")  ; bright_red
    (lup-cerulean  "#358fff")  ; bright_yellow
    (lup-cornflower "#3986ff") ; bright_cyan
    (lup-lilac     "#b363ff")  ; bright_magenta
    (lup-comment   "#9e9e9e")  ; muted
    (lup-ok        "#2f7d4f")  ; derived: no green upstream

    ;; Modus primary color slots
    (red           "#c900c4")
    (red-warmer    "#c900c4")
    (red-cooler    "#8a4ad7")
    (red-faint     "#d746d3")
    (red-intense   "#8e0c8b")
    (green         "#4a2fd0")
    (green-warmer  "#8a4ad7")
    (green-cooler  "#3264eb")
    (green-faint   "#7b68dc")
    (green-intense "#3c2a93")
    (yellow        "#026fde")
    (yellow-warmer "#026fde")
    (yellow-cooler "#0c67de")
    (yellow-faint  "#4796e6")
    (yellow-intense "#0d549c")
    (blue          "#3264eb")
    (blue-warmer   "#8a4ad7")
    (blue-cooler   "#0c67de")
    (blue-faint    "#6a8eef")
    (blue-intense  "#2c4da4")
    (magenta       "#8a4ad7")
    (magenta-warmer "#c900c4")
    (magenta-cooler "#4a2fd0")
    (magenta-faint "#a97be1")
    (magenta-intense "#653c97")
    (cyan          "#0c67de")
    (cyan-warmer   "#3264eb")
    (cyan-cooler   "#013a6f")
    (cyan-faint    "#4f90e6")
    (cyan-intense  "#134e9c")

    ;; Diff backgrounds
    (bg-added            "#e2ebe5")
    (bg-added-faint      "#eef2f0")
    (bg-added-refine     "#cdded4")
    (bg-added-intense    "#b9d2c3")
    (fg-added            "#2f7d4f")
    (fg-added-intense    "#29543a")

    (bg-removed          "#f4dcf4")
    (bg-removed-faint    "#f7ebf7")
    (bg-removed-refine   "#efc3ee")
    (bg-removed-intense  "#eaaae9")
    (fg-removed          "#c900c4")
    (fg-removed-intense  "#7d0f7b")

    (bg-changed          "#e2e8f8")
    (bg-changed-faint    "#eef1f9")
    (bg-changed-refine   "#ced9f7")
    (bg-changed-intense  "#bacaf5")
    (fg-changed          "#3264eb")
    (fg-changed-intense  "#2a4690"))
  "Lupine base colors, in Modus palette format.")

(defconst lupine-palette-mappings-partial
  '(;; ---- Syntax (matches the aether colorscheme slot mapping) ----
    (keyword         lup-lilac)        ; Keyword -> bright_magenta
    (builtin         lup-sky)          ; @function.builtin -> cyan
    (constant        lup-cerulean)     ; Constant -> bright_yellow
    (number          lup-azure)        ; Number, Boolean -> orange
    (fnname          lup-blue)         ; Function -> blue
    (fnname-call     lup-blue)
    (name            lup-blue)
    (type            lup-azure)        ; Type -> yellow
    (variable        fg-main)          ; @variable -> foreground
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        lup-cornflower)   ; @property -> bright_cyan
    (property-use    lup-cornflower)
    (string          lup-violet)       ; String -> green
    (docstring       lup-violet)
    (comment         lup-comment)      ; Comment -> muted (italic)
    (preprocessor    lup-sky)          ; PreProc -> cyan
    (operator        fg-main)          ; Operator -> foreground
    (punctuation     fg-alt)
    (rx-construct    lup-purple)
    (rx-backslash    lup-pink)

    ;; ---- Status / diagnostics ----
    (err             lup-fuchsia)      ; DiagnosticError -> bright_red
    (warning         lup-azure)        ; DiagnosticWarn -> yellow
    (info            lup-blue)         ; DiagnosticInfo -> blue
    (note            lup-sky)
    (success         lup-ok)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-inactive)
    (modeline-err              lup-pink)
    (modeline-warning          lup-purple)
    (modeline-info             lup-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     lup-blue)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            lup-pink)
    (bg-search-current         bg-active)
    (bg-search-lazy            bg-dim)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-dim)

    ;; ---- Links / prompts ----
    (link                      lup-blue)
    (link-symbolic             lup-sky)
    (cursor                    fg-main)
    (prompt                    lup-purple)

    ;; ---- Headings ----
    (fg-heading-0              lup-blue)
    (fg-heading-1              lup-purple)
    (fg-heading-2              lup-azure)
    (fg-heading-3              lup-violet)
    (fg-heading-4              lup-pink)
    (fg-heading-5              lup-sky)
    (fg-heading-6              lup-navy)
    (fg-heading-7              fg-alt)
    (fg-heading-8              fg-dim))
  "Semantic slot mappings for Lupine.")

(defconst lupine-palette
  (modus-themes-generate-palette
   lupine-palette-partial
   nil
   modus-themes-operandi-palette
   lupine-palette-mappings-partial)
  "Complete Lupine palette for use with `modus-themes-theme'.")

(defcustom lupine-palette-overrides nil
  "User-level palette overrides for the Lupine theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar lupine-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar lupine-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'lupine
   'omarchy-themes
   "Lupine, derived from Modus Operandi."
   'light
   'modus-themes-operandi-palette
   'lupine-palette
   'lupine-palette-overrides
   'lupine-custom-faces
   'lupine-custom-variables)

(provide 'lupine-theme)
;;; lupine-theme.el ends here

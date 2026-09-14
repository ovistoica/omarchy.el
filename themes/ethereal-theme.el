;;; ethereal-theme.el --- Ethereal, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Ethereal for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 `aether' Neovim rendering
;; of /usr/share/omarchy/themes/ethereal/colors.toml.
;;
;; Keyword -> bright_magenta, Function -> blue, Type -> yellow,
;; Constant -> bright_yellow, Number/Boolean -> orange, String -> green,
;; @property -> bright_cyan, Builtin/PreProc -> cyan,
;; Operator/Identifier -> foreground, Comment -> muted italic,
;; DiagnosticError -> bright_red, DiagnosticWarn -> yellow.

;;; Code:

(require 'omarchy-themes)

(defconst ethereal-palette-partial
  '(;; Core surfaces
    (bg-main       "#060b1e")  ; bg
    (bg-dim        "#060b1e")  ; bg_dark
    (bg-alt        "#1e3a5f")  ; blue7
    (bg-active     "#264f78")  ; blue0
    (bg-inactive   "#060b1e")
    (border        "#6d7db6")  ; dark3 / comment

    ;; Foregrounds
    (fg-main       "#ffcead")  ; fg
    (fg-dim        "#6d7db6")  ; comment
    (fg-alt        "#f99957")  ; fg_dark
    (cursor        "#ffcead")

    ;; Ethereal named slots
    (eth-blue      "#7d82d9")
    (eth-blue5     "#a3bfd1")
    (eth-cyan      "#a3bfd1")
    (eth-green     "#92a593")
    (eth-magenta   "#c89dc1")
    (eth-magenta2  "#8e93de")
    (eth-orange    "#eb8b54")  ; orange
    (eth-salmon    "#faaaa9")  ; bright_red
    (eth-purple    "#c89dc1")
    (eth-red       "#ed5b5a")
    (eth-teal      "#a3bfd1")
    (eth-yellow    "#e9bb4f")
    (eth-comment   "#6d7db6")
    (eth-special   "#f7dc9c")  ; bright_yellow
    (eth-mist      "#dfeaf0")  ; bright_cyan
    (eth-lilac     "#ead7e7")  ; bright_magenta

    ;; Modus primary color slots
    (red           "#ed5b5a")
    (red-warmer    "#faaaa9")
    (red-cooler    "#ed5b5a")
    (red-faint     "#ed5b5a")
    (red-intense   "#faaaa9")
    (green         "#92a593")
    (green-warmer  "#92a593")
    (green-cooler  "#a3bfd1")
    (green-faint   "#92a593")
    (green-intense "#c4cfc4")
    (yellow        "#e9bb4f")
    (yellow-warmer "#faaaa9")
    (yellow-cooler "#e9bb4f")
    (yellow-faint  "#e9bb4f")
    (yellow-intense "#f7dc9c")
    (blue          "#7d82d9")
    (blue-warmer   "#8e93de")
    (blue-cooler   "#a3bfd1")
    (blue-faint    "#7d82d9")
    (blue-intense  "#c2c4f0")
    (magenta       "#c89dc1")
    (magenta-warmer "#c89dc1")
    (magenta-cooler "#8e93de")
    (magenta-faint "#c89dc1")
    (magenta-intense "#ead7e7")
    (cyan          "#a3bfd1")
    (cyan-warmer   "#a3bfd1")
    (cyan-cooler   "#7d82d9")
    (cyan-faint    "#a3bfd1")
    (cyan-intense  "#dfeaf0")

    ;; Diff backgrounds
    (bg-added            "#1d2e23")
    (bg-added-faint      "#172218")
    (bg-added-refine     "#2e4635")
    (bg-added-intense    "#3e5e47")
    (fg-added            "#a5b5a6")
    (fg-added-intense    "#c4cfc4")

    (bg-removed          "#3a1a1c")
    (bg-removed-faint    "#2b1316")
    (bg-removed-refine   "#552b2c")
    (bg-removed-intense  "#703c3d")
    (fg-removed          "#ed5b5a")
    (fg-removed-intense  "#faaaa9")

    (bg-changed          "#1f2a46")
    (bg-changed-faint    "#161e33")
    (bg-changed-refine   "#2f3e62")
    (bg-changed-intense  "#42557f")
    (fg-changed          "#7d82d9")
    (fg-changed-intense  "#a3a8ef"))
  "Ethereal base colors, in Modus palette format.")

(defconst ethereal-palette-mappings-partial
  '(;; ---- Syntax (matches the aether colorscheme slot mapping) ----
    (keyword         eth-lilac)        ; Keyword -> bright_magenta
    (builtin         eth-cyan)         ; @function.builtin -> cyan
    (constant        eth-special)      ; Constant -> bright_yellow
    (number          eth-orange)       ; Number, Boolean -> orange
    (fnname          eth-blue)         ; Function -> blue
    (fnname-call     eth-blue)
    (name            eth-blue)
    (type            eth-yellow)       ; Type -> yellow
    (variable        fg-main)          ; @variable -> foreground
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        eth-mist)         ; @property -> bright_cyan
    (property-use    eth-mist)
    (string          eth-green)        ; String -> green
    (docstring       eth-green)
    (comment         eth-comment)      ; Comment -> muted (italic)
    (preprocessor    eth-cyan)         ; PreProc -> cyan
    (operator        fg-main)          ; Operator -> foreground
    (punctuation     fg-main)
    (rx-construct    eth-yellow)
    (rx-backslash    eth-special)

    ;; ---- Status / diagnostics ----
    (err             eth-salmon)       ; DiagnosticError -> bright_red
    (warning         eth-yellow)       ; DiagnosticWarn -> yellow
    (info            eth-blue)
    (note            eth-cyan)
    (success         eth-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              eth-red)
    (modeline-warning          eth-yellow)
    (modeline-info             eth-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     eth-salmon)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            eth-salmon)
    (bg-search-current         eth-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      eth-blue)
    (link-symbolic             eth-cyan)
    (cursor                    fg-main)
    (prompt                    eth-purple)

    ;; ---- Headings ----
    (fg-heading-0              eth-blue)
    (fg-heading-1              eth-magenta2)
    (fg-heading-2              eth-purple)
    (fg-heading-3              eth-yellow)
    (fg-heading-4              eth-green)
    (fg-heading-5              eth-cyan)
    (fg-heading-6              eth-salmon)
    (fg-heading-7              eth-red)
    (fg-heading-8              eth-special))
  "Semantic slot mappings for Ethereal.")

(defconst ethereal-palette
  (modus-themes-generate-palette
   ethereal-palette-partial
   nil
   modus-themes-vivendi-palette
   ethereal-palette-mappings-partial)
  "Complete Ethereal palette for use with `modus-themes-theme'.")

(defcustom ethereal-palette-overrides nil
  "User-level palette overrides for the Ethereal theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Ethereal italicizes comments.  Variables stay upright.
(defvar ethereal-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar ethereal-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'ethereal
   'omarchy-themes
   "Ethereal, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'ethereal-palette
   'ethereal-palette-overrides
   'ethereal-custom-faces
   'ethereal-custom-variables)

(provide 'ethereal-theme)
;;; ethereal-theme.el ends here

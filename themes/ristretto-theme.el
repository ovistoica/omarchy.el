;;; ristretto-theme.el --- Monokai Pro Ristretto, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Monokai Pro Ristretto for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 `aether' Neovim rendering
;; of /usr/share/omarchy/themes/ristretto/colors.toml.
;;
;; Keyword -> bright_magenta (italic), Function -> blue, Type -> yellow,
;; Constant -> bright_yellow, Number/Boolean -> orange, String -> green,
;; @property -> bright_cyan, Builtin/PreProc -> cyan,
;; Operator/Identifier -> foreground, Comment -> muted italic,
;; DiagnosticError -> bright_red, DiagnosticWarn -> yellow.

;;; Code:

(require 'omarchy-themes)

(defconst ristretto-palette-partial
  '(;; Core surfaces (ristretto palette)
    (bg-main       "#2c2525")  ; background
    (bg-dim        "#211c1c")  ; dark1
    (bg-alt        "#403838")  ; dimmed5
    (bg-active     "#5b5353")  ; dimmed4
    (bg-inactive   "#191515")  ; dark2
    (border        "#5b5353")

    ;; Foregrounds
    (fg-main       "#fff1f3")  ; text
    (fg-dim        "#72696a")  ; dimmed3 (comments)
    (fg-alt        "#c3b7b8")  ; dimmed1
    (cursor        "#c3b7b8")

    ;; Ristretto named slots (base color resolution)
    (rist-red      "#fd6883")  ; accent1
    (rist-blue     "#f38d70")  ; accent2  (monokai calls this blue/orange)
    (rist-yellow   "#f9cc6c")  ; accent3
    (rist-green    "#adda78")  ; accent4
    (rist-cyan     "#85dacc")  ; accent5
    (rist-magenta  "#a8a9eb")  ; accent6
    (rist-orange   "#fb9a77")  ; orange
    (rist-rose     "#ff8297")  ; bright_red
    (rist-gold     "#fcd675")  ; bright_yellow
    (rist-aqua     "#9bf1e1")  ; bright_cyan
    (rist-lilac    "#bebffd")  ; bright_magenta
    (rist-white    "#fff1f3")  ; text
    (rist-dimmed1  "#c3b7b8")
    (rist-dimmed2  "#948a8b")
    (rist-dimmed3  "#72696a")
    (rist-dimmed4  "#5b5353")

    ;; Modus primary color slots
    (red           "#fd6883")
    (red-warmer    "#f38d70")
    (red-cooler    "#fd6883")
    (red-faint     "#fd6883")
    (red-intense   "#ff8297")
    (green         "#adda78")
    (green-warmer  "#adda78")
    (green-cooler  "#85dacc")
    (green-faint   "#adda78")
    (green-intense "#c8e292")
    (yellow        "#f9cc6c")
    (yellow-warmer "#f38d70")
    (yellow-cooler "#f9cc6c")
    (yellow-faint  "#f9cc6c")
    (yellow-intense "#fcd675")
    (blue          "#85dacc")
    (blue-warmer   "#a8a9eb")
    (blue-cooler   "#85dacc")
    (blue-faint    "#85dacc")
    (blue-intense  "#a8a9eb")
    (magenta       "#a8a9eb")
    (magenta-warmer "#fd6883")
    (magenta-cooler "#a8a9eb")
    (magenta-faint "#a8a9eb")
    (magenta-intense "#bebffd")
    (cyan          "#85dacc")
    (cyan-warmer   "#85dacc")
    (cyan-cooler   "#85dacc")
    (cyan-faint    "#85dacc")
    (cyan-intense  "#9bf1e1")

    ;; Diff backgrounds — warm-leaning
    (bg-added            "#3a4328")
    (bg-added-faint      "#2d341e")
    (bg-added-refine     "#525f39")
    (bg-added-intense    "#6b7c4a")
    (fg-added            "#bbe090")
    (fg-added-intense    "#c6e89a")

    (bg-removed          "#4e2a33")
    (bg-removed-faint    "#3b1f26")
    (bg-removed-refine   "#6a3a47")
    (bg-removed-intense  "#8a4c5b")
    (fg-removed          "#fd6883")
    (fg-removed-intense  "#ff95a6")

    (bg-changed          "#4a401f")
    (bg-changed-faint    "#362e16")
    (bg-changed-refine   "#6a5a2b")
    (bg-changed-intense  "#8a7639")
    (fg-changed          "#f9cc6c")
    (fg-changed-intense  "#fcdd92"))
  "Ristretto base colors, in Modus palette format.")

(defconst ristretto-palette-mappings-partial
  '(;; ---- Syntax (matches the aether colorscheme slot mapping) ----
    (keyword         rist-lilac)       ; Keyword (italic) -> bright_magenta
    (builtin         rist-cyan)        ; @function.builtin -> cyan
    (constant        rist-gold)        ; Constant -> bright_yellow
    (number          rist-orange)      ; Number, Boolean -> orange
    (fnname          rist-blue)        ; Function -> blue
    (fnname-call     rist-blue)
    (name            rist-blue)
    (type            rist-yellow)      ; Type -> yellow
    (variable        rist-white)       ; @variable -> foreground
    (variable-use    rist-white)
    (identifier      rist-white)
    (property        rist-aqua)        ; @property -> bright_cyan
    (property-use    rist-aqua)
    (string          rist-green)       ; String -> green
    (docstring       rist-green)
    (comment         rist-dimmed3)     ; Comment -> muted (italic)
    (preprocessor    rist-cyan)        ; PreProc -> cyan
    (operator        rist-white)       ; Operator -> foreground
    (punctuation     rist-dimmed1)     ; Delimiter
    (rx-construct    rist-magenta)
    (rx-backslash    rist-cyan)

    ;; ---- Status / diagnostics ----
    (err             rist-rose)        ; DiagnosticError -> bright_red
    (warning         rist-yellow)      ; DiagnosticWarn -> yellow
    (info            rist-blue)
    (note            rist-cyan)
    (success         rist-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              rist-red)
    (modeline-warning          rist-yellow)
    (modeline-info             rist-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   rist-dimmed4)
    (fg-line-number-active     rist-blue)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)  ; dimmed4 — brighter than hl-line
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)      ; dimmed5 — subtle cursor line
    (bg-paren-match            bg-active)
    (fg-paren-match            rist-blue)
    (bg-search-current         rist-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      rist-blue)
    (link-symbolic             rist-cyan)
    (cursor                    fg-main)
    (prompt                    rist-magenta)

    ;; ---- Headings ----
    (fg-heading-0              rist-cyan)
    (fg-heading-1              rist-green)
    (fg-heading-2              rist-yellow)
    (fg-heading-3              rist-blue)
    (fg-heading-4              rist-magenta)
    (fg-heading-5              rist-red)
    (fg-heading-6              rist-cyan)
    (fg-heading-7              rist-green)
    (fg-heading-8              rist-yellow))
  "Semantic slot mappings for Monokai Pro Ristretto.")

(defconst ristretto-palette
  (modus-themes-generate-palette
   ristretto-palette-partial
   nil
   modus-themes-vivendi-palette
   ristretto-palette-mappings-partial)
  "Complete Ristretto palette for use with `modus-themes-theme'.")

(defcustom ristretto-palette-overrides nil
  "User-level palette overrides for the Ristretto theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Ristretto: keyword italic + comment italic.  Variables plain.
(defvar ristretto-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,rist-white :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,rist-white :slant normal)))
    `(help-argument-name           ((,c :foreground ,rist-white :slant normal)))
    `(font-lock-keyword-face       ((,c :foreground ,rist-lilac :slant italic))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar ristretto-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'ristretto
   'omarchy-themes
   "Monokai Pro Ristretto, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'ristretto-palette
   'ristretto-palette-overrides
   'ristretto-custom-faces
   'ristretto-custom-variables)

(provide 'ristretto-theme)
;;; ristretto-theme.el ends here

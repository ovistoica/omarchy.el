;;; jade-horse-theme.el --- Jade Horse, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Jade Horse for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 `aether' Neovim rendering
;; of /usr/share/omarchy/themes/jade-horse/colors.toml.  Jade Horse ships
;; no `neovim.lua'; Omarchy generates one from colors.toml through
;; `default/themed/neovim.lua.tpl', which configures omacom/aether.nvim
;; (v3).  The syntax mapping below therefore follows aether's palette
;; slots, the same reference used for Vantablack.
;;
;; Keyword -> bright_magenta, Function -> blue, Type -> yellow,
;; Constant -> bright_yellow, Number/Boolean -> orange, String -> green,
;; @property -> bright_cyan, Builtin/PreProc -> cyan,
;; Operator -> foreground, Comment -> muted,
;; DiagnosticError -> bright_red, DiagnosticWarn -> yellow.
;;
;; A deep jade canvas (#142620) with a warm off-white foreground
;; (#dfede5) and a muted jade accent.  Upstream italicizes comments and
;; keywords; like every bundled theme, italics are left to Modus's
;; `modus-themes-italic-constructs' (off by default).  Diff backgrounds
;; are the aether blends of green/red/selection over the theme bg.

;;; Code:

(require 'omarchy-themes)

(defconst jade-horse-palette-partial
  '(;; Core surfaces
    (bg-main       "#142620")  ; background
    (bg-dim        "#0a1713")  ; darker_background
    (bg-alt        "#203b31")  ; lighter_background
    (bg-active     "#2b5147")  ; selection
    (bg-inactive   "#0f1e19")  ; dark_background
    (border        "#64887b")  ; muted

    ;; Foregrounds
    (fg-main       "#dfede5")  ; foreground
    (fg-dim        "#91ad9f")  ; dark_foreground
    (fg-alt        "#bed6c9")  ; light_foreground
    (cursor        "#f0faf4")  ; bright_foreground

    ;; Jade Horse named slots
    (jh-green           "#8bcbb1")  ; green / accent
    (jh-red             "#d88d91")
    (jh-yellow          "#c5cc91")
    (jh-orange          "#d2ab8d")
    (jh-cyan            "#86c7c5")
    (jh-blue            "#96b7d0")
    (jh-magenta         "#b7a1c8")
    (jh-brown           "#7e8970")
    (jh-muted           "#64887b")  ; muted
    (jh-bright-red      "#e6a6aa")
    (jh-bright-yellow   "#dce1ac")
    (jh-bright-green    "#a7dfc5")
    (jh-bright-cyan     "#a2dcda")
    (jh-bright-blue     "#b0cde3")
    (jh-bright-magenta  "#cfbce0")
    (jh-punctuation     "#7a8a83")  ; blend(fg, 0.5)
    (jh-search          "#486066")  ; blend(blue, 0.4)

    ;; Modus primary color slots
    (red           "#d88d91")
    (red-warmer    "#d2ab8d")
    (red-cooler    "#c897ad")
    (red-faint     "#805f5e")
    (red-intense   "#e6a6aa")
    (green         "#8bcbb1")
    (green-warmer  "#a8cca1")
    (green-cooler  "#86c7c5")
    (green-faint   "#558170")
    (green-intense "#a7dfc5")
    (yellow        "#c5cc91")
    (yellow-warmer "#d2ab8d")
    (yellow-cooler "#a8cca1")
    (yellow-faint  "#75815e")
    (yellow-intense "#dce1ac")
    (blue          "#96b7d0")
    (blue-warmer   "#a7accc")
    (blue-cooler   "#627d8a")
    (blue-faint    "#5c7681")
    (blue-intense  "#b0cde3")
    (magenta       "#b7a1c8")
    (magenta-warmer "#c897ad")
    (magenta-cooler "#a7accc")
    (magenta-faint "#6e6a7c")
    (magenta-intense "#cfbce0")
    (cyan          "#86c7c5")
    (cyan-warmer   "#8ebfcb")
    (cyan-cooler   "#89c9bb")
    (cyan-faint    "#537f7b")
    (cyan-intense  "#a2dcda")

    ;; Diff backgrounds (aether: blend over bg)
    (bg-added            "#324f44")  ; blend(green, 0.25)
    (bg-added-faint      "#223a31")  ; blend(green, 0.12)
    (bg-added-refine     "#3e6053")  ; blend(green, 0.35)
    (bg-added-intense    "#507969")  ; blend(green, 0.50)
    (fg-added            "#a7dfc5")
    (fg-added-intense    "#bbe4d0")

    (bg-removed          "#45403c")  ; blend(red, 0.25)
    (bg-removed-faint    "#2c322e")  ; blend(red, 0.12)
    (bg-removed-refine   "#594a48")  ; blend(red, 0.35)
    (bg-removed-intense  "#765a59")  ; blend(red, 0.50)
    (fg-removed          "#e6a6aa")
    (fg-removed-intense  "#e4bfbf")

    (bg-changed          "#172c26")  ; blend(selection, 0.15)
    (bg-changed-faint    "#162923")  ; blend(selection, 0.08)
    (bg-changed-refine   "#1a312a")  ; blend(selection, 0.25)
    (bg-changed-intense  "#1d3730")  ; blend(selection, 0.40)
    (fg-changed          "#96b7d0")
    (fg-changed-intense  "#c0d8e4"))
  "Jade Horse base colors, in Modus palette format.")

(defconst jade-horse-palette-mappings-partial
  '(;; ---- Syntax (matches the aether colorscheme slot mapping) ----
    (keyword         jh-bright-magenta) ; Keyword -> bright_magenta
    (builtin         jh-cyan)           ; @function.builtin -> cyan
    (constant        jh-bright-yellow)  ; Constant -> bright_yellow
    (number          jh-orange)         ; Number, Boolean -> orange
    (fnname          jh-blue)           ; Function -> blue
    (fnname-call     jh-blue)
    (name            jh-blue)
    (type            jh-yellow)         ; Type -> yellow
    (variable        fg-main)           ; @variable -> foreground
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        jh-bright-cyan)    ; @property -> bright_cyan
    (property-use    jh-bright-cyan)
    (string          jh-green)          ; String -> green
    (docstring       jh-yellow)         ; @string.documentation -> yellow
    (comment         jh-muted)          ; Comment -> muted (italic upstream)
    (preprocessor    jh-cyan)           ; PreProc -> cyan
    (operator        fg-main)           ; Operator -> foreground
    (punctuation     jh-punctuation)    ; blend(fg, 0.5)
    (rx-construct    jh-bright-cyan)    ; @string.regexp -> bright_cyan
    (rx-backslash    jh-bright-magenta) ; @string.escape -> bright_magenta

    ;; ---- Status / diagnostics ----
    (err             jh-bright-red)     ; DiagnosticError -> bright_red
    (warning         jh-yellow)         ; DiagnosticWarn -> yellow
    (info            jh-blue)           ; DiagnosticInfo -> blue
    (note            jh-cyan)           ; DiagnosticHint -> cyan
    (success         jh-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              jh-bright-red)
    (modeline-warning          jh-bright-yellow)
    (modeline-info             jh-bright-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   jh-muted)
    (fg-line-number-active     jh-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            jh-orange)
    (bg-search-current         jh-search)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      jh-blue)
    (link-symbolic             jh-cyan)
    (cursor                    cursor)
    (prompt                    jh-green)

    ;; ---- Headings ----
    (fg-heading-0              jh-bright-green)
    (fg-heading-1              jh-green)
    (fg-heading-2              jh-cyan)
    (fg-heading-3              jh-blue)
    (fg-heading-4              jh-yellow)
    (fg-heading-5              jh-magenta)
    (fg-heading-6              jh-orange)
    (fg-heading-7              jh-red)
    (fg-heading-8              jh-brown))
  "Semantic slot mappings for Jade Horse.")

(defconst jade-horse-palette
  (modus-themes-generate-palette
   jade-horse-palette-partial
   nil
   modus-themes-vivendi-palette
   jade-horse-palette-mappings-partial)
  "Complete Jade Horse palette for use with `modus-themes-theme'.")

(defcustom jade-horse-palette-overrides nil
  "User-level palette overrides for the Jade Horse theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright: aether renders @variable in the default
;; foreground, and Modus's italic constructs would otherwise slant them.
(defvar jade-horse-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar jade-horse-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'jade-horse
   'omarchy-themes
   "Jade Horse, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'jade-horse-palette
   'jade-horse-palette-overrides
   'jade-horse-custom-faces
   'jade-horse-custom-variables)

(provide 'jade-horse-theme)
;;; jade-horse-theme.el ends here

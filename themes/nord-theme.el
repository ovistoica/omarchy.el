;;; nord-theme.el --- Nord, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Nord for Emacs, derived from Modus Vivendi via `modus-themes-theme'.
;; Surfaces follow doom-themes/doom-nord; syntax colours mirror the
;; Omarchy 4 Neovim scheme EdenEast/nightfox.nvim (`nordfox').
;;
;; Syntax mapping (nordfox palette keys):
;;   @keyword  magenta.base   @function  blue.bright    Type      yellow.base
;;   String    green.base     @variable  white.base     @property blue.base
;;   Constant  orange.bright  @number    orange.base    builtin   red.base
;;   PreProc   pink.bright    Operator   fg2            Comment   comment
;;   Error     red.base       Warn       yellow.base    Info      blue.base

;;; Code:

(require 'omarchy-themes)

(defconst nord-palette-partial
  '(;; Core surfaces (doom-nord)
    (bg-main       "#2e3440")  ; bg
    (bg-dim        "#272c36")  ; bg-alt
    (bg-alt        "#373e4c")  ; base3
    (bg-active     "#434c5e")  ; base4 — region
    (bg-inactive   "#242832")  ; base1
    (border        "#4c566a")  ; base5

    ;; Foregrounds
    (fg-main       "#eceff4")  ; fg
    (fg-dim        "#606977")  ; lightened base5 (comments)
    (fg-alt        "#e5e9f0")  ; fg-alt
    (cursor        "#d8dee9")  ; base7

    ;; Doom Nord named slots
    (nord-base0    "#191c25")
    (nord-base1    "#242832")
    (nord-base2    "#2c333f")
    (nord-base3    "#373e4c")
    (nord-base4    "#434c5e")
    (nord-base5    "#4c566a")
    (nord-base6    "#9099ab")
    (nord-base7    "#d8dee9")  ; variables
    (nord-base8    "#f0f4fc")
    (nord-red      "#bf616a")
    (nord-orange   "#d08770")
    (nord-green    "#a3be8c")  ; strings
    (nord-teal     "#8fbcbb")  ; type
    (nord-yellow   "#ebcb8b")
    (nord-blue     "#81a1c1")  ; keyword, builtin, constant, operator
    (nord-dark-blue "#5e81ac")
    (nord-magenta  "#b48ead")  ; numbers
    (nord-violet   "#5d80ae")
    (nord-cyan     "#88c0d0")  ; functions, methods
    (nord-dark-cyan "#507681")

    ;; nordfox syntax slots
    (nord-blue-bright   "#8cafd2")  ; blue.bright — @function
    (nord-orange-base   "#c9826b")  ; orange.base — @number
    (nord-orange-bright "#d89079")  ; orange.bright — Constant
    (nord-pink-bright   "#d092ce")  ; pink.bright — PreProc
    (nord-fg2           "#abb1bb")  ; fg2 — Operator
    (nord-comment       "#60728a")  ; comment

    ;; Modus primary color slots
    (red           "#bf616a")
    (red-warmer    "#d08770")
    (red-cooler    "#bf616a")
    (red-faint     "#bf616a")
    (red-intense   "#bf616a")
    (green         "#a3be8c")
    (green-warmer  "#a3be8c")
    (green-cooler  "#8fbcbb")
    (green-faint   "#a3be8c")
    (green-intense "#a3be8c")
    (yellow        "#ebcb8b")
    (yellow-warmer "#d08770")
    (yellow-cooler "#ebcb8b")
    (yellow-faint  "#ebcb8b")
    (yellow-intense "#ebcb8b")
    (blue          "#81a1c1")
    (blue-warmer   "#5e81ac")
    (blue-cooler   "#88c0d0")
    (blue-faint    "#81a1c1")
    (blue-intense  "#81a1c1")
    (magenta       "#b48ead")
    (magenta-warmer "#b48ead")
    (magenta-cooler "#5d80ae")
    (magenta-faint "#b48ead")
    (magenta-intense "#b48ead")
    (cyan          "#88c0d0")
    (cyan-warmer   "#88c0d0")
    (cyan-cooler   "#507681")
    (cyan-faint    "#88c0d0")
    (cyan-intense  "#88c0d0")

    ;; Diff backgrounds (nord-muted)
    (bg-added            "#2f3e3c")
    (bg-added-faint      "#28342f")
    (bg-added-refine     "#3e5749")
    (bg-added-intense    "#546f5c")
    (fg-added            "#b3c9a0")
    (fg-added-intense    "#b6cca0")

    (bg-removed          "#3e3039")
    (bg-removed-faint    "#33272e")
    (bg-removed-refine   "#5a424b")
    (bg-removed-intense  "#74545e")
    (fg-removed          "#bf616a")
    (fg-removed-intense  "#d88088")

    (bg-changed          "#303a47")
    (bg-changed-faint    "#283039")
    (bg-changed-refine   "#3f4d5c")
    (bg-changed-intense  "#536578")
    (fg-changed          "#81a1c1")
    (fg-changed-intense  "#9db4cf"))
  "Nord base colors, aligned with doom-themes' doom-nord.")

(defconst nord-palette-mappings-partial
  '(;; ---- Syntax (matches nightfox nordfox) ----
    (keyword         nord-magenta)      ; @keyword -> magenta.base
    (builtin         nord-red)          ; @function.builtin -> red.base
    (constant        nord-orange-bright) ; Constant -> orange.bright
    (number          nord-orange-base)  ; @number -> orange.base
    (fnname          nord-blue-bright)  ; @function -> blue.bright
    (fnname-call     nord-blue-bright)
    (name            nord-blue-bright)
    (type            nord-yellow)       ; Type -> yellow.base
    (variable        fg-alt)            ; @variable -> white.base
    (variable-use    fg-alt)
    (identifier      fg-alt)
    (property        nord-blue)         ; @property -> blue.base
    (property-use    nord-blue)
    (string          nord-green)        ; String -> green.base
    (docstring       nord-green)
    (comment         nord-comment)      ; Comment -> comment
    (preprocessor    nord-pink-bright)  ; PreProc -> pink.bright
    (operator        nord-fg2)          ; Operator -> fg2
    (punctuation     nord-base7)
    (rx-construct    nord-magenta)
    (rx-backslash    nord-cyan)

    ;; ---- Status / diagnostics ----
    (err             nord-red)
    (warning         nord-yellow)
    (info            nord-blue)
    (note            nord-cyan)
    (success         nord-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              nord-red)
    (modeline-warning          nord-yellow)
    (modeline-info             nord-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   nord-base5)
    (fg-line-number-active     nord-base7)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 nord-base4)  ; doom default
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            nord-orange)
    (bg-search-current         nord-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      nord-blue)
    (link-symbolic             nord-cyan)
    (cursor                    fg-main)
    (prompt                    nord-blue)

    ;; ---- Headings ----
    (fg-heading-0              nord-cyan)
    (fg-heading-1              nord-blue)
    (fg-heading-2              nord-teal)
    (fg-heading-3              nord-green)
    (fg-heading-4              nord-yellow)
    (fg-heading-5              nord-magenta)
    (fg-heading-6              nord-orange)
    (fg-heading-7              nord-red)
    (fg-heading-8              nord-dark-cyan))
  "Semantic slot mappings for Nord (nordfox syntax, doom-nord surfaces).")

(defconst nord-palette
  (modus-themes-generate-palette
   nord-palette-partial
   nil
   modus-themes-vivendi-palette
   nord-palette-mappings-partial)
  "Complete Nord palette for use with `modus-themes-theme'.")

(defcustom nord-palette-overrides nil
  "User-level palette overrides for the Nord theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; nordfox does not italicize; we italicize comments for parity with
;; the rest of the omarchy pack.  Variables stay plain white.base.
(defvar nord-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-alt :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-alt :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-alt :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar nord-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'nord
   'omarchy-themes
   "Nord, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'nord-palette
   'nord-palette-overrides
   'nord-custom-faces
   'nord-custom-variables)

(provide 'nord-theme)
;;; nord-theme.el ends here

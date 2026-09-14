;;; everforest-theme.el --- Everforest, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Everforest for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Surfaces follow sainnhe/everforest (Omarchy's
;; Neovim config uses `background = "soft"'); the syntax mapping mirrors
;; neanias/everforest-nvim so Emacs and Neovim render code consistently.
;; Named slots keep the theorytoe/everforest-emacs prefix convention.
;;
;; Key semantic groups (everforest-nvim highlight groups):
;;   keywords  red      builtin  green     constants aqua
;;   functions green    methods  green     type      yellow
;;   strings   green    variables fg       numbers   purple
;;   operators orange   comments mono-3 italic      region    gutter

;;; Code:

(require 'omarchy-themes)

(defconst everforest-palette-partial
  '(;; Core surfaces (sainnhe everforest "medium" dark — matches Omarchy's
    ;; colors.toml background #2d353b; Omarchy's neovim.lua says "soft"
    ;; but the terminal + system both use medium shades)
    (bg-main       "#2d353b")  ; bg0 medium
    (bg-dim        "#232a2e")  ; bg_dim
    (bg-alt        "#343f44")  ; bg1
    (bg-active     "#3d484d")  ; bg2
    (bg-inactive   "#232a2e")
    (border        "#475258")  ; bg3

    ;; Foregrounds
    (fg-main       "#d3c6aa")  ; fg
    (fg-dim        "#859289")  ; mono-3 (comments)
    (fg-alt        "#9da9a0")  ; silver
    (cursor        "#d3c6aa")

    ;; theorytoe everforest-emacs named slots
    (ever-red      "#e67e80")   ; keywords
    (ever-orange   "#e69875")   ; operators
    (ever-yellow   "#dbbc7f")   ; types, warning (sainnhe yellow; theorytoe uses #ddbc7f)
    (ever-green    "#a7c080")   ; functions, builtin, strings, success
    (ever-aqua     "#83c092")   ; constants (called `cyan' in theorytoe)
    (ever-blue     "#7fbbb3")   ; properties, info
    (ever-purple   "#d699b6")   ; numbers, preprocessor
    (ever-grey0    "#7a8478")
    (ever-grey1    "#859289")   ; mono-3
    (ever-grey2    "#9da9a0")   ; silver
    (ever-bg-visual "#543a48")  ; medium-dark visual selection
    (ever-gutter    "#445055")  ; region bg in theorytoe

    ;; Modus primary color slots
    (red           "#e67e80")
    (red-warmer    "#e69875")
    (red-cooler    "#e67e80")
    (red-faint     "#e67e80")
    (red-intense   "#e67e80")
    (green         "#a7c080")
    (green-warmer  "#a7c080")
    (green-cooler  "#83c092")
    (green-faint   "#a7c080")
    (green-intense "#a7c080")
    (yellow        "#ddbc7f")
    (yellow-warmer "#e69875")
    (yellow-cooler "#ddbc7f")
    (yellow-faint  "#ddbc7f")
    (yellow-intense "#ddbc7f")
    (blue          "#7fbbb3")
    (blue-warmer   "#d699b6")
    (blue-cooler   "#83c092")
    (blue-faint    "#7fbbb3")
    (blue-intense  "#7fbbb3")
    (magenta       "#d699b6")
    (magenta-warmer "#d699b6")
    (magenta-cooler "#d699b6")
    (magenta-faint "#d699b6")
    (magenta-intense "#d699b6")
    (cyan          "#83c092")
    (cyan-warmer   "#83c092")
    (cyan-cooler   "#7fbbb3")
    (cyan-faint    "#83c092")
    (cyan-intense  "#83c092")

    ;; Diff backgrounds (everforest bg_*)
    (bg-added            "#48584e")
    (bg-added-faint      "#3a463d")
    (bg-added-refine     "#5a6e5e")
    (bg-added-intense    "#708869")
    (fg-added            "#b6cb96")
    (fg-added-intense    "#c5dba2")

    (bg-removed          "#59464c")
    (bg-removed-faint    "#43373c")
    (bg-removed-refine   "#7a5c63")
    (bg-removed-intense  "#9a717a")
    (fg-removed          "#e67e80")
    (fg-removed-intense  "#f2a0a2")

    (bg-changed          "#55544a")
    (bg-changed-faint    "#403f37")
    (bg-changed-refine   "#706e5c")
    (bg-changed-intense  "#8c8972")
    (fg-changed          "#ddbc7f")
    (fg-changed-intense  "#e8cb9a"))
  "Everforest base colors, aligned with theorytoe/everforest-emacs.")

(defconst everforest-palette-mappings-partial
  '(;; ---- Syntax (matches neanias/everforest-nvim groups) ----
    (keyword         ever-red)         ; keywords -> red
    (builtin         ever-green)       ; @function.builtin -> green
    (constant        ever-aqua)        ; constants -> aqua
    (number          ever-purple)      ; @number -> purple
    (fnname          ever-green)       ; functions -> green
    (fnname-call     ever-green)
    (name            ever-green)
    (type            ever-yellow)      ; Type -> yellow
    (variable        fg-main)          ; @variable -> fg
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        ever-blue)        ; @property -> blue
    (property-use    ever-blue)
    (string          ever-green)       ; strings -> green
    (docstring       ever-green)
    (comment         ever-grey1)       ; comments -> mono-3 italic
    (preprocessor    ever-purple)      ; PreProc -> purple
    (operator        ever-orange)      ; Operator -> orange
    (punctuation     ever-grey2)
    (rx-construct    ever-purple)
    (rx-backslash    ever-aqua)

    ;; ---- Status / diagnostics ----
    (err             ever-red)
    (warning         ever-yellow)
    (info            ever-blue)
    (note            ever-aqua)
    (success         ever-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              ever-red)
    (modeline-warning          ever-yellow)
    (modeline-info             ever-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   ever-grey0)
    (fg-line-number-active     ever-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 ever-bg-visual)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            ever-orange)
    (bg-search-current         ever-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      ever-blue)
    (link-symbolic             ever-aqua)
    (cursor                    fg-main)
    (prompt                    ever-blue)

    ;; ---- Headings ----
    (fg-heading-0              ever-blue)
    (fg-heading-1              ever-green)
    (fg-heading-2              ever-yellow)
    (fg-heading-3              ever-orange)
    (fg-heading-4              ever-purple)
    (fg-heading-5              ever-aqua)
    (fg-heading-6              ever-red)
    (fg-heading-7              ever-blue)
    (fg-heading-8              ever-grey2))
  "Semantic slot mappings for Everforest (everforest-nvim alignment).")

(defconst everforest-palette
  (modus-themes-generate-palette
   everforest-palette-partial
   nil
   modus-themes-vivendi-palette
   everforest-palette-mappings-partial)
  "Complete Everforest palette for use with `modus-themes-theme'.")

(defcustom everforest-palette-overrides nil
  "User-level palette overrides for the Everforest theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Everforest italicizes comments.  Variables stay plain.
(defvar everforest-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar everforest-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'everforest
   'omarchy-themes
   "Everforest, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'everforest-palette
   'everforest-palette-overrides
   'everforest-custom-faces
   'everforest-custom-variables)

(provide 'everforest-theme)
;;; everforest-theme.el ends here

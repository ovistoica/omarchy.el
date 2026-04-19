;;; gruvbox-theme.el --- Gruvbox dark, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Gruvbox (dark, medium contrast) for Emacs, derived from Modus Vivendi
;; via `modus-themes-theme'.  Mirrors the highlight mapping from
;; ellisonleao/gruvbox.nvim so Emacs and Neovim render source code
;; consistently.
;;
;; Keyword → red, Function → green, Identifier → blue, Type → yellow,
;; String → green, Constant → purple, PreProc → aqua, Operator → orange,
;; Comment → gray italic.

;;; Code:

(require 'omarchy-themes)

(defconst gruvbox-palette-partial
  '(;; Core surfaces (gruvbox dark medium)
    (bg-main       "#282828")  ; dark0
    (bg-dim        "#32302f")  ; dark0_soft
    (bg-alt        "#3c3836")  ; dark1
    (bg-active     "#504945")  ; dark2
    (bg-inactive   "#1d2021")  ; dark0_hard
    (border        "#665c54")  ; dark3

    ;; Foregrounds
    (fg-main       "#ebdbb2")  ; light1
    (fg-dim        "#928374")  ; gray (comments)
    (fg-alt        "#d5c4a1")  ; light2
    (cursor        "#ebdbb2")

    ;; Gruvbox named slots (bright variants used by default)
    (gruv-red      "#fb4934")
    (gruv-green    "#b8bb26")
    (gruv-yellow   "#fabd2f")
    (gruv-blue     "#83a598")
    (gruv-purple   "#d3869b")
    (gruv-aqua     "#8ec07c")
    (gruv-orange   "#fe8019")
    (gruv-gray     "#928374")
    (gruv-dark3    "#665c54")
    (gruv-dark4    "#7c6f64")
    (gruv-light4   "#a89984")

    ;; Modus primary color slots
    (red           "#fb4934")
    (red-warmer    "#fe8019")
    (red-cooler    "#fb4934")
    (red-faint     "#cc241d")
    (red-intense   "#fb4934")
    (green         "#b8bb26")
    (green-warmer  "#b8bb26")
    (green-cooler  "#8ec07c")
    (green-faint   "#b8bb26")
    (green-intense "#b8bb26")
    (yellow        "#fabd2f")
    (yellow-warmer "#fe8019")
    (yellow-cooler "#fabd2f")
    (yellow-faint  "#fabd2f")
    (yellow-intense "#fabd2f")
    (blue          "#83a598")
    (blue-warmer   "#d3869b")
    (blue-cooler   "#83a598")
    (blue-faint    "#83a598")
    (blue-intense  "#83a598")
    (magenta       "#d3869b")
    (magenta-warmer "#d3869b")
    (magenta-cooler "#d3869b")
    (magenta-faint "#d3869b")
    (magenta-intense "#d3869b")
    (cyan          "#8ec07c")
    (cyan-warmer   "#8ec07c")
    (cyan-cooler   "#83a598")
    (cyan-faint    "#8ec07c")
    (cyan-intense  "#8ec07c")

    ;; Diff backgrounds
    (bg-added            "#34381b")
    (bg-added-faint      "#272a14")
    (bg-added-refine     "#4e5426")
    (bg-added-intense    "#687033")
    (fg-added            "#b8bb26")
    (fg-added-intense    "#d4d650")

    (bg-removed          "#3c1e1e")
    (bg-removed-faint    "#2c1616")
    (bg-removed-refine   "#5c2c2c")
    (bg-removed-intense  "#7c3838")
    (fg-removed          "#fb4934")
    (fg-removed-intense  "#fc7b6e")

    (bg-changed          "#3a3315")
    (bg-changed-faint    "#2a2410")
    (bg-changed-refine   "#575023")
    (bg-changed-intense  "#736930")
    (fg-changed          "#fabd2f")
    (fg-changed-intense  "#fccf5d"))
  "Gruvbox dark base colors, in Modus palette format.")

(defconst gruvbox-palette-mappings-partial
  '(;; ---- Syntax (matches gruvbox.nvim) ----
    (keyword         gruv-red)        ; Keyword, Statement -> GruvboxRed
    (builtin         gruv-aqua)       ; PreProc, Macro
    (constant        gruv-purple)     ; Constant, Number, Boolean
    (fnname          gruv-green)      ; Function -> GruvboxGreenBold
    (fnname-call     gruv-green)
    (name            gruv-green)
    (type            gruv-yellow)     ; Type, Typedef
    (variable        gruv-blue)       ; Identifier -> GruvboxBlue
    (variable-use    gruv-blue)
    (identifier      gruv-blue)
    (property        gruv-blue)       ; @property
    (property-use    gruv-blue)
    (string          gruv-green)      ; String
    (docstring       gruv-green)
    (comment         gruv-gray)       ; Comment italic
    (preprocessor    gruv-aqua)
    (operator        gruv-orange)     ; Operator italic
    (punctuation     gruv-light4)     ; Delimiter
    (rx-construct    gruv-purple)
    (rx-backslash    gruv-aqua)

    ;; ---- Status / diagnostics ----
    (err             gruv-red)
    (warning         gruv-yellow)
    (info            gruv-blue)
    (note            gruv-aqua)
    (success         gruv-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   border)
    (bg-mode-line-inactive     bg-alt)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              gruv-red)
    (modeline-warning          gruv-yellow)
    (modeline-info             gruv-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   gruv-dark4)
    (fg-line-number-active     gruv-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            gruv-orange)
    (bg-search-current         gruv-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      gruv-blue)
    (link-symbolic             gruv-aqua)
    (cursor                    fg-main)
    (prompt                    gruv-aqua)

    ;; ---- Headings ----
    (fg-heading-0              gruv-aqua)
    (fg-heading-1              gruv-green)
    (fg-heading-2              gruv-yellow)
    (fg-heading-3              gruv-blue)
    (fg-heading-4              gruv-purple)
    (fg-heading-5              gruv-aqua)
    (fg-heading-6              gruv-orange)
    (fg-heading-7              gruv-red)
    (fg-heading-8              gruv-gray))
  "Semantic slot mappings for Gruvbox dark.")

(defconst gruvbox-palette
  (modus-themes-generate-palette
   gruvbox-palette-partial
   nil
   modus-themes-vivendi-palette
   gruvbox-palette-mappings-partial)
  "Complete Gruvbox palette for use with `modus-themes-theme'.")

(defcustom gruvbox-palette-overrides nil
  "User-level palette overrides for the Gruvbox theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Gruvbox italicizes comments and operators by default.
(defvar gruvbox-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,gruv-blue :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,gruv-blue :slant normal)))
    `(help-argument-name           ((,c :foreground ,gruv-blue :slant normal)))
    ;; gruvbox.nvim links Function to GruvboxGreenBold
    `(font-lock-function-name-face ((,c :foreground ,gruv-green :weight bold))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar gruvbox-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'gruvbox
   'omarchy-themes
   "Gruvbox dark (medium contrast), derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'gruvbox-palette
   'gruvbox-palette-overrides
   'gruvbox-custom-faces
   'gruvbox-custom-variables))

(provide 'gruvbox-theme)
;;; gruvbox-theme.el ends here

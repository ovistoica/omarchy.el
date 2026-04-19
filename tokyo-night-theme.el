;;; tokyo-night-theme.el --- Tokyo Night, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Tokyo Night (night style) for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the highlight mapping from
;; folke/tokyonight.nvim (groups/base.lua) so Emacs and Neovim render
;; source code consistently.
;;
;; Palette (from colors/night.lua + storm.lua):
;;   bg       #1a1b26   background
;;   bg_dark  #16161e   panels
;;   fg       #c0caf5   default text
;;   comment  #565f89   comments
;;   blue     #7aa2f7   functions
;;   magenta  #bb9af7   identifiers/variables
;;   cyan     #7dcfff   keywords, PreProc
;;   blue1    #2ac3de   types
;;   blue5    #89ddff   operators
;;   green    #9ece6a   strings
;;   orange   #ff9e64   constants, numbers, booleans
;;   yellow   #e0af68   warnings
;;   red      #f7768e   errors

;;; Code:

(require 'omarchy-themes)

(defconst tokyo-night-palette-partial
  '(;; Core surfaces
    (bg-main       "#1a1b26")  ; bg
    (bg-dim        "#16161e")  ; bg_dark
    (bg-alt        "#292e42")  ; bg_highlight
    (bg-active     "#3b4261")  ; fg_gutter
    (bg-inactive   "#0c0e14")  ; bg_dark1
    (border        "#414868")  ; terminal_black

    ;; Foregrounds
    (fg-main       "#c0caf5")  ; fg
    (fg-dim        "#565f89")  ; comment
    (fg-alt        "#a9b1d6")  ; fg_dark
    (cursor        "#c0caf5")

    ;; Tokyo Night named slots
    (tn-blue       "#7aa2f7")
    (tn-blue1      "#2ac3de")
    (tn-blue5      "#89ddff")
    (tn-cyan       "#7dcfff")
    (tn-magenta    "#bb9af7")
    (tn-purple     "#9d7cd8")
    (tn-red        "#f7768e")
    (tn-orange     "#ff9e64")
    (tn-yellow     "#e0af68")
    (tn-green      "#9ece6a")
    (tn-green1     "#73daca")
    (tn-teal       "#1abc9c")
    (tn-comment    "#565f89")
    (tn-dark3      "#545c7e")
    (tn-fg-dark    "#a9b1d6")

    ;; Modus primary color slots
    (red           "#f7768e")
    (red-warmer    "#ff9e64")
    (red-cooler    "#f7768e")
    (red-faint     "#f7768e")
    (red-intense   "#db4b4b")
    (green         "#9ece6a")
    (green-warmer  "#9ece6a")
    (green-cooler  "#73daca")
    (green-faint   "#9ece6a")
    (green-intense "#9ece6a")
    (yellow        "#e0af68")
    (yellow-warmer "#ff9e64")
    (yellow-cooler "#e0af68")
    (yellow-faint  "#e0af68")
    (yellow-intense "#e0af68")
    (blue          "#7aa2f7")
    (blue-warmer   "#bb9af7")
    (blue-cooler   "#2ac3de")
    (blue-faint    "#7aa2f7")
    (blue-intense  "#7aa2f7")
    (magenta       "#bb9af7")
    (magenta-warmer "#ff007c")
    (magenta-cooler "#9d7cd8")
    (magenta-faint "#bb9af7")
    (magenta-intense "#bb9af7")
    (cyan          "#7dcfff")
    (cyan-warmer   "#73daca")
    (cyan-cooler   "#2ac3de")
    (cyan-faint    "#7dcfff")
    (cyan-intense  "#7dcfff")

    ;; Diff backgrounds
    (bg-added            "#20341f")
    (bg-added-faint      "#182718")
    (bg-added-refine     "#2f4d2d")
    (bg-added-intense    "#3f663d")
    (fg-added            "#9ece6a")
    (fg-added-intense    "#c3e996")

    (bg-removed          "#3f1e28")
    (bg-removed-faint    "#2f161e")
    (bg-removed-refine   "#5a2c39")
    (bg-removed-intense  "#77404e")
    (fg-removed          "#f7768e")
    (fg-removed-intense  "#fba7b6")

    (bg-changed          "#2a2a4a")
    (bg-changed-faint    "#1d1d36")
    (bg-changed-refine   "#3d3d6c")
    (bg-changed-intense  "#52528e")
    (fg-changed          "#7aa2f7")
    (fg-changed-intense  "#a6bdfb"))
  "Tokyo Night (night) base colors, in Modus palette format.")

(defconst tokyo-night-palette-mappings-partial
  '(;; ---- Syntax (matches tokyonight.nvim base.lua) ----
    (keyword         tn-cyan)         ; Keyword
    (builtin         tn-cyan)         ; PreProc, Macro
    (constant        tn-orange)       ; Constant, Number, Boolean, Float
    (fnname          tn-blue)         ; Function
    (fnname-call     tn-blue)
    (name            tn-blue)
    (type            tn-blue1)        ; Type
    (variable        tn-magenta)      ; Identifier
    (variable-use    tn-magenta)
    (identifier      tn-magenta)
    (property        tn-green1)       ; @property -> green1 teal
    (property-use    tn-green1)
    (string          tn-green)        ; String
    (docstring       tn-green)
    (comment         tn-comment)      ; Comment — italic
    (preprocessor    tn-cyan)
    (operator        tn-blue5)        ; Operator
    (punctuation     tn-fg-dark)      ; Delimiter
    (rx-construct    tn-blue5)
    (rx-backslash    tn-magenta)

    ;; ---- Status / diagnostics ----
    (err             tn-red)
    (warning         tn-yellow)
    (info            tn-blue)
    (note            tn-cyan)
    (success         tn-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-dim)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-main)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              tn-red)
    (modeline-warning          tn-yellow)
    (modeline-info             tn-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   bg-active)
    (fg-line-number-active     tn-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-alt)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            tn-orange)
    (bg-search-current         tn-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      tn-blue)
    (link-symbolic             tn-cyan)
    (cursor                    fg-main)
    (prompt                    tn-magenta)

    ;; ---- Headings ----
    (fg-heading-0              tn-magenta)
    (fg-heading-1              tn-blue)
    (fg-heading-2              tn-cyan)
    (fg-heading-3              tn-green)
    (fg-heading-4              tn-yellow)
    (fg-heading-5              tn-magenta)
    (fg-heading-6              tn-orange)
    (fg-heading-7              tn-red)
    (fg-heading-8              tn-teal))
  "Semantic slot mappings for Tokyo Night.")

(defconst tokyo-night-palette
  (modus-themes-generate-palette
   tokyo-night-palette-partial
   nil
   modus-themes-vivendi-palette
   tokyo-night-palette-mappings-partial)
  "Complete Tokyo Night palette for use with `modus-themes-theme'.")

(defcustom tokyo-night-palette-overrides nil
  "User-level palette overrides for the Tokyo Night theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'modus-themes)

;; tokyonight.nvim applies italic only to comments by default.
(defvar tokyo-night-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,tn-magenta :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,tn-magenta :slant normal)))
    `(help-argument-name           ((,c :foreground ,tn-magenta :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar tokyo-night-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'tokyo-night
   'omarchy-themes
   "Tokyo Night, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'tokyo-night-palette
   'tokyo-night-palette-overrides
   'tokyo-night-custom-faces
   'tokyo-night-custom-variables))

(provide 'tokyo-night-theme)
;;; tokyo-night-theme.el ends here

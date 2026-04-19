;;; catppuccin-mocha-theme.el --- Catppuccin Mocha, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Catppuccin Mocha for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the highlight mapping from
;; catppuccin/nvim (lua/catppuccin/groups/syntax.lua) so Emacs and
;; Neovim render source code consistently.
;;
;; Palette (from palettes/mocha.lua):
;;   base     #1e1e2e   bg-main
;;   mantle   #181825   bg-dim
;;   crust    #11111b   deeper
;;   surface0 #313244   bg-alt
;;   surface1 #45475a   bg-active
;;   overlay2 #9399b2   comments
;;   text     #cdd6f4   default fg
;;   rosewater#f5e0dc   cursor
;;   red      #f38ba8   errors
;;   peach    #fab387   constants, numbers, booleans
;;   yellow   #f9e2af   types, storage classes
;;   green    #a6e3a1   strings, diff-add
;;   teal     #94e2d5   characters, escapes
;;   sky      #89dceb   operators
;;   sapphire #74c7ec   labels
;;   blue     #89b4fa   functions
;;   lavender #b4befe   tags
;;   mauve    #cba6f7   keywords, conditionals, macros
;;   pink     #f5c2e7   PreProc, special
;;   flamingo #f2cdcd   identifiers/variables

;;; Code:

(require 'omarchy-themes)

(defconst catppuccin-mocha-palette-partial
  '(;; Core surfaces
    (bg-main       "#1e1e2e")  ; base
    (bg-dim        "#181825")  ; mantle
    (bg-alt        "#313244")  ; surface0
    (bg-active     "#45475a")  ; surface1
    (bg-inactive   "#11111b")  ; crust
    (border        "#585b70")  ; surface2

    ;; Foregrounds
    (fg-main       "#cdd6f4")  ; text
    (fg-dim        "#9399b2")  ; overlay2 (comments)
    (fg-alt        "#bac2de")  ; subtext1
    (cursor        "#f5e0dc")  ; rosewater

    ;; Catppuccin named slots
    (cat-rosewater "#f5e0dc")
    (cat-flamingo  "#f2cdcd")
    (cat-pink      "#f5c2e7")
    (cat-mauve     "#cba6f7")
    (cat-red       "#f38ba8")
    (cat-maroon    "#eba0ac")
    (cat-peach     "#fab387")
    (cat-yellow    "#f9e2af")
    (cat-green     "#a6e3a1")
    (cat-teal      "#94e2d5")
    (cat-sky       "#89dceb")
    (cat-sapphire  "#74c7ec")
    (cat-blue      "#89b4fa")
    (cat-lavender  "#b4befe")
    (cat-overlay2  "#9399b2")
    (cat-overlay1  "#7f849c")
    (cat-subtext1  "#bac2de")
    (cat-surface2  "#585b70")

    ;; Modus primary color slots
    (red           "#f38ba8")
    (red-warmer    "#eba0ac")  ; maroon
    (red-cooler    "#f38ba8")
    (red-faint     "#f38ba8")
    (red-intense   "#f38ba8")
    (green         "#a6e3a1")
    (green-warmer  "#a6e3a1")
    (green-cooler  "#94e2d5")  ; teal
    (green-faint   "#a6e3a1")
    (green-intense "#a6e3a1")
    (yellow        "#f9e2af")
    (yellow-warmer "#fab387")  ; peach
    (yellow-cooler "#f9e2af")
    (yellow-faint  "#f9e2af")
    (yellow-intense "#f9e2af")
    (blue          "#89b4fa")
    (blue-warmer   "#b4befe")  ; lavender
    (blue-cooler   "#74c7ec")  ; sapphire
    (blue-faint    "#89b4fa")
    (blue-intense  "#89b4fa")
    (magenta       "#cba6f7")  ; mauve
    (magenta-warmer "#f5c2e7") ; pink
    (magenta-cooler "#cba6f7")
    (magenta-faint "#cba6f7")
    (magenta-intense "#cba6f7")
    (cyan          "#89dceb")  ; sky
    (cyan-warmer   "#94e2d5")  ; teal
    (cyan-cooler   "#74c7ec")  ; sapphire
    (cyan-faint    "#89dceb")
    (cyan-intense  "#89dceb")

    ;; Diff backgrounds — tuned for mocha bg
    (bg-added            "#1e3b2e")
    (bg-added-faint      "#182e24")
    (bg-added-refine     "#2b5640")
    (bg-added-intense    "#3c7054")
    (fg-added            "#a6e3a1")
    (fg-added-intense    "#c3efbf")

    (bg-removed          "#472530")
    (bg-removed-faint    "#3a1e28")
    (bg-removed-refine   "#5e3440")
    (bg-removed-intense  "#7a4655")
    (fg-removed          "#f38ba8")
    (fg-removed-intense  "#f9b4c5")

    (bg-changed          "#3d3a1d")
    (bg-changed-faint    "#2d2c18")
    (bg-changed-refine   "#5a5426")
    (bg-changed-intense  "#766e30")
    (fg-changed          "#f9e2af")
    (fg-changed-intense  "#fcedc7"))
  "Catppuccin Mocha base colors, in Modus palette format.")

(defconst catppuccin-mocha-palette-mappings-partial
  '(;; ---- Syntax (matches catppuccin/nvim syntax.lua) ----
    (keyword         cat-mauve)       ; Keyword, Statement, Conditional, Repeat, Exception, Include
    (builtin         cat-mauve)       ; Macro = mauve
    (constant        cat-peach)       ; Constant, Number, Boolean, Float
    (fnname          cat-blue)        ; Function definitions
    (fnname-call     cat-blue)        ; Function calls
    (name            cat-blue)
    (type            cat-yellow)      ; Type, Structure, Typedef, StorageClass
    (variable        cat-flamingo)    ; Identifier
    (variable-use    cat-flamingo)
    (identifier      cat-flamingo)
    (property        cat-lavender)    ; @property, @field
    (property-use    cat-lavender)
    (string          cat-green)       ; String
    (docstring       cat-green)       ; docstrings render like strings
    (comment         cat-overlay2)    ; Comment — overlay2, italic
    (preprocessor    cat-pink)        ; PreProc
    (operator        cat-sky)         ; Operator
    (punctuation     cat-overlay2)    ; Delimiter
    (rx-construct    cat-pink)        ; regex constructs
    (rx-backslash    cat-teal)        ; @string.escape

    ;; ---- Status / diagnostics ----
    (err             cat-red)
    (warning         cat-yellow)
    (info            cat-blue)
    (note            cat-teal)
    (success         cat-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              cat-red)
    (modeline-warning          cat-yellow)
    (modeline-info             cat-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   cat-surface2)
    (fg-line-number-active     cat-lavender)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-dim)
    (bg-paren-match            bg-active)
    (fg-paren-match            cat-peach)
    (bg-search-current         cat-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      cat-blue)
    (link-symbolic             cat-teal)
    (cursor                    cat-rosewater)
    (prompt                    cat-mauve)

    ;; ---- Headings (mirror catppuccin markdown/htmlH) ----
    (fg-heading-0              cat-lavender)
    (fg-heading-1              cat-pink)
    (fg-heading-2              cat-blue)
    (fg-heading-3              cat-peach)
    (fg-heading-4              cat-green)
    (fg-heading-5              cat-mauve)
    (fg-heading-6              cat-teal)
    (fg-heading-7              cat-yellow)
    (fg-heading-8              cat-red))
  "Semantic slot mappings for Catppuccin Mocha.
Mirrors the catppuccin/nvim syntax group specification.")

(defconst catppuccin-mocha-palette
  (modus-themes-generate-palette
   catppuccin-mocha-palette-partial
   nil
   modus-themes-vivendi-palette
   catppuccin-mocha-palette-mappings-partial)
  "Complete Catppuccin Mocha palette for use with `modus-themes-theme'.")

(defcustom catppuccin-mocha-palette-overrides nil
  "User-level palette overrides for the Catppuccin Mocha theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'modus-themes)

;; Catppuccin italicizes comments but not variables.  Override
;; variable faces back to upright.
(defvar catppuccin-mocha-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,cat-flamingo :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,cat-flamingo :slant normal)))
    `(help-argument-name           ((,c :foreground ,cat-flamingo :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar catppuccin-mocha-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'catppuccin-mocha
   'omarchy-themes
   "Catppuccin Mocha, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'catppuccin-mocha-palette
   'catppuccin-mocha-palette-overrides
   'catppuccin-mocha-custom-faces
   'catppuccin-mocha-custom-variables))

(provide 'catppuccin-mocha-theme)
;;; catppuccin-mocha-theme.el ends here

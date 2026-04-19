;;; catppuccin-latte-theme.el --- Catppuccin Latte, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Catppuccin Latte for Emacs, derived from Modus Operandi via
;; `modus-themes-theme'.  Mirrors the highlight mapping from
;; catppuccin/nvim (groups/syntax.lua), using the Latte palette.

;;; Code:

(require 'omarchy-themes)

(defconst catppuccin-latte-palette-partial
  '(;; Core surfaces
    (bg-main       "#eff1f5")  ; base
    (bg-dim        "#e6e9ef")  ; mantle
    (bg-alt        "#ccd0da")  ; surface0
    (bg-active     "#bcc0cc")  ; surface1
    (bg-inactive   "#dce0e8")  ; crust
    (border        "#acb0be")  ; surface2

    ;; Foregrounds
    (fg-main       "#4c4f69")  ; text
    (fg-dim        "#7c7f93")  ; overlay2 (comments)
    (fg-alt        "#5c5f77")  ; subtext1
    (cursor        "#dc8a78")  ; rosewater

    ;; Catppuccin Latte named slots
    (cat-rosewater "#dc8a78")
    (cat-flamingo  "#dd7878")
    (cat-pink      "#ea76cb")
    (cat-mauve     "#8839ef")
    (cat-red       "#d20f39")
    (cat-maroon    "#e64553")
    (cat-peach     "#fe640b")
    (cat-yellow    "#df8e1d")
    (cat-green     "#40a02b")
    (cat-teal      "#179299")
    (cat-sky       "#04a5e5")
    (cat-sapphire  "#209fb5")
    (cat-blue      "#1e66f5")
    (cat-lavender  "#7287fd")
    (cat-overlay2  "#7c7f93")
    (cat-overlay1  "#8c8fa1")
    (cat-subtext1  "#5c5f77")
    (cat-surface2  "#acb0be")

    ;; Modus primary color slots
    (red           "#d20f39")
    (red-warmer    "#e64553")
    (red-cooler    "#d20f39")
    (red-faint     "#d20f39")
    (red-intense   "#d20f39")
    (green         "#40a02b")
    (green-warmer  "#40a02b")
    (green-cooler  "#179299")
    (green-faint   "#40a02b")
    (green-intense "#40a02b")
    (yellow        "#df8e1d")
    (yellow-warmer "#fe640b")
    (yellow-cooler "#df8e1d")
    (yellow-faint  "#df8e1d")
    (yellow-intense "#df8e1d")
    (blue          "#1e66f5")
    (blue-warmer   "#7287fd")
    (blue-cooler   "#209fb5")
    (blue-faint    "#1e66f5")
    (blue-intense  "#1e66f5")
    (magenta       "#8839ef")
    (magenta-warmer "#ea76cb")
    (magenta-cooler "#8839ef")
    (magenta-faint "#8839ef")
    (magenta-intense "#8839ef")
    (cyan          "#04a5e5")
    (cyan-warmer   "#179299")
    (cyan-cooler   "#209fb5")
    (cyan-faint    "#04a5e5")
    (cyan-intense  "#04a5e5")

    ;; Diff backgrounds — tuned for light paper bg
    (bg-added            "#d8e9c6")
    (bg-added-faint      "#e7f1dc")
    (bg-added-refine     "#bdd9a3")
    (bg-added-intense    "#a0c784")
    (fg-added            "#2b5d1a")
    (fg-added-intense    "#1f4711")

    (bg-removed          "#f2cdd1")
    (bg-removed-faint    "#f7dde0")
    (bg-removed-refine   "#e9a9ae")
    (bg-removed-intense  "#d88088")
    (fg-removed          "#7e0a22")
    (fg-removed-intense  "#5d0517")

    (bg-changed          "#f3e3c5")
    (bg-changed-faint    "#f7ecd5")
    (bg-changed-refine   "#ecd292")
    (bg-changed-intense  "#d6b361")
    (fg-changed          "#6d5000")
    (fg-changed-intense  "#523c00"))
  "Catppuccin Latte base colors, in Modus palette format.")

(defconst catppuccin-latte-palette-mappings-partial
  '(;; ---- Syntax (matches catppuccin/nvim syntax.lua) ----
    (keyword         cat-mauve)
    (builtin         cat-mauve)
    (constant        cat-peach)
    (fnname          cat-blue)
    (fnname-call     cat-blue)
    (name            cat-blue)
    (type            cat-yellow)
    (variable        cat-flamingo)
    (variable-use    cat-flamingo)
    (identifier      cat-flamingo)
    (property        cat-lavender)
    (property-use    cat-lavender)
    (string          cat-green)
    (docstring       cat-green)
    (comment         cat-overlay2)
    (preprocessor    cat-pink)
    (operator        cat-sky)
    (punctuation     cat-overlay2)
    (rx-construct    cat-pink)
    (rx-backslash    cat-teal)

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
    (bg-mode-line-inactive     bg-main)
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

    ;; ---- Headings ----
    (fg-heading-0              cat-lavender)
    (fg-heading-1              cat-pink)
    (fg-heading-2              cat-blue)
    (fg-heading-3              cat-peach)
    (fg-heading-4              cat-green)
    (fg-heading-5              cat-mauve)
    (fg-heading-6              cat-teal)
    (fg-heading-7              cat-yellow)
    (fg-heading-8              cat-red))
  "Semantic slot mappings for Catppuccin Latte.")

(defconst catppuccin-latte-palette
  (modus-themes-generate-palette
   catppuccin-latte-palette-partial
   nil
   modus-themes-operandi-palette
   catppuccin-latte-palette-mappings-partial)
  "Complete Catppuccin Latte palette for use with `modus-themes-theme'.")

(defcustom catppuccin-latte-palette-overrides nil
  "User-level palette overrides for the Catppuccin Latte theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

(defvar catppuccin-latte-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,cat-flamingo :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,cat-flamingo :slant normal)))
    `(help-argument-name           ((,c :foreground ,cat-flamingo :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar catppuccin-latte-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'catppuccin-latte
   'omarchy-themes
   "Catppuccin Latte, derived from Modus Operandi."
   'light
   'modus-themes-operandi-palette
   'catppuccin-latte-palette
   'catppuccin-latte-palette-overrides
   'catppuccin-latte-custom-faces
   'catppuccin-latte-custom-variables))

(provide 'catppuccin-latte-theme)
;;; catppuccin-latte-theme.el ends here

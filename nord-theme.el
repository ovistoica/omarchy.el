;;; nord-theme.el --- Nordfox, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Nord (nordfox variant) for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the syntax.* spec from
;; EdenEast/nightfox.nvim (palette/nordfox.lua), which is what Omarchy's
;; Nord theme uses in Neovim.
;;
;; Keyword/Statement -> magenta, Conditional -> magenta.bright,
;; Function -> blue.bright, Identifier -> cyan, Variable -> white,
;; Type -> yellow, Const/Number -> orange, String -> green,
;; PreProc -> pink.bright, Comment -> muted.

;;; Code:

(require 'omarchy-themes)

(defconst nord-palette-partial
  '(;; Core surfaces (nordfox)
    (bg-main       "#2e3440")  ; bg1
    (bg-dim        "#232831")  ; bg0
    (bg-alt        "#39404f")  ; bg2
    (bg-active     "#444c5e")  ; bg3
    (bg-inactive   "#232831")
    (border        "#5a657d")  ; bg4

    ;; Foregrounds
    (fg-main       "#cdcecf")  ; fg1
    (fg-dim        "#60728a")  ; comment
    (fg-alt        "#abb1bb")  ; fg2
    (cursor        "#d8dee9")

    ;; Nordfox named slots
    (nord-red         "#bf616a")
    (nord-red-bright  "#d06f79")
    (nord-green       "#a3be8c")
    (nord-yellow      "#ebcb8b")
    (nord-yellow-bright "#f0d399")
    (nord-blue        "#81a1c1")
    (nord-blue-bright "#8cafd2")
    (nord-magenta     "#b48ead")
    (nord-magenta-bright "#c895bf")
    (nord-cyan        "#88c0d0")
    (nord-cyan-bright "#93ccdc")
    (nord-orange      "#c9826b")
    (nord-orange-bright "#d89079")
    (nord-pink        "#bf88bc")
    (nord-pink-bright "#d092ce")
    (nord-white       "#e5e9f0")
    (nord-comment     "#60728a")
    (nord-fg2         "#abb1bb")
    (nord-fg3         "#7e8188")
    (nord-sel0        "#3e4a5b")
    (nord-sel1        "#4f6074")

    ;; Modus primary color slots
    (red           "#bf616a")
    (red-warmer    "#c9826b")
    (red-cooler    "#bf616a")
    (red-faint     "#a54e56")
    (red-intense   "#d06f79")
    (green         "#a3be8c")
    (green-warmer  "#a3be8c")
    (green-cooler  "#88c0d0")
    (green-faint   "#8aa872")
    (green-intense "#b1d196")
    (yellow        "#ebcb8b")
    (yellow-warmer "#c9826b")
    (yellow-cooler "#ebcb8b")
    (yellow-faint  "#d9b263")
    (yellow-intense "#f0d399")
    (blue          "#81a1c1")
    (blue-warmer   "#8cafd2")
    (blue-cooler   "#88c0d0")
    (blue-faint    "#668aab")
    (blue-intense  "#8cafd2")
    (magenta       "#b48ead")
    (magenta-warmer "#c895bf")
    (magenta-cooler "#b48ead")
    (magenta-faint "#9d7495")
    (magenta-intense "#c895bf")
    (cyan          "#88c0d0")
    (cyan-warmer   "#93ccdc")
    (cyan-cooler   "#81a1c1")
    (cyan-faint    "#69a7ba")
    (cyan-intense  "#93ccdc")

    ;; Diff backgrounds (blended per nordfox spec)
    (bg-added            "#2f3e3c")
    (bg-added-faint      "#28342f")
    (bg-added-refine     "#3e5749")
    (bg-added-intense    "#546f5c")
    (fg-added            "#a3be8c")
    (fg-added-intense    "#b6cca0")

    (bg-removed          "#3e3039")
    (bg-removed-faint    "#33272e")
    (bg-removed-refine   "#5a424b")
    (bg-removed-intense  "#74545e")
    (fg-removed          "#bf616a")
    (fg-removed-intense  "#d88088")

    (bg-changed          "#303a47")
    (bg-changed-faint    "#283039)")
    (bg-changed-refine   "#3f4d5c")
    (bg-changed-intense  "#536578")
    (fg-changed          "#81a1c1")
    (fg-changed-intense  "#9db4cf"))
  "Nordfox base colors, in Modus palette format.")

(defconst nord-palette-mappings-partial
  '(;; ---- Syntax (matches nightfox.nvim nordfox syntax spec) ----
    (keyword         nord-magenta)        ; Keyword, Statement -> magenta.base
    (builtin         nord-red)            ; builtin0 -> red.base
    (constant        nord-orange-bright)  ; const -> orange.bright
    (fnname          nord-blue-bright)    ; func -> blue.bright
    (fnname-call     nord-blue-bright)
    (name            nord-blue-bright)
    (type            nord-yellow)         ; type -> yellow.base
    (variable        nord-white)          ; variable -> white.base
    (variable-use    nord-white)
    (identifier      nord-cyan)           ; ident -> cyan.base
    (property        nord-blue)           ; field -> blue.base
    (property-use    nord-blue)
    (string          nord-green)          ; string -> green.base
    (docstring       nord-green)
    (comment         nord-comment)        ; italic
    (preprocessor    nord-pink-bright)    ; preproc -> pink.bright
    (operator        nord-fg2)            ; operator -> fg2
    (punctuation     nord-fg2)            ; bracket -> fg2
    (rx-construct    nord-yellow-bright)  ; regex -> yellow.bright
    (rx-backslash    nord-cyan-bright)

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
    (fg-line-number-inactive   nord-fg3)
    (fg-line-number-active     nord-orange-bright)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 nord-sel0)
    (fg-region                 fg-main)
    (bg-hl-line                bg-active)
    (bg-paren-match            bg-alt)
    (fg-paren-match            nord-orange)
    (bg-search-current         nord-yellow)
    (bg-search-lazy            nord-sel1)

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
    (fg-heading-0              nord-blue-bright)
    (fg-heading-1              nord-blue)
    (fg-heading-2              nord-cyan)
    (fg-heading-3              nord-green)
    (fg-heading-4              nord-yellow)
    (fg-heading-5              nord-magenta)
    (fg-heading-6              nord-orange)
    (fg-heading-7              nord-red)
    (fg-heading-8              nord-pink))
  "Semantic slot mappings for Nordfox.")

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
  :group 'modus-themes)

;; Nordfox: comments italic, variables plain fg.
(defvar nord-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,nord-white :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,nord-white :slant normal)))
    `(help-argument-name           ((,c :foreground ,nord-white :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar nord-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'nord
   'omarchy-themes
   "Nord (nordfox), derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'nord-palette
   'nord-palette-overrides
   'nord-custom-faces
   'nord-custom-variables))

(provide 'nord-theme)
;;; nord-theme.el ends here

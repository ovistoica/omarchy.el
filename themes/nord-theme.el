;;; nord-theme.el --- Nord, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Nord for Emacs, derived from Modus Vivendi via `modus-themes-theme'.
;; Mirrors the slot mapping from doom-themes/doom-nord.
;;
;; Key semantic groups (doom "face categories"):
;;   keyword  blue       builtin   blue       operator  blue
;;   function cyan       methods   cyan       type      teal
;;   strings  green      variables base7      numbers   magenta
;;   constants blue      region    base4      comments  lightened-base5

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
    (fg-added            "#a3be8c")
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
  '(;; ---- Syntax (matches doom-nord face categories) ----
    (keyword         nord-blue)         ; keyword -> blue
    (builtin         nord-blue)         ; builtin -> blue
    (constant        nord-blue)         ; constants -> blue
    (fnname          nord-cyan)         ; functions -> cyan
    (fnname-call     nord-cyan)
    (name            nord-cyan)
    (type            nord-teal)         ; type -> teal
    (variable        nord-base7)        ; variables -> base7
    (variable-use    nord-base7)
    (identifier      nord-base7)
    (property        nord-base7)
    (property-use    nord-base7)
    (string          nord-green)        ; strings -> green
    (docstring       nord-green)
    (comment         fg-dim)            ; comments -> lightened base5
    (preprocessor    nord-blue)
    (operator        nord-blue)         ; operators -> blue
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
  "Semantic slot mappings for Nord (doom-themes alignment).")

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

;; doom-nord does not italicize; we italicize comments for parity with
;; the rest of the omarchy pack.  Variables stay plain base7.
(defvar nord-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,nord-base7 :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,nord-base7 :slant normal)))
    `(help-argument-name           ((,c :foreground ,nord-base7 :slant normal))))
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

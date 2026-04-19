;;; kanagawa-theme.el --- Kanagawa Wave, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Kanagawa Wave for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the syntax mapping from
;; rebelot/kanagawa.nvim (themes.lua :: wave :: syn).

;;; Code:

(require 'omarchy-themes)

(defconst kanagawa-palette-partial
  '(;; Core surfaces (wave)
    (bg-main       "#1f1f28")  ; sumiInk3
    (bg-dim        "#181820")  ; sumiInk1
    (bg-alt        "#2a2a37")  ; sumiInk4
    (bg-active     "#363646")  ; sumiInk5
    (bg-inactive   "#16161d")  ; sumiInk0
    (border        "#54546d")  ; sumiInk6

    ;; Foregrounds
    (fg-main       "#dcd7ba")  ; fujiWhite
    (fg-dim        "#727169")  ; fujiGray (comments)
    (fg-alt        "#c8c093")  ; oldWhite
    (cursor        "#c8c093")

    ;; Kanagawa named slots
    (kana-spring-green "#98bb6c")
    (kana-crystal-blue "#7e9cd8")
    (kana-oni-violet   "#957fb8")
    (kana-oni-violet2  "#b8b4d0")
    (kana-carp-yellow  "#e6c384")
    (kana-boat-yellow2 "#c0a36e")
    (kana-surimi-orange "#ffa066")
    (kana-sakura-pink  "#d27e99")
    (kana-wave-red     "#e46876")
    (kana-peach-red    "#ff5d62")
    (kana-wave-aqua2   "#7aa89f")
    (kana-spring-blue  "#7fb4ca")
    (kana-spring-violet2 "#9cabca")
    (kana-fuji-gray    "#727169")
    (kana-katana-gray  "#717c7c")
    (kana-autumn-green "#76946a")
    (kana-autumn-red   "#c34043")
    (kana-autumn-yellow "#dca561")
    (kana-samurai-red  "#e82424")
    (kana-ronin-yellow "#ff9e3b")
    (kana-wave-blue2   "#2d4f67")  ; selection bg

    ;; Modus primary color slots
    (red           "#c34043")
    (red-warmer    "#e46876")
    (red-cooler    "#ff5d62")
    (red-faint     "#c34043")
    (red-intense   "#e82424")
    (green         "#98bb6c")
    (green-warmer  "#98bb6c")
    (green-cooler  "#7aa89f")
    (green-faint   "#76946a")
    (green-intense "#98bb6c")
    (yellow        "#e6c384")
    (yellow-warmer "#ffa066")
    (yellow-cooler "#c0a36e")
    (yellow-faint  "#dca561")
    (yellow-intense "#ff9e3b")
    (blue          "#7e9cd8")
    (blue-warmer   "#957fb8")
    (blue-cooler   "#7fb4ca")
    (blue-faint    "#7e9cd8")
    (blue-intense  "#7e9cd8")
    (magenta       "#957fb8")
    (magenta-warmer "#d27e99")
    (magenta-cooler "#957fb8")
    (magenta-faint "#957fb8")
    (magenta-intense "#957fb8")
    (cyan          "#7fb4ca")
    (cyan-warmer   "#7aa89f")
    (cyan-cooler   "#6a9589")
    (cyan-faint    "#7fb4ca")
    (cyan-intense  "#7fb4ca")

    ;; Diff backgrounds (kanagawa winter*)
    (bg-added            "#2b3328")
    (bg-added-faint      "#22281f")
    (bg-added-refine     "#3f4a37")
    (bg-added-intense    "#556648")
    (fg-added            "#76946a")
    (fg-added-intense    "#a3bf87")

    (bg-removed          "#43242b")
    (bg-removed-faint    "#321a20")
    (bg-removed-refine   "#623640")
    (bg-removed-intense  "#824954")
    (fg-removed          "#c34043")
    (fg-removed-intense  "#de6e70")

    (bg-changed          "#252535")
    (bg-changed-faint    "#1e1e2a")
    (bg-changed-refine   "#3b3b52")
    (bg-changed-intense  "#52526f")
    (fg-changed          "#dca561")
    (fg-changed-intense  "#e8bd80"))
  "Kanagawa Wave base colors, in Modus palette format.")

(defconst kanagawa-palette-mappings-partial
  '(;; ---- Syntax (matches kanagawa.nvim wave.syn) ----
    (keyword         kana-oni-violet)     ; Keyword, Statement
    (builtin         kana-wave-red)       ; Macro, PreProc
    (constant        kana-surimi-orange)  ; Constant
    (fnname          kana-crystal-blue)   ; Function
    (fnname-call     kana-crystal-blue)
    (name            kana-crystal-blue)
    (type            kana-wave-aqua2)     ; Type
    (variable        fg-main)             ; variable = "none" in kanagawa (fg)
    (variable-use    fg-main)
    (identifier      kana-carp-yellow)    ; Identifier
    (property        kana-carp-yellow)    ; @property
    (property-use    kana-carp-yellow)
    (string          kana-spring-green)   ; String
    (docstring       kana-spring-green)
    (comment         kana-fuji-gray)      ; Comment italic
    (preprocessor    kana-wave-red)       ; PreProc
    (operator        kana-boat-yellow2)   ; Operator
    (punctuation     kana-spring-violet2) ; Delimiter -> springViolet2
    (rx-construct    kana-boat-yellow2)   ; regex = boatYellow2
    (rx-backslash    kana-peach-red)      ; special3

    ;; ---- Status / diagnostics ----
    (err             kana-samurai-red)
    (warning         kana-ronin-yellow)
    (info            kana-crystal-blue)
    (note            kana-wave-aqua2)
    (success         kana-autumn-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-alt)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              kana-samurai-red)
    (modeline-warning          kana-ronin-yellow)
    (modeline-info             kana-crystal-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   kana-fuji-gray)
    (fg-line-number-active     kana-surimi-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 kana-wave-blue2)  ; waveBlue2 — kanagawa's selection
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            kana-surimi-orange)
    (bg-search-current         kana-carp-yellow)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      kana-crystal-blue)
    (link-symbolic             kana-spring-blue)
    (cursor                    fg-main)
    (prompt                    kana-oni-violet)

    ;; ---- Headings ----
    (fg-heading-0              kana-crystal-blue)
    (fg-heading-1              kana-surimi-orange)
    (fg-heading-2              kana-oni-violet)
    (fg-heading-3              kana-spring-green)
    (fg-heading-4              kana-carp-yellow)
    (fg-heading-5              kana-wave-aqua2)
    (fg-heading-6              kana-sakura-pink)
    (fg-heading-7              kana-wave-red)
    (fg-heading-8              kana-katana-gray))
  "Semantic slot mappings for Kanagawa Wave.")

(defconst kanagawa-palette
  (modus-themes-generate-palette
   kanagawa-palette-partial
   nil
   modus-themes-vivendi-palette
   kanagawa-palette-mappings-partial)
  "Complete Kanagawa palette for use with `modus-themes-theme'.")

(defcustom kanagawa-palette-overrides nil
  "User-level palette overrides for the Kanagawa theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Kanagawa italicizes comments.  Variables are plain fg.
(defvar kanagawa-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,kana-oni-violet2 :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar kanagawa-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(let ((modus-themes-italic-constructs t)
      (modus-themes-bold-constructs nil))
  (modus-themes-theme
   'kanagawa
   'omarchy-themes
   "Kanagawa Wave, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'kanagawa-palette
   'kanagawa-palette-overrides
   'kanagawa-custom-faces
   'kanagawa-custom-variables))

(provide 'kanagawa-theme)
;;; kanagawa-theme.el ends here

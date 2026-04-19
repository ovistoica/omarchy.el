;;; tokyo-night-theme.el --- Tokyo Night, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Tokyo Night for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the slot mapping from
;; doom-themes/doom-tokyo-night (night background, VSCode palette).
;;
;; Key semantic groups (doom "face categories"):
;;   builtin  red         keyword   magenta    operator  dark-cyan
;;   function blue        methods   blue       type      base8
;;   strings  dark-green  variables base8      numbers   orange
;;   constants orange     comments  base1/5    region    base0

;;; Code:

(require 'omarchy-themes)

(defconst tokyo-night-palette-partial
  '(;; Core surfaces (doom night)
    (bg-main       "#1a1b26")  ; bg
    (bg-dim        "#13141c")  ; bg-alt
    (bg-alt        "#242832")  ; base1
    (bg-active     "#414868")  ; base0 (region)
    (bg-inactive   "#13141c")
    (border        "#51587a")  ; base1 variant

    ;; Foregrounds
    (fg-main       "#a9b1d6")  ; fg
    (fg-dim        "#565f89")  ; comments (base1-ish)
    (fg-alt        "#c0caf5")  ; fg-alt / base8
    (cursor        "#c0caf5")

    ;; Doom Tokyo Night named slots
    (tn-base0       "#414868")  ; region / terminal black
    (tn-base1       "#242832")
    (tn-base5       "#9099c0")  ; brighter comments (optional)
    (tn-base8       "#c0caf5")  ; variables, type, fg-alt
    (tn-red         "#f7768e")  ; builtin, errors
    (tn-orange      "#ff9e64")  ; constants, numbers
    (tn-yellow      "#e0af68")  ; warnings, fn params
    (tn-green       "#9ece6a")  ; strings (dark-green)
    (tn-green-bright "#73daca") ; green accent
    (tn-teal        "#2ac3de")  ; support fns
    (tn-blue        "#7aa2f7")  ; functions
    (tn-dark-cyan   "#7dcfff")  ; operators, properties
    (tn-magenta     "#bb9af7")  ; keywords
    (tn-violet      "#9aa5ce")
    (tn-cyan        "#b4f9f8")
    (tn-dark-blue   "#565f89")
    (tn-brown       "#cfc9c2")

    ;; Modus primary color slots
    (red           "#f7768e")
    (red-warmer    "#ff9e64")
    (red-cooler    "#f7768e")
    (red-faint     "#f7768e")
    (red-intense   "#f7768e")
    (green         "#9ece6a")
    (green-warmer  "#73daca")
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
    (blue-cooler   "#7dcfff")
    (blue-faint    "#7aa2f7")
    (blue-intense  "#7aa2f7")
    (magenta       "#bb9af7")
    (magenta-warmer "#f7768e")
    (magenta-cooler "#9aa5ce")
    (magenta-faint "#bb9af7")
    (magenta-intense "#bb9af7")
    (cyan          "#7dcfff")
    (cyan-warmer   "#2ac3de")
    (cyan-cooler   "#b4f9f8")
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
  "Tokyo Night base colors, aligned with doom-themes' doom-tokyo-night.")

(defconst tokyo-night-palette-mappings-partial
  '(;; ---- Syntax (matches doom-tokyo-night face categories) ----
    (keyword         tn-magenta)       ; keywords -> magenta
    (builtin         tn-red)           ; builtin -> red
    (constant        tn-orange)        ; constants + numbers -> orange
    (fnname          tn-blue)          ; functions -> blue
    (fnname-call     tn-blue)
    (name            tn-blue)
    (type            tn-base8)         ; type -> base8 (plain bright fg)
    (variable        tn-base8)         ; variables -> base8
    (variable-use    tn-base8)
    (identifier      tn-base8)
    (property        tn-dark-cyan)     ; @property -> dark-cyan (object props)
    (property-use    tn-dark-cyan)
    (string          tn-green)         ; strings -> dark-green
    (docstring       tn-dark-blue)     ; doc-comments (lightened dark-blue)
    (comment         tn-dark-blue)     ; comments -> base1/dark-blue
    (preprocessor    tn-dark-cyan)     ; import/export -> dark-cyan
    (operator        tn-dark-cyan)     ; operators -> dark-cyan
    (punctuation     fg-main)          ; fg
    (rx-construct    tn-magenta)       ; regex symbols -> magenta
    (rx-backslash    tn-cyan)          ; regex literals -> cyan

    ;; ---- Status / diagnostics ----
    (err             tn-red)
    (warning         tn-yellow)
    (info            tn-blue)
    (note            tn-dark-cyan)
    (success         tn-green-bright)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-dim)
    (fg-mode-line-active       fg-alt)
    (border-mode-line-active   bg-active)
    (bg-mode-line-inactive     bg-main)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              tn-red)
    (modeline-warning          tn-yellow)
    (modeline-info             tn-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   tn-dark-blue)
    (fg-line-number-active     tn-base8)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 tn-base0)    ; region -> base0
    (fg-region                 fg-alt)
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
    (link-symbolic             tn-dark-cyan)
    (cursor                    fg-main)
    (prompt                    tn-magenta)

    ;; ---- Headings (doom uses dark-cyan for markdown-header) ----
    (fg-heading-0              tn-dark-cyan)
    (fg-heading-1              tn-dark-cyan)
    (fg-heading-2              tn-blue)
    (fg-heading-3              tn-magenta)
    (fg-heading-4              tn-green)
    (fg-heading-5              tn-orange)
    (fg-heading-6              tn-yellow)
    (fg-heading-7              tn-teal)
    (fg-heading-8              tn-red))
  "Semantic slot mappings for Tokyo Night (doom-themes alignment).")

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
  :group 'omarchy-themes)

;; doom-tokyo-night does not italicize by default.  We italicize
;; comments for parity with the rest of the omarchy pack; variables
;; and types stay upright (type=base8, variable=base8 in doom).
(defvar tokyo-night-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,tn-base8 :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,tn-base8 :slant normal)))
    `(help-argument-name           ((,c :foreground ,tn-yellow :slant normal))))
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

;;; starship-theme.el --- Starship, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Starship for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the Omarchy 4 `aether' Neovim rendering
;; of /usr/share/omarchy/themes/starship/colors.toml.  Starship ships no
;; `neovim.lua'; Omarchy generates one from colors.toml through
;; `default/themed/neovim.lua.tpl', which configures omacom/aether.nvim
;; (v3).  The syntax mapping below therefore follows aether's palette
;; slots, the same reference used for Vantablack.
;;
;; Keyword -> bright_magenta, Function -> blue, Type -> yellow,
;; Constant -> bright_yellow, Number/Boolean -> orange, String -> green,
;; @property -> bright_cyan, Builtin/PreProc -> cyan,
;; Operator -> foreground, Comment -> muted,
;; DiagnosticError -> bright_red, DiagnosticWarn -> yellow.
;;
;; An Apple-flavoured palette: a #1c1c1e canvas, near-white #f5f5f7 text,
;; and a single amber accent (#ff9f0a) that also serves as `green'.
;; Upstream italicizes comments and keywords; like every bundled theme,
;; italics are left to Modus's `modus-themes-italic-constructs' (off by
;; default).  Diff backgrounds are the aether blends of red/green/
;; selection over the theme bg.

;;; Code:

(require 'omarchy-themes)

(defconst starship-palette-partial
  '(;; Core surfaces
    (bg-main       "#1c1c1e")  ; background
    (bg-dim        "#0e0e10")  ; darker_background
    (bg-alt        "#2c2c2e")  ; lighter_background
    (bg-active     "#3a3a3c")  ; selection
    (bg-inactive   "#161618")  ; dark_background
    (border        "#8e8e93")  ; muted

    ;; Foregrounds
    (fg-main       "#f5f5f7")  ; foreground
    (fg-dim        "#98989d")  ; dark_foreground
    (fg-alt        "#fbfbfd")  ; light_foreground
    (cursor        "#ffffff")  ; bright_foreground

    ;; Starship named slots
    (ss-green           "#ff9f0a")  ; green / accent
    (ss-red             "#ff5f4a")
    (ss-yellow          "#ffc27a")
    (ss-orange          "#ff6a3d")
    (ss-cyan            "#a6dcef")
    (ss-blue            "#8fb8de")
    (ss-magenta         "#ff8fa3")
    (ss-brown           "#b8a99a")
    (ss-muted           "#8e8e93")  ; muted
    (ss-bright-red      "#ff8373")
    (ss-bright-yellow   "#ffd8a8")
    (ss-bright-green    "#ffb340")
    (ss-bright-cyan     "#cdeefa")
    (ss-bright-blue     "#b5d0ea")
    (ss-bright-magenta  "#ffb3c1")
    (ss-punctuation     "#89898b")  ; blend(fg, 0.5)
    (ss-search          "#4a5a6b")  ; blend(blue, 0.4)

    ;; Modus primary color slots
    (red           "#ff5f4a")
    (red-warmer    "#ff6a3d")
    (red-cooler    "#ff7777")
    (red-faint     "#994136")
    (red-intense   "#ff8373")
    (green         "#ff9f0a")
    (green-warmer  "#ffc27a")
    (green-cooler  "#a6dcef")
    (green-faint   "#996413")
    (green-intense "#ffb340")
    (yellow        "#ffc27a")
    (yellow-warmer "#ff6a3d")
    (yellow-cooler "#ff9f0a")
    (yellow-faint  "#997751")
    (yellow-intense "#ffd8a8")
    (blue          "#8fb8de")
    (blue-warmer   "#c7a4c1")
    (blue-cooler   "#617a91")
    (blue-faint    "#5b7288")
    (blue-intense  "#b5d0ea")
    (magenta       "#ff8fa3")
    (magenta-warmer "#ff5f4a")
    (magenta-cooler "#c7a4c1")
    (magenta-faint "#995b67")
    (magenta-intense "#ffb3c1")
    (cyan          "#a6dcef")
    (cyan-warmer   "#8fb8de")
    (cyan-cooler   "#7fb8c9")
    (cyan-faint    "#688691")
    (cyan-intense  "#cdeefa")

    ;; Diff backgrounds (aether: blend over bg)
    (bg-added            "#553d19")  ; blend(green, 0.25)
    (bg-added-faint      "#372c1c")  ; blend(green, 0.12)
    (bg-added-refine     "#6b4a17")  ; blend(green, 0.35)
    (bg-added-intense    "#8e5e14")  ; blend(green, 0.50)
    (fg-added            "#ffb340")
    (fg-added-intense    "#fcca80")

    (bg-removed          "#552d29")  ; blend(red, 0.25)
    (bg-removed-faint    "#372423")  ; blend(red, 0.12)
    (bg-removed-refine   "#6b332d")  ; blend(red, 0.35)
    (bg-removed-intense  "#8e3e34")  ; blend(red, 0.50)
    (fg-removed          "#ff8373")
    (fg-removed-intense  "#fcaba1")

    (bg-changed          "#212123")  ; blend(selection, 0.15)
    (bg-changed-faint    "#1e1e20")  ; blend(selection, 0.08)
    (bg-changed-refine   "#242426")  ; blend(selection, 0.25)
    (bg-changed-intense  "#28282a")  ; blend(selection, 0.40)
    (fg-changed          "#8fb8de")
    (fg-changed-intense  "#cbddef"))
  "Starship base colors, in Modus palette format.")

(defconst starship-palette-mappings-partial
  '(;; ---- Syntax (matches the aether colorscheme slot mapping) ----
    (keyword         ss-bright-magenta) ; Keyword -> bright_magenta
    (builtin         ss-cyan)           ; @function.builtin -> cyan
    (constant        ss-bright-yellow)  ; Constant -> bright_yellow
    (number          ss-orange)         ; Number, Boolean -> orange
    (fnname          ss-blue)           ; Function -> blue
    (fnname-call     ss-blue)
    (name            ss-blue)
    (type            ss-yellow)         ; Type -> yellow
    (variable        fg-main)           ; @variable -> foreground
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        ss-bright-cyan)    ; @property -> bright_cyan
    (property-use    ss-bright-cyan)
    (string          ss-green)          ; String -> green
    (docstring       ss-yellow)         ; @string.documentation -> yellow
    (comment         ss-muted)          ; Comment -> muted (italic upstream)
    (preprocessor    ss-cyan)           ; PreProc -> cyan
    (operator        fg-main)           ; Operator -> foreground
    (punctuation     ss-punctuation)    ; blend(fg, 0.5)
    (rx-construct    ss-bright-cyan)    ; @string.regexp -> bright_cyan
    (rx-backslash    ss-bright-magenta) ; @string.escape -> bright_magenta

    ;; ---- Status / diagnostics ----
    (err             ss-bright-red)     ; DiagnosticError -> bright_red
    (warning         ss-yellow)         ; DiagnosticWarn -> yellow
    (info            ss-blue)           ; DiagnosticInfo -> blue
    (note            ss-cyan)           ; DiagnosticHint -> cyan
    (success         ss-green)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              ss-bright-red)
    (modeline-warning          ss-yellow)
    (modeline-info             ss-blue)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   ss-muted)
    (fg-line-number-active     ss-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            ss-orange)
    (bg-search-current         ss-search)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      ss-blue)
    (link-symbolic             ss-cyan)
    (cursor                    cursor)
    (prompt                    ss-green)

    ;; ---- Headings ----
    (fg-heading-0              ss-bright-green)
    (fg-heading-1              ss-green)
    (fg-heading-2              ss-cyan)
    (fg-heading-3              ss-blue)
    (fg-heading-4              ss-yellow)
    (fg-heading-5              ss-magenta)
    (fg-heading-6              ss-orange)
    (fg-heading-7              ss-red)
    (fg-heading-8              ss-brown))
  "Semantic slot mappings for Starship.")

(defconst starship-palette
  (modus-themes-generate-palette
   starship-palette-partial
   nil
   modus-themes-vivendi-palette
   starship-palette-mappings-partial)
  "Complete Starship palette for use with `modus-themes-theme'.")

(defcustom starship-palette-overrides nil
  "User-level palette overrides for the Starship theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright: aether renders @variable in the default
;; foreground, and Modus's italic constructs would otherwise slant them.
(defvar starship-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar starship-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'starship
   'omarchy-themes
   "Starship, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'starship-palette
   'starship-palette-overrides
   'starship-custom-faces
   'starship-custom-variables)

(provide 'starship-theme)
;;; starship-theme.el ends here

;;; retro-82-theme.el --- Retro 82, derived from Modus  -*- lexical-binding: t; -*-

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "5.2"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Retro 82 for Emacs, derived from Modus Vivendi via
;; `modus-themes-theme'.  Mirrors the syntax colours of the Omarchy 4
;; Neovim scheme OldJobobo/retro-82.nvim (a base24 palette).
;;
;; Sunset over deep navy: mint text, orange/amber accents and a teal
;; family standing in for green, cyan and blue.  Syntax mapping
;; (retro-82.nvim palette keys):
;;   Normal/@variable/@property  base06 (fg-main)
;;   Comment   base03            String     base0B (cream)
;;   keyword/func/preproc base0A (orange)   Type   base1D (sky)
;;   Constant/Number base18 (coral)         builtin base0C (mint)
;;   Error base08   Warn base09 (amber)     Info   base1C (azure)
;; The `-intense' slots are lightened because upstream repeats its
;; colours in `bright_*'.

;;; Code:

(require 'omarchy-themes)

(defconst retro-82-palette-partial
  '(;; Core surfaces
    (bg-main       "#05182e")  ; background
    (bg-dim        "#020c17")  ; darker_background
    (bg-alt        "#0a2540")  ; lighter_background
    (bg-active     "#134e5a")  ; selection
    (bg-inactive   "#031222")  ; dark_background
    (border        "#2a6b78")  ; muted

    ;; Foregrounds
    (fg-main       "#a7c9c6")  ; base06 — Normal fg
    (fg-dim        "#3f8f8a")  ; dark_foreground
    (fg-alt        "#a7c9c6")  ; light_foreground
    (cursor        "#f6dcac")  ; bright_foreground

    ;; Retro 82 named slots
    (r82-orange    "#faa968")  ; accent / base0A
    (r82-amber     "#e97b3c")  ; yellow / base09
    (r82-red       "#f85525")  ; base08
    (r82-teal      "#028391")  ; green
    (r82-sea       "#3f8f8a")  ; blue / magenta
    (r82-mint      "#8cbfb8")  ; cyan / base0C
    (r82-cream     "#f6dcac")  ; base0B — String
    (r82-coral     "#ff8a6b")  ; base18 — Constant, Number
    (r82-sky       "#6fa6c8")  ; base1D — Type
    (r82-azure     "#39b5d4")  ; base1C — DiagnosticInfo
    (r82-ink       "#134e5a")  ; base03 — Comment (upstream, == selection)
    (r82-brown     "#743d1e")
    (r82-comment   "#569195")  ; derived: muted lightened to read as text

    ;; Modus primary color slots
    (red           "#f85525")
    (red-warmer    "#f85525")
    (red-cooler    "#e97b3c")
    (red-faint     "#b44428")
    (red-intense   "#f78454")
    (green         "#028391")
    (green-warmer  "#3f8f8a")
    (green-cooler  "#8cbfb8")
    (green-faint   "#036575")
    (green-intense "#57a29a")
    (yellow        "#e97b3c")
    (yellow-warmer "#faa968")
    (yellow-cooler "#e97b3c")
    (yellow-faint  "#a95f38")
    (yellow-intense "#faa968")
    (blue          "#3f8f8a")
    (blue-warmer   "#8cbfb8")
    (blue-cooler   "#028391")
    (blue-faint    "#2f6e70")
    (blue-intense  "#7faa96")
    (magenta       "#3f8f8a")
    (magenta-warmer "#e97b3c")
    (magenta-cooler "#3f8f8a")
    (magenta-faint "#2f6e70")
    (magenta-intense "#7faa96")
    (cyan          "#8cbfb8")
    (cyan-warmer   "#8cbfb8")
    (cyan-cooler   "#3f8f8a")
    (cyan-faint    "#669091")
    (cyan-intense  "#b1c9b4")

    ;; Diff backgrounds
    (bg-added            "#042b40")
    (bg-added-faint      "#052338")
    (bg-added-refine     "#04384c")
    (bg-added-intense    "#044558")
    (fg-added            "#02bdd1")
    (fg-added-intense    "#70ab9d")

    (bg-removed          "#31232c")
    (bg-removed-faint    "#1d1e2d")
    (bg-removed-refine   "#4e2a2b")
    (bg-removed-intense  "#6b322a")
    (fg-removed          "#f85525")
    (fg-removed-intense  "#f79262")

    (bg-changed          "#2e2a31")
    (bg-changed-faint    "#1c222f")
    (bg-changed-refine   "#493632")
    (bg-changed-intense  "#654234")
    (fg-changed          "#e97b3c")
    (fg-changed-intense  "#efa76e"))
  "Retro 82 base colors, in Modus palette format.")

(defconst retro-82-palette-mappings-partial
  '(;; ---- Syntax (matches retro-82.nvim) ----
    (keyword         r82-orange)       ; @keyword -> base0A
    (builtin         r82-mint)         ; @function.builtin -> base0C
    (constant        r82-coral)        ; Constant -> base18
    (number          r82-coral)        ; @number -> base18
    (fnname          r82-orange)       ; @function -> base0A
    (fnname-call     r82-orange)
    (name            r82-orange)
    (type            r82-sky)          ; Type -> base1D
    (variable        fg-main)          ; @variable -> Normal fg
    (variable-use    fg-main)
    (identifier      fg-main)
    (property        fg-main)          ; @property -> Normal fg
    (property-use    fg-main)
    (string          r82-cream)        ; String -> base0B
    (docstring       r82-sea)
    (comment         r82-ink)          ; Comment -> base03
    (preprocessor    r82-orange)       ; PreProc -> base0A
    (operator        fg-main)
    (punctuation     fg-alt)
    (rx-construct    r82-amber)
    (rx-backslash    r82-orange)

    ;; ---- Status / diagnostics ----
    (err             r82-red)
    (warning         r82-amber)
    (info            r82-azure)        ; DiagnosticInfo -> base1C
    (note            r82-mint)
    (success         r82-teal)

    ;; ---- Mode line ----
    (bg-mode-line-active       bg-active)
    (fg-mode-line-active       fg-main)
    (border-mode-line-active   bg-alt)
    (bg-mode-line-inactive     bg-dim)
    (fg-mode-line-inactive     fg-dim)
    (border-mode-line-inactive bg-dim)
    (modeline-err              r82-red)
    (modeline-warning          r82-amber)
    (modeline-info             r82-sea)

    ;; ---- Line numbers ----
    (fg-line-number-inactive   border)
    (fg-line-number-active     r82-orange)
    (bg-line-number-inactive   bg-main)
    (bg-line-number-active     bg-alt)

    ;; ---- Region / highlight / search ----
    (bg-region                 bg-active)
    (fg-region                 fg-main)
    (bg-hl-line                bg-alt)
    (bg-paren-match            bg-active)
    (fg-paren-match            r82-orange)
    (bg-search-current         r82-orange)
    (bg-search-lazy            bg-active)

    ;; ---- Completion / popups ----
    (bg-completion             bg-alt)
    (bg-hover                  bg-active)
    (bg-hover-secondary        bg-alt)

    ;; ---- Links / prompts ----
    (link                      r82-mint)
    (link-symbolic             r82-sea)
    (cursor                    r82-orange)
    (prompt                    r82-orange)

    ;; ---- Headings ----
    (fg-heading-0              r82-orange)
    (fg-heading-1              r82-red)
    (fg-heading-2              r82-amber)
    (fg-heading-3              r82-mint)
    (fg-heading-4              r82-sea)
    (fg-heading-5              r82-orange)
    (fg-heading-6              r82-teal)
    (fg-heading-7              fg-alt)
    (fg-heading-8              r82-comment))
  "Semantic slot mappings for Retro 82.")

(defconst retro-82-palette
  (modus-themes-generate-palette
   retro-82-palette-partial
   nil
   modus-themes-vivendi-palette
   retro-82-palette-mappings-partial)
  "Complete Retro 82 palette for use with `modus-themes-theme'.")

(defcustom retro-82-palette-overrides nil
  "User-level palette overrides for the Retro 82 theme."
  :type '(repeat (list symbol (choice symbol string)))
  :group 'omarchy-themes)

;; Keep variable faces upright; only comments are slanted upstream.
(defvar retro-82-custom-faces
  '(`(font-lock-variable-name-face ((,c :foreground ,fg-main :slant normal)))
    `(font-lock-variable-use-face  ((,c :foreground ,fg-main :slant normal)))
    `(help-argument-name           ((,c :foreground ,fg-main :slant normal))))
  "Additional face specs layered on top of the Modus-generated faces.")

(defvar retro-82-custom-variables nil
  "Custom-variable specs layered on top of Modus defaults.")

(modus-themes-theme
   'retro-82
   'omarchy-themes
   "Retro 82, derived from Modus Vivendi."
   'dark
   'modus-themes-vivendi-palette
   'retro-82-palette
   'retro-82-palette-overrides
   'retro-82-custom-faces
   'retro-82-custom-variables)

(provide 'retro-82-theme)
;;; retro-82-theme.el ends here

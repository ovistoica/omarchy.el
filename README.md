# omarchy.el

Emacs integration for [Omarchy](https://omarchy.org), the opinionated Arch + Hyprland Linux distribution by DHH. Keeps your Emacs theme and default font in lockstep with the rest of the desktop, ships 13 Modus-derived themes faithful to their Neovim counterparts (one per theme Omarchy supports), and wraps the common `omarchy-*` CLI toggles so you don't have to context-switch to a terminal.

On non-Omarchy systems the package loads cleanly and degrades gracefully — interactive commands no-op with a message, and `omarchy-init` falls back to `omarchy-default-theme`.

## Table of contents

- [What's in the box](#whats-in-the-box)
- [Installation](#installation)
- [Getting started](#getting-started)
- [Themes](#themes)
- [Interactive commands](#interactive-commands)
- [Customization](#customization)
- [Shell hook integration](#shell-hook-integration)
- [How the sync works](#how-the-sync-works)
- [FAQ](#faq)
- [Status](#status)

## What's in the box

The package lives at the repo root; the 13 bundled themes are grouped under `themes/`:

```
omarchy.el/
├── omarchy.el            — core package
├── omarchy-themes.el     — shared theme library
└── themes/
    ├── rose-pine-theme.el
    ├── osaka-jade-theme.el
    ├── flexoki-light-theme.el
    ├── catppuccin-mocha-theme.el
    ├── catppuccin-latte-theme.el
    ├── tokyo-night-theme.el
    ├── gruvbox-theme.el
    ├── kanagawa-theme.el
    ├── everforest-theme.el
    ├── nord-theme.el
    ├── ristretto-theme.el
    ├── matte-black-theme.el
    └── ethereal-theme.el
```

| File | Purpose |
|---|---|
| `omarchy.el` | Core package: CLI integration, theme/font pickers, hook installer, desktop toggles, `omarchy-init` |
| `omarchy-themes.el` | Shared library for the bundled themes; registers `themes/` with `custom-theme-load-path` and defines the `omarchy-themes` customize group |
| `themes/rose-pine-theme.el` | Rose Pine Dawn, derived from Modus Operandi |
| `themes/osaka-jade-theme.el` | Osaka Jade, derived from Modus Vivendi (mirrors `bamboo.nvim` *vulgaris*) |
| `themes/flexoki-light-theme.el` | Flexoki Light, derived from Modus Operandi Tinted |
| `themes/catppuccin-mocha-theme.el` | Catppuccin Mocha (`catppuccin/nvim`) |
| `themes/catppuccin-latte-theme.el` | Catppuccin Latte (`catppuccin/nvim` latte flavor) |
| `themes/tokyo-night-theme.el` | Tokyo Night (doom-tokyo-night alignment, night palette) |
| `themes/gruvbox-theme.el` | Gruvbox dark medium (`ellisonleao/gruvbox.nvim`) |
| `themes/kanagawa-theme.el` | Kanagawa Wave (`rebelot/kanagawa.nvim`) |
| `themes/everforest-theme.el` | Everforest medium dark (`theorytoe/everforest-emacs` alignment) |
| `themes/nord-theme.el` | Nord (doom-nord alignment) |
| `themes/ristretto-theme.el` | Monokai Pro Ristretto (`gthelding/monokai-pro.nvim`) |
| `themes/matte-black-theme.el` | Matte Black (`tahayvr/matteblack.nvim`) |
| `themes/ethereal-theme.el` | Ethereal (`bjarneo/ethereal.nvim`) |

All bundled themes use the public `modus-themes-theme` machinery, so you get full coverage of the Modus face catalog (Magit, Org, Eglot, tree-sitter, Corfu, Vertico, etc.) without hand-rolling hundreds of `custom-theme-set-faces` entries. Each one's syntax slot mapping (keyword, function, variable, string, comment, type, …) is taken from the upstream Neovim plugin that Omarchy ships, so code renders near-identically across the two editors.

## Installation

### Prerequisites

- Emacs 29.1 or newer
- [`modus-themes`](https://protesilaos.com/emacs/modus-themes) 4.4 or newer (for the bundled themes only — `omarchy.el` itself has no runtime dependencies)
- Omarchy on the host system, if you want the desktop sync (otherwise it's just a theme pack + small convenience library)

### MELPA

Coming soon.

### Straight / use-package

```elisp
(use-package omarchy
  :vc (:url "https://github.com/ovistoica/omarchy.el" :rev :newest)
  :demand t
  :init
  (setq omarchy-default-theme 'modus-operandi
        omarchy-default-font  "Iosevka Nerd Font Mono")
  :config
  (require 'omarchy-themes)  ; register bundled themes
  (omarchy-init))
```

### Manual

Clone the repo somewhere, add it to `load-path`, and you're done:

```elisp
(add-to-list 'load-path "~/path/to/omarchy.el")
(require 'omarchy)
(require 'omarchy-themes)
(setq omarchy-default-theme 'modus-operandi)
(omarchy-init)
```

## Getting started

Four lines gets you the whole experience:

```elisp
(require 'omarchy)
(require 'omarchy-themes)                     ; register bundled themes
(setq omarchy-default-theme 'modus-operandi)  ; non-Omarchy fallback
(omarchy-init)                                ; sync theme + font now
```

`omarchy-themes` is only needed if you want the bundled themes on `custom-theme-load-path` — the core `omarchy` package itself has no theme dependencies.

On an Omarchy system `omarchy-init` will:

1. Read the current theme from `omarchy-theme-current` and apply it.
2. Read the current font from `omarchy-font-current` and apply it.
3. In daemon mode, defer both until the first graphical client attaches (otherwise `font-family-list` is empty and your font choice is silently dropped).

Then install the shell hooks so Omarchy notifies Emacs of future changes:

```elisp
M-x omarchy-install-hooks
```

That's it. Change the theme from `walker`, the Omarchy menu, or `omarchy-theme-set` in any terminal, and Emacs repaints.

## Themes

Every bundled theme is designed to render source code as identically as possible to the Neovim theme Omarchy ships for the same name, so your editor looks like every other surface in the Omarchy UI.

For each theme below, the syntax slot mapping (keyword, function, variable, string, comment, type, constant, operator, property, …) was lifted directly from the upstream Neovim plugin's palette and highlight-group files (or, for Tokyo Night / Nord / Everforest, from the corresponding doom-themes Emacs port, which is the common reference point for "Modus-derived, upstream-faithful" feel).

### Light themes

| Theme | Symbol | Upstream | Highlights |
|---|---|---|---|
| Rose Pine Dawn | `rose-pine` | `rose-pine/neovim` | keyword pine · function rose · string gold · variable text upright |
| Flexoki Light | `flexoki-light` | `crmsnbleyd/flexoki-emacs-theme` | keyword magenta · function orange · string cyan · variable blue |
| Catppuccin Latte | `catppuccin-latte` | `catppuccin/nvim` latte | keyword mauve · function blue · string green · variable flamingo |

### Dark themes

| Theme | Symbol | Upstream | Highlights |
|---|---|---|---|
| Osaka Jade | `osaka-jade` | `ribru17/bamboo.nvim` *vulgaris* | keyword purple · function blue · string green · variable fg-plain |
| Catppuccin Mocha | `catppuccin-mocha` | `catppuccin/nvim` | keyword mauve · function blue · string green · variable flamingo |
| Tokyo Night | `tokyo-night` | `doom-tokyo-night` alignment (night palette) | keyword magenta · function blue · string green · variable base8 |
| Gruvbox | `gruvbox` | `ellisonleao/gruvbox.nvim` | keyword red · function green+bold · string green · variable blue |
| Kanagawa Wave | `kanagawa` | `rebelot/kanagawa.nvim` | keyword oniViolet · function crystalBlue · string springGreen · variable fujiWhite |
| Everforest | `everforest` | `theorytoe/everforest-emacs` (medium dark) | keyword red · function green · string green · variable blue |
| Nord | `nord` | `doom-nord` alignment | keyword blue · function cyan · string green · variable base7 |
| Ristretto | `ristretto` | `gthelding/monokai-pro.nvim` ristretto filter | keyword red italic · function green · string yellow · variable white |
| Matte Black | `matte-black` | `tahayvr/matteblack.nvim` | keyword green · function crimson · string fg-neutral · variable amber |
| Ethereal | `ethereal` | `bjarneo/ethereal.nvim` | keyword purple-bold · function magenta2 · string green · variable magenta2 |

Every theme follows the same defaults, all of which can be turned off or retargeted — see [Customizing a theme](#customizing-a-theme) below:

- **Comments are italic**, everything else upright. Toggle with `modus-themes-italic-constructs` and reload the theme.
- **Variables are not italic** even when the upstream Neovim highlight group implies it, because in Emacs that bleeds through `help-argument-name` / function parameters / magit into places where it hurts readability. Override `font-lock-variable-name-face` if you'd like it back.
- **Bold is opt-in and reserved** for what upstream actually bolds (Gruvbox functions, Ethereal's keyword/function/type). Toggle globally with `modus-themes-bold-constructs`.
- `bg-region` / `bg-hl-line` / `bg-paren-match` are tuned to match the upstream plugin's visual selection and cursor line, not Modus's defaults — override via the theme's `*-palette-overrides` defcustom.

### Customizing a theme

Because every bundled theme derives from Modus, the whole `modus-themes` customization surface works out of the box.

All 13 bundled themes register their `<theme>-palette-overrides` defcustoms under the `omarchy-themes` customize group (itself a child of the `modus-themes` group). `M-x customize-group RET omarchy-themes RET` gives you a single screen with every bundled theme's override slot.

**Colors** — `<theme>-palette-overrides` changes any palette slot without editing the theme file. See [Modus's palette override guide][modus-overrides] for all available semantic slot names (`comment`, `keyword`, `fnname`, `string`, `bg-region`, `fg-heading-1`, etc.).

```elisp
(setq rose-pine-palette-overrides
      '((comment   "#8b8199")    ; nudge comments brighter
        (bg-region "#e4d7c7")))   ; warmer selection
```

**Italics and bold** — the bundled themes pre-set these to match upstream (e.g. italic comments for every theme, bold functions for Gruvbox, bold keyword/function/type for Ethereal). You can override globally with Modus's own variables:

```elisp
(setq modus-themes-italic-constructs nil   ; turn italics off globally
      modus-themes-bold-constructs   t)    ; turn bold on globally
```

After changing these, reload the theme (`M-x load-theme RET <theme> RET`) so Modus regenerates its faces with the new settings — they're read at face-generation time, not at face-application time.

**Font weight/slant of individual faces** — use standard `custom-set-faces` or `face-remap`. Common ones:

```elisp
(custom-set-faces
 '(font-lock-keyword-face  ((t (:weight bold))))
 '(font-lock-comment-face  ((t (:slant normal)))))  ; unitalic comments
```

For deeper customization — headings with different weights per level, org-block backgrounds, completion highlights, diff colors — every relevant Modus face still responds to its documented customization knobs. See the [Modus themes manual][modus-manual] for the full list.

[modus-overrides]: https://protesilaos.com/emacs/modus-themes#h:a9956d15-7ab7-4f7e-96fe-58f1a002510e
[modus-manual]: https://protesilaos.com/emacs/modus-themes

## Interactive commands

### Pickers (interactive with completion)

| Command | Behavior |
|---|---|
| `M-x omarchy-theme-pick` | `completing-read` over `omarchy-theme-list`; calls `omarchy-theme-set` which broadcasts to all Omarchy surfaces. Falls back to an Emacs-only `omarchy-apply-theme` on non-Omarchy systems. |
| `M-x omarchy-font-pick` | Same, for fonts. Preserves any externally-managed `:height` (Fontaine-friendly). |

### Desktop toggles

| Command | Runs |
|---|---|
| `M-x omarchy-toggle-nightlight` | `omarchy-toggle-nightlight` |
| `M-x omarchy-toggle-waybar` | `omarchy-toggle-waybar` |
| `M-x omarchy-screenshot` | `omarchy-cmd-screenshot` |
| `M-x omarchy-lock-screen` | `omarchy-lock-screen` |
| `M-x omarchy-terminal-at-cwd` | `omarchy-cmd-terminal-cwd` (with `default-directory` set to the buffer's directory) |

All toggles are launched detached via `setsid`, so processes like waybar survive after the wrapper script exits.

### Apply-only (called by shell hooks, but also usable directly)

| Command | Behavior |
|---|---|
| `M-x omarchy-apply-theme` | Apply a theme to this Emacs only. Accepts an Omarchy display name, a theme symbol, or a thunk. |
| `M-x omarchy-apply-font` | Set the default face family. Reads current `:height` when not specified. |

### Hook setup

| Command | Behavior |
|---|---|
| `M-x omarchy-install-hooks` | Write executable `theme-set` and `font-set` scripts into `omarchy-hooks-directory` (default `~/.config/omarchy/hooks/`). Overwrites existing files. |

## Customization

Core user-facing variables live in the `omarchy` customize group (`M-x customize-group RET omarchy RET`). Per-theme palette overrides live in the `omarchy-themes` group (a child of `modus-themes`).

```elisp
;; Fallback theme if Omarchy is unavailable or the lookup fails.
(setq omarchy-default-theme 'modus-operandi)

;; Fallback font family when `omarchy-font-current' reports nothing.
(setq omarchy-default-font "Iosevka Nerd Font Mono")

;; Where `omarchy-install-hooks' writes its scripts.
(setq omarchy-hooks-directory "~/.config/omarchy/hooks")

;; Add or override entries in the theme name -> Emacs theme map.
;; Values can be a symbol (loaded via load-theme) or a thunk
;; (called for side effects, e.g. setting a flavor variable first).
(add-to-list 'omarchy-theme-map
             '("My Custom Theme" . my-emacs-theme))

;; Thunk form — useful when the theme needs setup before it loads
(add-to-list 'omarchy-theme-map
             '("Catppuccin Frappe" .
               (lambda ()
                 (setq catppuccin-flavor 'frappe)
                 (mapc #'disable-theme custom-enabled-themes)
                 (load-theme 'catppuccin :no-confirm))))
```

The full default `omarchy-theme-map` (as shipped) — every entry points at a theme bundled in this package, so no additional theme dependencies are required:

```
"Catppuccin"       -> catppuccin-mocha
"Catppuccin Latte" -> catppuccin-latte
"Ethereal"         -> ethereal
"Everforest"       -> everforest
"Flexoki Light"    -> flexoki-light
"Gruvbox"          -> gruvbox
"Kanagawa"         -> kanagawa
"Matte Black"      -> matte-black
"Nord"             -> nord
"Osaka Jade"       -> osaka-jade
"Ristretto"        -> ristretto
"Rose Pine"        -> rose-pine
"Tokyo Night"      -> tokyo-night
```

If you prefer a third-party Emacs theme over the bundled one, just override the map entry — for example `(add-to-list 'omarchy-theme-map '("Gruvbox" . doom-gruvbox))`. `omarchy-apply-theme` will fall back to `omarchy-default-theme` with a message if the target theme fails to load.

## Shell hook integration

Omarchy invokes scripts in `~/.config/omarchy/hooks/` whenever the system theme or font changes. `omarchy-install-hooks` writes two of them:

**`~/.config/omarchy/hooks/theme-set`**:

```bash
#!/usr/bin/env bash
# Omarchy theme-set hook for Emacs integration
NAME="$1"
if command -v emacsclient >/dev/null 2>&1 && pgrep -x emacs >/dev/null; then
    emacsclient -e "(omarchy-apply-theme \"$NAME\")" >/dev/null 2>&1
fi
```

**`~/.config/omarchy/hooks/font-set`** is identical but calls `omarchy-apply-font`.

The `pgrep` guard avoids starting a new Emacs if you don't have one running, so the hooks are safe to leave installed even when you're using a different editor.

If you already maintain hooks by hand, `omarchy-install-hooks` **overwrites** them without warning. Edit `omarchy--hook-script-template` or skip the installer and write them yourself.

## How the sync works

```
   Omarchy CLI / UI                              Emacs
   ────────────────                              ─────
 omarchy-theme-set "Tokyo Night"
         │
         ▼
 ~/.config/omarchy/hooks/theme-set "Tokyo Night"
         │
         ▼
 emacsclient -e '(omarchy-apply-theme "Tokyo Night")'
         │
         ▼
 omarchy--lookup-theme → "Tokyo Night" → 'tokyo-night
         │
         ▼
 disable-theme <old>; load-theme 'tokyo-night
```

Two subtleties that matter:

1. **`omarchy-set-theme` is fire-and-forget.** It calls `omarchy-theme-set` on the CLI and returns. The emacsclient round-trip from the shell hook is what actually updates Emacs — this avoids double-application.

2. **Font syncs before theme, and both wait for a display in daemon mode.** `omarchy-init` applies font first, theme second. When Emacs is running as a daemon with no graphical client yet, `font-family-list` is empty — so the initial sync waits on `server-after-make-frame-hook` for the first frame to attach, then runs once.

## FAQ

**Does `omarchy-apply-font` conflict with Fontaine?** No. When called without an explicit `HEIGHT`, it reads and preserves the current `:height` on the `default` face — so Fontaine-managed size presets survive a font family change. Fontaine owns size; Omarchy owns family.

**Can I use just the themes without the rest of the package?** Yes. The themes depend only on `omarchy-themes.el` (which brings in `modus-themes`) — not on `omarchy.el`. Add the repo to `load-path`, `(require 'omarchy-themes)`, then `M-x load-theme RET <any-bundled-theme> RET`. No `omarchy-init`, no Omarchy CLI dependency.

**I'm not on Omarchy — is this still useful?** The themes are standalone and usable on any Emacs. The core package degrades to a no-op on non-Omarchy systems, so it's safe to leave in your config if you occasionally boot between distros. Interactive commands will just message "Omarchy not available".

**Why derive from Modus instead of hand-rolling faces?** `modus-themes-theme` expands into a `custom-theme-set-faces` block generated from Modus's comprehensive ~400-face catalog against your palette. You get Magit, Org, Eglot, tree-sitter, Corfu, Vertico, and dozens of other packages styled coherently for free — and future Modus updates bring new package coverage without any work on your end. See the Modus Info node *Build on top of the Modus themes* for the pattern.

**I set `<theme>-palette-overrides` but nothing changed.** Palette overrides are baked into face specs when the theme loads. Reload the theme after changing them: `M-x load-theme RET <theme> RET` (or just toggle away and back via `omarchy-theme-pick`). Same applies to `modus-themes-italic-constructs` and `modus-themes-bold-constructs`.

## Status

Alpha. Interfaces may change before 0.1 is released. In particular:

- All 13 Omarchy theme names mapped by default are bundled. New additions would need a matching Omarchy theme (e.g. `hackerman`, `lumon`, `retro-82`, `vantablack`, `white`, `miasma` are not yet bundled; the core package still handles them via `omarchy-theme-map` if you wire up a third-party Emacs theme).
- Battery / power / brightness toggles are planned.

Bug reports, palette nits, and theme submissions welcome.

## License

GPL-3.0-or-later, matching the broader Emacs ecosystem.

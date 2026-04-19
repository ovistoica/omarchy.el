# omarchy.el

Emacs integration for [Omarchy](https://omarchy.org), the opinionated
Arch + Hyprland Linux distribution by DHH. Keeps your Emacs theme and
default font in lockstep with the rest of the desktop, ships three
Modus-derived themes faithful to their Neovim counterparts, and wraps
the common `omarchy-*` CLI toggles so you don't have to context-switch
to a terminal.

On non-Omarchy systems the package loads cleanly and degrades
gracefully — interactive commands no-op with a message, and
`omarchy-init` falls back to `omarchy-default-theme`.

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

| File | Purpose |
|---|---|
| `omarchy.el` | Core package: CLI integration, theme/font pickers, hook installer, desktop toggles, `omarchy-init` |
| `omarchy-themes.el` | Shared library for the bundled themes; registers the package directory with `custom-theme-load-path` |
| `rose-pine-theme.el` | Rose Pine Dawn, derived from Modus Operandi |
| `osaka-jade-theme.el` | Osaka Jade, derived from Modus Vivendi (mirrors `bamboo.nvim` *vulgaris*) |
| `flexoki-light-theme.el` | Flexoki Light, derived from Modus Operandi Tinted |

All three bundled themes use the public `modus-themes-theme` machinery,
so you get full coverage of the Modus face catalog (Magit, Org, Eglot,
tree-sitter, Corfu, Vertico, etc.) without hand-rolling hundreds of
`custom-theme-set-faces` entries.

## Installation

### Prerequisites

- Emacs 29.1 or newer
- [`modus-themes`](https://protesilaos.com/emacs/modus-themes) 4.4 or
  newer (for the bundled themes only — `omarchy.el` itself has no
  runtime dependencies)
- Omarchy on the host system, if you want the desktop sync (otherwise
  it's just a theme pack + small convenience library)

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
  (omarchy-init))
```

### Manual

Clone the repo somewhere, add it to `load-path`, and you're done:

```elisp
(add-to-list 'load-path "~/path/to/omarchy.el")
(require 'omarchy)
(setq omarchy-default-theme 'modus-operandi)
(omarchy-init)
```

## Getting started

Three lines gets you the whole experience:

```elisp
(require 'omarchy)
(setq omarchy-default-theme 'modus-operandi)  ; non-Omarchy fallback
(omarchy-init)                                ; sync theme + font now
```

On an Omarchy system `omarchy-init` will:

1. Read the current theme from `omarchy-theme-current` and apply it.
2. Read the current font from `omarchy-font-current` and apply it.
3. In daemon mode, defer both until the first graphical client attaches
   (otherwise `font-family-list` is empty and your font choice is
   silently dropped).

Then install the shell hooks so Omarchy notifies Emacs of future
changes:

```elisp
M-x omarchy-install-hooks
```

That's it. Change the theme from `walker`, the Omarchy menu, or
`omarchy-theme-set` in any terminal, and Emacs repaints.

## Themes

The three bundled themes are designed to render source code as
identically as possible to the Neovim themes Omarchy ships, so your
editor looks like every other surface in the Omarchy UI.

### Rose Pine

A "soho vibes for your terminal" light theme, matched to
[rose-pine/neovim](https://github.com/rose-pine/neovim). Keywords in
pine, functions in rose, strings in gold, comments in subtle with
italics.

```elisp
(load-theme 'rose-pine t)
```

### Osaka Jade

Deep green dark theme with Japanese bamboo palette, matched to
[ribru17/bamboo.nvim](https://github.com/ribru17/bamboo.nvim) (the
*vulgaris* variant). Keywords in purple, functions in blue, types in
yellow, comments in warm bamboo. Surfaces pulled from Omarchy's
`colors.toml` so the editor blends into the rest of the desktop.

```elisp
(load-theme 'osaka-jade t)
```

### Flexoki Light

Steph Ango's "inky color scheme for prose and code", faithful to the
canonical [flexoki-emacs-theme](https://codeberg.org/crmsnbleyd/flexoki-emacs-theme).
Paper background, magenta keywords, orange functions, cyan strings,
blue variables.

```elisp
(load-theme 'flexoki-light t)
```

### Tuning italic / bold per theme

Each bundled theme controls its own `modus-themes-italic-constructs`
and `modus-themes-bold-constructs` via a `let` wrapper around
`modus-themes-theme`, so you can flip them independently from your
other Modus-derived themes. Override by editing the theme file or
using `modus-themes-common-palette-overrides` / the per-theme
`*-palette-overrides` defcustom:

```elisp
;; Tweak Rose Pine without editing the theme file
(setq rose-pine-palette-overrides
      '((comment   "#8b8199")    ; nudge comments brighter
        (bg-region "#e4d7c7")))   ; warmer selection
```

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

All toggles are launched detached via `setsid`, so processes like
waybar survive after the wrapper script exits.

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

All user-facing variables are in the `omarchy` customize group
(`M-x customize-group RET omarchy RET`).

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

(add-to-list 'omarchy-theme-map
             '("Catppuccin Frappe" .
               (lambda () (setq catppuccin-flavor 'frappe)
                 (omarchy--raw-load-theme 'catppuccin))))
```

The full default `omarchy-theme-map` (as shipped):

```
"Catppuccin"       -> catppuccin (mocha flavor)
"Catppuccin Latte" -> catppuccin (latte flavor)
"Everforest"       -> everforest
"Flexoki Light"    -> flexoki-light           (bundled)
"Gruvbox"          -> doom-gruvbox
"Kanagawa"         -> kanagawa
"Matte Black"      -> matte-black
"Nord"             -> doom-nord
"Osaka Jade"       -> osaka-jade              (bundled)
"Ristretto"        -> doom-monokai-ristretto
"Rose Pine"        -> rose-pine               (bundled)
"Tokyo Night"      -> doom-tokyo-night
"Ethereal"         -> modus-vivendi-tinted
```

You're responsible for making sure the target theme package is
installed — `omarchy-apply-theme` will fall back to
`omarchy-default-theme` with a message if `load-theme` signals.

## Shell hook integration

Omarchy invokes scripts in `~/.config/omarchy/hooks/` whenever the
system theme or font changes. `omarchy-install-hooks` writes two of
them:

**`~/.config/omarchy/hooks/theme-set`**:

```bash
#!/usr/bin/env bash
# Omarchy theme-set hook for Emacs integration
NAME="$1"
if command -v emacsclient >/dev/null 2>&1 && pgrep -x emacs >/dev/null; then
    emacsclient -e "(omarchy-apply-theme \"$NAME\")" >/dev/null 2>&1
fi
```

**`~/.config/omarchy/hooks/font-set`** is identical but calls
`omarchy-apply-font`.

The `pgrep` guard avoids starting a new Emacs if you don't have one
running, so the hooks are safe to leave installed even when you're
using a different editor.

If you already maintain hooks by hand,
`omarchy-install-hooks` **overwrites** them without warning. Edit
`omarchy--hook-script-template` or skip the installer and write them
yourself.

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
 omarchy--lookup-theme → "Tokyo Night" → 'doom-tokyo-night
         │
         ▼
 disable-theme <old>; load-theme 'doom-tokyo-night
```

Two subtleties that matter:

1. **`omarchy-set-theme` is fire-and-forget.** It calls
   `omarchy-theme-set` on the CLI and returns. The emacsclient
   round-trip from the shell hook is what actually updates Emacs —
   this avoids double-application.

2. **Font is applied before theme.** In daemon mode specifically,
   `omarchy-init` waits for `server-after-make-frame-hook`, because
   `font-family-list` is empty until a display connection exists.

## FAQ

**Does `omarchy-apply-font` conflict with Fontaine?**
No. When called without an explicit `HEIGHT`, it reads and preserves
the current `:height` on the `default` face — so Fontaine-managed size
presets survive a font family change. Fontaine owns size; Omarchy owns
family.

**Can I use just the themes without the rest of the package?**
Yes. Each theme is self-contained once `omarchy-themes.el` is on your
`load-path`. You don't need to `(require 'omarchy)` or call
`(omarchy-init)`.

**I'm not on Omarchy — is this still useful?**
The themes are standalone and usable on any Emacs. The core package
degrades to a no-op on non-Omarchy systems, so it's safe to leave in
your config if you occasionally boot between distros. Interactive
commands will just message "Omarchy not available".

**Why derive from Modus instead of hand-rolling faces?**
`modus-themes-theme` expands into a `custom-theme-set-faces` block
generated from Modus's comprehensive ~400-face catalog against your
palette. You get Magit, Org, Eglot, tree-sitter, Corfu, Vertico, and
dozens of other packages styled coherently for free — and future Modus
updates bring new package coverage without any work on your end. See
the Modus Info node *Build on top of the Modus themes* for the pattern.

**Why is my waybar toggle not bringing waybar back?**
Older versions of this package used `start-process`, which kept Emacs
as waybar's session leader — when the wrapper script backgrounded
`uwsm-app -- waybar &` and exited, waybar died orphaned. Current code
uses `setsid sh -c '... &'` for true detachment. If you're on an old
version, update.

## Status

Alpha. Interfaces may change before 0.1 is released. In particular:

- Several `my/*` defaliases are kept temporarily for backward
  compatibility with un-updated shell hooks; they'll be removed in 0.2.
- More bundled themes may land (Kanagawa, Matte Black).
- Battery / power / brightness toggles are planned.

Bug reports, palette nits, and theme submissions welcome.

## License

GPL-3.0-or-later, matching the broader Emacs ecosystem.

# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] — 2026-08-16

Support for **Omarchy 4 (Quattro)**.

Quattro reimplemented the entire desktop shell in Quickshell, retiring Waybar,
Walker, Mako, SwayOSD, hyprlock and hypridle. Several of the `omarchy-*` CLIs
this package drives were renamed or removed as a result, so this release targets
Omarchy 4 only. **Omarchy 3 users should pin [v0.1.0](https://github.com/ovistoica/omarchy.el/releases/tag/v0.1.0).**

### Breaking

- **Requires Omarchy 4.** The desktop toggles call CLIs that do not exist on
  Omarchy 3.
- **`omarchy-toggle-waybar` is renamed to `omarchy-toggle-bar`.** Waybar is gone
  in Quattro; the command now toggles the Omarchy shell bar without killing the
  shell. Update any keybindings referring to the old name.
- **`omarchy-install-hooks` now writes drop-ins instead of whole hook files.**
  It previously overwrote `~/.config/omarchy/hooks/theme-set` and `font-set`
  wholesale, clobbering user-managed hooks — and, on dotfiles setups where those
  paths are symlinks, writing straight through into the user's repo. It now
  writes `theme-set.d/50-emacs` and `font-set.d/50-emacs`, which Omarchy runs in
  addition to any plain hook file. If you installed hooks with 0.1.0, the old
  `theme-set`/`font-set` files are still yours to keep or delete; re-running
  `M-x omarchy-install-hooks` will not remove them.

### Added

- Nine new bundled themes covering the rest of the Omarchy 4 stock set. Dark:
  **Hackerman**, **Last Horizon**, **Lumon**, **Miasma**, **Retro 82**,
  **Solitude**, **Vantablack**. Light: **Lupine**, **White**. All 22 stock
  Omarchy themes now map to a bundled Emacs theme; previously the 9 unmapped
  ones silently fell back to `omarchy-default-theme`.
- `omarchy-hook-dropin-name` (default `"50-emacs"`) to control the drop-in
  filename, and therefore when Emacs is notified relative to other drop-ins.

### Changed

- `omarchy-screenshot` now runs `omarchy-capture-screenshot` (was
  `omarchy-cmd-screenshot`).
- `omarchy-lock-screen` now runs `omarchy-system-lock` (was
  `omarchy-lock-screen`). The underlying lock is Quickshell's, not hyprlock's.
- Commentary and README document the Omarchy 4 requirement and the v0.1.0 pin.

### Notes

- `Solarized Light` is deliberately **not** bundled. It ships as a user-local
  theme under `~/.config/omarchy/themes/`, not as part of Omarchy, so mapping it
  in `omarchy-theme-map` would be wrong for everyone else. Add your own entry if
  you use it.
- The theme/font hook mechanism itself is unchanged — `omarchy-theme-set` and
  `omarchy-font-set` still invoke `omarchy-hook`, and `omarchy-theme-current`,
  `omarchy-theme-list`, `omarchy-font-current`, `omarchy-font-list`,
  `omarchy-toggle-nightlight` and `omarchy-cmd-terminal-cwd` are untouched by
  Quattro.

## [0.1.0] — 2026

Initial release. Final version targeting the **Omarchy 3** series.

### Added

- Theme and font synchronisation between Omarchy and Emacs via the `omarchy-*`
  CLIs, with `omarchy-init` handling daemon startup ordering.
- Interactive pickers `omarchy-theme-pick` and `omarchy-font-pick`.
- Thin wrappers for night light, Waybar, screenshot, lock screen and
  terminal-at-cwd.
- `omarchy-install-hooks` to generate the `theme-set` / `font-set` shell hooks.
- Thirteen bundled Modus-derived themes matching Omarchy 3's stock set.

[Unreleased]: https://github.com/ovistoica/omarchy.el/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/ovistoica/omarchy.el/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/ovistoica/omarchy.el/releases/tag/v0.1.0

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is Bob Yantosca's personal Emacs configuration. It's a directory meant to be cloned or copied into `~/.emacs.d`, or used as a git submodule of another repo. There is no build system, linter, or test suite — changes are validated by reloading Emacs and exercising the affected mode/binding/key interactively.

## Installation / applying changes

- `./install.sh` copies `emacs-config.org` and `init.el` into `~/.emacs.d`, then runs `git submodule update --init --recursive` and builds the `emacs-libvterm` submodule via cmake/make. Pass any argument to `install.sh` to skip the vterm build (e.g. `./install.sh skip`).
- To pick up edits without reinstalling, reload Emacs, or run `M-x org-babel-load-file` on the specific `.org` file you changed.
- Never hand-edit the generated `.emacs-config.el` — it's rebuilt from `emacs-config.org` on every startup and is gitignored.

## Architecture: the load chain

Configuration lives in literate org files, not plain `.el` files, and loads in this order:

1. `init.el` → `(org-babel-load-file "~/.emacs.d/emacs-config.org")`
2. `emacs-config.org`, under its `* Externals` heading, loads two more org files via `org-babel-load-file`:
   - `elisp/elisp.org` — wires up third-party single-file packages in `elisp/`
   - `elpa/elpa.org` — wires up vendored ELPA/MELPA packages in `elpa/`

Each `.org` file contains `#+BEGIN_SRC emacs-lisp ... #+END_SRC` blocks; these are the actual elisp and are what you edit. Prose between blocks is documentation, not comments to preserve mechanically.

**All user-facing settings belong in `emacs-config.org`**, organized under top-level headings (use `M-x outline` / org folding to navigate a ~700-line file):

- `Global toggles` — feature flags read by later sections (`enable-athena-backend`, `enable-two-vertical-frames`, `enable-vterm`)
- `Externals` — the `elisp.org`/`elpa.org` loading described above
- `Display` — date/time, font, frames, line/column numbers, scroll bar, splash screen, title, visual bell
- `General settings` — `custom-set-variables` block, backup/autosave, dired omit patterns, package archives, misc aliases
- `Key bindings` — buffers, deletion, ediff, editing, modes, navigation, search/replace
- `Major modes` — default mode, `auto-mode-alist` file-extension → mode mapping, and per-mode hooks (cperl, ediff, font-lock, f90, fortran, markdown, org, shell-script, text)
- `Motion` — cursor/mouse scroll behavior
- `Terminal emulation` — `term` and `vterm` setup (gated by `enable-vterm`)

When adding a new file-extension/mode association or key binding, find the matching heading above rather than searching blindly.

## Vendored code: read-only vs. actively edited

- `elisp/` holds single-file third-party modes obtained from upstream (cmake-mode, yaml-mode, markdown-mode, org-bullets, xterm-color, eterm-256color, org-tempo, ox-rst) plus the `rust-mode` git submodule. These are generally left as-is.
- `elisp/kpp.el` is the exception: a custom-maintained major mode for KPP (Kinetic PreProcessor) files used by GEOS-Chem chemistry mechanisms. It receives regular fixes (font-lock, keyword recognition) and should be treated as first-party code, not a vendored drop-in.
- `elpa/` holds vendored ELPA/MELPA packages (color-theme, yasnippet, magit, dash, async, ghub, git-commit, with-editor, magit-popup, treepy, better-shell, yasnippet-classic-snippets). Most are unmodified upstream drops.
- `elpa/yasnippet-classic-snippets-1.0.2/snippets/` is the exception: snippet files here (organized by major-mode subdirectory, e.g. `fundamental-mode/int-test-results`) are directly authored/edited as part of this repo — e.g. GEOS-Chem release Git/GitHub message snippets. Treat this snippets directory as project content, not a dependency to leave alone.

## Submodules

`emacs-libvterm` and `elisp/rust-mode` are git submodules (see `.gitmodules`). `emacs-libvterm` is only built/loaded when `enable-vterm` is `t` in `emacs-config.org`'s `Global toggles` section.

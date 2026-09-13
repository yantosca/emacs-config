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

### Emacs and Org versions per machine

This config is copied unmodified to machines spanning Emacs 26.1 to 31.x, and
Org version tracks the Emacs version. That gap is what most portability problems
come down to:

| Machine | Emacs | Org | Notes |
|---|---|---|---|
| calculon | 31.1 | bundled (9.8-era) | nothing to do |
| zoidberg | 29.3 | **9.8.10 from GNU ELPA** | bundles 9.6.15, which predates the 9.7 `org-element-*` renames `ox-rst` needs |
| Cannon | 26.1 | bundled 9.1 | cannot run a modern Org; see below |

zoidberg's Org was installed with `package-install-upgrade-built-in` set to `t`
(package.el otherwise treats the bundled Org as already satisfying the
dependency). It lands in `~/.emacs.d/elpa/`, separate from this repo's vendored
`elpa/`, and Emacs 27+ puts it on `load-path` before `init.el` runs, so the
`org-babel-load-file` call there picks it up. To back it out, delete
`~/.emacs.d/elpa/org-9.8.10*` and the bundled Org takes over again.

**Cannon has no upgrade path.** GNU ELPA now ships only Org 9.8.10, which
requires Emacs 28.2, and keeps no older versions; orgmode.org's own ELPA is a
stale 2021 snapshot. Short of building Org 9.7 from git, Emacs 26.1 is stuck on
Org 9.1, which is too old for `ox-rst` — it calls `org-assert-version`, added in
Org 9.6. That is survivable rather than fatal only because of `my-require`
(below): Cannon loses rst export and keeps everything else.

### Failure isolation: `my-require`

`org-babel-load-file` loads a tangled `.el`, and an error anywhere in it aborts
the rest of that file *and* the org file that loaded it. A single vendored
package that will not load therefore takes out everything configured after it —
for a `require` in `elisp.org`, that is most of `emacs-config.org`.

`my-require` (defined in `elisp/my-require.el`) wraps `require` in a
`condition-case` and returns non-nil on success. **Use it for anything
vendored under `elisp/` or `elpa/`**; plain `require` is fine for what Emacs
itself ships. Where the code after a require depends on the package having
loaded, guard it: `(when (my-require 'foo) ...)`.

Note that `require`'s own NOERROR argument is *not* a substitute — it only
covers a missing file, not an error signalled while the file loads.

### Deploy skew: emacs-config.org is a *copy*

`emacs-config.org` and `init.el` only reach `~/.emacs.d` when `install.sh` copies
them. Everything else — `elisp/*.org`, `elpa/*.org` and the vendored `.el` files
— is loaded in place from the repository. So `git pull` updates those
immediately while the deployed `emacs-config.org` stays behind until someone runs
`install.sh`.

**Never let something in `elisp/` or `elpa/` depend on a symbol defined in
`emacs-config.org`.** A pull would deliver the caller without the definition.
This bit `my-require`, which is why it lives in `elisp/my-require.el` — a file
that travels with the pull — rather than in `emacs-config.org` where it started.
Both calculon and hypnotoad failed at startup with `Symbol's function definition
is void: my-require` until that moved.

The reverse direction is safe: `emacs-config.org` may freely use things defined
under `elisp/`, since `* Externals` loads them before the rest of the file.

### Local portability patches

The vendored `.el` files under `elisp/` and `elpa/` are no longer pristine
upstream drops. They carry local patches that keep them compiling and running
cleanly across the Emacs versions this config targets — 26.1 on Harvard Cannon
through 31.x on calculon:

- `elisp/ox-rst.el` has an Org 9.7 compatibility shim near the top, defining the
  renamed `org-element-*` accessors in terms of their pre-9.7 equivalents when
  the running Org predates 9.7. Without it, list, link, math and table export all
  signal `void-function` on Emacs 29.3, which bundles Org 9.6.15.
- `elisp/org-bullets.el` lost its `(require 'cl)` and its positional
  `define-minor-mode` arguments; `cl` is gone in Emacs 31.
- `elisp/cmake-mode.el`, `elisp/yaml-mode.el` and `elisp/markdown-mode.el` use
  `line-beginning-position`/`line-end-position` instead of the obsolete
  `point-at-bol`/`point-at-eol`. Do **not** "modernize" these to `pos-bol`/`pos-eol`
  — those are Emacs 29+ only and would break Cannon.
- `elpa/yasnippet-0.14.0/yasnippet.el` has reflowed docstrings and a relocated
  `declare` form.

Separately, every vendored file that this config actually loads carries an
explicit `-*- lexical-binding: nil; -*-` cookie, because Emacs 30+ warns about
files that have no cookie at all. `nil` is deliberate: it states the semantics
the code was already written for, so it silences the warning while changing
nothing. Do **not** flip these to `t` without testing that package — several
(color-theme in particular, which dates to 2008) rely on dynamic binding. Our
own files — `init.el` and the three tangled outputs — use `t`.

**Re-check these after any upstream refresh** — pulling a new version of one of
these files will silently drop its patch. `./install.sh` byte-compiles everything
the config loads and reports failures; a clean run should print no warnings at
all.

## Submodules

`emacs-libvterm` and `elisp/rust-mode` are git submodules (see `.gitmodules`). `emacs-libvterm` is only built/loaded when `enable-vterm` is `t` in `emacs-config.org`'s `Global toggles` section.

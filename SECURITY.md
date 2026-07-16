# Security Policy

## Supported versions

This is a personal Emacs configuration published for others to reuse. Only
the `main` branch is maintained; there are no separate maintained release
branches.

## Reporting a vulnerability

This repository is Emacs Lisp configuration and vendored third-party
packages (under `elpa/` and `elisp/`) — it has no network service or server
component. Realistic concerns are things like a vendored package pinned at
a version with a known CVE, or a configuration change that would execute
untrusted code on load.

If you find such an issue:

- Preferably, report it privately via
  [GitHub Security Advisories](https://github.com/yantosca/emacs-config/security/advisories)
  with a description of the issue and, if possible, how to reproduce it.
  Please don't open a public GitHub issue for vulnerabilities until there's
  been time to address them.
- If it's a low-severity issue (e.g. an outdated vendored package with no
  practical exploit path in this config), a regular GitHub issue or pull
  request is fine.

There's no bounty program and no fixed response-time SLA — this is a
personal project maintained on a best-effort basis.

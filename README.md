# emacs-config : Repository of Emacs configuration files

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Description

This repository contains several settings for Emacs in a directory that can be cloned or copied to your `~/.emacs.d` folder.  It can also be used as a submodule of another repository.

## Installation

```console
$ cd ~/.emacs.d
$ git clone https://github.com/yantosca/emacs-config.git
$ cd emacs-config
$ ./install.sh
```
This will copy the following files to your ~/.emacs.d folder:

  1. init.el
  2. emacs-config.org

The init.el file loads the emacs-config.org file (via
org-babel-file-load).  A configuration file (emacs-config.el) will be
created with all of the corresponding options each time you start
emacs.

## Configuration notes

You should edit any configuration settings in the emacs-config.org
file.  You can use org-mode keys to open or close each of the
sections.  Configuration settings are contained in emacs-lisp code blocks.

Some external packages (e.g. color-theme, yasnippet, etc.) are
contained in the elpa/ directory tree.

Third-party configuration files (e.g. cmake-mode.el, yaml-mode.el) are
contained in the elisp/ folder.


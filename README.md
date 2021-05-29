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
This will copy an init.el file to your ~/.emacs.d folder where you can
customize the following settings:

  - Window font
  - Display frame options:
    - 2 vertical frames, optimized for desktop
    - 1 vertical frame, optmized for laptop
  - Enable or disable the vterm terminal module

All of the other settings will be defined by the various configuration files (*.el) in the emacs-config directory structure.

## Contents

### Main directory

 `emacs.config.el`: Main configuration file (called from `~/.emacs.d/init.el`).  Loads configuration options from other *.el files in subfolders.

### user-options directory

The `user_options` folder contains several `*.el` files that you can customize for your own setup:

  - `cmake-mode.el`: Sets indent, formatting etc. options for cmake-mode.
  - `display-options.el`: Sets general display options (timestamp, line/number, scrollbar, etc.) for Emacs frames.
  - `frame-options-desktop.el`: Sets the window and frame size for a typical desktop display (2 vertical frames side by side).
  - `frame-options-laptop.el`: Sets the window and frame size for a typical laptop setup (1 vertical frame).
  - `global-options.el`: Sets various global settings (backup & save, repositories, other misc. settings)
  - `keybind-options.el`: Sets keybindings for executing various functions or macros.
  - `mode-options.el`: Sets indent and formatting options for several common major modes (f90-mode, python-mode, etc.)
  - `motion-options.el`: Sets cursor and mouse scroll options.
  - `term-options.el`: Sets options for the emacs terminal (aka "term").
  - `yaml-mode.el`: Sets indentation and formatting options for yaml-mode.

### color-theme-6.6.1 directory

This folder contains the `color-theme` package.  You can use this to set the background color of frames.

### elpa directory

Directory containing various other Emacs packages (including yasnippet-0.14.0 and magit).  You should not need to modify this folder.
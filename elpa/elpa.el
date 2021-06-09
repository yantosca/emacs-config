(add-to-list
 'load-path
 "~/.emacs.d/emacs-config/elpa/color-theme-6.6.1")
(when (display-graphic-p)
  (require 'color-theme)
  (setq color-theme-is-global t)
  (color-theme-initialize)
  (color-theme-yantosca))

(add-to-list 'load-path
 "~/.emacs.d/emacs-config/elpa/yasnippet-0.14.0")
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path
 "~/.emacs.d/emacs-config/elpa/yasnippet-classic-snippets-1.0.2")
(require 'yasnippet-classic-snippets)

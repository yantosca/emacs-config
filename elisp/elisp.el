(add-to-list 'load-path "~/.emacs.d/emacs-config/elisp/")

(require 'cmake-mode)

(require 'yaml-mode)

(add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;(require 'eterm-256color)
(require 'xterm-color)

;;; keybind-options.el -- User-customizable key bindings
;;
;; NOTE: Some specific key bindings are located
;; in motion-options.el and term-options.el
;; 
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

; Editing
(global-set-key [f1]                   'kill-line)
(global-set-key [f2]                   'kill-word)
(global-set-key [f3]                   'string-rectangle)
(global-set-key [f4]                   'delete-rectangle)
(global-set-key [f5]                   'shell) ;macrotimestamp)
(global-set-key [(shift f5)]           'delete-trailing-whitespace)
(global-set-key (kbd "<S-pause>")      "\M-l")
(global-set-key (kbd "<pause>")        "\M-u")
(global-set-key (kbd "<kp-enter>")     'goto-line)

; Search & replace
(global-set-key [f6]                   'find-file)
(global-set-key [(shift f6)]           'insert-file)
(global-set-key [f7]                   'save-buffer)
(global-set-key [f8]                   'isearch-forward)
(global-set-key [f9]                   'replace-string)
(global-set-key [(shift f9)]           'query-replace)
				       
; Buffers			       
(global-set-key [f10]                  'swapbuffer)
(global-set-key [f11]                  'switch-to-buffer)
(global-set-key [f12]                  'kill-this-buffer)
				       
; Modes				       
(global-set-key [(control f3)]         'c++-mode)
(global-set-key [(control f4)]         'cmake-mode)
(global-set-key [(control f5)]         'f90-mode)
(global-set-key [(control f6)]         'idlwave-mode)
(global-set-key [(control f7)]         'makefile-mode)
(global-set-key [(control f8)]         'shell-script-mode)
(global-set-key [(control f9)]         'cperl-mode)
(global-set-key [(control f10)]        'font-lock-mode)

; Ediff
(global-set-key [(shift f1)]           'ediff-files)
(global-set-key [(shift f2)]           'ediff-buffers)
(global-set-key [(shift f3)]           'fullcleanediff)

; Deletion
(global-set-key [(delete)]             "\C-d")   
(global-set-key [(control delete)]     'kill-word)
(global-set-key [(control backspace)]  'backward-kill-word)
(delete-selection-mode t)

;; Navigation and scrolling
(global-set-key [(meta n)]             'scroll-n-lines-ahead)
(global-set-key [(meta p)]             'scroll-n-lines-behind)
(global-set-key [(control tab)]        'other-window)

;; Shell
(global-set-key (kbd "C-'") 'better-shell-shell)
(global-set-key (kbd "C-;") 'better-shell-remote-open)


(provide 'keybind-options)

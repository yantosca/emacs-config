;;; emacs-config.el: Main file for Emacs customizations
;;
;; 26 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;;=============================================================================
;; FONTS - customize to look best on your system!
;;
;; Some good options (note: 120 = 12pt, etc)
;; (1) "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1" 
;; (2) "-*-Lucidatypewriter-Bold-R-*-*-*-140-*-*-*-*-iso8859-1" 
;; (3) "-*-Lucidatypewriter-*-R-*-*-*-140-*-*-*-*-iso8859-1"
;; (4) "-*-Lucidatypewriter-Bold-R-*-*-*-130-*-*-*-*-iso8859-1"
;; (5) "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1" 
;;=============================================================================
(set-face-font
 'default "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1" )

;;=============================================================================
;; COLOR SETTINGS - customize
;;=============================================================================

;; Only load the background color if we are running Emacs in Xwindows
(when (display-graphic-p)
  (set-face-background 'default "gray75"))

;; "COLORIZATION" COLORS FOR CODE
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-face-symlink ((t (:foreground "white" :background "darkOrchid"))))
 '(font-lock-builtin-face ((t (:foreground "red2"))))
 '(font-lock-comment-face ((t (:foreground "#6920ac"))))
 '(font-lock-doc-face ((t (:foreground "green4"))))
 '(font-lock-doc-string-face ((t (:foreground "green4"))))
 '(font-lock-function-name-face ((t (:foreground "red2"))))
 '(font-lock-keyword-face ((t (:foreground "orange3"))))
 '(font-lock-other-type-face ((t (:foreground "blue"))))
 '(font-lock-preprocessor-face ((t (:foreground "red2"))))
 '(font-lock-reference-face ((t (:foreground "red2"))))
 '(font-lock-string-face ((t (:foreground "green4"))))
 '(font-lock-type-face ((t (:foreground "brown"))))
 '(font-lock-variable-name-face ((t (:foreground "blue"))))
 '(sh-heredoc ((((class color) (background light)) (:foreground "green4"))))
 '(term-color-black ((t (:background "black" :foreground "black"))))
 '(term-color-cyan ((t (:background "cyan" :foreground "cyan"))))
 '(term-color-green ((t (:background "green3" :foreground "green3"))))
 '(term-color-magenta ((t (:background "dark magenta" :foreground "dark magenta")))
 '(term-color-yellow ((t (:background "yellow" :foreground "yellow"))))))
;
;; Set syntax highlighting for diff mode (*.diff files)
(defun update-diff-colors ()
  "update the colors for diff faces"
  (set-face-attribute 'diff-added nil
                      :foreground "black" :background "DarkSeaGreen1")
  (set-face-attribute 'diff-removed nil
                      :foreground "black" :background "RosyBrown1")
  (set-face-attribute 'diff-changed nil
                      :foreground "black" :background "wheat1"))
(eval-after-load "diff-mode"
  '(update-diff-colors))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "ASCII")
 '(display-time-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages '(better-shell magit yasnippet-classic-snippets))
 '(query-user-mail-address nil)
 '(term-default-fg-color "LemonChiffon")
 '(term-default-bg-color "DarkSlateGray")
 '(user-mail-address "yantosca@seas.harvard.edu"))

;;=============================================================================
;; Load customizations that are less likely to be modified by the user.
;; We have abstracted these into separate files in the ~/.emacs.d folder.
;;=============================================================================

;; Look for config files (*.el) in these directories
(add-to-list 'load-path "~/.emacs.d/emacs-config/user-options")
(add-to-list 'load-path "~/.emacs.d/emacs-config/color-theme-6.6.0/")

;; Load user-customizable options
;; NOTE: Only pick one of frame-options-laptop or frame-options-desktop!
(require 'global-options)         ;; Global settings & func defs
(require 'display-options)        ;; Display customizations
(require 'frame-options-laptop)   ;; Window & frame size options
;(require 'frame-options-desktop)  ;; Window & frame size options
(require 'keybind-options)        ;; Emacs keybindings
(require 'mode-options)           ;; Major mode options
(require 'motion-options)         ;; Cursor & mouse motion options
(require 'term-options)           ;; Terminal options w/in emacs
(require 'color-theme)            ;; Color themes

;(require 'color-theme-buffer-local)
;(add-hook 'term-mode
;	  (lambda nil
;	    (color-theme-buffer-local 'color-theme-gnome (current-buffer))))
;EOC


(provide 'emacs-config)

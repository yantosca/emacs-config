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

;; Comment out since we are now using a color theme
;; Only load the background color if we are running Emacs in Xwindows
;(when (display-graphic-p)
;  (set-face-background 'default "gray75"))

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
 '(sh-heredoc ((((class color) (background light)) (:foreground "green4")))))
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
 '(user-mail-address "yantosca@seas.harvard.edu"))

;;=============================================================================
;; USER CUSTOMIZATIONS
;; We have abstracted these into separate *.el (Emacs-Lisp) files in
;; the emacs-config/user-options folder.  Edit these to your tastes.
;;=============================================================================

;; Look for Emacs-Lisp config files (*.el) in these directories
(add-to-list 'load-path "~/.emacs.d/emacs-config/user-options")
(add-to-list 'load-path "~/.emacs.d/emacs-config/emacs-libvterm")

;; Load user-customizable options
;; NOTE: Only pick one of frame-options-laptop or frame-options-desktop!
(require 'global-options)           ;; Global settings & func defs
(require 'display-options)          ;; Display customizations
;(require 'frame-options-laptop)     ;; Window & frame size options
(require 'frame-options-desktop)   ;; Window & frame size options
(require 'keybind-options)          ;; Emacs keybindings
(require 'mode-options)             ;; Major mode options
(require 'motion-options)           ;; Cursor & mouse motion options
(require 'vterm)                    ;; Vterm native-compiled terminal
(require 'term-options)             ;; Terminal options w/in emacs
(require 'eterm-256color)           ;; Extended color options for term mode

;;=============================================================================
;; COLOR THEME CUSTOMIZATIONS
;; We now use the "color-theme-yantosca" color theme by default.
;; This is based off of "color-theme-gnome" with further customizations
;; to match the Xterminal color scheme of Bob Yantosca.
;;=============================================================================

;; Look for Emacs-Lisp config files (*.el) in these directories
(add-to-list 'load-path "~/.emacs.d/emacs-config/color-theme-6.6.1/")

;; Pick the "Yantosca" custom color-theme if we are running in X11
(when (display-graphic-p)
  (require 'color-theme)
  (setq color-theme-is-global t)
  (color-theme-initialize)
  (color-theme-yantosca)


(provide 'emacs-config)

;;; emacs-config.el: Main file for Emacs customizations
;;
;; 26 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;;=============================================================================
;; COLOR SETTINGS - customize
;;=============================================================================

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

;; Load several user-customizable settings
(require 'global-options)           ;; Global settings & func defs
(require 'display-options)          ;; Display customizations
(require 'keybind-options)          ;; Emacs keybindings
(require 'mode-options)             ;; Major mode options
(require 'motion-options)           ;; Cursor & mouse motion options
(require 'term-options)             ;; term customizations w/in emacs
(require 'xterm-color)              ;; Color Xterminal options

;; Enable vterm (compiled module, faster than term)
(when enable-vterm
  (require 'vterm)                  ;; vterm native-compiled terminal
  (require 'vterm-options))         ;; vterm customizations w/in emacs

;; Set the window frame options depending on the user's choice in ../init.el
(if enable-two-vertical-frames
    (require 'frame-options-desktop)
  (require 'frame-options-laptop))

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
  (color-theme-yantosca))


;; Export this configuration
(provide 'emacs-config)

;;; init-global.el --- Define various global settings for Emacs
;;
;; Bob Yantosca (yantosca@seas.harvard.edu)
;; 25 May 2021

;; Whatever your configuration is, you get TWO WINDOWS SPLIT VERTICAL. If
;; it is already the case, the left and right buffers are switched.
(defalias 'two-windows-vertical
  (read-kbd-macro "C-x 1 C-x 3 C-x b RET"))

;; kill process (like a tail -f) and purge output. In shell mode.
(defalias 'quitnclean
  (read-kbd-macro "C-c C-\\ C-c C-o"))

;; for quick swap b/w 2 buffers
(defalias 'swapbuffer
  (read-kbd-macro "C-x b RET"))

;; EDIFF : to restore my 2 windows setting w/ each compared file in one window
(defalias 'clean-after-ediff
  (read-kbd-macro "C-x 1 C-x 3 C-x b RET"))

;;; EDIFF : like clean-after-ediff but close the two compared windows
;;; This one depends on the bindings below
;(defalias 'fullcleanediff
;  (read-kbd-macro "<f3> <C-f2> <f3>"))

;; EDIFF : close the two compared windows
;; This one depends on the bindings below
(defalias 'fullcleanediff
  (read-kbd-macro "<f3> <f2> <f3>"))

;; OMIT :
;; This C-o business was working in Xemacs, but it is not in Emacs...:
;; to add ".mod" to the list of file type to omit when you do C-o in Directory
(defalias 'omitmod
  (read-kbd-macro "C-u %o.mod RET"))

;; So redefined the "omit" functions for Emacs in dired mode:
(fset 'omitdotfiles
      [?% ?m ?^ ?\\ ?. ?. ?* return ?k])

;; and this one will omit .o, .mod, ~, and . files from directory listing
(fset 'omit-fortran
      [?% ?m ?^ ?\\ ?. ?\\ ?| ?\\ ?. ?o ?$ ?\\ ?| ?\\ ?. ?m ?o ?d ?$ ?\\ ?| ?~ ?$ return ?k])

;; customized insertion of timestamp (function is defined below in miscella.)
(fset 'macrotimestamp
      [?\M-x ?i ?n ?s ?e ?r ?t ?- ?t ?i ?m ?e ?s ?t tab return return left ? ])

;;-----------------------------------------------------------------------------
;; BACKUP & AUTOSAVE options
;;-----------------------------------------------------------------------------
(setq backup-by-copying t)     ;; for symlinks to refer to the last version
(setq delete-old-versions t)   ;; delete excess backups silently
(setq kept-new-versions 10)    ;; Keep 10 new versions
(setq kept-old-versions 2)     ;; Keep 2 old versions
(setq version-control t)       ;; always use versioned backups

;;-----------------------------------------------------------------------------
;; REPOSITORIES -- use melpa-stable for installing packages
;;-----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Make the init-global module visible
(provide 'global-options)

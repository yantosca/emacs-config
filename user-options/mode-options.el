;;; mode-options.el -- Basic display options for Emacs frames
;;
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;; activate image mode to display images in emacs buffer (jpg, gif, tiff, ...)
;; Alternatively, you can use ! command, where command is DISPLAY, GV
(auto-image-file-mode)

;; Autoload modes
(autoload 'matlab-mode "matlab" "Major mode for editing .m files" t)
(autoload 'idl-mode "idl" "Major mode for editing IDL/WAVE CL .pro files" t)
(autoload 'idlwave-mode  "idlwave"  "IDLWAVE Mode"  t)

;; Use fundamental-mode by default ...
(setq-default major-mode 'fundamental-mode)

;; ... but load the appropriate mode for different file types
(setq auto-mode-alist
      (append '(("\\.cmake$"                . cmake-mode)
                ("\\.c$"                    . c-mode)
		("\\.C$"                    . c++-mode)
		("\\.cc$"                   . c++-mode)
		("\\.hh$"                   . c++-mode)
		("\\.hpp$"                  . c++-mode)
		("\\.cpp$"                  . c++-mode)
		("\\.h$"                    . c++-mode)
		("\\.hM$"                   . c++-mode)
		("\\.F$"                    . fortran-mode)
		("\\.H$"                    . f90-mode)
		("\\.F90"                   . f90-mode)
		("\\.kpp"                   . f90-mode)
		("\\.eqn$"                  . fundamental-mode)
		("\\.geos$"                 . fundamental-mode)
		("\\.log$"                  . fundamental-mode)
		("\\.rc$"                   . fundamental-mode)
		("\\.m$"                    . matlab-mode)
		("\\.md$"                   . org-mode)
		("\\.rst$"                  . org-mode)
		("\\.tex$"                  . org-mode)
		("\\.sh$"                   . shell-script-mode)
		("\\.env$"                  . shell-script-mode)
		("\\.centos7$"              . shell-script-mode)
		("\\.pl$"                   . cperl-mode)
		("\\.yaml$"                 . yaml-mode)
		("\\.yml$"                  . yaml-mode)
	       )auto-mode-alist))

;; Manually add certain configuration files to shell-script mode
(add-to-list 'auto-mode-alist '(".bash_profile"         . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bashrc"               . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bash_aliases"         . shell-script-mode))
(add-to-list 'auto-mode-alist '(".my_personal_settings" . shell-script-mode))
(add-to-list 'auto-mode-alist '("README"                . fundamental-mode))

;;-----------------------------------------------------------------------------
;; FORTRAN MODE CUSTOMIZATIONS (aka Fortran 77 style)
;;
;; NOTE: For Emacs 24.4 and higher!!! (Bob Yantosca, 11 Dec 2015)
;; ===========================================================================
;; Turn off the "electric-indent-mode if it supported in this Emacs version.
;; This feature was introduced in Emacs 24.  When typing multiple comment
;; lines (esp. in Fortran mode), electric-indent would align each new comment
;; line to column 0 instead of at the previous indent level.  This meant that
;; you would have had to manually indent comments by typing spaces.
;;
;; With electric-indent-mode turned off, after hitting return, the cursor
;; will return to column 0.  You can then hit TAB to move the cursor to the
;; previous indent level and then type your comment or code.
;;
;; The default indentation behavior for Fortran mode was changed in Emacs 24.
;; Fortran-90 mode is unaffected.  Therefore, we turn off the electric-indent
;; mode only if we are in Fortran mode.
;;
;; See this web post for more information: http://emacs.stackexchange.com/questions/5939/how-to-disable-auto-indentation-of-new-lines
;;-----------------------------------------------------------------------------

(add-hook 'fortran-mode-hook
	  (function
	   (lambda ()
	     (setq
	      ;; use abbreviations (e.g.: ";s" for "stop")
	      abbrev-mode 1
	      )

             ; Turn off automatic indentation for Fortran mode only
             (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
	     )
	   )
)

;; Make sure we have F90 mode loaded
(require 'fortran)
;
;;-----------------------------------------------------------------------------
;; F90 MODE CUSTOMIZATIONS (free-format style)
;;-----------------------------------------------------------------------------
(add-hook 'f90-mode-hook
	  (function
	   (lambda ()

	     ;; use abbreviations (e.g.: "`pr" for "print")
	     (setq  abbrev-mode 1)

             ; Turn off automatic indentation for Fortran mode only
             (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

	     )
	   )
)

;; Align comments starting with ! with the code
(fset 'smart-f90-tab
   [home ?  tab end])

;; Make sure we have F90 mode loaded
(require 'f90)

;;-----------------------------------------------------------------------------
;; SHELL SCRIPT MODE CUSTOMIZATIONS
;;-----------------------------------------------------------------------------
(add-hook 'shell-mode-hook
	  '(lambda ()
             (local-set-key [home] 'comint-bol)                ;; Home key

	     (local-set-key [up]                               ;; Cycle up
                            '(lambda () (interactive)          ;; through
                               (if (comint-after-pmark-p)      ;; command
                                   (comint-previous-input 1)   ;; history
                                 (previous-line 1))))

	     (local-set-key [down]                             ;; Cycle down
                            '(lambda () (interactive)          ;; through
                               (if (comint-after-pmark-p)      ;; command
                                   (comint-next-input 1)       ;; history
                                 (forward-line 1))))
             )
)

;;----------------------------------------------------------------------------
;; TEXT-MODE CUSTOMIZATIONS
;;-----------------------------------------------------------------------------
(add-hook 'text-mode-hook 'turn-on-auto-fill)  ;; Turn on auto-formatting

;;-----------------------------------------------------------------------------
;; CPERL-MODE CUSTOMIZATIONS
;;-----------------------------------------------------------------------------
(setq perl-indent-level 2)               ;; Number of spaces to indent
(setq perl-tab-to-comment t)             ;; Create a new comment with tab
(setq perl-electric-parens t)            ;; Add the matching ), }, ]
(setq perl-electric-keywords t)          ;; Automatic expansion of keywords
(setq perl-continued-statement-offset 2) ;; Extra indent for each sub-block

;;-----------------------------------------------------------------------------
;; CMAKE-MODE CUSTOMIZATIONS
;;
;; NOTE: Get cmake-mode.el from:
;;   https://github.com/Kitware/CMake/blob/master/Auxiliary/cmake-mode.el
;; and copy it to your ~/.emacs.d folder
;;-----------------------------------------------------------------------------
(require 'cmake-mode)

;;-----------------------------------------------------------------------------
;; YAML-MODE CUSTOMIZATIONS
;;
;; NOTE: Get yaml-mode.el from:
;;   See https://github.com/yoshiki/yaml-mode
;; and copy it to your ~/.emacs.d folder
;;-----------------------------------------------------------------------------
(require 'yaml-mode)
(add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)
     )
)

;;-----------------------------------------------------------------------------
;; GLOBAL FONT LOCK MODE (for colorizing text)
;;-----------------------------------------------------------------------------
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1)          ; GNU Emacs
    (setq font-lock-auto-fontify t))   ; XEmacs

;;-----------------------------------------------------------------------------
;; GLOBAL YASnippets MODE
;;-----------------------------------------------------------------------------
(add-to-list 'load-path
	     "~/.emacs.d/emacs-config/elpa/yasnippet-0.14.0")
(add-to-list 'load-path
	     "~/.emacs.d/emacs-config/elpa/yasnippet-classic-snippets-1.0.2")
(require 'yasnippet)
(require 'yasnippet-classic-snippets)
(yas-global-mode 1)

;;-----------------------------------------------------------------------------
;; ORG MODE
;;-----------------------------------------------------------------------------
(require 'org-tempo)
(setq org-startup-indented t)
(setq org-src-tab-acts-natively t)
(setq org-hide-emphasis-markers t)
(setq org-fontify-done-headline t)
(setq org-hide-leading-stars t)
(setq org-pretty-entities t)
(setq org-odd-levels-only t)
(setq org-structure-template-alist
  '(("a" . "export ascii\n")
    ("c" . "center\n")
    ("C" . "comment\n")
    ("e" . "example\n")
    ("E" . "export")
    ("h" . "export html\n")
    ("l" . "export latex\n")
    ("q" . "quote\n")
    ("s" . "src")
    ("v" . "verse\n")))

;; Need this to get Yasnippets to work with Org Mode
(defun yas-org-very-safe-expand()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
	  (lambda ()
	    (make-variable-buffer-local 'yas/trigger-key)
	    (setq yas/trigger-key [tab])
	    (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
	    (define key yas/keymap [tab] 'yas/next-field)))



(provide 'mode-options)

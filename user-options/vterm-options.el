;;; vterm-options.el -- Options for the Emacs "vterm" mode
;;
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu
;;
;; NOTE: Will be ignored if enable-vterm is set to nil.
;;
;; see http://stackoverflow.com/questions/2886184/copy-paste-in-emacs-ansi-term-shell/2886539#2886539

;; {{ @see http://emacs-journey.blogspot.com.au/2012/06/improving-ansi-vterm.html
;; kill the buffer when vterminal is exited
(defadvice vterm-sentinel (around my-advice-vterm-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'vterm-sentinel)

;; always use bash
(defvar my-vterm-shell "/bin/bash")
(defadvice vterm (before force-bash)
  (interactive
   (list my-vterm-shell)))
(ad-activate 'vterm)

;; utf8
(defun my-vterm-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'vterm-exec-hook 'my-vterm-use-utf8)

;; }}

;; {{ multi-vterm
(defun last-vterm-buffer (l)
  "Return most recently used vterm buffer."
  (when l
	(if (eq 'vterm-mode (with-current-buffer (car l) major-mode))
	    (car l) (last-vterm-buffer (cdr l)))))

(defun get-vterm ()
  "Switch to the vterm buffer last used, or create a new one if
    none exists, or if the current buffer is already a vterm."
  (interactive)
  (let ((b (last-vterm-buffer (buffer-list))))
	(if (or (not b) (eq 'vterm-mode major-mode))
	    (multi-vterm)
	  (switch-to-buffer b))))

(defun vterm-send-kill-whole-line ()
  "Kill whole line in vterm mode."
  (interactive)
  (vterm-send-raw-string "\C-a")
  (vterm-send-raw-string "\C-k"))

(defun vterm-send-kill-line ()
  "Kill line in vterm mode."
  (interactive)
  (vterm-send-raw-string "\C-k"))

(defun vterm-send-escape ()
  (vterm-send-key "<escape>"))

;; Open a uniquely-named vterminal
(defun unique-bash-vterm ()
  "Opens a uniquely-named vterminal running bash."
  (interactive)
  (vterm)
  (vterm-send-key "<escape>")
  (rename-uniquely)
  )

;; Keybindings
(global-set-key [(control f1)] 'unique-bash-vterm)
(global-set-key (kbd "C-q") 'unique-bash-vterm)
(define-key global-map (kbd "C-x e") 'multi-vterm)


(provide 'vterm-options)

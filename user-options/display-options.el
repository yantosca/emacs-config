;;; display-options.el -- Basic display options for Emacs frames
;;
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;; Display path name in window title
(setq frame-title-format "%S: %f")

;; Turn on line and column number mode
(setq-default line-number-mode   t)
(setq-default column-number-mode t)

;; get date and time in the info bar ("mode line")
(setq display-time-day-and-date t)
(setq display-time-string-forms
      (quote
       ((if (and (not display-time-format)
		 display-time-day-and-date)
	    (format-time-string "%a %b %e   " now) "  ")
	(format-time-string
	 (or display-time-format
	     (if display-time-24hr-format "%H:%M" "%-I:%M%p")) now)
	))
      )
(display-time)

;; To insert a basic time stamp in a buffer
(defun insert-timestamp ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "!  %e %b %Y - R. Yantosca - ")))

;; no splash screen at start
(setq inhibit-splash-screen t)   ;; not working w/ 21.4
(setq inhibit-startup-message t) ;; working w/ 21.4

;; C-k kills line and end of line
(setq kill-whole-line t)

;; Enable multiple minibuffers.  If you don't do this, then you
;; can't do things like search the minibuffer history with M-s.
(setq minibuffer-max-depth nil)

;; to answer Y/ N instead of YES/NO RET when asked for confirmation
;; NOTE: not for newbies!
(defalias 'yes-or-no-p 'y-or-n-p)

;; Put vertical scroll bar on the left (bmy, 5/30/17)
(set-scroll-bar-mode 'left)

;; Set Ediff window splitting
;;(setq ediff-split-window-function 'split-window-horizontally) ;; horizontal
(setq ediff-split-window-function 'split-window-vertically)     ;; vertical

;; Subtly flash the mode line when an exception (e.g. compiler warning) occurs
(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))


(provide 'display-options)

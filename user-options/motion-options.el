;;; motion-options.el -- Cursor and mouse scroll options
;;
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;;=============================================================================
;; CURSOR SCROLL
;;=============================================================================
(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

; Accelerate by 10 lines
(global-set-key [(control shift n)] (lambda () (interactive) (next-line 10)))
(global-set-key [(control shift p)] (lambda () (interactive) (previous-line 10)))

;; To scroll only one line when cursor is at the bottom of the screen
;; (instead of finding the lastline suddenly in the middle)
;; (I use it in conjunction with C-l to get the cursor at the middle of
;;  the screen if this is what I really want)
(setq scroll-step 1)

;;=============================================================================
;; MOUSE WHEEL -- scroll by 3 lines at a time
;;=============================================================================
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;;=============================================================================
;; BOUNCE BETWEEN PARENTHESES 
;; bounces from one sexp "(){}[]<>" to another (ala vi's %)
;; written by Joe Casadonte (joc@netaxs.com)
;;=============================================================================
(defun joc-bounce-sexp ()
  "Will bounce between matching parens just like % in vi"
  (interactive)
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
        (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
                  ((string-match "[\]})>]" prev-char) (backward-sexp 1))
                  (t (error "%s" "Not on a paren, brace, or bracket")))))
(global-set-key [(control =)] 'joc-bounce-sexp)


(provide 'motion-options)

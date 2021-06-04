;;; init.el -- Initialization file for Emacs
;;
;; 28 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;;=============================================================================
;; Set variables to toggle various options on (t) or off (nil)
;;=============================================================================
(setq enable-two-vertical-frames t)   ;; Use larger window w/ 2 vertical frames
(setq enable-vterm nil)               ;; Use vterm instead of term
(setq enable-athena-backend nil)      ;; Use athena/X11 instead of gtk

;;=============================================================================
;; FONTS - customize to look best on your system!
;;
;; Some good options (note: 120 = 12pt, etc)
;; (1) "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1"
;; (2) "-*-Lucidatypewriter-Bold-R-*-*-*-140-*-*-*-*-iso8859-1"
;; (3) "-*-Lucidatypewriter-*-R-*-*-*-140-*-*-*-*-iso8859-1"
;; (4) "-*-Lucidatypewriter-Bold-R-*-*-*-130-*-*-*-*-iso8859-1"
;; (5) "-*-source code pro-Bold-R-*-*-*-140-*-*-*-*-iso8859-1"
;;=============================================================================
(unless enable-athena-backend
  (when (display-graphic-p)
    (set-face-font
     'default "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1")))

;;=============================================================================
;; Load emacs configurations from the emacs-config submodule
;;=============================================================================
(add-to-list 'load-path "~/.emacs.d/emacs-config")
(require 'emacs-config)

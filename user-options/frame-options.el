;;=============================================================================
;; FRAME SIZE AND POSITION
;; NOTE: The default is for a screen of 1920x1200 resolution,
;; You will likely want to modify these settings if working
;; with a different resolution (e.g. on your laptop)
;;=============================================================================

;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;; %%%%% Bob Y's Coronavirus working from home preferences          
;; %%%%% Open two windows, 80 columns x 49 lines, centered on screen
;;(set-frame-height (selected-frame) 49)    ; 48 lines
;;(set-frame-width  (selected-frame) 164)   ; 163 columns
;;(split-window-horizontally)               ; Use two vertical windows
;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;; %%%%% Bob Y's Linux Laptop preferences
;; %%%%% Open 1 window
(set-frame-height (selected-frame) 34)      ; 34 lines
(set-frame-width  (selected-frame) 81)      ; 80 columns
;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;; %%%%% Bob Y's working at the office preferences 
;; %%%%% Open two windows side by side, 164 columns x 72 lines
;;(set-frame-height (selected-frame) 72)      ; 72 lines, for XMing
;;(set-frame-height (selected-frame) 56)      ; 56 lines, for MobaXterm
;;(set-frame-width  (selected-frame) 164)     ; 164 columns
;;(split-window-horizontally)                 ; Use two vertical windows
;;(other-window 1)                            ; Start in the right window
;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; %%%%% Other possibilities (uncomment the one you want)

;; %%%%% Open one window, 80 columns x 60 lines, centered on screen %%%%%
;;(set-frame-height (selected-frame) 72)    ; 72 lines
;;(set-frame-width  (selected-frame) 81)    ; 80 columns
;;(set-frame-position (selected-frame) 550 30)

;; %%%%% Open two windows on top of each other, 80 columns x 72 lines %%%%%
;;(set-frame-height (selected-frame) 72)    ; 72 lines
;;(set-frame-width  (selected-frame) 80)    ; 80 columns
;;(split-window-vertically)                 ; Use two horizontal windows
;;(other-window 1)                          ; Start in the bottom window

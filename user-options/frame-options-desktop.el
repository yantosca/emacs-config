;;; frame-options-desktop.el -- Window & Frame sizes for a desktop display
;;
;; 25 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

(set-frame-height (selected-frame) 49)    ; 48 lines
(set-frame-width  (selected-frame) 164)   ; 163 columns
(split-window-horizontally)               ; Use two vertical windows

(provide 'frame-options-desktop)

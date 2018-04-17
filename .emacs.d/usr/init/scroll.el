;; -----------------------------------------------------------------------------
;; File: scroll.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Configure scrolling mechanics.
;; 
;; -----------------------------------------------------------------------------

;; Disable scroll bar
(when (window-system)
  (scroll-bar-mode -1))

;; Change the way Emacs keyboard scrolls
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Change Emacs Trackpad scrolls
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

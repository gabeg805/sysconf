;; -----------------------------------------------------------------------------
;; File: highlight.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Highlight line and region, as well as parenthesis pairs.
;; 
;; -----------------------------------------------------------------------------

;; Highlight parenthesis pairs
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Highlight region
(transient-mark-mode 1)
(set-face-attribute 'region nil
                    :background "#222222"
                    :foreground nil
                    :inherit t)

;; Highlight line
(remove-hook 'coding-hook 'turn-on-hl-line-mode)
(global-hl-line-mode 1)
(setq hl-line-sticky-flag 1)
(set-face-attribute 'hl-line nil
                    :background "#3f3f3f"
                    :foreground nil
                    :inherit t)

;; -----------------------------------------------------------------------------
;; File: keybindings.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Personal keybindings.
;; 
;; -----------------------------------------------------------------------------

;; Kill Line Backwards
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

;; Prompt when closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

;; Unset keybindings
(global-unset-key "\C-x\C-z")
(global-unset-key "\C-z")
(global-unset-key "\C-j")
(global-unset-key "\M-r")
(global-unset-key "\C-xb")

;; Set keybindings
(global-set-key "\C-xw" 'count-words)
(global-set-key "\M-," 'beginning-of-buffer)
(global-set-key "\M-." 'end-of-buffer)
(global-set-key "\M-r" 'query-replace)
(global-set-key "\M-s" 'switch-to-buffer)
(global-set-key "\M-f" 'forward-word)
(global-set-key "\M-b" 'backward-word)
(global-set-key "\C-f" 'forward-char)
(global-set-key "\C-b" 'backward-char)
(global-set-key "\C-xc" 'set-fill-column)
;; (global-set-key "\C-xf" 'fill-individual-paragraphs)
(global-set-key "\C-xp" 'fill-paragraph)
(global-set-key (kbd "<f5>") 'eval-buffer)
(global-set-key "\C-xb" 'backward-kill-line) 
(global-set-key (kbd "C-x C-c") 'ask-before-closing)

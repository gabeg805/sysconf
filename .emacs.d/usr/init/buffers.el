;; -----------------------------------------------------------------------------
;; File: buffers.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Per-buffer configuration. Right now used to close unwanted buffers
;;        that are opened when emacs starts.
;; 
;; -----------------------------------------------------------------------------

;; Close startup window
(setq inhibit-startup-screen t)

;; Removes the specified buffer 
(defun remove-completion-buffer ()
  (if (get-buffer "*Completions*")
    (kill-buffer "*Completions*")))
(defun remove-message-buffer ()
  (if (get-buffer "*Messages*")
    (kill-buffer "*Messages*")))
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
    (kill-buffer "*scratch*")))

;; Empty *scratch* buffer
(setq initial-scratch-message "")
(setq-default message-log-max nil)

;; Remove unwanted buffers
(remove-message-buffer)
(remove-scratch-buffer)
(add-hook 'minibuffer-exit-hook 'remove-completion-buffer)
(add-hook 'minibuffer-exit-hook 'remove-message-buffer)
(add-hook 'minibuffer-exit-hook 'remove-scratch-buffer)

;; Add directory name to buffer name
(defun mode-line-buffer-file-parent-directory ()
  (when buffer-file-name
    (concat "[" (file-name-nondirectory (directory-file-name (file-name-directory buffer-file-name))) "]")))
(setq-default mode-line-buffer-identification
      (cons (car mode-line-buffer-identification) '((:eval (mode-line-buffer-file-parent-directory)))))

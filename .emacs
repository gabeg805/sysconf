;; -----------------------------------------------------------------------------
;; Default custom sets
;; -----------------------------------------------------------------------------


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-faces
  '(default ((t (:family "Input" :foundry "nil" :slant normal :weight normal
                 :height 100 :width normal :foreground "#ffffff"
                 :background "#303030"))))
  '(font-lock-comment-face  ((t (:foreground "#777777"))))
  '(font-lock-constant-face ((t (:foreground "#e79600"))))
  '(sh-quoted-exec          ((t (:bold t :foreground "#1fc4eb"))))
)

;; -----------------------------------------------------------------------------
;; General Setup
;; -----------------------------------------------------------------------------

;; Setup emacs display
(display-time)
(global-linum-mode 1)
(setq column-number-mode 1)
(setq visible-bell 1)

;; Disable toolbar and scroll bar
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Highlight parenthesis pairs
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Change the way Emacs keyboard scrolls
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Change Emacs Trackpad scrolls
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Changing highlight region defaults
(transient-mark-mode 1)
(set-face-attribute 'region nil
                    :background "#222222"
                    :foreground nil
                    :inherit t)

;; Changing highlight line defaults
(remove-hook 'coding-hook 'turn-on-hl-line-mode)
(global-hl-line-mode 1)
(setq hl-line-sticky-flag 1)
(set-face-attribute 'hl-line nil
                    :background "#3f3f3f"
                    :foreground nil
                    :inherit t)

;; Enable copy from clipboard (or something like that)
(setq x-select-enable-clipboard t)

;; Make backups with "~" appended to the file name
(setq make-backup-files 1)

;; Stop asking to follow git controlled source file
(setq vc-follow-symlinks nil)

;; Line wrapping settings
(setq-default fill-column 80)
(setq paragraph-start "\f\\|[ \t]*>.*$\\|[ \t]*$\\|[ \t]*[-+*] ")
(add-hook 'fundamental-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-auto-fill)

;; -----------------------------------------------------------------------------
;; Indentation
;; -----------------------------------------------------------------------------

;; -----------------------------------------------------------------------------
;; Functions
;; -----------------------------------------------------------------------------

;; Removes the specified buffer 
(defun remove-completion-buffer ()
    (if (get-buffer "*Completions*")
        (kill-buffer "*Completions*")))
(defun remove-message-buffer ()
    (if (get-buffer "*Messages*")
        (kill-buffer "*Messages*")))

;; Kill Line Backwards
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg))
)

;; Prompt when closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

;; -----------------------------------------------------------------------------
;; Keybindings
;; -----------------------------------------------------------------------------


;; -----------------------------------------------------------------------------
;; Remove unwanted windows
;; -----------------------------------------------------------------------------

;; Startup window
(setq inhibit-startup-screen t)

;; *scratch* empty.
;; (setq initial-scratch-message "")
;; (setq-default message-log-max nil)

;; Completion buffer
;; (add-hook 'minibuffer-exit-hook 'remove-completion-buffer)
;; (remove-message-buffer)

;; -----------------------------------------------------------------------------
;; Custom themes
;; -----------------------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/usr/init/")
(add-to-list 'load-path "~/.emacs.d/usr/mode/")
(load "indentation")
(load "keybindings")
(load "shell-highlighting")
;; (load "arduino-mode")
;; (load "php-mode")
;; (load "sh-script")

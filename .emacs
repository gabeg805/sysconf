;; *****************************************************************************
;; Default custom sets
;; *****************************************************************************


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

(custom-set-faces
 '(default ((t (:family "Input" :foundry "nil" :slant normal :weight normal :height 90 :width normal))))
 ;; '(font-lock-builtin-face ((t (:foreground "deep sky blue" :weight normal))))
 ;; '(font-lock-comment-face ((t (:foreground "gray65"))))
 ;; '(font-lock-string-face ((t (:foreground "orchid3"))))
)

;; *****************************************************************************
;; General Setup
;; *****************************************************************************

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
;; (set-face-attribute 'region nil
;;                     :background "#ffe34c"
;;                     :foreground nil
;;                     :inherit t)

;; Changing highlight line defaults
(remove-hook 'coding-hook 'turn-on-hl-line-mode)
(global-hl-line-mode 1)
(setq hl-line-sticky-flag 1)

;; (set-face-attribute 'hl-line nil
;;                     :background "#e5e5e5"
;;                     :foreground nil
;;                     :inherit t)

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

;; *****************************************************************************
;; Indentation
;; *****************************************************************************

;; General identation preferences
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))

;; Python
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 4)))

;; Disable auto indent
(add-hook 'after-change-major-mode-hook '(lambda () (electric-indent-mode 0)))

;; LaTeX
(setq LaTeX-indent-level 4)
(setq LaTeX-item-indent 0)
(setq TeX-brace-indent-level 4)
(setq font-lock-maximum-decoration '((latex-mode . 2)))

;; C
(setq c-default-style "linux"
      c-basic-offset 4)

;; *****************************************************************************
;; Functions
;; *****************************************************************************

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

;; Change to solarized light theme
(defun set-solarized-light ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'light)
  (load-theme 'solarized t))

;; Change to solarized dark theme
(defun set-solarized-dark ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'dark)
  (load-theme 'solarized t))

;; *****************************************************************************
;; Keybindings
;; *****************************************************************************

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

;; Color theme
(global-set-key (kbd "C-c l") 'set-solarized-light)
(global-set-key (kbd "C-c d") 'set-solarized-dark)

;; *****************************************************************************
;; Remove unwanted windows
;; *****************************************************************************

;; Startup window
(setq inhibit-startup-screen t)

;; *scratch* empty.
(setq initial-scratch-message "")
(setq-default message-log-max nil)

;; Completion buffer
(add-hook 'minibuffer-exit-hook 'remove-completion-buffer)
(remove-message-buffer)

;; *****************************************************************************
;; Custom themes
;; *****************************************************************************

;; Load theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
;; (customize-set-variable 'frame-background-mode 'dark)
;; (load-theme 'solarized t)

;; ;; Set theme mode
;; (set-frame-parameter nil 'background-mode 'dark)
;; (set-terminal-parameter nil 'background-mode 'dark)
;; (enable-theme 'solarized)

;; (add-to-list 'load-path "/home/gabeg/.emacs.d/user-elisp/modes")

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)   
;;             (let ((mode (if (display-graphic-p frame) 'dark 'dark)))
;;               (set-frame-parameter frame 'background-mode mode)
;;               (set-terminal-parameter frame 'background-mode mode))
;;             (enable-theme 'solarized)))

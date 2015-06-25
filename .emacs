;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; DEFAULT CUSTOM SET ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input" :foundry "nil" :slant normal :weight normal :height 80 :width normal))))
 '(font-lock-builtin-face ((t (:foreground "blue"))))
 '(font-lock-comment-face ((t (:foreground "gray65"))))
 '(font-lock-string-face ((t (:foreground "orchid3"))))
 '(font-lock-variable-name-face ((t (:foreground "yellow4" :weight normal)))))

;; (set-face-attribute 'default nil :font Inconsolata-8)
;; (set-fram-font Inconsolata-8 nil t)


;; ;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; FUNCTIONS ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;

;; Removes the specified buffer 
(defun remove-scratch-buffer ()
    (if (get-buffer "*scratch*")
        (kill-buffer "*scratch*")))
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

;; Run file
(defun run-current-file ()
  "Runs the compilation of the current file.
   Assumes it has the same name, but without an extension"
  (interactive)
  (compile (file-name-sans-extension buffer-file-name)))

;; Prompt when closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; SETUP EMACS WINDOW ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Library is being deprecated and causing errors, this will fix the errors
(require 'cl)

;; Setup emacs display
(display-time)
(setq inhibit-startup-screen t)

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(menu-bar-mode -1)
(setq column-number-mode 1)
(setq visible-bell 1)

;; Enable copy from clipboard (or something like that)
(setq x-select-enable-clipboard t)

;; Make backups with "~" appended to the file name
(setq make-backup-files 1)

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
                    :background "#ffe34c"
                    :foreground nil
                    :inherit t)

;; Changing highlight line defaults
(global-hl-line-mode 1)
(setq hl-line-sticky-flag nil)

(if (window-system)
    (defvar hlback "#ececed")
    (progn 
      (defvar hlback "#101010") 
      ;; (invert-face 'font-lock-comment-face)
    )
)

(set-face-attribute 'hl-line nil
                    :background hlback
                    :foreground nil
                    :inherit t)
;; (invert-face 'hl-line)

;; Highlight parenthesis pairs
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Makes *scratch* empty.
(setq initial-scratch-message "")
(setq-default message-log-max nil)

;; Removes the specified buffer 
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)
(add-hook 'minibuffer-exit-hook 'remove-completion-buffer)
(remove-message-buffer)

;; Line wrapping settings
(setq-default fill-column 80)
(setq paragraph-start "\f\\|[ \t]*>.*$\\|[ \t]*$\\|[ \t]*[-+*] ")
(add-hook 'fundamental-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-auto-fill)



;; ;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; INDENTATION ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;

;; General identation preferences
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))

(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 4)))

;; Disable auto indent
(add-hook 'after-change-major-mode-hook '(lambda () (electric-indent-mode 0)))


(setq LaTeX-indent-level 4)
(setq LaTeX-item-indent 0)
(setq TeX-brace-indent-level 4)
(setq font-lock-maximum-decoration '((latex-mode . 2)))

;; IDL indentation preferences 
(setq idlwave-main-block-indent 0   ; default  0
      idlwave-block-indent 4        ; default  4
      idlwave-end-offset -4)        ; default -4

;; IDL Syntax Highlighting
(add-hook 'idlwave-mode-hook 'turn-on-font-lock)

;; IDL online help files location
(setq idlwave-help-directory "~/.idlwave")

;; IDL indent function/pro calls
(setq idlwave-main-block-indent 4)

(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 4
        c-basic-offset 4))
 
;; Lua indentation preferences
(setq lua-indent-level 4)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

;; (setq-default c-basic-offset 4
;;               tab-width 4)
(setq c-default-style "linux"
      c-basic-offset 4)



;; ;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; KEYBINDINGS ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;

;; Unset keybindings
(global-unset-key "\C-x\C-z")
(global-unset-key "\C-z")
(global-unset-key "\C-j")
(global-unset-key "\M-r")

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

(global-unset-key "\C-xb")
(global-set-key "\C-xb" 'backward-kill-line) 

(global-set-key (kbd "C-x C-c") 'ask-before-closing)



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; MARMALADE PACKAGE INFORMATION ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; DOWNLOADED '.EL' FILES ;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/home/gabeg/.emacs.d/user-elisp/")
(require 'arduino-mode)
(require 'less-css-mode)
(require 'php-mode)

;; [Facultative] Only if you have installed async.
(add-to-list 'load-path "/home/gabeg/.emacs.d/user-elisp/helm/async/")
(add-to-list 'load-path "/home/gabeg/.emacs.d/user-elisp/helm/helm/")
(require 'helm-config)

;; ;;;;;;;;;;;;;;;;
;; ;;;;; HELM ;;;;;
;; ;;;;;;;;;;;;;;;;


;; helm-recentf:                  helm-recentf-fuzzy-match to t.
;; helm-mini:                     helm-buffers-fuzzy-matching and helm-recentf-fuzzy-match to t.
;; helm-buffers-list:             helm-buffers-fuzzy-matching to t.
;; (helm-find-files t)
;; helm-locate:                   helm-locate-fuzzy-match to t.
;; helm-M-x:                      helm-M-x-fuzzy-match to t.
;; helm-semantic:                 helm-semantic-fuzzy-match to t.
;; helm-imenu:                    helm-imenu-fuzzy-match to t.
;; helm-apropos:                  helm-apropos-fuzzy-match to t.
;; helm-lisp-completion-at-point: helm-lisp-fuzzy-completion to t.
;; (helm-mode 0)


;; -----------------------------------------------------------------------------
;; File: default.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Various default configuration items.
;; 
;; -----------------------------------------------------------------------------

;; Custom faces
(custom-set-faces
  '(default ((t (:family "Input" :foundry "nil" :slant normal :weight normal
                 :height 110 :width normal :foreground "#ffffff"
                 :background "#303030"))))
  '(font-lock-comment-face  ((t (:foreground "#777777"))))
  '(font-lock-constant-face ((t (:foreground "#e79600"))))
  '(sh-quoted-exec          ((t (:bold t :foreground "#1fc4eb"))))
)

;; Display time
(display-time)

;; Line and column numbers
(global-linum-mode 1)
(setq column-number-mode 1)

;; Alarm bell when reached EOF
(setq visible-bell 1)

;; Disable toolbar
(when (window-system)
  (tool-bar-mode -1))

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

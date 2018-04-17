;; -----------------------------------------------------------------------------
;; File: indentation.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Personal indentations for various languages.
;; 
;; -----------------------------------------------------------------------------

;; General identation preferences
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))

;; Python
(add-hook 'python-mode-hook '(lambda () (setq python-indent 4)))

;; Disable auto indent
(add-hook 'after-change-major-mode-hook '(lambda () (electric-indent-mode 0)))

;; LaTeX
(setq LaTeX-indent-level 4)
(setq LaTeX-item-indent 0)
(setq TeX-brace-indent-level 4)
(setq font-lock-maximum-decoration '((latex-mode . 2)))

;; C
(setq c-default-style "linux" c-basic-offset 4)

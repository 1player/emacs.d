;; -*- lexical-binding: t -*-

(add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode))

(require-package 'go-mode)
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'go-ts-mode-hook #'eglot-ensure)

(require 'go-mode)
(require 'go-ts-mode)
(add-hook 'go-ts-mode-hook (lambda ()
                             (sph-format-on-save-mode)
                             (set (make-local-variable 'compile-command)
                                  "go run ./...")))
(define-key go-ts-mode-map (kbd "C-c C-a") #'go-import-add)
(setq go-ts-mode-indent-offset 4)

(provide 'sph-src-lang-go)

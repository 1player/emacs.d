(require 'sph-eglot)

(use-package go-mode
  :defer
  :config
  (defun sph-go-mode-hook ()
    (set (make-local-variable 'compile-command)
         "go run ./...")
    (add-hook 'before-save-hook 'eglot-format-buffer -10 t))
  (add-hook 'go-mode-hook 'sph/go-mode-hook))

(provide 'sph-lang-go)

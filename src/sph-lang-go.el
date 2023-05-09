(require 'sph-programming)

(use-package go-mode
  :hook
  (go-mode . eglot-ensure)
  (go-mode . sph-format-on-save-mode)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'compile-command)
                                 "go run ./..."))))

(provide 'sph-lang-go)

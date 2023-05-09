(use-package php-mode
  :hook (php-mode . eglot-ensure)
  :config
  (define-key php-mode-map (kbd "C-.") nil)
  (add-hook 'php-mode-hook (lambda ()
                             (c-toggle-auto-newline 1)))
  (with-eval-after-load "eglot"
    (add-to-list 'eglot-server-programs '(php-mode "intelephense" "--stdio"))))

(provide 'sph-lang-php)

(use-package php-mode
  :defer t)

(with-eval-after-load "php-mode"
  (define-key php-mode-map (kbd "C-.") nil))

(with-eval-after-load "eglot"
  (add-to-list 'eglot-server-programs '(php-mode "intelephense" "--stdio"))
  (add-hook 'php-mode-hook 'eglot-ensure))

(provide 'sph-lang-php)

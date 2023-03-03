(use-package eglot
  :diminish
  :defer nil
  :hook (((go-mode php-mode python-mode rust-mode typescript-mode) . eglot-ensure))
  :init
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)))
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider)))

(defun eglot-format-buffer-on-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(provide 'sph-eglot)

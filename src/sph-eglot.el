(use-package eglot
  :diminish
  :custom ((eglot-ignored-server-capabilities '(:documentHighlightProvider)))
  :defer nil
  :hook (((go-mode php-mode python-mode rust-mode typescript-mode) . eglot-ensure))
  :init
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)

              ;; Show flymake diagnostics first.
              (setq eldoc-documentation-functions (cons #'flymake-eldoc-function
                                                        (remove #'flymake-eldoc-function
                                                                eldoc-documentation-functions)))
              (eglot-inlay-hints-mode -1))))

(provide 'sph-eglot)

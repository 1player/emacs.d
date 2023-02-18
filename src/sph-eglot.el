(use-package eglot
  :diminish
  :hook (((go-mode php-mode python-mode rust-mode typescript-mode elixir-mode elixir-ts-mode heex-ts-mode) . eglot-ensure))
  :init
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)))

              ;; Show flymake diagnostics first.
              ;; (setq eldoc-documentation-functions
              ;;       (cons #'flymake-eldoc-function
              ;;             (remove #'flymake-eldoc-function eldoc-documentation-functions)))))
  (defun eglot-format-buffer-on-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
  :config
  (dolist (mode '(elixir-mode elixir-ts-mode heex-ts-mode))
    (add-to-list 'eglot-server-programs `(,mode . ("elixir-ls")))))

(provide 'sph-eglot)

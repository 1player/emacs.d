(use-package elixir-ts-mode)

(dolist (mode '(elixir-ts-mode-hook heex-ts-mode-hook))
  (add-hook mode #'eglot-ensure))

(with-eval-after-load 'eglot
  ;; Use elixir-ls as LSP client
  (dolist (mode '(elixir-mode elixir-ts-mode heex-ts-mode))
    (add-to-list 'eglot-server-programs `(,mode . ("elixir-ls"))))

  (with-eval-after-load 'elixir-ts-mode
    (add-hook 'elixir-ts-mode-hook #'eglot-format-buffer-on-save)))

(provide 'sph-lang-elixir)

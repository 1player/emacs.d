(use-package elixir-ts-mode)

(with-eval-after-load 'eglot
  (add-hook 'elixir-ts-mode-hook #'eglot-format-buffer-on-save))

(provide 'sph-lang-elixir)

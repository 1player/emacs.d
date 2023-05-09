(require 'sph-programming)

(use-package elixir-ts-mode
  :hook
  ((elixir-ts-mode heex-ts-mode) . eglot-ensure)
  ((elixir-ts-mode heex-ts-mode) . sph-format-on-save-mode)
  :config
  (with-eval-after-load "eglot"
    ;; Use elixir-ls as LSP client
    (dolist (mode '(elixir-mode elixir-ts-mode heex-ts-mode))
      (add-to-list 'eglot-server-programs `(,mode . ("elixir-ls"))))))

(provide 'sph-lang-elixir)

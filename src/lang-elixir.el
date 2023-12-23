;; -*- lexical-binding: t -*-

(require-package 'elixir-ts-mode)

;; Use elixir-ls as LSP client
(after 'eglot
  (add-to-list 'eglot-server-programs '((elixir-mode elixir-ts-mode) . ("elixir-ls")))
  (add-to-list 'eglot-server-programs '((heex-mode heex-ts-mode) . ("elixir-ls"))))

(add-hook 'elixir-ts-mode-hook
	  (defun elixir-ts-mode-setup ()
	    (treesit-font-lock-recompute-features '() '(elixir-constant heex-attribute))))

(provide 'sph-src-lang-elixir)

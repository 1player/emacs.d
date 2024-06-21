;; -*- lexical-binding: t -*-

(require 'sph-src-lang-html)

(require-package 'elixir-ts-mode)

;; Set LSP client
(after 'eglot
  (add-to-list
   'eglot-server-programs
   `((elixir-mode elixir-ts-mode heex-mode heex-ts-mode) . ("next_ls" "--stdio=true"))))
                                                            ;;"elixir-ls"))))

(defun setup-elixir-mode ()
  (eglot-ensure)
  (sph-format-on-save-mode 1)

  (setq-local compile-command "mix test "))

(add-hook 'elixir-mode-hook #'setup-elixir-mode)
(add-hook 'elixir-ts-mode-hook #'setup-elixir-mode)

(defun setup-heex-mode ()
  (eglot-ensure)
  (sph-format-on-save-mode 1)
  (html-editing-mode 1))

(add-hook 'heex-ts-mode-hook #'setup-heex-mode)

(add-hook 'elixir-ts-mode-hook
	  (defun elixir-ts-mode-setup ()
	    (treesit-font-lock-recompute-features '() '(elixir-constant heex-attribute))))

;; Add compilation-mode regexes to match mix errors
(add-to-list 'compilation-error-regexp-alist-alist '(elixir-mix "^[     ]+\\(?:(.*) \\)?\\(.*\\):\\([0-9]+\\):?.*$" 1 2))
(add-to-list 'compilation-error-regexp-alist 'elixir-mix)

(provide 'sph-src-lang-elixir)

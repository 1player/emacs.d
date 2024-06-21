;; -*- lexical-binding: t -*-

(use-package rust-mode
  :hook
  ((rust-mode rust-ts-mode) . sph-format-on-save-mode)
  ((rust-mode rust-ts-mode) . electric-pair-local-mode)
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '((rust-mode rust-ts-mode) . ("rustup" "run" "stable" "rust-analyzer" :initializationOptions (:check (:command "clippy")))))
    (add-hook 'rust-mode-hook 'eglot-ensure)
    (add-hook 'rust-ts-mode-hook 'eglot-ensure)))


(provide 'sph-src-lang-rust)

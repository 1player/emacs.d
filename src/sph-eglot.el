(use-package eglot
  :diminish
  :defer nil
  :hook (((go-mode php-mode python-mode rust-mode typescript-mode) . eglot-ensure))
  :init
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider)))

(defun eglot-format-buffer-on-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(provide 'sph-eglot)

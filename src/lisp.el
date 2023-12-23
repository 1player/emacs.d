;;; -*- lexical-binding: t -*-

(require-package 'paredit)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)

(provide 'sph-src-paredit)

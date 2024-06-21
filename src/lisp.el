;;; -*- lexical-binding: t -*-

(require-package 'paredit)

;(add-hook 'emacs-lisp-mode-hook #'paredit-mode)

;; Stop bothering me about missing documentation in elisp files
(eval-after-load 'flymake
  (add-hook 'emacs-lisp-mode-hook (lambda ()
                                    (remove-hook 'flymake-diagnostic-functions 'elisp-flymake-checkdoc t))))

;; Scheme
(require-package 'geiser-guile)
(require-package 'geiser-mit)


(provide 'sph-src-paredit)

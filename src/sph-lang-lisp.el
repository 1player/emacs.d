(use-package paredit)

(use-package slime
  :config
  (setq slime-lisp-implementations
        '((sbcl ("sbcl" "--noinform") :coding-system utf-8-unix)))
  (setq slime-default-lisp 'sbcl)
  (setq slime-contribs '(slime-fancy slime-quicklisp slime-asdf)))

(provide 'sph-lang-lisp)

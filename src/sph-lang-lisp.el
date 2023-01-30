(use-package paredit)

;; Don't use slime because it doesn't work
;; with corfu completions
;;
;; (use-package slime
;;   :config
;;   (setq slime-lisp-implementations
;;         '((sbcl ("sbcl" "--noinform") :coding-system utf-8-unix)))
;;   (setq slime-default-lisp 'sbcl)
;;   (setq slime-contribs '(slime- slime-quicklisp slime-asdf)))

(use-package sly
  :config
   (setq sly-lisp-implementations
         '((sbcl ("sbcl" "--noinform") :coding-system utf-8-unix)))
   (setq sly-default-lisp 'sbcl))


(provide 'sph-lang-lisp)

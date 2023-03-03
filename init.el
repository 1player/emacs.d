;;; init.el --- Emacs initialization.
;;;
;;; Commentary:
;;; No comment.
;;;
;;; Code:

(setq
 user-full-name "Stephane Travostino"
 user-mail-address "steph@combo.cc")

;;; Packaging boilerplate
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'straight)
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; Packages

(use-package json-mode
  :defer t)

(use-package lua-mode
  :defer t
  :config
  (setq lua-indent-nested-block-content-align nil))

(use-package markdown-mode
  :defer t)

(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t)
  ;; Don't show error buffer when trying to format invalid code
  (setq rust-format-show-buffer nil))

(use-package typescript-mode
  :defer t)

(use-package yaml-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.bu\\'" . yaml-mode)))

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.html?.l?eex\\'" . web-mode)
         ("\\.html?.php\\'" . web-mode)))



(use-package embark-consult)


(use-package perspective
  :requires consult
  :custom
  (persp-mode-prefix-key (kbd "C-c p"))
  :config
  (persp-mode)
  (consult-customize consult--source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source))


(use-package eat
  :straight (eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el")))
  :bind (("C-x p t" . #'eat-project)
         ("C-c t" . #'eat)))


;;; Modular config starts here

(defvar sph/src-dir (expand-file-name "src" user-emacs-directory))
(add-to-list 'load-path sph/src-dir)

(require 'sph-prelude)

(require 'sph-themes)
(require 'sph-ui)
(require 'sph-completion)
(require 'sph-editing)
(require 'sph-programming)
(require 'sph-eglot)
(require 'sph-tree-sitter)
;; (require 'sph-meow)
(require 'sph-tramp)

(require 'sph-lang-elixir)
(require 'sph-lang-go)
(require 'sph-lang-lisp)
(require 'sph-lang-php)

(require 'sph-keybinds)


;; Server
(require 'server)

(unless (server-running-p)
  (server-start))


;; Custom
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

(provide 'init)
;;; init.el ends here

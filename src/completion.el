;;; -*- lexical-binding: t -*-

;; Vertico
(require-package 'vertico)
(require 'vertico)
(vertico-mode)

(after 'vertico
  ;; Tidy shadower file names
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

  (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
  (define-key vertico-map (kbd "<prior>") #'vertico-scroll-down)
  (define-key vertico-map (kbd "<next>") #'vertico-scroll-up))

;; Marginalia
(require-package 'marginalia)
(require 'marginalia)
(marginalia-mode)

;; Hotfuzz
(require-package 'hotfuzz)
(require 'hotfuzz)
(setq completion-styles '(basic hotfuzz))

;; Prescient
(require-package 'prescient)
(require 'prescient)
(push 'prescient completion-styles)
(prescient-persist-mode)

(require-package 'vertico-prescient)
(vertico-prescient-mode)

;; Company
(require-package 'company)

(setopt company-backends '((company-capf company-files company-yasnippet)))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<return>") nil))

(add-hook 'prog-mode-hook #'company-mode)

(provide 'sph-src-completion)

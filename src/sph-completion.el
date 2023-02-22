
(use-package vertico
  :straight (:files (:defaults "extensions/*"))
  :bind (:map vertico-map
              ("RET" . #'vertico-directory-enter)
	          ("<prior>" . #'vertico-scroll-down)
	          ("<next>" . #'vertico-scroll-up))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay-hook . #'vertico-directory-tidy)
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package hotfuzz
  :config
  (setq completion-styles '(basic hotfuzz)))

(use-package prescient
  :config
  (push 'prescient completion-styles)
  (prescient-persist-mode))

(use-package vertico-prescient
  :config
  (vertico-prescient-mode))


(use-package corfu
  :init
  (setq tab-always-indent 'complete)
  (global-corfu-mode))



(provide 'sph-completion)

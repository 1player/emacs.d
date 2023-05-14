
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
  :bind (:map corfu-map
              ("RET" . nil)
              ("<escape>" . corfu-quit))
  :custom
  (corfu-auto t)
  :config
  (global-corfu-mode))

(use-package cape
  :config
  (dolist (backend '(cape-dabbrev cape-file cape-abbrev))
    (add-to-list 'completion-at-point-functions backend)))

(provide 'sph-completion)

(use-package avy
  :bind (("M-j" . #'avy-goto-char))
  :custom (avy-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)))


(use-package whole-line-or-region
  :bind (("M-," . #'whole-line-or-region-comment-dwim-2))
  :config
  (whole-line-or-region-global-mode 1))


(use-package pulsar
  :config
  ;; integration with the `consult' package:
  (add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

  ;; integration with the built-in `imenu':
  (add-hook 'imenu-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  (pulsar-global-mode))


(use-package olivetti
  :defer t)

(global-set-key (kbd "M-<delete>") #'kill-word)
(global-set-key (kbd "M-DEL") #'backward-kill-word)

(provide 'sph-editing)

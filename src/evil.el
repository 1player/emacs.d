;; -*- lexical-binding: t -*-

(when (eq sph-editing-engine 'evil)
  ;; Early evil config
  (add-hook 'evil-jumps-post-jump-hook #'recenter)

  (setq evil-want-keybinding nil) ;; evil-collection will provide instead

  ;; Load evil
  (require-package 'evil)
  (require 'evil)
  (evil-mode)

  ;; Additional packages
  (require-package 'evil-surround)
  (global-evil-surround-mode t)

  (require-package 'evil-collection)
  (add-hook 'evil-collection-setup-hook
            (lambda (_mode mode-keymaps)
              ;; removes any bindings to SPC and , since they are global prefix keys
              (evil-collection-translate-key 'normal mode-keymaps
                                             (kbd "SPC") nil
                                             "," nil
                                             )))
  (evil-collection-init)

  ;; Keybinds
  (evil-set-leader nil (kbd "SPC"))
  (evil-set-leader nil "," t))

(provide 'sph-src-evil)

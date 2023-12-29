;; -*- lexical-binding: t -*-

(when (eq sph-editing-engine 'evil)
  ;; Early evil config
  (add-hook 'evil-jumps-post-jump-hook #'recenter)

  (setq evil-want-keybinding nil) ;; evil-collection will provide instead
  (setopt evil-undo-system 'undo-redo)
  (setopt evil-want-C-w-delete nil
	  evil-want-C-d-scroll nil
	  evil-want-fine-undo t)
							
  ;; Load evil
  (require-package 'evil)
  (require 'evil)
  (evil-mode)

  ;; Additional packages
  (require-package 'evil-surround)
  (global-evil-surround-mode)

  (require-package 'evil-commentary)
  (require 'evil-commentary)
  (evil-define-key 'normal 'global (kbd "<localleader>c") 'evil-commentary)

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
  (evil-set-leader nil "," t)

  ;; Unbind annoying keys
  (dolist (key '("C-a" "C-e" "C-k"))
    (define-key evil-motion-state-map (kbd key) nil)
    (define-key evil-normal-state-map (kbd key) nil)
    (define-key evil-insert-state-map (kbd key) nil))
  )

(provide 'sph-src-evil)

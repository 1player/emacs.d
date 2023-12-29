;; -*- lexical-binding: t -*-

(require 'dired)
(require 'dired-x)

(setq
 delete-by-moving-to-trash t
 dired-recursive-copies t
 dired-do-revert-buffer t
 dired-listing-switches "-alh --group-directories-first")

(setq dired-omit-files
      (rx (or (seq bol "."))))

(add-hook 'dired-mode-hook #'dired-omit-mode)

;; Auto refresh on change
(add-hook 'dired-mode-hook #'auto-revert-mode)

(define-key dired-mode-map (kbd "C-c C-o") #'dired-omit-mode)
(define-key dired-mode-map (kbd "DEL") #'dired-up-directory)
(define-key dired-mode-map (kbd "SPC") #'dired-find-file)

(global-set-key (kbd "C-x C-d") #'dired-jump)

;; Sidebar
(require-package 'dired-sidebar)
(global-set-key (kbd "C-c s") #'dired-sidebar-toggle-sidebar)


(provide 'sph-dired)


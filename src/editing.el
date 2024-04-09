;; -*- lexical-binding: t -*-

(require-package 'avy)
(require 'avy)
(when (eq sph-keyboard-layout 'moonlander)
  (setopt avy-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)))
(global-set-key (kbd "M-m") #'avy-goto-char-timer)

(require-package 'avy-zap)
(global-set-key (kbd "M-z") #'avy-zap-up-to-char-dwim)
(global-set-key (kbd "M-Z") #'avy-zap-to-char-dwim)

;; Whole line or region
(require-package 'whole-line-or-region)
(whole-line-or-region-global-mode 1)

;; Crux
(require-package 'crux)

(global-set-key (kbd "C-a") #'crux-move-beginning-of-line)
(global-set-key (kbd "<home>") #'crux-move-beginning-of-line)
(global-set-key (kbd "C-x K") #'crux-kill-other-buffers)
(global-set-key (kbd "C-c w s") #'crux-transpose-windows)
(global-set-key (kbd "C-c r") #'crux-rename-file-and-buffer)
(global-set-key (kbd "M-<down>") #'crux-smart-open-line)
(global-set-key (kbd "M-<up>") #'crux-smart-open-line-above)
(global-set-key (kbd "M-j") #'crux-top-join-line)

;; Whitespace
(require-package 'dtrt-indent)
(add-hook 'prog-mode-hook #'dtrt-indent-mode)

(require-package 'ws-butler)
(require 'ws-butler)
(setopt ws-butler-keep-whitespace-before-point nil)
(dolist (hook '(prog-mode-hook markdown-mode-hook text-mode-hook))
  (add-hook hook #'ws-butler-mode))

;; Mark line
(defun mark-line ()
  "Sets mark, and if mark is already present, select the whole line."
  (interactive)
  (unless mark-active
    (beginning-of-line nil)
    (set-mark-command nil))
  (forward-line 1))

(global-set-key (kbd "M-l") #'mark-line)

(provide 'sph-editing)


;; -*- lexical-binding: t -*-

(require-package 'eat)
(require 'eat)
(global-set-key (kbd "C-x p t") #'eat-project)
(global-set-key (kbd "C-c t") #'eat)

;; Do not "eat" M-w
(setopt eat-semi-char-non-bound-keys (cons [?\e ?w] eat-semi-char-non-bound-keys))

(provide 'sph-terminal)

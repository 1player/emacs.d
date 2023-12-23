;;; -*- lexical-binding: t -*-

(require-package 'consult)

(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "C-x 4 b") #'consult-buffer-other-window)
(global-set-key (kbd "M-g i") #'consult-imenu)

(provide 'sph-src-consult)

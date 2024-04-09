;; -*- lexical-binding: t -*-

(require-package 'vue-mode)

(setopt js-indent-level 2)

;; Disable the ugly background color in vue-mode
(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

(provide 'sph-src-lang-javascript)

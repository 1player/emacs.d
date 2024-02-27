;; -*- lexical-binding: t -*-

(require-package 'vue-mode)

;; Disable the ugly background color in vue-mode
(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

(provide 'sph-src-lang-javascript)

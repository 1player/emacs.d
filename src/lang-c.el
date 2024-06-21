;; -*- lexical-binding: t -*-

(setopt comment-style 'multi-line
        c-default-style "linux")

(setopt c-basic-offset 2)

(add-hook 'c-mode-hook #'electric-pair-local-mode)

;; Force single line comments
(add-hook 'c-mode-hook (lambda ()
                         (c-toggle-comment-style -1)))

;; GDB
(setopt gdb-debuginfod-enable-setting t)

(provide 'sph-src-lang-c)


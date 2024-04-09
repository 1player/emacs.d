;; -*- lexical-binding: t -*-

(require-package 'forth-mode)
(require-package 'just-mode)
(require-package 'lua-mode)
(require-package 'markdown-mode)
(require-package 'yaml-mode)
(require-package 'rust-mode)

;; For shell scripts
(require-package 'flymake-shellcheck)
(add-hook 'sh-mode-hook #'flymake-shellcheck-load)


(provide 'sph-src-langs)

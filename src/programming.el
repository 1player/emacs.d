;; -*- lexical-binding: t -*-

;; eldoc
(setopt eldoc-idle-delay 2.0
        eldoc-documentation-strategy 'eldoc-documentation-compose)

(add-to-list 'display-buffer-alist
             '("^\\*eldoc" display-buffer-at-bottom
               (window-height . 4)))


;; Flymake
(require-package 'flymake)
(add-hook 'prog-mode-hook #'flymake-mode)
(global-set-key (kbd "C-c d") #'flymake-show-buffer-diagnostics)


;; Compile accepts ANSI colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(global-set-key (kbd "C-c c") #'recompile)
(global-set-key (kbd "C-c C") #'project-compile)

;; Direnv
(require-package 'direnv)
(direnv-mode)

(provide 'sph-src-programming)

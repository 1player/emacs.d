(use-package dtrt-indent
  :diminish
  :hook (prog-mode . dtrt-indent-mode))

(use-package ws-butler
  :diminish ws-butler-mode
  :hook ((prog-mode markdown-mode text-mode) . ws-butler-mode)
  :init
  (setq ws-butler-keep-whitespace-before-point nil))


(use-package flymake
  :hook ((prog-mode latex-mode) . #'flymake-mode)
  :bind (("M-p" . #'flymake-goto-prev-error)
         ("M-n" . #'flymake-goto-next-error)
         ("C-c d" . #'flymake-show-buffer-diagnostics)
         ("C-x p d" . #'flymake-show-project-diagnostics)))


(use-package eldoc
  :init
  (add-to-list 'display-buffer-alist
               '("^\\*eldoc" display-buffer-at-bottom
                 (window-height . 4)))
  ;; (setq eldoc-echo-area-use-multiline-p nil)
  (setq eldoc-idle-delay 0.1)
  (setq eldoc-documentation-strategy
        'eldoc-documentation-compose-eagerly))


(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook #'flymake-shellcheck-load))

(use-package magit
  :defer t)

(use-package editorconfig
  :defer t)

(use-package direnv
  :config
  (direnv-mode))

(use-package expand-region
  :bind (("C--" . #'er/expand-region)
         ("C-=" . #'er/contract-region)))

(use-package tempel)


(use-package deadgrep
  :defer t
  :bind (:map deadgrep-mode-map
              ("SPC" . #'deadgrep-visit-result-other-window)))

(use-package highlight-indent-guides
  :diminish
  :hook ((python-mode yaml-mode) . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'bitmap))


(use-package format-all)

(defun sph-format-buffer ()
  "Formats the buffer with the best available method."
  (interactive)
  (cond (eglot--managed-mode (eglot-format-buffer))
        ((fboundp 'format-all-buffer) (format-all-buffer))))

(global-set-key (kbd "C-c f") #'sph-format-buffer)
(global-set-key (kbd "M-m") #'comment-dwim)


(add-hook 'prog-mode-hook (lambda ()
                            (superword-mode 1)))

(provide 'sph-programming)

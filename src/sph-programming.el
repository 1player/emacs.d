(use-package dtrt-indent
  :diminish
  :hook (prog-mode . dtrt-indent-mode))

(use-package ws-butler
  :diminish ws-butler-mode
  :hook ((prog-mode markdown-mode text-mode) . ws-butler-mode)
  :init
  (setq ws-butler-keep-whitespace-before-point nil))


(add-hook 'prog-mode-hook (lambda ()
                            (superword-mode 1)
                            (electric-pair-local-mode 1)))

(provide 'sph-programming)

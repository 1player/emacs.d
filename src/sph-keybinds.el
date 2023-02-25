(require 'compile)
(require 'sph-prelude)
(require 'sph-ui)

;; Disable Ctrl-Z suspend-frame
(defun sph-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

(defun sph-find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))

(global-set-key (kbd "C-x C-z") #'sph-suspend-frame)
(global-set-key (kbd "C-z") #'sph-suspend-frame)

(global-set-key (kbd "C-x C-r") #'revert-buffer-quick)
(global-set-key (kbd "C-x k") #'kill-this-buffer)

(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

(global-set-key (kbd "C-c c") #'recompile)
(global-set-key (kbd "C-c C") #'project-compile)
(global-set-key (kbd "C-c i") #'sph-find-user-init-file)

(global-set-key (kbd "<escape>") #'abort-recursive-edit)

(global-set-key (kbd "M-<home>") #'beginning-of-buffer)
(global-set-key (kbd "M-<end>") #'end-of-buffer)


;; Moonlander keybinds

(global-set-key (kbd "<HomePage>") (key-binding (kbd "C-x b")))
(global-set-key (kbd "C-M-s-u") #'undo-only)
(global-set-key (kbd "C-M-s-y") #'undo-redo)

(provide 'sph-keybinds)

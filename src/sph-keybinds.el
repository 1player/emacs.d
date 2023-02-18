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

(with-eval-after-load "eglot"
  (global-set-key (kbd "C-c f") #'eglot-format-buffer))


(when (equal sph-keyboard-layout 'moonlander)
  (global-set-key (kbd "C-,") #'undo-only)
  (global-set-key (kbd "C-.") #'undo-redo))

;; (when (equal sph-keyboard-layout 'qwerty)
;;     (global-set-key (kbd "M-`") #'other-window))

;; Hyper keybinds

(when (equal sph-keyboard-layout 'moonlander)
  (global-set-key (kbd "C-M-s-q") #'delete-window)
  (global-set-key (kbd "C-M-s-s") #'save-buffer)
  (global-set-key (kbd "C-M-s-g") #'keyboard-quit)
  (global-set-key (kbd "C-M-s-k") #'kill-this-buffer)
  (global-set-key (kbd "C-M-s-t") #'eat-project)
  (global-set-key (kbd "C-M-s-o") #'ace-window)
  (global-set-key (kbd "C-M-s-w") #'delete-other-windows))

(with-eval-after-load "consult"
  (when (equal sph-keyboard-layout 'moonlander)
    (global-set-key (kbd "C-M-s-b") #'consult-buffer)))

(provide 'sph-keybinds)

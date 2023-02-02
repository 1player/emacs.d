(require 'compile)
(require 'sph-prelude)

;; Disable Ctrl-Z suspend-frame
(defun sph-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

(global-set-key (kbd "C-x C-z") #'sph-suspend-frame)
(global-set-key (kbd "C-z") #'sph-suspend-frame)

(global-set-key (kbd "C-x C-r") #'revert-buffer-quick)

(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

(global-set-key (kbd "C-c c") #'recompile)
(global-set-key (kbd "C-c C") #'project-compile)

(global-set-key (kbd "M-<up>") #'windmove-up)
(global-set-key (kbd "M-<down>") #'windmove-down)
(global-set-key (kbd "M-<left>") #'windmove-left)
(global-set-key (kbd "M-<right>") #'windmove-right)

;; (define-key key-translation-map (kbd "ESC") (kbd "C-]"))
(global-set-key (kbd "<escape>") #'abort-recursive-edit)

(when (equal sph-keyboard-layout 'moonlander)
  (global-set-key (kbd "C-:") #'undo-only)
  (global-set-key (kbd "C-;") #'undo-redo))

(when (equal sph-keyboard-layout 'qwerty)
  (global-set-key (kbd "M-`") #'other-window))

;; Hyper keybinds

(provide 'sph-keybinds)

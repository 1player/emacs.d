;;; -*- lexical-binding: t -*-

(global-set-key (kbd "<escape>") #'abort-recursive-edit)

;; Switch buffers with mouse side buttons
(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-0") #'delete-window)
(global-set-key (kbd "C-1") #'delete-other-windows)
(global-set-key (kbd "C-2") #'split-window-below)
(global-set-key (kbd "C-3") #'split-window-right)
(global-set-key (kbd "M-o") #'other-window)
(global-set-key (kbd "C-<tab>") #'consult-buffer)

(global-set-key (kbd "C-x k") #'kill-this-buffer)

(global-set-key (kbd "M-p") #'project-find-file)

;; Up and down history in interactive modes
(define-key comint-mode-map (kbd "<up>") #'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") #'comint-next-input)

;; Disable Ctrl-Z suspend-frame
(defun sph-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

(global-set-key (kbd "C-x C-z") #'sph-suspend-frame)
(global-set-key (kbd "C-z") #'undo-only)
(global-set-key (kbd "C-S-z") #'undo-redo)

(global-set-key (kbd "C-x C-r") #'revert-buffer-quick)

(after 'evil
  (evil-define-key 'normal 'global (kbd "<leader>SPC") #'consult-buffer)
  
  ;; File
  (evil-define-key 'normal 'global (kbd "<leader>ff") #'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>fr") #'rename-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>fR") #'revert-buffer-quick)

  ;; Project
  (evil-define-key 'normal 'global (kbd "<leader>p") project-prefix-map)

  ;; Window
  (evil-define-key 'normal 'global (kbd "<leader>w") evil-window-map)
  (evil-define-key 'normal 'global (kbd "<leader>k") #'kill-this-buffer)

  ;; Help
  (evil-define-key 'normal 'global (kbd "<leader>h") help-map)

  ;; Local leader
  (evil-define-key 'normal 'global (kbd "<leader>s") 'save-buffer))

(provide 'sph-src-keybinds)

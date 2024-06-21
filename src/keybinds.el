;;; -*- lexical-binding: t -*-

(defun sph-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

(defun sph-find-user-init-file ()
  "Open user init file."
  (interactive)
  (find-file user-init-file))

(defun sph-toggle-buffer ()
  "Flips to the last-visited buffer in this window."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer))))

(global-set-key (kbd "C-c i") #'sph-find-user-init-file)

(global-set-key (kbd "<escape>") #'abort-recursive-edit)

;; Switch buffers with mouse side buttons
(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

;; Switch buffers with keyboard
(global-set-key (kbd "C-,") #'sph-toggle-buffer)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "M-n") 'whole-line-or-region-comment-dwim)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-o") #'other-window)
(global-set-key (kbd "C-<tab>") #'consult-buffer)

(global-set-key (kbd "C-x k") #'kill-this-buffer)

(global-set-key (kbd "C-x C-z") #'sph-suspend-frame)

(global-set-key (kbd "C-z") #'undo-only)
(global-set-key (kbd "C-S-z") #'undo-redo)

(global-set-key (kbd "C-x C-r") #'revert-buffer-quick)

(global-set-key (kbd "M-g M-a") #'beginning-of-buffer)
(global-set-key (kbd "M-g M-e") #'end-of-buffer)

(when (eq sph-keyboard-layout 'moonlander)
  (global-set-key (kbd "C-M-S-s-v") #'consult-buffer)
  (global-set-key (kbd "C-M-S-s-f") #'project-find-file))

;; Up and down history in interactive modes
(define-key comint-mode-map (kbd "<up>") #'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") #'comint-next-input)

;; Switching between tabs
(defun switch-to-tab (number)
  (lambda ()
    (interactive)
    (tab-select number)))

(global-set-key (kbd "C-0") #'tab-close)
(global-set-key (kbd "C-1") (switch-to-tab 1))
(global-set-key (kbd "C-2") (switch-to-tab 2))
(global-set-key (kbd "C-3") (switch-to-tab 3))
(global-set-key (kbd "C-4") (switch-to-tab 4))
(global-set-key (kbd "C-5") (switch-to-tab 5))
(global-set-key (kbd "C-9") #'tab-new)



(when (eq sph-keyboard-layout 'moonlander)
  (global-set-key (kbd "C-M-S-SPC") #'consult-buffer)
  (global-set-key (kbd "C-M-S-s") #'save-buffer)
  (global-set-key (kbd "C-M-S-f") #'project-find-file)

  ;; Often hit this while clicking after activating Caps WORD
  (global-set-key (kbd "S-<mouse-1>") #'mouse-set-point)
  (global-set-key (kbd "S-<down-mouse-1>") #'mouse-set-point))

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

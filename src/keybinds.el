;;; -*- lexical-binding: t -*-

(global-set-key (kbd "<escape>") #'abort-recursive-edit)

;; Switch buffers with mouse side buttons
(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

(after 'evil
  (evil-define-key 'normal 'global (kbd "<leader>SPC") #'consult-buffer)
  
  ;; File
  (evil-define-key 'normal 'global (kbd "<leader>ff") #'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>fr") #'rename-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>fR") #'revert-buffer-quick)

  ;; Project
  (evil-define-key 'normal 'global (kbd "<leader>p") project-prefix-map)

  ;; Local leader
  (evil-define-key 'normal 'global (kbd "<leader>s") 'save-buffer))

(provide 'sph-src-keybinds)

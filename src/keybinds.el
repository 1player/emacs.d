;;; -*- lexical-binding: t -*-

(after 'evil
       (evil-define-key 'normal 'global (kbd "<localleader>s") 'save-buffer))

(provide 'sph-src-keybinds)

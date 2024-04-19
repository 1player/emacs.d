;;; -*- lexical-binding: t -*-

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Save minibuffer history
(savehist-mode 1)

;; Some defaults
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      backup-by-copying t
      frame-inhibit-implied-resize t
      ediff-window-setup-function 'ediff-setup-windows-plain
      create-lockfiles nil
      backup-by-copying t
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      sentence-end-double-space nil
      confirm-kill-emacs 'y-or-n-p
      inhibit-startup-message t
      initial-scratch-message nil
      initial-major-mode 'fundamental-mode
      vc-follow-symlinks t
      show-paren-delay 0.0
      confirm-kill-emacs nil)

(setq-default indent-tabs-mode nil
              tab-width 4)

;; Autosaves
(let ((auto-save-dir (file-name-as-directory (expand-file-name "autosaves" user-emacs-directory))))
  (make-directory auto-save-dir t)
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t))))

;; Actually, save whenever a buffer or window loses focus
(use-package super-save
  :custom
  ;; Default is '(mouse-leave-buffer-hook focus-out-hook), but the
  ;; mouse-leave-buffer-hook is also called when clicking anywhere in
  ;; the _same_ buffer, which is annoying when working on TRAMP, and
  ;; any click suffers the delay of remote saving
  (super-save-hook-triggers '(focus-out-hook))
  :config
  (super-save-mode 1))

;; Sensible defaults
(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(fset 'yes-or-no-p 'y-or-n-p)

;; Cache passwords for one hour
(setq password-cache-expiry 3600)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 500)

;; Auto revert
(setopt auto-revert-interval 1)
(global-auto-revert-mode 1)

;; Typed text replaces selection
(delete-selection-mode 1)

;; Allow motion during search - not sure if needed
(setq isearch-allow-motion t)

;; Try - to try packages
(require-package 'try)

(provide 'sph-src-misc)

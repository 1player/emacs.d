(defvar sph-keyboard-layout 'moonlander)


;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Display the distance between two tab stops as 4 characters wide.
(setq-default tab-width 4)

(setq create-lockfiles nil)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(let ((auto-save-dir (file-name-as-directory (expand-file-name "autosaves" user-emacs-directory))))
  (make-directory auto-save-dir t)
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t))))



;; Cache passwords for one hour
(setq password-cache-expiry 3600)

(setq compilation-scroll-output t)


;;
(setq recentf-max-menu-items 500)
(recentf-mode 1)
(save-place-mode 1)

;; Dired
(require 'dired)
(require 'dired-x)

(setq
 delete-by-moving-to-trash t
 dired-recursive-copies t
 dired-do-revert-buffer t
 dired-listing-switches "-alh --group-directories-first")

(setq dired-omit-files
      (rx (or (seq bol "."))))

(add-hook 'dired-mode-hook #'dired-omit-mode)

;; Auto refresh on change
(add-hook 'dired-mode-hook #'auto-revert-mode)

(define-key dired-mode-map (kbd "C-c C-o") #'dired-omit-mode)
(define-key dired-mode-map (kbd "DEL") #'dired-up-directory)
(define-key dired-mode-map (kbd "SPC") #'dired-find-file)

(global-set-key (kbd "C-x C-d") #'dired-jump)

;; Compile accepts ANSI colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


;; Auto revert
(global-auto-revert-mode 1)


;; TODO: there is no reason why we can't use the upstream package instead of our fork
;; and just load the settings and keybinds we want to use
(use-package sensible-defaults
  :straight (sensible-defaults :type git :host github
                               :repo "1player/sensible-defaults.el")
  :config
  (sensible-defaults/use-all-settings)
  (sensible-defaults/use-all-keybindings))

(use-package diminish)



;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode))


(use-package crux
  :bind (("C-a" . #'crux-move-beginning-of-line)
         ("<home>" . #'crux-move-beginning-of-line)
         ("C-o" . #'crux-smart-open-line)
         ("M-o" . #'crux-smart-open-line-above)
         ("C-c i" . #'crux-find-user-init-file)
         ("C-x K" . #'crux-kill-other-buffers)
         ("C-c w s" . #'crux-swap-windows)
         ("C-c r" . #'crux-rename-buffer-and-file)))

(use-package embark
  :bind (("C-." . #'embark-act)
         ("C-h B" . #'embark-bindings)))



(use-package helpful
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)
         ("C-h x" . #'helpful-command)))


(provide 'sph-prelude)

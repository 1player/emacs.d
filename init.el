(menu-bar-mode -1)   ; Disable menu bar
(tool-bar-mode -1)   ; Disable toolbar
(scroll-bar-mode 1) ; Enable scrollbar
(set-window-scroll-bars (minibuffer-window) nil nil)
(set-fringe-mode 10) ; Give some breathing room
(setq
 window-resize-pixelwise t
 frame-resize-pixelwise t)

(setq
 user-full-name "Stephane Travostino"
 user-mail-address "steph@combo.cc")

;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(use-package straight
             :custom (straight-use-package-by-default t))

;; Packages
(use-package sensible-defaults
  :straight (sensible-defaults :type git
			               :host github
			               :repo "hrs/sensible-defaults.el"
                           :fork (:host github
                                        :repo "1player/sensible-defaults.el"))
  :config
  (sensible-defaults/use-all-settings)
  (sensible-defaults/use-all-keybindings))

(use-package diminish)

(use-package general)

(use-package vertico
  :straight (:files (:defaults "extensions/*"))
  :bind (:map vertico-map
              ("RET" . #'vertico-directory-enter)
	          ("<prior>" . #'vertico-scroll-down)
	          ("<next>" . #'vertico-scroll-up))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay-hook . #'vertico-directory-tidy)
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :defer t
  :config
  ;; Add project.el projects
  (setq sph/consult-source-projects
        `(:name "Projects"
                :narrow ?P
                :category project
                :action ,#'project-switch-project
                :items ,(apply #'append project--list)))
  (add-to-list 'consult-buffer-sources sph/consult-source-projects 'append))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode))

(use-package flymake
  :hook ((prog-mode latex-mode) . #'flymake-mode))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  ;; (add-hook 'sh-mode-hook (lambda ()
  ;;                           (unless (eq sh-shell 'rpm)
  ;;                             (flymake-shellcheck-load))))
  (add-hook 'sh-mode-hook #'flymake-shellcheck-load))

(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . #'company-complete-selection)
              ("<escape>" . #'company-abort)
              ("<return>" . nil)
              ("RET" . nil)))

(use-package eglot
  :hook ((go-mode python-mode rust-mode typescript-mode) . eglot-ensure)
  :init
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eldoc-idle-delay 0.1)
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider)))

(use-package crystal-mode
  :defer t)

(use-package elixir-mode
  :defer t)

(use-package fish-mode
  :defer t)

(use-package go-mode
  :defer t
  :config
  (defun sph/go-mode-hook ()
    (set (make-local-variable 'compile-command)
         "go run ./...")
    (add-hook 'before-save-hook 'eglot-format-buffer -10 t))
  (add-hook 'go-mode-hook 'sph/go-mode-hook))

(use-package json-mode
  :defer t)


(use-package lua-mode
  :defer t
  :config
  (setq lua-indent-nested-block-content-align nil))

(use-package markdown-mode
  :defer t)

(use-package rust-mode
  :defer t)

(use-package typescript-mode
  :defer t)

(use-package yaml-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.bu\\'" . yaml-mode)))

(use-package web-mode
  :defer t
  :mode ("\\.html?\\'" . web-mode))

(use-package zig-mode
  :defer t)

(use-package magit
  :defer t)

(use-package devdocs
  :defer t)

(use-package editorconfig
  :defer t)

(use-package dtrt-indent
  :diminish
  :defer t)

(use-package ws-butler
  :diminish
  :hook ((prog-mode markdown-mode text-mode) . ws-butler-mode)
  :init
  (setq ws-butler-keep-whitespace-before-point nil))

(use-package crux
  :defer t)

(use-package yasnippet
  :diminish
  :config
  (setq-default yas-indent-line 'fixed)
  (yas-global-mode 1))

(use-package winner
  :straight (:type built-in)
  :config
  (winner-mode 1))


;; (use-package popwin
;;   :init
;;   (popwin-mode 1))

(use-package shackle
  :init
  (setq shackle-rules '(("\\`\\*Flymake diagnostics for.*\\'" :regexp t :select t)
                        ("*Help*" :select t)
                        ("*devdocs*" :select t)))
  (shackle-mode 1))

(use-package embark)

;; (use-package undo-tree
;;   :init
;;   (setq undo-tree-enable-undo-in-region t)
;;   (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache")))
;;   (global-undo-tree-mode 1))

(use-package deadgrep
  :defer t
  :bind (:map deadgrep-mode-map
         ("SPC" . #'deadgrep-visit-result-other-window)))

(use-package highlight-indent-guides
  :diminish
  :hook ((python-mode yaml-mode) . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'bitmap))

(use-package doom-themes)

(use-package pulsar
  :defer t
  :config
  ;; integration with the `consult' package:
  (add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

  ;; integration with the built-in `imenu':
  (add-hook 'imenu-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  (pulsar-global-mode))

(use-package evil
  :init
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-d-scroll nil)
  (setq evil-want-C-h-delete nil)
  (setq evil-want-C-u-delete nil)
  (setq evil-want-C-u-scroll nil)
  (setq evil-want-C-w-delete nil)
  (setq evil-want-C-w-in-emacs-state t)
  ;; Play well with evil-collection, recommended on their README
  ;; (setq evil-want-keybinding nil)
  :config
  (evil-set-initial-state 'flymake-diagnostics-buffer-mode 'emacs)
  (evil-mode 1))

(use-package eshell
  :straight (:type built-in)
  :custom
  (eshell-scroll-to-bottom-on-input 'this))

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))


;; Mouse
(setq
 ;; Disable mouse acceleration
 mouse-wheel-progressive-speed nil
 ;; Scroll 3 lines at a time, full screens while holding SHIFT
 mouse-wheel-scroll-amount '(3 ((shift) . nil)))


;; 21 Jun 2022: Still wonky in Emacs 29
;; (pixel-scroll-precision-mode 1)
;; (setq pixel-scroll-precision-interpolate-page nil)
;; (setq pixel-scroll-precision-large-scroll-height 10.0)
;; (setq pixel-scroll-precision-interpolation-factor 6.0)

;; Try this with Emacs 29 or with pgtk, if mouse wheel is laggy
;; See also: https://lists.gnu.org/archive/html/bug-gnu-emacs/2022-03/msg00803.html
;; (setq mwheel-coalesce-scroll-events nil)

;; Prog mode settings
(add-hook 'prog-mode-hook (lambda ()
                            (setq-local show-trailing-whitespace nil
                                        indicate-empty-lines t)
                            ;;(hl-line-mode 1)
                            (dtrt-indent-mode 1)))

(setq-default indicate-buffer-boundaries 'left)

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


;; Typed text replaces selection
(delete-selection-mode 1)

;; F12 toggles menu
(defun sph/toggle-menu-bar ()
  "Toggle menu bar."
  (interactive)
  (if menu-bar-mode
      (menu-bar-mode 0)
    (menu-bar-mode 1)))

;;
(setq recentf-max-menu-items 500)
(recentf-mode 1)
(save-place-mode 1)

;; Scratch
(setq initial-major-mode #'fundamental-mode)

;; Dired
(setq
 delete-by-moving-to-trash t
 dired-recursive-copies t)

;; Font and theme
(set-frame-font "PragmataPro Liga-13" nil t)

(setq modus-themes-mode-line '(accented borderless))
(setq modus-themes-syntax '(faint))

(defvar sph/light-theme 'modus-operandi)
(defvar sph/dark-theme 'modus-vivendi)
(defvar sph/current-theme nil)

(require 'dbus)

(defun sph/load-light-theme ()
  "Load the light theme."
  (interactive)
  (disable-theme sph/dark-theme)
  (load-theme sph/light-theme t)
  (setq sph/current-theme 'light))

(defun sph/load-dark-theme ()
  "Load the dark theme."
  (interactive)
  (disable-theme sph/light-theme)
  (load-theme sph/dark-theme t)
  (setq sph/current-theme 'dark))

(defun theme-switcher (value)
  (pcase value
    ;; No Preference. Used by GNOME to indicate light theme.
    (0 (sph/load-light-theme))
    ;; Prefers dark
    (1 (sph/load-dark-theme))
    ;; Prefers light
    (2 (sph/load-light-theme))
    (_ (message "Invalid key value"))))

(defun handler (value)
  (theme-switcher (car (car value))))

(defun signal-handler (namespace key value)
  (if (and
       (string-equal namespace "org.freedesktop.appearance")
       (string-equal key "color-scheme"))
      (theme-switcher (car value))))

(dbus-call-method-asynchronously
 :session
 "org.freedesktop.portal.Desktop"
 "/org/freedesktop/portal/desktop"
 "org.freedesktop.portal.Settings"
 "Read"
 #'handler
 "org.freedesktop.appearance"
 "color-scheme")

(dbus-register-signal
 :session
 "org.freedesktop.portal.Desktop"
 "/org/freedesktop/portal/desktop"
 "org.freedesktop.portal.Settings"
 "SettingChanged"
 #'signal-handler)

;; Write customizations to a separate file instead of this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

(require 'tramp)

(defun podman-tramp-add-method ()
  (add-to-list
   'tramp-methods
   '("podman"
     (tramp-login-program "podman")
     (tramp-login-args         (("exec" "-it") ("%h") ("sh")))
     (tramp-remote-shell       "/bin/sh")
     (tramp-remote-shell-args  ("-i" "-c")))))

(defconst podman-tramp-completion-function-alist '((nil "")))

(eval-after-load 'tramp
  '(progn
     (podman-tramp-add-method)
     (tramp-set-completion-function "podman" podman-tramp-completion-function-alist)))

(defun host-tramp-add-method ()
  (add-to-list
   'tramp-methods
   '("host"
     (tramp-login-program "host-spawn")
     (tramp-login-args         (("sh"))
     (tramp-remote-shell       "/bin/sh")
     (tramp-remote-shell-args  ("-i" "-c"))))))

(defconst host-tramp-completion-function-alist '((nil "")))

(eval-after-load 'tramp
  '(progn
     (host-tramp-add-method)
     (tramp-set-completion-function "host" host-tramp-completion-function-alist)))

;;;;;;;;;;;;;;;;;
;; Key bindings

;; Let me bind SPC in motion state
(define-key evil-motion-state-map " " nil)

(require 'general)

(general-create-definer evil-leader-def :prefix "SPC")

(evil-leader-def
 :states '(normal motion)

 "<left>"  #'previous-buffer
 "<right>" #'next-buffer

 "."       #'embark-act

 "SPC"     #'consult-buffer
 "`"       #'crux-other-window-or-switch-buffer

 "b k"     #'kill-this-buffer
 "b R"     #'revert-buffer-quick
 "b K"     #'crux-kill-other-buffers

 "f f"     #'find-file
 "f r"     #'consult-recent-file
 "f i"     #'crux-find-user-init-file
 "f s"     #'save-buffer

 "e"       #'flymake-show-buffer-diagnostics

 "g"       #'magit-status

 "p p"     #'project-switch-project
 "p f"     #'project-find-file
 "p g"     #'deadgrep
 "p K"     #'project-kill-buffers

 "q"       #'kill-this-buffer

 "s"       #'save-buffer

 "w c"     #'evil-window-delete
 "w o"     #'delete-other-windows
 "w s"     #'evil-window-split
 "w v"     #'evil-window-vsplit)

(general-define-key
 "C-." #'embark-act)

(general-define-key
 :states 'normal
 "g ^" #'dired-jump
 "g @" #'consult-imenu)

(general-define-key
 :states 'normal
 "[ e" #'flymake-goto-prev-error
 "] e" #'flymake-goto-next-error)

;; Shift-Tab to force completion
(global-set-key (kbd "<backtab>") #'company-complete)
(general-define-key
 :states 'insert
 "<backtab>" #'company-complete)

;; Help keys
(general-define-key
 "C-h B" #'embark-bindings
 "C-h D" #'devdocs-lookup)


;; TODO: replace the following with general.el
(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)

(global-set-key [f12] #'sph/toggle-menu-bar)

(global-set-key [f5] #'recompile)
(global-set-key [(shift f5)] #'compile)


;; Make ESC quit prompts
;; https://stackoverflow.com/questions/557282/in-emacs-whats-the-best-way-for-keyboard-escape-quit-not-destroy-other-windows
(defadvice keyboard-escape-quit
  (around keyboard-escape-quit-dont-close-windows activate)
  (let ((buffer-quit-function (lambda () ())))
    ad-do-it))
(global-set-key (kbd "<escape>") 'minibuffer-keyboard-quit)

;; Disable Ctrl-Z suspend-frame
(defun sph/suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
(global-set-key (kbd "C-x C-z") 'sph/suspend-frame)

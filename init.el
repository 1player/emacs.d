;;; init.el --- Emacs initialization.
;;;
;;; Commentary:
;;; No comment.
;;;
;;; Code:

(setq
 user-full-name "Stephane Travostino"
 user-mail-address "steph@combo.cc")

;;; Packaging boilerplate
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'straight)
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; Packages

;; TODO: there is no reason why we can't use the upstream package instead of our fork
;; and just load the settings and keybinds we want to use
(use-package sensible-defaults
  :straight (sensible-defaults :type git :host github
                               :repo "1player/sensible-defaults.el")
  :config
  (sensible-defaults/use-all-settings)
  (sensible-defaults/use-all-keybindings))

(use-package diminish)

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
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :defer t
  :bind (("C-x b" . #'consult-buffer)))

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
  :hook ((prog-mode latex-mode) . #'flymake-mode)
  :bind (("M-p" . #'flymake-goto-prev-error)
         ("M-n" . #'flymake-goto-next-error)
         ("C-c d" . #'flymake-show-buffer-diagnostics)
         ("C-x p d" . #'flymake-show-project-diagnostics)))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook #'flymake-shellcheck-load))

(use-package corfu
  :init
  (setq tab-always-indent 'complete)
  (global-corfu-mode))

(use-package eglot
  :diminish
  :hook ((go-mode python-mode rust-mode typescript-mode elixir-mode elixir-ts-mode heex-ts-mode) . eglot-ensure)
  :init
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eldoc-idle-delay 0.1)
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)

              ;; Show flymake diagnostics first.
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))))
  (setq eldoc-documentation-strategy 'eldoc-documentation-compose)
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (defun eglot-format-buffer-on-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
  :config
  (dolist (mode '(elixir-mode elixir-ts-mode heex-ts-mode))
    (add-to-list 'eglot-server-programs `(,mode . ("elixir-ls")))))

(use-package clojure-mode
  :defer t)

(use-package crystal-mode
  :defer t)

(use-package elixir-ts-mode
  :defer t
  :config
  (add-hook 'elixir-ts-mode-hook #'eglot-format-buffer-on-save))

(use-package fish-mode
  :defer t)

(use-package go-mode
  :defer
  :config
  (defun sph/go-mode-hook ()
    (set (make-local-variable 'compile-command)
         "go run ./...")
    (add-hook 'before-save-hook 'eglot-format-buffer -10 t))
  (add-hook 'go-mode-hook 'sph/go-mode-hook))

(use-package janet-mode
  :defer t)

(use-package json-mode
  :defer t)


(use-package lua-mode
  :defer t
  :config
  (setq lua-indent-nested-block-content-align nil))

(use-package markdown-mode
  :defer t)

(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t)
  ;; Don't show error buffer when trying to format invalid code
  (setq rust-format-show-buffer nil))

(use-package php-mode
  :defer t)

(use-package typescript-mode
  :defer t)

(use-package yaml-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.bu\\'" . yaml-mode)))

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.html?.l?eex\\'" . web-mode)
         ("\\.html?.php\\'" . web-mode)))
;; :init
;; (define-derived-mode heex-mode web-mode "HEEx"
;;   "Major mode for editing HEEx files")
;; (add-to-list 'auto-mode-alist '("\\.heex\\'" . heex-mode)))

(use-package zig-mode
  :defer t)

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package cider)

(use-package magit
  :defer t)

(use-package editorconfig
  :defer t)

(use-package direnv
  :config
  (direnv-mode))

(use-package dtrt-indent
  :diminish
  :defer t)

(use-package ws-butler
  :diminish ws-butler-mode
  :hook ((prog-mode markdown-mode text-mode) . ws-butler-mode)
  :init
  (setq ws-butler-keep-whitespace-before-point nil))

(use-package crux
  :bind (("C-a" . #'crux-move-beginning-of-line)
         ("<home>" . #'crux-move-beginning-of-line)
         ("C-o" . #'crux-smart-open-line)
         ("M-o" . #'crux-smart-open-line-above)
                                        ;("C-k" . #'crux-smart-kill-line)
         ("C-c i" . #'crux-find-user-init-file)
         ("C-x K" . #'crux-kill-other-buffers)
         ("C-c w s" . #'crux-swap-windows)
         ("C-c r" . #'crux-rename-buffer-and-file)))

(use-package avy
  :bind (("M-j" . #'avy-goto-char))
  :custom (avy-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)))

(use-package expand-region
  :bind (("C--" . #'er/expand-region)
         ("C-=" . #'er/contract-region)))

(use-package tempel)

(use-package window-numbering
  :config
  (window-numbering-mode))

(use-package embark
  :bind (("C-." . #'embark-act)
         ("C-h B" . #'embark-bindings)))

(use-package helpful
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)
         ("C-h x" . #'helpful-command)))

(use-package deadgrep
  :defer t
  :bind (:map deadgrep-mode-map
              ("SPC" . #'deadgrep-visit-result-other-window)))

(use-package highlight-indent-guides
  :diminish
  :hook ((python-mode yaml-mode) . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'bitmap))

(use-package whole-line-or-region
  :bind (("M-," . #'whole-line-or-region-comment-dwim-2))
  :config
  (whole-line-or-region-global-mode 1))

(use-package pulsar
  :config
  ;; integration with the `consult' package:
  (add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

  ;; integration with the built-in `imenu':
  (add-hook 'imenu-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  (pulsar-global-mode))

(use-package geiser-chicken)

(use-package format-all)

(use-package nano-modeline
  :config
  (nano-modeline-mode))

(use-package ef-themes)

(use-package paredit)

;; (use-package meow
;;   :config
;;   (setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak-dh)
;;   (meow-motion-overwrite-define-key
;;    ;; Use e to move up, n to move down.
;;    ;; Since special modes usually use n to move down, we only overwrite e here.
;;    '("e" . meow-prev)
;;    '("<escape>" . ignore))
;;   (meow-leader-define-key
;;    '("?" . meow-cheatsheet)
;;    ;; To execute the originally e in MOTION state, use SPC e.
;;    '("e" . "H-e")
;;    '("1" . meow-digit-argument)
;;    '("2" . meow-digit-argument)
;;    '("3" . meow-digit-argument)
;;    '("4" . meow-digit-argument)
;;    '("5" . meow-digit-argument)
;;    '("6" . meow-digit-argument)
;;    '("7" . meow-digit-argument)
;;    '("8" . meow-digit-argument)
;;    '("9" . meow-digit-argument)
;;    '("0" . meow-digit-argument))
;;   (meow-normal-define-key
;;    '("0" . meow-expand-0)
;;    '("1" . meow-expand-1)
;;    '("2" . meow-expand-2)
;;    '("3" . meow-expand-3)
;;    '("4" . meow-expand-4)
;;    '("5" . meow-expand-5)
;;    '("6" . meow-expand-6)
;;    '("7" . meow-expand-7)
;;    '("8" . meow-expand-8)
;;    '("9" . meow-expand-9)
;;    '("-" . negative-argument)
;;    '("'" . meow-reverse)
;;    '("," . meow-inner-of-thing)
;;    '("." . meow-bounds-of-thing)
;;    '("(" . meow-beginning-of-thing)
;;    '(")" . meow-end-of-thing)
;;    '("/" . meow-visit)
;;    '("a" . meow-append)
;;    '("A" . meow-open-below)
;;    '("d" . meow-back-word)
;;    '("D" . meow-back-symbol)
;;    '("c" . meow-change)
;;    '("g" . meow-delete)
;;    '("i" . meow-prev)
;;    '("I" . meow-prev-expand)
;;    '("f" . meow-find)
;;    '("b" . meow-cancel-selection)
;;    '("B" . meow-grab)
;;    '("n" . meow-left)
;;    '("N" . meow-left-expand)
;;    '("o" . meow-right)
;;    '("O" . meow-right-expand)
;;    '("j" . meow-join)
;;    '("k" . meow-kill)
;;    '("l" . meow-line)
;;    '("L" . meow-goto-line)
;;    '("h" . meow-mark-word)
;;    '("H" . meow-mark-symbol)
;;    '("e" . meow-next)
;;    '("E" . meow-next-expand)
;;    '("m" . meow-block)
;;    '("M" . meow-to-block)
;;    '("p" . meow-yank)
;;    '("q" . meow-quit)
;;    '("r" . meow-replace)
;;    '("s" . meow-insert)
;;    '("S" . meow-open-above)
;;    '("t" . meow-till)
;;    '("u" . meow-undo)
;;    '("U" . meow-undo-in-selection)
;;    '("v" . meow-search)
;;    '("w" . meow-next-word)
;;    '("W" . meow-next-symbol)
;;    '("x" . meow-delete)
;;    '("X" . meow-backward-delete)
;;    '("y" . meow-save)
;;    '("z" . meow-pop-selection)
;;    '("=" . repeat)
;;    '("<escape>" . ignore)))



(use-package olivetti
  :defer t)

(use-package eat
  :straight (eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el")))
  :bind (("C-x p t" . #'eat-project)
         ("C-c t" . #'eat)))


;; Tree sitter
(setq treesit-extra-load-path `(,(expand-file-name "~/.local/share/tree-sitter")))

;; Mouse
(setq
 ;; Disable mouse wheel acceleration
 mouse-wheel-progressive-speed nil
 ;; Scroll 3 lines at a time, full screens while holding SHIFT
 mouse-wheel-scroll-amount '(3 ((shift) . nil)))


;; 09 Sep 2022: Works almost perfectly, but needs to press PgUp/PgDown twice when at the
;; top or bottom of the file.
(pixel-scroll-precision-mode 1)
(setq pixel-scroll-precision-interpolate-page t)
(setq pixel-scroll-precision-use-momentum t)
(setq pixel-scroll-precision-momentum-seconds 0.5)
(setq pixel-scroll-precision-momentum-min-velocity 10.0)
(setq pixel-scroll-precision-initial-velocity-factor 0.005)
(setq pixel-scroll-precision-large-scroll-height nil)

;; Try this with Emacs 29 or with pgtk, if mouse wheel is laggy
;; See also: https://lists.gnu.org/archive/html/bug-gnu-emacs/2022-03/msg00803.html
;; (setq mwheel-coalesce-scroll-events nil)

;; Prog mode settings
(add-hook 'prog-mode-hook (lambda ()
                            ;; this_is-a-single_word
                            (superword-mode 1)
                            (dtrt-indent-mode 1)
                            (electric-pair-local-mode 0)))

;; Scroll just enough to show the next line, like
;; other editors do.
(setq scroll-conservatively 101)

(setq scroll-margin 5)
(setq scroll-preserve-screen-position t)

;; Don't just scroll windows, also move the cursor to the top/bottom
;; if we reach the first/last page.
;; Basically emulates PgUp/Down like all other editors.
(setq scroll-error-top-bottom t)

(setq-default indicate-buffer-boundaries nil)
(setq-default indicate-empty-lines nil)
(setq-default show-trailing-whitespace nil)

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

;; Allow motion during search
(setq isearch-allow-motion t)

;; Windows
(setq switch-to-buffer-obey-display-actions t)
(setq switch-to-buffer-in-dedicated-window 'pop)

;; Cache passwords for one hour
(setq password-cache-expiry 3600)

(setq compilation-scroll-output t)

;; winner-mode, but with support for tabs
(winner-mode 1)

(setq tab-bar-format '(tab-bar-format-tabs tab-bar-format-add-tab))
(setq tab-bar-show 1) ; show only when more than one tab
(tab-bar-history-mode 1)

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

;; Dired
(require 'dired)

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

(require 'dired-x)

;; Compile accepts ANSI colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Completions
;; 12 Oct 2022 - Disable for now
;; (setq completions-format 'one-column)
;; (setq completions-header-format nil)
;; (setq completions-max-height 20)
;; (setq completion-auto-select nil)

;; (define-key minibuffer-mode-map (kbd "C-n") 'minibuffer-next-completion)
;; (define-key minibuffer-mode-map (kbd "C-p") 'minibuffer-previous-completion)

;; (define-key completion-in-region-mode-map (kbd "C-n") 'minibuffer-next-completion)
;; (define-key completion-in-region-mode-map (kbd "C-p") 'minibuffer-previous-completion)


;; Auto revert
(global-auto-revert-mode 1)

;; Font and theme

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;; (set-frame-font "IBM Plex Mono-14" nil t)
(set-frame-font "Iosevka Comfy-14" nil t)

(setq-default line-spacing nil)

(setq modus-themes-mode-line '(borderless)
      modus-themes-syntax '(alt-syntax faint)
      modus-themes-italic-constructs t
      modus-themes-bold-constructs nil)

(defun current-meteorological-season ()
  "Return the current meteorological season."
  (let* ((day-in-year (lambda (date)
                        (time-to-day-in-year (date-to-time (concat "2001-" date)))))
         (spring-start (funcall day-in-year "03-01"))
         (summer-start (funcall day-in-year "06-01"))
         (autumn-start (funcall day-in-year "09-01"))
         (winter-start (funcall day-in-year "12-01"))
         (current-day (time-to-day-in-year (current-time))))
    (cond ((< current-day spring-start) 'winter)
          ((< current-day summer-start) 'spring)
          ((< current-day autumn-start) 'summer)
          ((< current-day winter-start) 'autumn)
          (t 'winter))))

(defun light-theme-for-this-season ()
  "Return the light theme for this season."
  (pcase (current-meteorological-season)
    ('spring 'ef-spring)
    ('summer 'ef-summer)
    ('autumn 'ef-day)
    ('winter 'modus-operandi)))

(defvar sph/light-theme (light-theme-for-this-season))
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

(global-set-key (kbd "M-g M-,") #'beginning-of-buffer)
(global-set-key (kbd "M-g M-.") #'end-of-buffer)

(global-set-key (kbd "C-x C-r") #'revert-buffer-quick)

(global-set-key (kbd "<mouse-8>") #'switch-to-prev-buffer)
(global-set-key (kbd "<Back>") #'switch-to-prev-buffer)
(global-set-key (kbd "<mouse-9>") #'switch-to-next-buffer)
(global-set-key (kbd "<Forward>") #'switch-to-next-buffer)

(global-set-key [f12] #'sph/toggle-menu-bar)

(global-set-key (kbd "C-c c") #'recompile)
(global-set-key (kbd "C-c C") #'project-compile)

(global-set-key (kbd "M-<up>") #'windmove-up)
(global-set-key (kbd "M-<down>") #'windmove-down)
(global-set-key (kbd "M-<left>") #'windmove-left)
(global-set-key (kbd "M-<right>") #'windmove-right)

(global-set-key (kbd "M-SPC") #'dabbrev-expand)

(global-set-key (kbd "<escape>") #'minibuffer-keyboard-quit)

(global-set-key (kbd "C-`") #'undo)

;; Make ESC quit prompts
;; https://stackoverflow.com/questions/557282/in-emacs-whats-the-best-way-for-keyboard-escape-quit-not-destroy-other-windows
;; (defadvice keyboard-escape-quit
;;   (around keyboard-escape-quit-dont-close-windows activate)
;;   (let ((buffer-quit-function (lambda () ())))
;;     ad-do-it))
;; (global-set-key (kbd "<escape>") 'minibuffer-keyboard-quit)

;; Disable Ctrl-Z suspend-frame
(defun sph/suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
(global-set-key (kbd "C-x C-z") 'sph/suspend-frame)
(global-set-key (kbd "C-z") 'sph/suspend-frame)

;; Server

(require 'server)

(unless (server-running-p)
  (server-start))

(provide 'init)
;;; init.el ends here

;;; -*- lexical-binding: t -*-

;; Mouse
(setq
 ;; Disable mouse wheel acceleration
 mouse-wheel-progressive-speed nil
 ;; Scroll 3 lines at a time, full screens while holding SHIFT
 mouse-wheel-scroll-amount '(3 ((shift) . nil)))

(pixel-scroll-precision-mode 1)
(setq pixel-scroll-precision-interpolate-page t)
(setq pixel-scroll-precision-use-momentum t)
(setq pixel-scroll-precision-momentum-seconds 0.5)
(setq pixel-scroll-precision-momentum-min-velocity 25.0)
(setq pixel-scroll-precision-initial-velocity-factor 0.005)
(setq pixel-scroll-precision-large-scroll-height nil)

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

;; Open context menu with right click
(context-menu-mode 1)

;; Windows - Not sure why these were set
(setq switch-to-buffer-obey-display-actions t)
(setq switch-to-buffer-in-dedicated-window 'pop)

;; Winner
(winner-mode)

;; Which key
(require-package 'which-key)
(setopt which-key-idle-delay 1.0)
(which-key-mode)

;; Helpful
(require-package 'helpful)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)

(after 'evil
  (evil-set-initial-state 'helpful-mode 'motion))

(provide 'sph-src-ui)

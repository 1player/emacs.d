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
(setq pixel-scroll-precision-momentum-min-velocity 10.0)
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

;; Typed text replaces selection
(delete-selection-mode 1)

;; Allow motion during search
(setq isearch-allow-motion t)

;; Windows
(setq switch-to-buffer-obey-display-actions t)
(setq switch-to-buffer-in-dedicated-window 'pop)

(global-set-key (kbd "C-0") #'delete-window)
(global-set-key (kbd "C-1") #'delete-other-windows)
(global-set-key (kbd "C-2") #'split-window-below)
(global-set-key (kbd "C-3") #'split-window-right)
(global-set-key (kbd "C-<tab>") #'other-window)

(use-package ace-window
  :custom ((aw-scope 'frame)
           (aw-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)))
  :bind (("C-M-s-a" . #'ace-window)))

;; winner-mode, but with support for tabs
(winner-mode 1)

;; consult
(use-package consult
  :defer t
  :bind (("C-x b" . #'consult-buffer)
         ("C-x 4 b" . #'consult-buffer-other-window)))


;; F12 toggles menu
(defun sph/toggle-menu-bar ()
  "Toggle menu bar."
  (interactive)
  (if menu-bar-mode
      (menu-bar-mode 0)
    (menu-bar-mode 1)))

(global-set-key [f12] #'sph/toggle-menu-bar)

(provide 'sph-ui)

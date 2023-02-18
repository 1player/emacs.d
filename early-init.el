;;; early-init.el --- Emacs early initialization.
;;;
;;; Commentary:
;;; No comment.
;;;
;;; Code:

;; Temporarily disable GC.
(setq gc-cons-threshold most-positive-fixnum)

;; Then lower the threshold to 50 MB during normal operation to prevent longer
;; GC pauses, but still have it at a higher value than the default to
;; experience less mini-interruptions – eg. while scrolling larger buffers.
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 50 1000 1000))))

(setq inhibit-startup-message t)

;; Required for straight.el
(setq package-enable-at-startup nil)

;; Style frame
(menu-bar-mode -1)   ; Disable menu bar
(tool-bar-mode -1)   ; Disable toolbar
(scroll-bar-mode -1)  ; Enable scrollbar
(set-window-scroll-bars (minibuffer-window) nil nil)
(fringe-mode 10)

(setq frame-inhibit-implied-resize t
      window-resize-pixelwise t
      frame-resize-pixelwise t)

(provide 'early-init)
;;; early-init.el ends here

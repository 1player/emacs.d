;; -*- lexical-binding: t -*-

(defvar-local sph-format-method 'eglot)

(require-package 'format-all)

(defun sph-format-buffer ()
  "Formats the buffer with the best available method."
  (interactive)
  (save-excursion
    (cond ((and (eq sph-format-method 'eglot) (fboundp 'eglot-format-buffer) eglot--managed-mode)
           (eglot-format-buffer))
          ((eq sph-format-method 'format-all)
           (format-all-ensure-formatter)
           (format-all-buffer))
          (t (message "Could not format.")))))

(global-set-key (kbd "C-c f") #'sph-format-buffer)

;; Format on save mode
(define-minor-mode sph-format-on-save-mode
  "Automatically format buffer on save"
  :lighter " FoS")

(add-hook 'sph-format-on-save-mode-hook
          (lambda ()
            (if sph-format-on-save-mode
                (add-hook 'before-save-hook #'sph-format-buffer -10 t)
              (remove-hook 'before-save-hook #'sph-format-buffer t))))


(provide 'sph-src-format)

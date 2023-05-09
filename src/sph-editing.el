(define-prefix-command 'avy-map)

(use-package avy
  :bind (("M-m" . #'avy-goto-char-timer))
  :custom (avy-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)))


(use-package avy-zap
  :bind (("M-z" . #'avy-zap-up-to-char-dwim)
         ("M-Z" . #'avy-zap-to-char-dwim)))


(use-package whole-line-or-region
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


(use-package olivetti
  :defer t)

(use-package project-x
  :straight (project-x :type git :host github
                       :repo "karthink/project-x")
  :after project
  :config
  (add-hook 'project-find-functions 'project-x-try-local -90))

(use-package tempel
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions (cons #'tempel-expand completion-at-point-functions)))
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf))

;;

(global-set-key (kbd "M-<delete>") #'kill-word)
(global-set-key (kbd "M-DEL") #'backward-kill-word)

;; kill-line also kills excess whitespace
(defadvice kill-line (before kill-line-autoreindent activate)
  "Kill excess whitespace when joining lines.
If the next line is joined to the current line, kill the extra indent whitespace in front of the next line."
  (when (and (eolp) (not (bolp)))
    (save-excursion
      (forward-char 1)
      (just-one-space 1))))

;; Offer the option to diff buffer when trying to kill a modified one
;; From https://in.comum.org/smart-way-to-close-files.html
;; and https://old.reddit.com/r/emacs/comments/13b2z5z/add_a_diff_to_the_yesnosave_and_quit_choices/
;;
;; Perhaps having a custom function for `kill-buffer-query-functions` would be preferable
(defun sph-kill-or-diff-this-buffer ()
  (interactive)
  (catch 'quit
    (save-window-excursion
      (let (done)
        (when (and buffer-file-name (buffer-modified-p))
          (while (not done)
            (let ((response (read-char-choice
                             (format "Save file %s? (y)es, (n)o, (d)iff, (q)uit" (buffer-file-name))
                             '(?y ?n ?d ?q))))
              (setq done (cond
                          ((eq response ?q) (throw 'quit nil))
                          ((eq response ?y) (save-buffer) t)
                          ((eq response ?n) (set-buffer-modified-p nil) t)
                          ((eq response ?d) (diff-buffer-with-file) nil))))))
        (kill-buffer (current-buffer))))))

(global-set-key (kbd "C-x k") #'sph-kill-or-diff-this-buffer)


;; Undo macros in a single step
(defun block-undo (fn &rest args)
  (let ((marker (prepare-change-group)))
    (unwind-protect (apply fn args)
      (undo-amalgamate-change-group marker))))

(dolist (fn '(kmacro-call-macro
              kmacro-exec-ring-item
              dot-mode-execute
              apply-macro-to-region-lines))
  (advice-add fn :around #'block-undo))

(provide 'sph-editing)

;;; -*- lexical-binding: t -*-

(require-package 'org)
(require 'org)

(setopt
 org-directory (expand-file-name "~/Documents/Org")
 org-default-notes-file (concat org-directory "/life.org")
 org-cycle-separator-lines -1
 org-startup-indented t
 org-archive-location "::* Archived Tasks"
 org-todo-keywords '((sequence "TODO" "DOING" "DONE"))
 org-todo-keyword-faces '(("TODO" . (:background "wheat" :foreground "black"))
                          ("DOING" . (:background "spring green" :foreground "black"))))


(add-hook 'org-mode-hook (lambda ()
                           (auto-fill-mode)))

(setopt org-refile-targets '((nil :maxlevel . 1)
                             (org-agenda-files :maxlevel . 1)))

;; Capture
(setopt org-capture-templates '(("t" "Todo" entry (file+headline "life.org" "Tasks")
                                 "* TODO %?\n  %i")
                                ("b" "Bernard task" entry (file+headline "bernard.org" "Triage")
                                 "* TODO %?\n  %i")))

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c g") #'org-capture)

(defun sph-find-org-files ()
  "List Org files for opening."
  (interactive)
  (ido-find-file-in-dir org-directory))

(global-set-key (kbd "C-c o") #'sph-find-org-files)


(provide 'sph-src-org)

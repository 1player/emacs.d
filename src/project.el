;;; -*- lexical-binding: t -*-

(require-package 'consult-project-extra)

(setopt project-switch-commands '((project-find-file "Find file" ?f)
                                  (project-find-dir "Find directory" ?d)
                                  (magit-project-status "Git status" ?g)
                                  (eat-project "Eat Shell" ?t)))


(provide 'sph-src-magit)

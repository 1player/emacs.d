;;; -*- lexical-binding: t -*-

(use-package deft
  :bind (("C-c n" . deft))
  :custom
  (deft-directory "~/Documents/notes")
  (deft-recursive t)
  (deft-use-filename-as-title t))

(provide 'sph-src-deft)

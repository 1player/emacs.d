;;; -*- lexical-binding: t -*-

(require-package 'consult)

(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "C-x 4 b") #'consult-buffer-other-window)
(global-set-key (kbd "M-g i") #'consult-imenu)

(with-eval-after-load 'bufferlo
  (defvar my-consult--source-buffer
    `(:name "All Buffers"
      :narrow   ?a
      :hidden   t
      :category buffer
      :face     consult-buffer
      :history  buffer-name-history
      :state    ,#'consult--buffer-state
      :items ,(lambda () (consult--buffer-query
                          :sort 'visibility
                          :as #'buffer-name)))
    "All buffer candidate source for `consult-buffer'.")

  (defvar my-consult--source-local-buffer
    `(:name nil
      :narrow   ?b
      :category buffer
      :face     consult-buffer
      :history  buffer-name-history
      :state    ,#'consult--buffer-state
      :default  t
      :items ,(lambda () (consult--buffer-query
                          :predicate #'bufferlo-local-buffer-p
                          :sort 'visibility
                          :as #'buffer-name)))
    "Local buffer candidate source for `consult-buffer'.")

  (setopt consult-buffer-sources '(consult--source-hidden-buffer
                                   my-consult--source-buffer
                                   my-consult--source-local-buffer)))

(after 'evil
  (evil-define-key 'normal 'global "gs" 'consult-imenu))

(provide 'sph-src-consult)

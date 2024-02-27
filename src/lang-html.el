;; -*- lexical-binding: t -*-

;; Web mode (required for some php template files)
(require-package 'web-mode)

;; HTML editing mode

(require 'sgml-mode)

(defun html-editing-insert-gt ()
  "Insert a `>' character and calls `my-sgml-close-tag-if-necessary', leaving point where it is."
  (interactive)
  (insert ">")
  (save-excursion (html-editing-close-tag-if-necessary)))

(defun html-editing-close-tag-if-necessary ()
  "Call sgml-close-tag if the tag immediately before point is an opening tag."
  (when (looking-back "<\\s-*\\([^</> \t\r\n]+\\)[^</>]*>")
    (let ((tag (match-string 1)))
      (unless (and (not (sgml-unclosed-tag-p tag))
                   (looking-at (concat "\\s-*<\\s-*/\\s-*" tag "\\s-*>")))
        (sgml-close-tag)))))

(define-minor-mode html-editing-mode
  "HTML editing minor mode based on sgml-mode"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map ">" #'html-editing-insert-gt)
            map))

(provide 'sph-src-lang-html)

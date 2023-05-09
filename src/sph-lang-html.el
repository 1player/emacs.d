(require 'sgml-mode)

(defun html-editing-current-tag ()
  (save-excursion
    (let ((tag (sgml-parse-tag-backward)))
      (if tag
          (sgml-tag-name tag)))))

(defun html-editing-close-bracket-and-close-tag ()
  (interactive)
  (if (eq (car (sgml-lexical-context)) 'tag)
      (progn
        (insert-char ?>)
        (unless (sgml-empty-tag-p (html-editing-current-tag))
          (save-excursion
            (sgml-close-tag))))
    (insert-char ?>)))

(define-minor-mode html-editing-mode
  "HTML editing minor mode based on sgml-mode"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map ">" #'html-editing-close-bracket-and-close-tag)
            map))

(provide 'sph-lang-html)

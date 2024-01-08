;;; -*- lexical-binding: t -*-

(require-package 'eglot)
(require 'eglot)

(setopt eglot-ignored-server-capabilities '(:documentHighlightProvider :documentLinkProvider :inlayHintProvider)
	eglot-send-changes-idle-time 0.5
	eglot-events-buffer-size 0
	eglot-sync-connect nil)

;; Performance tweaks
(fset #'jsonrpc--log-event #'ignore)

(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	    (put 'eglot-note 'flymake-overlay-control nil)
	    (put 'eglot-warning 'flymake-overlay-control nil)
	    (put 'eglot-error 'flymake-overlay-control nil)

            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions (cons #'flymake-eldoc-function
                                                      (remove #'flymake-eldoc-function
                                                              eldoc-documentation-functions)))
            (eglot-inlay-hints-mode -1)))

(provide 'sph-src-eglot)

;;; -*- lexical-binding: t -*-

(use-package eglot
  :init
  ;; Performance tweaks
  (fset #'jsonrpc--log-event #'ignore)
  :config
  (with-eval-after-load 'flymake
    (add-hook 'eglot-managed-mode-hook
	          (lambda ()
	            (put 'eglot-note 'flymake-overlay-control nil)
	            (put 'eglot-warning 'flymake-overlay-control nil)
	            (put 'eglot-error 'flymake-overlay-control nil)

                ;; Show flymake diagnostics first.
                (setq eldoc-documentation-functions (cons #'flymake-eldoc-function
                                                          (remove #'flymake-eldoc-function
                                                                  eldoc-documentation-functions)))
                (eglot-inlay-hints-mode -1))))

  (setopt eglot-ignored-server-capabilities '(:documentHighlightProvider :documentLinkProvider :inlayHintProvider)
	      eglot-send-changes-idle-time 0.5
	      eglot-events-buffer-size 0
	      eglot-sync-connect nil))

(use-package eglot-booster
  :vc (:fetcher github :repo jdtsmith/eglot-booster)
  :after eglot
  :config (eglot-booster-mode))


(provide 'sph-src-eglot)

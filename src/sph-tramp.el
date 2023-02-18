
(require 'tramp)

(defun podman-tramp-add-method ()
  (add-to-list
   'tramp-methods
   '("podman"
     (tramp-login-program "podman")
     (tramp-login-args         (("exec" "-it") ("%h") ("sh")))
     (tramp-remote-shell       "/bin/sh")
     (tramp-remote-shell-args  ("-i" "-c")))))

(defconst podman-tramp-completion-function-alist '((nil "")))

(eval-after-load 'tramp
  '(progn
     (podman-tramp-add-method)
     (tramp-set-completion-function "podman" podman-tramp-completion-function-alist)))

(defun host-tramp-add-method ()
  (add-to-list
   'tramp-methods
   '("host"
     (tramp-login-program "host-spawn")
     (tramp-login-args         (("sh"))
                               (tramp-remote-shell       "/bin/sh")
                               (tramp-remote-shell-args  ("-i" "-c"))))))

(defconst host-tramp-completion-function-alist '((nil "")))

(eval-after-load 'tramp
  '(progn
     (host-tramp-add-method)
     (tramp-set-completion-function "host" host-tramp-completion-function-alist)))

(provide 'sph-tramp)

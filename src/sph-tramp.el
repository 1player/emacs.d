(require 'tramp)

(push (cons "host"
            '((tramp-login-program "host-spawn")
              (tramp-remote-shell
               "/bin/sh")
              (tramp-remote-shell-args ("-i") ("-c"))))
      tramp-methods)

(provide 'sph-tramp)

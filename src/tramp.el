;;; -*- lexical-binding: t -*-

(require 'tramp)

;; hoping this avoids ruining my zsh history when using the
;; `host` tramp connector
(setq tramp-histfile-override nil)

(push (cons "host"
            '((tramp-login-program "host-spawn")
              (tramp-remote-shell
               "/bin/sh")
              (tramp-remote-shell-args ("-i") ("-c"))))
      tramp-methods)

(provide 'sph-src-tramp)

;;; -*- lexical-binding: t -*-

(require 'tramp)

;; hoping this avoids ruining my zsh history when using the
;; `host` tramp connector
(setq tramp-histfile-override nil)

;; host tramp connector
(push (cons "host"
            '((tramp-login-program "host-spawn")
              (tramp-remote-shell
               "/bin/sh")
              (tramp-remote-shell-args ("-i") ("-c"))))
      tramp-methods)

;; set up ControlMaster to speed up SSH
(setopt tramp-ssh-controlmaster-options (concat "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
                                                "-o ControlMaster=auto -o ControlPersist=yes"))

(setopt tramp-inline-compress-start-size 1048576)

(provide 'sph-src-tramp)

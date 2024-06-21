;;; -*- lexical-binding: t -*-

(use-package languagetool
  :custom
  (languagetool-java-arguments '("-Dfile.encoding=UTF-8"
                                 "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*"))
  (languagetool-console-command "org.languagetool.commandline.Main")
  (languagetool-server-command "org.languagetool.server.HTTPServer"))



(add-hook 'text-mode-hook (lambda ()
                            (visual-line-mode 1)))


(provide 'sph-src-prose)

;; -*- lexical-binding: t -*-

(defgroup sph nil
  "Custom configuration for sph's Emacs files"
  :group 'local)

(defcustom sph-keyboard-layout
  'moonlander
  "Keyboard layout."
  :type '(radio
          (const :tag "moonlander" moonlander))
  :group 'sph)

(defcustom sph-editing-engine
  'emacs
  "Emacs or Evil keybinds."
  :type '(radio
          (const :tag "Emacs" emacs)
          (const :tag "Evil" evil))
  :group 'sph)

(provide 'sph-core-config)

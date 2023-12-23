;;; -*- lexical-binding: t -*-

(defcustom sph-theme
  'modus
  "Colour theme."
  :type '(radio
          (const :tag "Modus" modus))
  :group 'sph)

(defvar sph-light-theme)
(defvar sph-dark-theme)
(defvar sph-current-theme)

(defun sph-load-light-theme ()
  "Load the light theme."
  (interactive)
  (disable-theme sph-dark-theme)
  (load-theme sph-light-theme t)
  (setq sph-current-theme 'light))

(defun sph-load-dark-theme ()
  "Load the dark theme."
  (interactive)
  (disable-theme sph-light-theme)
  (load-theme sph-dark-theme t)
  (setq sph-current-theme 'dark))

;; Font
(set-frame-font "Iosevka Comfy Motion-13" nil t)
(setq-default line-spacing 1)

;; Dark/light theme switcher
(require 'dbus)

(defun theme-switcher (value)
  (pcase value
    ;; No Preference. Used by GNOME to indicate light theme.
    (0 (sph-load-light-theme))
    ;; Prefers dark
    (1 (sph-load-dark-theme))
    ;; Prefers light
    (2 (sph-load-light-theme))
    (_ (message "Invalid key value"))))

(defun handler (value)
  (theme-switcher (car (car value))))

(defun signal-handler (namespace key value)
  (if (and
       (string-equal namespace "org.freedesktop.appearance")
       (string-equal key "color-scheme"))
      (theme-switcher (car value))))

(defun sph-start-theme-switcher ()
  "Set the appropriate theme based on the time of day and listens to changes."
  (dbus-call-method-asynchronously
   :session
   "org.freedesktop.portal.Desktop"
   "/org/freedesktop/portal/desktop"
   "org.freedesktop.portal.Settings"
   "Read"
   #'handler
   "org.freedesktop.appearance"
   "color-scheme")

  ;; Listen to OS light/dark colorscheme changes
  (dbus-register-signal
   :session
   "org.freedesktop.portal.Desktop"
   "/org/freedesktop/portal/desktop"
   "org.freedesktop.portal.Settings"
   "SettingChanged"
   #'signal-handler))

;; Theme packages
(require-package 'modus-themes)
(require 'modus-themes)
(setopt modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

(setopt modus-themes-common-palette-overrides
        `(;; Remove the border from the modeline
          (border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)
          ;; Make the mode line more colorful
          (bg-mode-line-active bg-magenta-subtle)
          (fg-mode-line-active fg-main)
          ,@modus-themes-preset-overrides-faint))

(when (eq sph-theme 'modus)
  (setq sph-light-theme 'modus-operandi-tinted)
  (setq sph-dark-theme 'modus-vivendi))

;;
(sph-start-theme-switcher)

(provide 'sph-src-theme)

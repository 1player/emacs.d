(require 'dbus)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(set-frame-font "Iosevka Comfy-14" nil t)
(setq-default line-spacing nil)

;; Theme customization

(with-eval-after-load 'modus-themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  (setq modus-themes-common-palette-overrides
        `(;; Remove the border from the modeline
          (border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)
          ;; Make the mode line more colorful
          (bg-mode-line-active bg-magenta-subtle)
          (fg-mode-line-active fg-main)
          ,@modus-themes-preset-overrides-faint)))

;;


(defun current-meteorological-season ()
  "Return the current meteorological season."
  (let* ((day-in-year (lambda (date)
                        (time-to-day-in-year (date-to-time (concat "2001-" date)))))
         (spring-start (funcall day-in-year "03-01"))
         (summer-start (funcall day-in-year "06-01"))
         (autumn-start (funcall day-in-year "09-01"))
         (winter-start (funcall day-in-year "12-01"))
         (current-day (time-to-day-in-year (current-time))))
    (cond ((< current-day spring-start) 'winter)
          ((< current-day summer-start) 'spring)
          ((< current-day autumn-start) 'summer)
          ((< current-day winter-start) 'autumn)
          (t 'winter))))

(defun light-theme-for-this-season ()
  "Return the light theme for this season."
  (pcase (current-meteorological-season)
    ('spring 'ef-spring)
    ('summer 'ef-summer)
    ('autumn 'ef-day)
    ('winter 'modus-operandi)))

(defvar sph/light-theme (light-theme-for-this-season))
(defvar sph/dark-theme 'modus-vivendi)
(defvar sph/current-theme nil)



(defun sph/load-light-theme ()
  "Load the light theme."
  (interactive)
  (disable-theme sph/dark-theme)
  (load-theme sph/light-theme t)
  (setq sph/current-theme 'light))

(defun sph/load-dark-theme ()
  "Load the dark theme."
  (interactive)
  (disable-theme sph/light-theme)
  (load-theme sph/dark-theme t)
  (setq sph/current-theme 'dark))

(defun theme-switcher (value)
  (pcase value
    ;; No Preference. Used by GNOME to indicate light theme.
    (0 (sph/load-light-theme))
    ;; Prefers dark
    (1 (sph/load-dark-theme))
    ;; Prefers light
    (2 (sph/load-light-theme))
    (_ (message "Invalid key value"))))

(defun handler (value)
  (theme-switcher (car (car value))))

(defun signal-handler (namespace key value)
  (if (and
       (string-equal namespace "org.freedesktop.appearance")
       (string-equal key "color-scheme"))
      (theme-switcher (car value))))

;; Load appropriate light/dark theme
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
 #'signal-handler)



(provide 'sph-themes)

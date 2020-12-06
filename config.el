;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load! "+bindings")

(setq tab-width 2)
(setq display-line-numbers nil)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "SF Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "SF Mono" :size 13))

(use-package! company
  :config
  (setq
   company-idle-delay 1.5
   company-minimum-prefix-length 5))

(use-package! magit
  :config
  (setq magit-repository-directories
        '(("~/.dotfiles" . 0)
          ("~/Projects" . 1))))

(use-package! projectile
  :config
  (setq projectile-project-search-path '("~/Projects" "~/.config")))

(use-package! nov-mode
  :mode "\\.epub$")

(use-package! which-key
  :config
  (setq which-key-idle-delay 0.15
        which-key-idle-secondary-delay 0.15))

(load! "+org")

;; https://github.com/Malabarba/aggressive-indent-mode/issues/138
;; https://github.com/Malabarba/aggressive-indent-mode/issues/137
;; https://discordapp.com/channels/406534637242810369/406624667496087572/714350381324304446

(defadvice! kill-aggressive-indent-timers (l r &rest _)
  :override #'aggressive-indent--keep-track-of-changes
  (when aggressive-indent-mode
    (push (list l r) aggressive-indent--changed-list)
    (when (timerp aggressive-indent--idle-timer)
      (cancel-timer aggressive-indent--idle-timer))
    (setq aggressive-indent--idle-timer
          (run-with-idle-timer
           aggressive-indent-sit-for-time
           nil #'aggressive-indent--indent-if-changed (current-buffer)))))

(setq-default indent-tabs-mode nil)
;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)
(setq backward-delete-char-untabify-method 'hungry)

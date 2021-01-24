(electric-pair-mode 1) ; Auto close parens
(show-paren-mode 1)    ; Highlight parens

(global-set-key (kbd "M-o") #'other-window)

(setq mac-right-command-modifier 'control)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'exec-path (substitute-env-in-file-name "$HOME/.cargo/bin"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package flx)
(use-package smex)
(use-package ivy
  :demand
  :config
  (ivy-mode t))
;; (use-package evil
;;   :init
;;   (evil-mode t))

(use-package company
  :diminish
  :init
  (setq company-idle-delay 0.25)
  (global-company-mode t))

(use-package one-themes
  :init
  (load-theme 'one-dark 'no-confirm))

(use-package eglot
  :config
  (setq eglot-autoshutdown t))

(use-package rust-mode)

(use-package projectile
  :init
  :config
  (projectile-mode t)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(package-selected-packages
   '(smex flx projectile projectile-mode rust-mode eglot one-themes company use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

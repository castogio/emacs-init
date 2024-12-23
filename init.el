(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ranger move-text indent-guide focus speed-type timu-macos-theme elfeed ox-clip counsel ace-window which-key try org-bullets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; CUSTOM SETTINGS

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)

;; scratch buffer settings
(setq initial-scratch-message "")
(setq initial-major-mode 'org-mode)

;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; package management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; initialize use-package
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(use-package try
:ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; terminal session
(use-package multi-vterm
  :ensure t
  :commands (vterm))

;; org-mode tools
(add-hook 'org-mode-hook #'abbrev-mode)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode))

(use-package ox-clip
  :ensure t
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      (keymap-local-set "C-c w" 'ox-clip-formatted-copy))))

(defalias 'list-buffers 'ibuffer-other-window)

;; window state management
(winner-mode 1)

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)))

(use-package ivy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :custom
  (ivy-initial-inputs-alist nil)
  :config
  (progn
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key minibuffer-local-map
		(kbd "C-r")
		'counsel-minibuffer-history)
    ))

;; RSS/ATOM feed
(use-package elfeed
  :ensure t
  :bind ("C-x w e" . elfeed)
  :custom
  (elfeed-feeds
   '("https://www.reddit.com/r/StallmanWasRight.rss")))

;; programming tools
(use-package magit
  :ensure t)

;; tramp mode config
(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)

;; theme
(use-package timu-macos-theme
  :ensure t
  :config
  (load-theme 'timu-macos t))

;; set font
(set-face-attribute 'default nil
		    :family "JetBrains Mono Medium"
		    :height 110)


;; -------- PROGRAMMING ----------

;; highlight current line
(global-hl-line-mode t)

;; show column boundary
(add-hook 'emacs-lisp-mode-hook
	  #'display-fill-column-indicator-mode)
(add-hook 'python-mode-hook
	  #'display-fill-column-indicator-mode)

(use-package focus
  :ensure t
  :hook (emacs-lisp-mode . focus-mode)
  :hook (python-mode . focus-mode))

(use-package indent-guide
  :ensure t
  :config (set-face-background 'indent-guide-face
			       "background at point")
  :hook (emacs-lisp-mode . indent-guide-mode)
  :hook (python-mode . indent-guide-mode))
	 
(use-package move-text
  :ensure t
  :config (move-text-default-bindings))


;; -------- FILE NAVIGATION ----------
(use-package ranger
  :ensure t)

;; -------- RANDOM ----------

;; typing aid
(use-package speed-type
  :ensure t)


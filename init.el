(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elfeed ox-clip counsel ace-window which-key try org-bullets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; CUSTOM SETTINGS

(setq inhibit-startup-message t)
(tool-bar-mode -1)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
'("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(use-package try
:ensure t)

(use-package which-key
:ensure t
:config
(which-key-mode))


;; org-mode stuff
(use-package org-bullets
:ensure t
:config
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ox-clip
  :ensure t
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      (keymap-local-set "C-c w" 'ox-clip-formatted-copy))))

;; minibuffer hints
;; (setq indo-enable-flex-matching t)
;; (setq ido-everywhere t)
; (ido-mode 1)

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
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))

;; (setq
;;  newsticker-url-list-defaults nil ;; remove EmacsWiki
;;  newsticker-retrieval-interval 0 ;; do not retrieve if not requested
;;  newsticker-url-list
;;       '(
;; 	("Reddit - Stallman Was Right" "https://www.reddit.com/r/StallmanWasRight")
;; 	))

(use-package elfeed
  :ensure t
  :bind ("C-x w e" . elfeed)
  :custom
  (elfeed-feeds
   '("https://www.reddit.com/r/StallmanWasRight.rss")))

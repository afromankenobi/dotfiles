(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck docker-compose-mode dockerfile-mode evil goto-chg minitest org smooth-scrolling timu-caribbean-theme undo-fu undo-fu-session undo-tree vimrc-mode yaml yaml-mode zig-mode zoxide)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See package-archive-priorities
;; and package-pinned-packages. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(setq evil-undo-system 'undo-fu)

(require 'evil)
(evil-mode 1)

;; Orgmode
;; Must do this so the agenda knows where to look for my files
;; When a TODO is set to a done state, record a timestamp
;; Follow the links
(setq org-log-done 'time)
(setq org-return-follows-link t)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;; end Orgmode

(load-theme 'timu-caribbean t)
(setq display-line-numbers 'relative)
(global-display-line-numbers-mode 1)
(set-face-attribute 'default nil :font "MesloLGSDZ Nerd Font-13")

(global-visual-line-mode 1)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

(require 'ox-md)
(global-flycheck-mode +1)

(setq ido-enable-flex-matching t)
(ido-mode t)

(server-start)

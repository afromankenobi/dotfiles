(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes '(default))
 '(package-selected-packages
   '(0blayout alchemist dockerfile-mode elixir-mode elixir-ts-mode
	      elixir-yasnippets evil flycheck goto-chg kanagawa-theme
	      magit markdown-changelog markdown-mode minitest org
	      smooth-scrolling standard-themes timu-caribbean-theme
	      timu-macos-theme tomorrow-night-deepblue-theme trashed
	      undo-fu undo-fu-session undo-tree vimrc-mode yaml
	      yaml-mode zig-mode zoxide))
 '(ring-bell-function 'ignore)
 '(visible-bell nil))

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

(setq evil-undo-system 'undo-fu)
(use-package undo-fu-session
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))

(undo-fu-session-global-mode)

(require 'evil)
(evil-mode 1)

;; Orgmode configuration
(with-eval-after-load 'org
  (setq org-directory "~/orgfiles")
  (setq org-agenda-files (list (concat org-directory "/agenda.org")))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))

  (setq org-todos-file (concat org-directory "/todos.org"))
  (setq org-notes-file (concat org-directory "/notes.org"))
  (setq org-journal-file (concat org-directory "/journal.org"))

  (setq org-capture-templates
        `(("t" "Todo" entry (file+headline ,org-todos-file "Tasks")
           "* TODO %?\n  %U\n  %a")
          ("n" "Notes" entry (file+headline ,org-notes-file "Notes")
           "* %?\n  %U\n  %a")
          ("j" "Journal" entry (file+datetree ,org-journal-file)
           "* %?\nEntered on %U\n  %i\n  %a")))

  ;; Add a timestamp when a task is created with date and time
  (setq org-todo-keywords
        '((sequence "TODO(t!)" "WAITING(w@/!)" "NEXT(n!)" "|" "DONE(d@!/!)" "CANCELLED(c@/!)")))

  ;; Custom key bindings
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c l") 'org-store-link)

  (setq org-log-done 'time
        org-return-follows-link t
        org-log-into-drawer t
        org-log-redeadline 'time
        org-log-reschedule 'time)

  ;; Make evil play nice in org-mode
  (evil-define-key 'normal org-mode-map
    (kbd "TAB") 'org-cycle
    ">" 'org-shiftmetaright
    "<" 'org-shiftmetaleft)

  ;; Add all files into orgfiles to agenda.
  ;; I know that i'm messy, so try to prevent.
  (setq org-agenda-files (directory-files-recursively "~/orgfiles/" "\\.org$")))
;; end Orgmode

(solaire-global-mode +1)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-vibrant t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(set-face-attribute 'default nil :font "MesloLGSDZ Nerd Font-14")
(setq display-line-numbers 'relative)
(setq find-file-visit-truename t)
(setq ns-right-alternate-modifier nil)
(tab-bar-mode 1)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

(which-key-mode)

(require 'ox-md)
(global-flycheck-mode +1)

(setq ido-enable-flex-matching t)
(ido-mode t)

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

;; Backup files configuration
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq make-backup-files t)
(setq version-control t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq vc-make-backup-files t)

;; Instalar y configurar trashed
(unless (package-installed-p 'trashed)
  (package-refresh-contents)
  (package-install 'trashed))

(require 'trashed)
(setq delete-by-moving-to-trash t)

;; Función para mover archivos antiguos a la papelera
;; (defun my/cleanup-backup-files ()
;;   "Move old backup files to trash."
;;   (message "Cleaning up old backup files...")
;;   (let ((week (* 60 60 24 7))
;;         (current (float-time (current-time))))
;;     (dolist (file (directory-files "~/.emacs.d/backups" t))
;;       (when (and (backup-file-name-p file)
;;                  (> (- current (float-time (nth 5 (file-attributes file))))
;;                     week))
;;         (message "Trashing backup file: %s" file)
;;         (trashed-put file)))))
;; 
;; (run-at-time "2:00am" (* 24 60 60) 'my/cleanup-backup-files)

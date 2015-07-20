;;;; init.el


;; global defaults
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(load-theme 'wombat)

(show-paren-mode 1)

(setq inhibit-startup-message t)
(setq initial-scractch-message "")

(setq-default indent-tabs-mode nil)


;; packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
    (package-refresh-contents))


;; slime
(package-install 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))


;; magit
(package-install 'magit)

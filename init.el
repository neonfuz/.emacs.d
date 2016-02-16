(setq-default c-default-style "bsd"
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil
              js-indent-level 4
              show-trailing-whitespace t)

(add-to-list 'default-frame-alist '(font . "PragmataPro-10" ))
;;(set-face-attribute 'default t :font "PragmataPro-10" )

;;(icomplete-mode 99)
(column-number-mode t)

;; For nicer window movement
(windmove-default-keybindings)

;; Clean things up
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(linum-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (misterioso)))
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))

(put 'upcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "dim gray")))))
(put 'downcase-region 'disabled nil)


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(require 'yasnippet)
(yas-global-mode 1)

(require 'origami)
(global-set-key (kbd "<C-tab>") 'origami-forward-toggle-node)
(global-origami-mode)

(require 'ecb)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;; Helm stuff
;;(require 'helm-config)
;;(helm-mode 1)
;;(define-key global-map [remap find-file] 'helm-find-files)
;;(define-key global-map [remap occur] 'helm-occur)
;;(define-key global-map [remap list-buffers] 'helm-buffers-list)
;;(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(unless (boundp 'completion-in-region-function)
;;  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
;;  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
;;(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "/tmp/helm-cfg.el") (delete-file "/tmp/helm-cfg.el"))))


;; Key chords
;;(require 'key-chord)
;;(key-chord-mode 1)
;;(key-chord-define-global "hj" 'undo)

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c e") 'eval-and-replace)

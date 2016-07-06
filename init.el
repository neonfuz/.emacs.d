(setq-default c-default-style "bsd"
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil
              js-indent-level 2
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

(require 'editorconfig)
(editorconfig-mode 1)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(setq web-mode-engines-alist
      '(("ctemplate" . "\\.html\\'"))
)

(setq web-mode-markup-indent-offset 2)

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


(defun delete-current-file ()
  "Delete the file associated with the current buffer and close the buffer.
Also push file content to `kill-ring'.
If buffer is not file, just close it, and push file content to `kill-ring'.

URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2015-08-12"
  (interactive)
  (progn
    (kill-new (buffer-string))
    (when (buffer-file-name)
      (when (file-exists-p (buffer-file-name))
        (progn
          (delete-file (buffer-file-name))
          (message "Deleted: 「%s」." (buffer-file-name)))))
    (let ((buffer-offer-save nil))
      (set-buffer-modified-p nil)
      (kill-buffer (current-buffer)))))

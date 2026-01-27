(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(atom-one-dark-theme evil))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode 1)

(load-theme 'atom-one-dark t)

;; Ask
(autoload 'ask-mode "~/git/ask/emacs/ask.el" nil t)
(add-to-list 'auto-mode-alist '("\\.ask\\'" . ask-mode))
(with-eval-after-load 'ask-mode
    (set-face-attribute 'ask-secondary-keyword nil 
        :inherit 'font-lock-keyword-face
        :foreground nil
        :background nil
        :weight 'normal))

;; Agda 
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda --emacs-mode locate")))

;; (define-key evil-normal-state-map [mouse-2] 'agda2-goto-definition-mouse)
(add-hook 'agda2-mode-hook
          (lambda ()
            (when (bound-and-true-p evil-local-mode)
              (evil-local-mode -1))
            (setq-local evil-normal-state-map (make-sparse-keymap))
            (setq-local evil-insert-state-map (make-sparse-keymap))
            (setq-local evil-visual-state-map (make-sparse-keymap))
            (setq-local evil-motion-state-map (make-sparse-keymap))
            (mapc #'disable-theme custom-enabled-themes)
            (if (fboundp 'buffer-face-set)
                (buffer-face-set '(:family "JuliaMono"))
              ;; fallback if buffer-face isn't present
                (face-remap-add-relative 'default :family "JuliaMono"))))


;; Configure the c/c++ formatting
(require 'cc-mode)

;; Turn off the damn beeping
(setq ring-bell-function 'ignore)

                                        ; use c style comments in c++
(add-hook 'c++-mode-hook (lambda ()
                           (setq comment-start "/* " comment-end " */")))

;; set the default font
(set-face-attribute 'default nil :font "Source Code Variable 10")
;;(set-face-attribute 'default nil :font "Hack 10")

;; Look at the file path and apply linux style if contains 'linux'
(defun apply-linux-style ()
  (progn
    (c-set-style "Linux")
    (setq tab-width 8)
    (setq c-basic-offset 8)
    (setq indent-tabs-mode t)
    (c-set-offset 'arglist-intro '++)
    (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)
    (setq comment-style 'extra-line)))
(defun apply-my-style ()
  (progn
    (setq c-set-style "linux")
    (setq c-basic-offset 4)
    (setq tab-width 4)
    (setq-default tab-width 4)
    (setq-default indent-tabs-mode nil)
    (c-set-offset 'arglist-intro '++)
    ;; indent case statements properly
    ;; (c-set-offset 'case-label '+)
    ;; ok-labs style function alignment
    (c-set-offset 'arglist-cont-nonempty '++)))

;; If the filepath has 'linux' in it, use linux style
(defun maybe-linux-style ()
  (if (and buffer-file-name
           (string-match "CID660" buffer-file-name))
      (apply-linux-style)
    (apply-my-style)))
(add-hook 'c-mode-hook 'maybe-linux-style)
(add-hook 'c++-mode-hook 'maybe-linux-style)

(require 'whitespace)
;; show whitespace in shell files
(add-hook 'sh-mode-hook
          (lambda()
            (setq show-trailing-whitespace t)))

;; vhdl formatting
(add-hook 'vhdl-mode-hook
	  (lambda ()
	    (setq-default vhdl-basic-offset 2)
	    (setq show-trailing-whitespace t)
	    (setq whitespace-line-column 80)
	    (setq-default indent-tabs-mode nil)
            (setq whitespace-style '(face lines-tail tabs tab-mark))
	    (whitespace-mode t)
            (#'linum-on)))

(defun verilog-beautify ()
  (interactive)
  (verilog-pretty-expr)
  (verilog-pretty-declarations))

;; verilog formatting
(add-hook 'verilog-mode-hook
	  (lambda ()
	    ;; don't hijack my keys pls
	    (local-unset-key (kbd "C-;"))
            (local-set-key (kbd "C-c C-v") 'verilog-beautify)
            ;; Setup indentation levels
	    (setq-default verilog-indent-level 2)
	    (setq-default verilog-indent-level-behavioral 2)
	    (setq-default verilog-indent-level-module 2)
	    (setq-default verilog-indent-level-declaration 2)
            (setq verilog-auto-lineup 'all)
            ;; Auto new line after semicolon
            (setq verilog-auto-newline t)
            ;; Show trailing whitespace
	    (setq show-trailing-whitespace t)
            ;; Highlight part of line over 80 characters
	    (setq whitespace-line-column 80)
            ;; Use spaces not tabs
	    (setq-default indent-tabs-mode nil)
            ;; Set to nil to stop verilog-mode aligning lists to parens 
            (setq-default verilog-indent-lists nil)
            ;; Highlight tabs and enable whitespace mode.
	    (setq whitespace-style '(face lines-tail tabs tab-mark))
	    (whitespace-mode t)
            ;; turn linum mode on for verilog files
            (display-line-numbers-mode t)))


;; better xml formattting
(add-hook 'nxml-mode-hook
	  (lambda()
	    (setq show-trailing-whitespace t)
	    (setq-default tab-width 4)
            (setq sgml-basic-offset 4)
            (setq-default sgml-basic-offset 4)
            (setq tab-width 4)
	    (setq-default indent-tabs-mode nil)))

;; Python whitespace
(add-hook 'python-mode-hook
          (lambda () (setq show-trailing-whitespace t)))
(add-hook 'python-mode-hook
          (lambda ()
	    (setq tab-width 4)
            (setq whitespace-style '(face lines-tail))
            (whitespace-mode t)))


(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;; Deal with pesky whitespace
(add-hook 'c-mode-hook
          (lambda () (setq show-trailing-whitespace t)))
(add-hook 'c++-mode-hook
          (lambda () (setq show-trailing-whitespace t)))

;; highlight over 80
(add-hook 'c-mode-hook
          (lambda ()
            (setq whitespace-style '(face lines-tail tabs tab-mark))
            (whitespace-mode t)))
(add-hook 'c++-mode-hook
          (lambda ()
            (setq whitespace-style '(face lines-tail tabs tab-mark))
            (whitespace-mode t)))


;; better enter key behaviour
(define-key global-map (kbd "RET") 'newline-and-indent)

;; org mode
(setq org-agenda-include-diary t)

;; Spell check git commit messages
(add-hook 'git-commit-setup-hook
          (lambda ()
            (git-commit-turn-on-flyspell)))


;; Avy for jumping around visible characters
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-c C-SPC") 'avy-goto-line)
(global-set-key (kbd "C-c C-;") 'avy-kill-region)

;; Set global linenum and hl-line mode
;; (global-linum-mode 1)
;; (global-hl-line-mode 1)

;; auto enter matching parens
(electric-pair-mode 1)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; Save a desktop session!!
;;(desktop-save-mode 1)

;; Prompt on exit
(setq confirm-kill-emacs 'yes-or-no-p)

;; Ivy mode!
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "M-s o") 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c C-k") 'rg-file)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(define-key ivy-minibuffer-map (kbd "TAB") 'ivy-call)
;; increase the popup window height
(setq ivy-height 25)
(setq ivy-count-format "%d/%d: ")



;; custom rg wrapper for searching for vhdl
(defun rg-vhdl ()
  (interactive)
  (counsel-rg nil nil "--type vhdl" "rg-vhdl"))

;; custom rg wrapper for searching for verilog
(defun rg-verilog ()
  (interactive)
  (counsel-rg nil nil "--type verilog" "rg-verilog"))

;; custom wrapper for searching for a certain file type
(defun rg-file ()
  (interactive)
  (let ((file-type (read-string "File type ")))
    (counsel-rg
     nil
     nil
     (format "--type %s" file-type)
     (format "rg-%s" file-type))))

;; provide all the options
(defun rg-generic ()
  (interactive)
  (let ((file-type (read-string "Options ")))
    (counsel-rg
     nil
     nil
     (format "%s" file-type)
     "rg-generic")))

;; Show the filepath of the current buffer, pretty handy
(defun display-name-of-file ()
  (interactive)
  (message (buffer-file-name)))

(global-set-key (kbd "C-c b") 'display-name-of-file)
(global-set-key (kbd "M-z") 'avy-zap-up-to-char)
(global-set-key (kbd "<f5>") 'magit-status)
(global-set-key (kbd "C-x v l") 'magit-log-buffer-file)
(global-set-key (kbd "C-x v =") 'magit-diff-buffer-file)

;;(global-set-key (kbd "<f2>") 'other-window)
(global-set-key (kbd "<f2>") 'ace-window)

;; automatically balance windows when splitting
(defun auto-balance-windows ()
  (interactive)
  (split-window-right)
  (balance-windows))

(defun close-auto-balance ()
  (interactive)
  (delete-window)
  (balance-windows))

;; automatically balance the windows when splitting vertically (more like vim)
(global-set-key (kbd "C-x 3") 'auto-balance-windows)
(global-set-key (kbd "C-x 0") 'close-auto-balance)

;; Function to calculate memory offsets,
;; base - base address
;; size - partition size in Mb
(defun calc-mem (base size)
  (+ base (* 1024 1024 size)))


;; Copy the whole line if nothing is selected
(defun my-kill-ring-save (beg end)
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-beginning-position 2))))
  (kill-ring-save beg end))
(global-set-key [remap kill-ring-save] 'my-kill-ring-save)

;; unbind control z to stop accidentally exiting emacs
;;(global-unset-key (kbd "C-z"))

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;;(set-terminal-parameter nil 'background-mode 'light)


;; show column numbers in the bar
(setq column-number-mode t)

;; Mouse and clipboard support
(setq select-enable-clipboard t)
(setq select-enable-primary t)

(require 'moe-theme)
(moe-dark)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("a5956ec25b719bf325e847864e16578c61d8af3e8a3d95f60f9040d02497e408" default)))
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (treemacs avy-zap ace-window ivy-hydra ninja-mode gruvbox-theme evil wgrep rust-mode zzz-to-char moe-theme magit counsel ace-jump-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; init-basic.el
;; A barebones emacs init file for beginners. Removes most common annoyances.
;;
;;==============================================================================
;;  PRELIMINARIES
;;==============================================================================
;; packages for Emacs 24

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))


;; M-x customize-* settings location.
;; Create a custom.el file and set before using M-x customize, or else you
;; litter the init.el file

;; (setq custom-file "~/.emacs.d/custom-24.el")
;; (load custom-file)


;;(elpy-enable)
;;(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;;(define-key global-map (kbd "C-c o" 'iedit-mode)

;; your info here
(setq user-full-name "Tyler James Burch"
      user-mail-address "burcht11@gmail.com")

(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-linux* (member system-type '(gnu gnu/linux gnu/kfreebsd)))

;;==============================================================================
;;  KEYBINDINGS
;;==============================================================================
;; fix modifier keys on Mac GUI (carbon emacs)
;; Assume caps is mapped to control
(setq
 ns-command-modifier 'meta              ; L command -> C
 ns-option-modifier 'meta               ; L option -> m
 ;; ns-control-modifier 'super          ; L control -> super
 ;; ns-function-modifier 'hyper         ; fn -> super
 ns-function-modifier 'super

 ;; right hand side modifiers
 ns-right-command-modifier 'super       ; R command -> super
 ns-right-option-modifier 'hyper        ; R option -> hyper
 )

(global-set-key (kbd "M-/") 'hippie-expand) ; replace default expand command

;;==============================================================================
;; STARTUP, UI, AND GENERAL SETTINGS
;;==============================================================================
;;------------------------------------------------------------------------------
;; Mac open new files in the existing frame
(setq ns-pop-up-frames nil)

;;------------------------------------------------------------------------------
;; Show time on the mode line
(display-time)

;;------------------------------------------------------------------------------
;; Saves backup files ( ~ and # files) to /tmp/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;------------------------------------------------------------------------------
;; Kill UI cruft
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; want menu bar only in guis, it's useless on the terminal anyways
(cond ((not window-system)
       (menu-bar-mode -1)))

;; No cursor blink
(blink-cursor-mode 0)

;;------------------------------------------------------------------------------
;; Load stuff
(eval-when-compile (require 'cl))
;;(load 'saveplace)                       ; save last loc in file
;;(load 'ffap)                            ; Finding Files and URLs at Point
;;(load 'uniquify)                        ; unique buffer titles
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; dired jump to current file dir with C-x C-j
(autoload 'dired-x "dired-x")

;;------------------------------------------------------------------------------
;; Completion modes, etc
;; Use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; isearch buffer switching
(iswitchb-mode 1)
(icomplete-mode 1)

;; ido
(autoload 'ido "ido")

(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

;;------------------------------------------------------------------------------
;; Fix Emacs interface annoyances
;; Global settings for ALL BUFFERS
(setq-default
 ;;---------------------------;;
 ;; GLOBAL INTERFACE SETTINGS ;;
 ;;---------------------------;;

 ;; Kill the splash screen and all that garbage
 inhibit-splash-screen t
 inhibit-startup-message t
 inhibit-startup-screen t
 inhibit-startup-buffer-menu t
 initial-scratch-message ""
 menu-prompting nil
; confirm-kill-emacs 'y-or-n-p           ; Ask before exit - takes a while to load, y'know?

 display-warning-minimum-level 'error   ; Turn off annoying warning messages
 disabled-command-function nil          ; Don't second-guess advanced commands

 ;; Mode line customizations
 line-number-mode t
 column-number-mode t

 ;; Scrolling
 scroll-preserve-screen-position t      ; scrolling does not move cursor
 mouse-wheel-mode t                     ; use wheel
 echo-keystrokes 0.1

 redisplay-dont-pause t                 ; smooth scrolling
 scroll-margin 1
 scroll-step 1
 scroll-conservatively 10000
 scroll-preserve-screen-position 1
 mouse-wheel-follow-mouse 't
 mouse-wheel-scroll-amount '(1 ((shift) . 1))

 ;; Buffer handling
 save-place t
 save-place-forget-unreadable-files t
 uniquify-rationalize-file-buffer-names t
 uniquify-buffer-name-style 'forward
 buffers-menu-sort-function 'sort-buffers-menu-by-mode-then-alphabetically ; Buffers menu settings
 buffers-menu-grouping-function 'group-buffers-menu-by-mode-then-alphabetically
 buffers-menu-submenus-for-groups-p t
 ibuffer-default-sorting-mode 'filename/process

 ;; Syntax highlighting: font lock mode
 font-lock-use-fonts '(or (mono) (grayscale))    ; Maximal syntax highlighting
 font-lock-use-colors '(color)
 font-lock-maximum-decoration t
 font-lock-maximum-size nil
 font-lock-auto-fontify t

 ring-bell-function 'ignore             ; stfu and stop beeping. you ain't vim.

 ;;-------------------------;;
 ;; GLOBAL EDITING SETTINGS ;;
 ;;-------------------------;;

 ;; integrate with the system clipboard ffs
 x-select-enable-clipboard t
 ;; set initial major mode to be text
 initial-major-mode 'fundamental-mode
 ;; Increase number of undo
 undo-limit 1000
 ;; default fill-column is 80 chars
 fill-column 100
 ;; English spelling, thanks
 ispell-dictionary "english"

 ;; Tabs and indentation and whitespace
 ;; tabs to spaces by default
 ;; indent-tabs-mode nil

 ;; Default tab display is 4 spaces
 tab-width 4

 ;; default insert is also 4 and inc of 4
 ;; got to specify this or it will continue to expand to 8 spc
 tab-stop-list (number-sequence 4 120 4)

 ;; highlight the whole expression when closing parens
 ;; show-paren-style 'expression

 ;; No newlines at end of buffer unless I press return
 next-line-add-newlines nil

 ;; sentences end with one space only.
 sentence-end-double-space nil

 ;; FORCE FILES TO BE UTF-8 and LF damn it
 buffer-file-coding-system        'utf-8-unix
 default-file-name-coding-system  'utf-8-unix
 default-keyboard-coding-system   'utf-8-unix
 default-process-coding-system    '(utf-8-unix . utf-8-unix)
 default-sendmail-coding-system   'utf-8-unix
 default-terminal-coding-system   'utf-8-unix

 ;; flyspell
 flyspell-issue-welcome-flag nil
 ispell-list-command "list"
 ) ;; end setq-default

;; Redefine startup messasge, replace the string with whatever you want
(defun startup-echo-area-message ()
  "Emacs ready.")

;; y/n prompts instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; normal delete key behaviour please
(delete-selection-mode t)               ; highlight selection and overwrite
(transient-mark-mode t)

;; line numbers
(global-linum-mode t)
(autoload 'linum "linum-mode")
(eval-after-load "linum"
  ;; one space separation, even in terminal
  (setq linum-format "%d "))

;; Cleanup file on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;------------------------------------------------------------------------------
;; Fonts (face) customization
(autoload 'faces "fonts")
(when (and (window-system) *is-a-mac*)
  (set-face-attribute 'default nil
		      :font "Monaco"
		      :height 120    ; default font size is 12pt on carbon emacs
		      :weight 'normal
		      :width 'normal))

(when (and (window-system) *is-linux*)
  (set-face-attribute 'default nil
		      :font "Monospace-10"
		      :height 100
		      :width 'normal))

;;------------------------------------------------------------------------------
;; No popups and dialogues. They crash carbon emacs.
;; Not to mention that they're incredibly annoying.
(defadvice y-or-n-p (around prevent-dialog activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
;; Fallback. DIE, DIALOGUE BOXES, DIE!!
(setq use-dialog-box nil)

;;------------------------------------------------------------------------------
;; File formatting. yuck crlf
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;;------------------------------------------------------------------------------
;; flyspell - aspell is better
(if *is-a-mac*
    (setq-default ispell-program-name "/opt/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))

(set-language-environment "UTF-8")

;;==============================================================================
;; PLAIN TEXT AND DOCUMENT MODES
;;==============================================================================
(add-hook 'text-mode-hook
	  (lambda ()
	    (linum-mode 0)
	    (visual-line-mode 1)
	    (setq
	     ;; tabs to spaces in text mode
	     indent-tabs-mode nil
	     ;; Default tabs in text is 4 spaces
	     tab-width 4
	     ;; default insert is also 4 and inc of 4
	     ;; got to specify this or it will continue to expand to 8 spc
	     tab-stop-list (number-sequence 4 120 4)
	     )
	    ;; ask to turn on hard line wrapping
;	    (when (y-or-n-p "Hard wrap text?")
;		(turn-on-auto-fill)
;		)
	  ))

;;==============================================================================
;; PROGRAMMING MODES
;;==============================================================================
;;------------------------------------------------------------------------------
;; C family common settings
;;------------------------------------------------------------------------------
;; cc-mode hooks in order:
;; 1. c-initialization-hook, init cc mode once per session (i.e. emacs startup)
;; 2. c-mode-common-hook, run immediately before loading language hook
;; 3. then language hooks:
;;    c, c++, objc, java, idl, pike, awk

(defun my-c-indent ()
  (setq
   ;; set correct backspace behaviour
   ;; c-backspace-function 'backward-delete-char
   ;; c-type lang specifics. want 4-space width tab tabs
   c-basic-offset 4
   c-indent-tabs-mode t               ; tabs please (change t to nil for spaces)
   c-indent-level 4
   c-tab-always-indent t
   tab-width 4
   ;; use tabs, not spaces.
   indent-tabs-mode t))

(add-hook 'c-initialization-hook
	  (lambda ()
	    (my-c-indent)             ; just to be sure
	    (setq-default c-default-style '((c-mode     . "linux")
					    (c++-mode   . "k&r")
					    (java-mode  . "java")
					    (awk-mode   . "awk")
					    (other      . "free-group-style")))
	    (add-to-list 'c-cleanup-list 'comment-close-slash)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (my-c-indent)
	    ;; subword editing and movement to deal with CamelCase
	    (c-toggle-electric-state 1)
	    (subword-mode 1)
	    (c-toggle-auto-newline 1)
	    ;; don't indent curly braces. gnu style is madness.
	    (c-set-offset 'statement-case-open 0)
	    (c-set-offset 'substatement-open 0)
	    (c-set-offset 'comment-intro 0)))
;; Assembly
(add-hook 'asm-mode-hook
	  (lambda ()
	    (auto-complete-mode 0)
	    (setq-local asm-comment-char ?\!)
	    (setq-local tab-width 8)
	    (setq-local tab-stop-list (number-sequence 8 120 8))
	    (setq-local indent-tabs-mode t)))

;; C
(autoload 'ac-c-headers "ac-c-headers")
(add-hook 'c-mode-hook
	  (lambda ()
	    (matt/c-indent)
	    (add-to-list 'ac-sources 'ac-source-c-headers)
	                (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (doom-molokai)))
 '(custom-safe-themes
   (quote
	("9f3181dc1fabe5d58bbbda8c48ef7ece59b01bed606cfb868dd147e8b36af97c" "34c6da8c18dcbe10d34e3cf0ceab80ed016552cb40cee1b906a42fd53342aba3" "227e2c160b0df776257e1411de60a9a181f890cfdf9c1f45535fc83c9b34406b" default)))
 '(package-selected-packages
   (quote
	(elpy magit doom fountain-mode evil doom-themes auctex)))
 '(vc-annotate-background "#000000")
 '(vc-annotate-color-map
   (quote
	((20 . "#B6E63E")
	 (40 . "#c4db4e")
	 (60 . "#d3d15f")
	 (80 . "#E2C770")
	 (100 . "#ebb755")
	 (120 . "#f3a73a")
	 (140 . "#FD971F")
	 (160 . "#fb713a")
	 (180 . "#fa4b56")
	 (200 . "#F92672")
	 (220 . "#f33260")
	 (240 . "#ed3f4e")
	 (260 . "#E74C3C")
	 (280 . "#dd6a60")
	 (300 . "#d38885")
	 (320 . "#c9a6aa")
	 (340 . "#C0C5CF")
	 (360 . "#C0C5CF"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1D1F20" :foreground "#D6D6D4" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Noto Mono for Powerline")))))

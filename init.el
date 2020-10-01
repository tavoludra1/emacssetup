
;;========== Visual - Interfaz de Usuario  ==============

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)


;; tipo de letra
(set-face-attribute 'default nil :font "Fira Code" :height 130)


;; THEME
(load-theme 'tango-dark)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; Numbers line
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))



;; Delimitadores con colores para los parentesis en idioma LIPS
;; hay que activarlo despues de instalarlo ->  M-x rainbox-delimiters-mode

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



;; =========== PACKAGES ===========

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)



;;============ BUFFER ===============

;; M-x counsel {buscar lo que necesita}

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))


;; Herramienta de atajos para el buffer y busquedas

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Package DoomLine -> permite personalizar muchas cosas de la vista del editor, con iconos

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15))) ;; personaliza la barra inferior y le agrega iconos

;; Package Which-key -> crea un panel en el buffer con la identidicacion de las teclas: C-x  C-h

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


;; Package Ivy-rich -> para conocer la informacion de las funciones que estan en el buffer

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;;============== Conocer el nucleo de las funciones =======================
;; Es importante saber como esta construida la funcion utilizamos: M-x M-o y la letra que necesita
;; No modificar nada cuando se explora, puede producir errores en EMACS
;;=========================================================================

;; Un mejor sistema de ayuda de EMACS
;; Package Helpul
;; C-h f -> Describe functions: encuentra la ayuda sobre las funciones que esta utilizando


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))



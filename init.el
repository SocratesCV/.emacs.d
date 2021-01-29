;; init.el                                   
;; Archivo de configuración de emacs
;; Autor: Socrates.C.V.


;; Añadimos algunos repositorios
(require 'package)  ; Le pedimos a emacs que cargue la variable 'package
(setq package-archives
      '(("org" . "http://orgmode.org/elpa/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

(package-initialize) ; inicializa el paquete



(defun load-user-file (file) (interactive "f")
  "Load a file in current user's configuration directory"
  ;; (load-file (expand-file-name file user-init-dir)))
  (load-file (expand-file-name file "~/.emacs.d")))


;;-------------
;; use-package
;;-------------
;; use-package permite cargar un paquete solo cuando se utiliza el atajo de teclado.
;; así permite la carga más rápida de emacs.
;; Es posible ejecutar un código antes de cargar un paquete usando "init"
;; Y para ejecutarlo después se utiliza "config"
;; Por ejemplo se puede presentar un mensaje: " (message "Loading Magit!")"
;; También se puede hacer que se cargue al iniciar un modo con ":mode"


;; Bootstrap 'usepackage
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; Set the path variable
(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))



;; --------------------------------------
;; Pulsando C-x o aparecen unas letras en las esquinas de las
;; ventanas (las definidas debajo), y mediante esas techas se
;; accede rapidamente a las ventanas.
;;---------------------------------------
(use-package ace-window
  :ensure t
  :bind
  ("C-x o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f)))


;; ------------------------------------
;; multi1ple-cursors
;; Para seleccionar verticalmente
;;-------------------------------------
(use-package multiple-cursors
  :ensure t
  :bind (
	 ("C-S-c C-S-c" . mc/edit-lines)
	 ("M->" . mc/mark-next-like-this)
	 ("M-<" . mc/previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))


;;--------------------------------------------------------
;; undo-tree
;; Este paquete se utiliza para poder deshacer multiples
;; acciones.
;; "C-x u" para ver el arbol
;; "p" ó "n" para subir y bajar (o las flechas)
;; "q" para salir dejando el seleccionado.
;;-------------------------------------------------------
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))


;;------------------------------------
;; auto-complete
;; activa el autocompletado. 
;;------------------------------------
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;;------------------------------------------------
;; Paquete Which-key
;; para tener ayuda con los prefijos de comandos
;; -----------------------------------------------
(use-package which-key
  :diminish
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1))


;;-------------------------------------------
;; doom-acario-dark
;; cambiamos el tema
;; configuramos algunos parámetros de neotree
;;-------------------------------------------
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-acario-dark t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))



;------------------------------------------------
; modeline
; Modificamos el modeline
; This package requires the fonts included with all-the-icons to be installed. Run M-x all-the-icons-install-fonts
; Un paquete muy recomendable esteticamente.
;------------------------------------------------

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; paquete necesario para doom-modeline
;; Importante:
;; hay que instalar las fuentes con el comando:
;; M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)



;;-------------------------------------------------------------
;; Configuraciones del entorno.
;;-----------------------------------------------------------------

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;;Maximizar la ventana al abrir Emacs

;; Eliminar pantalla de bienvenida
(setq inhibit-startup-message t) 

;; Eliminar la barra de menús
(menu-bar-mode -1) 

;; Eliminar la barra de herramientas
(tool-bar-mode -1) 

;; Numerar las líneas del archivo
(global-linum-mode t) 

;; Poner el nº de columna en la barra de estado
(column-number-mode t) 

;; Activar el Wrap (las líneas largas no se adaptan al tamaño de la pantalla)
(setq-default truncate-lines -1) 

;; Destacar la línea actual.
(global-hl-line-mode +1) 

;; Desactivar la barra de scroll
(scroll-bar-mode -1) 

;;Cuando el modo Tooltip está deshabilitado,
;;Emacs muestra el texto de ayuda en el
;; área de eco, en lugar de hacer una ventana emergente.
(tooltip-mode -1)

;; Hora 
(display-time) ; muestra el rekoj
(setq display-time-24hr-formatq t) ; Muestra el reloj en formato 24h
(setq display-time-format "%H:%M"); Le da formato a la hora



;; ********************************************************************
;; Establecer fuente y tamaño, comprobar que está en el sistema.
;; (set-face-attribute 'default nil :font "Monaco-16")

;;---------------------------------------------------------
;; Configuración de funcionamiento
;;--------------------------------------------------------

;;--------------------------------------------------------------------------
;; Muestra una pantalla a la derecha principalmente con las teclas activas
;; pero si no hay sitio lo pondrá en la parte de abajo.
;; Hay otras configuraciones que lo ponen sólo a la derecha o solo abajo.
;;--------------------------------------------------------------------------
(which-key-setup-side-window-right-bottom)

;; Reemplazar "yes" y "no" por "y" y "n"
(setq yes-or-no-p 'y-or-n-p)

;; Pedir confirmación para salir de emacs
 ;(setq confirm-kill-emacs 'y-or-n-p)

;; (setq delete-by-moving-to-trash t
;; trash-directory "~/.local/share/Trash/files") ;; Mover a la papelera al borrar archivos y directorios
;; (setq desktop-save-mode t) ;; guardar la sessión al cerrar emacs y restaurarla

;;Moverse entre ventanas con Shift-flechas
;; Let me switch windows with shift-arrows instead of "C-x o" all the time
(windmove-default-keybindings)

;; Borra algo seleccionado al escribir encima
(delete-selection-mode 1) 

;; Guarda las copias de seguridad en el directorio ...
(setq backup-directory-alist '(("." . "~/.saves"))) 

;; Señala el paréntesis hermano
(show-paren-mode 1) 

;; Cierra automaticamente los paréntesis y los corchees.
(electric-pair-mode 1)

;; Resaltar la línea activa.
(global-hl-line-mode 1)
;; Color de la línea activa
;; Puedes ver la lista de colores con el comando: M-x list-colors-display
;; O poner cualquier color en hexadecimal
;;(set-face-background 'hl-line "SteelBlue4")
;;(customize-face 'hl-line "underline")

;; ido-mode muestra archivos y bufers en la barra de modo.
;; uno de los 
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Definición teclas
;; (global-set-key (kbd "C-c c") 'flyspell-mode) ;; Activar/desactivar automáticamente corrector con C-c c:

;; projectile
;; paquete para la gestión de proyectos.
;; para activarlo le asignamos ese atajo de teclado. ("C-x p")


;; (use-package projectile
;;   :ensure t
;;   :config
;;   (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
;;   (projectile-mode +1))

;; (use-package helm-projectile
;;   :ensure t
;;   :config (helm-projectile-on))


;;-------------------------------------------------
;; Dashboard
;; Pantalla de inicio, con archivos abiertos anteriormente,
;; marcadores y la agenda.
;; https://github.com/emacs-dashboard/emacs-dashboard
;;---------------------------------------------------------
;;(add-to-list 'dashboard-items '(agenda) t)
(use-package dashboard
  :ensure t
  :init
  (progn
    ;; Para personalizar que widgets y cuantos se muestran.
    (setq dashboard-items '((recents . 8) 
			    (projects . 3)
			    (bookmarks . 5)
			    (agenda . 5)
			    (registers . 1)))
    ;; Añadir iconos a los widgets y los elementos.
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)

    ;; Cambiar el logo de la pantalla de bienvenida.
    (setq dashboard-startup-banner "~/.emacs.d/banners/pinguinlogo.png")

    ;; Establecer el título
    (setq dashboard-banner-logo-title "Bienvenido a mi emacs 2")

    ;; Mostrar los accesos directos.
    (setq dashboard-show-shortcuts t)
    
    ;; Centrar (t) o no (nil) el contenido.
    (setq dashboard-center-content t)

    (setq dashboard-week-agenda t))

    (setq dashboard-set-navigator t)

    ;; Enlaces de navegación debajo del logo.
 (setq dashboard-navigator-buttons
   `(
     ((,(and (display-graphic-p)
             (all-the-icons-faicon "github" :height 1.3 :face 'all-the-icons-orange))
       "Homepage"
       "https://github.com/Socracv"
       (lambda (&rest _) (browse-url "homepage")))
      (,(and (display-graphic-p)
             (all-the-icons-material "save" :height 1.3 :face 'all-the-icons-green))
       "Previous session"
       "Restore previous session"
       (lambda (&rest _) (desktop-read)))
      (,(and (display-graphic-p)
             (all-the-icons-material "autorenew" :height 1.3 :face 'all-the-icons-yellow))
       "Restart"
       "Restar emacs"
       (lambda (&rest _) (Restart.emacs))))))
  (setq dashboard-set-footer t)
  (setq dashboard-footer-messages (list (format "Powered by Socrates C.V., %s" (format-time-string "%Y"))))
  (setq dashboard-footer-icon (cond ((display-graphic-p)
                                (all-the-icons-faicon "code" :height 1  :face 'all-the-icons-red))
                               (t (propertize ">" 'face 'font-lock-doc-face))))
    

   :config
   (dashboard-setup-startup-hook))


;; -------------------------------------------------------------
;; treemacs
;; Muestra un árbol de directorios en el lateral de la pantalla.
;;
;;------------------------------------------------------------
(use-package treemacs
  :ensure t
  ;; Lo activamos mediante la tecla [f8]
  :bind
     (:map global-map
	([f8] . treemacs)
	("C-<f8>" . treemacs-select-window))
  :config
  (setq treemacs-is-ever-other-window t))


;; ---------------------------------------------------------------
;; Bookmarks
;; Son como accesos directos a directorios o archivos.
;; Aquí espacificamos el archivo dónde se guardarán
;; Y ponemos que se guarden cuando se modifique, sino
;; tendríamos que poner *M-x bookmark-save*
;;---------------------------------------------------------

;; Archivo donde se guardará
(setq bookmark-default-file "~/.emacs.d/my-bookmarks")
;; Guardar cuando se modifique
(setq bookmark-save-flag 1)
;; Así ya nos aparecerán en el dashboard


;; ---------------------------------------------------------
;; expand-region
;; Permite mediante una combinación de teclas ampliar o
;; disminuir la región seleccionada.
;; un paquete muy útil.
;; Utilizamos "C-+" y "C--", aunque la que viene en la
;; documentación es "C-=" pero es menos accesible en español.
;; ---------------------------------------------------------

(use-package expand-region
  :ensure t
  :bind
  ("C-+" . er/expand-region)
  ("C--" . er/contract-region))



;; ------------------------------------------------------------
;; Centaur tabs
;; ------------------------------------------------------------
;; Añadir pestañas.
(setq centaur-tabs-set.bar 'over ;; Ponemos una barra debajo del archivo activo.
      centaur-tabs-set-icons t  ;; Muestra los iconos del thema.
      centaur-tabs-gray-out-icons 'buffer ;; Atenua los iconos de las pestañas no seleccionadas.
      centaur-tabs-height 24 ;; Para cambiar la altura de la pestaña
      centaur-tabs-set-modified-market t ;; Cambia el indicador de que se ha modificado el buffer.
      centaur-tabs-modifier-marker "*") ;; Cambia el caracter cuando se ha modificado ese buffer.

;;  (centaur-tabs-headline-match) ;; apariencia uniforme
;;  (centaur-tabs-mode t)


;; ------------------------------------------------------------
;; org settings
;; ------------------------------------------------------------

;; Ponemos bolibullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()(org-bullets-mode 1))))

;; para poder seleccionar con shift+flechas 
(setq org-support-shift-select t)

;; Bloques de código
(org-babel-do-load-languages
   'org-babel-load-languages
   '( (python . t)
       (emacs-lisp . t)))

;; Añadimos el código para emacs-lips con (<el)
(add-to-list 'org-structure-template-alist
               '("m" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC" "<src lang=\"emacs-lisp\">\n?\n</src>"))

;; Añadimos el código para python con (<p)
(add-to-list 'org-structure-template-alist
 	     '("p" "#+BEGIN_SRC python -n :results output pp replace :exports both\n?\n#+END_SRC"))


;; Para poder añadir bloques de estructuras mendiante [<s] o la letra que corresponda.
(require 'org-tempo)

;; Añadimos bloques de estructuras de diferentes tipos de código. Se utilza pulsando [C-c C-,]
(setq org-structure-template-alist
  '(("a" . "export ascii\n")
    ("c" . "center\n")
    ("C" . "comment\n")
    ("e" . "example\n")
    ("E" . "export")
    ("h" . "export html\n")
    ("l" . "export latex\n")
    ("q" . "quote\n")
    ("s" . "src")
    ("v" . "verse\n")))



;; --------------------------------------------------------
;; Otros paquetes
;; -------------------------------------------------------

(use-package python-mode
   :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(python-mode org-bullets which-key use-package undo-tree treemacs theme-changer multiple-cursors helm-projectile expand-region exec-path-from-shell doom-themes doom-modeline dashboard auto-complete)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:extend t :underline t :underline "gold3")))))


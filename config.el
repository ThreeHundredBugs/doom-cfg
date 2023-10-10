;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Dmitry Leonov"
      user-mail-address "lnvdmitry@protonmail.com")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 13))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
(setq doom-font (font-spec :family "Fira Code" :size 13 :weight 'medium))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (load-theme 'doom-ephemeral t)
(setq doom-theme 'doom-flatwhite)
      ;; 'light-blue
      ;;'doom-tokyo-night

(with-eval-after-load 'doom-themes
  (doom-themes-neotree-config))

(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'over)
(setq centaur-tabs-close-button "X")
(setq centaur-tabs-set-modified-marker t)

(setq doom-themes-neotree-file-icons t)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to l      ook up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq neo-smart-open t)

;;;;;;;;;
;;;;;;;;;
;;;;;;;;;
;; accept completion from copilot and fallback to company

;; (use-package! jsonrpc)

; complete by copilot first, then company-mode
;; (defun my-tab ()
;;   (interactive)
;;   (or (copilot-accept-completion)
;;       (company-indent-or-complete-common nil)))

;; ; modify company-mode behaviors
;; (with-eval-after-load 'company
;;   ; disable inline previews
;;   (delq 'company-preview-if-just-one-frontend company-frontends)
;;   ; enable tab completion
;;   (define-key company-mode-map (kbd "<tab>") 'my-tab)
;;   (define-key company-mode-map (kbd "TAB") 'my-tab)
;;   (define-key company-active-map (kbd "<tab>") 'my-tab)
;;   (define-key company-active-map (kbd "TAB") 'my-tab))
(setq display-line-numbers-type 'absolute)

(global-set-key (kbd "C-:") 'clojure-toggle-keyword-string)
(global-set-key (kbd "M-<up>") 'paredit-raise-sexp)
(global-set-key (kbd "M-<down>") 'paredit-wrap-sexp)
(global-set-key (kbd "M-<left>") 'paredit-backward-slurp-sexp)
(global-set-key (kbd "M-S-<left>") 'paredit-forward-barf-sexp)
(global-set-key (kbd "M-<right>") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "M-S-<right>") 'paredit-backward-barf-sexp)
(map! :leader
      :desc "Kill function"
      "k f" #'paredit-kill)
(global-set-key (kbd "S-<right>") 'paredit-forward-up)
(global-set-key (kbd "S-<left>") 'paredit-backward-up)

;; (global-set-key (kbd "SPC /") 'consult-ripgrep)
;; (map! :bind (("s-S-<right>") . 'paredit-forward-barf-sexp))
;; (global-set-key (kbd " k f") 'paredit-splice-sexp)
;; (map! (("SPC k f" . 'paredit-forward-slurp-sexp)))

(map! :leader
      :desc "Search im project"
      "/" #'consult-ripgrep)

(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))

(use-package blox
  :bind (:map lua-prefix-mode-map
              ("s" . blox-prompt-serve)
              ("b" . blox-prompt-build)
              ("t" . blox-test)))

;; persist-scope
(defun clj-insert-persist-scope-macro ()
  (interactive)
  (insert
   "(defmacro persist-scope
              \"Takes local scope vars and defines them in the global scope. Useful for RDD\"
              []
              `(do ~@(map (fn [v] `(def ~v ~v))
                  (keys (cond-> &env (contains? &env :locals) :locals)))))"))


(defun persist-scope ()
  (interactive)
  (let ((beg (point)))
    (clj-insert-persist-scope-macro)
    (cider-eval-region beg (point))
    (delete-region beg (point))
    (insert "(persist-scope)")
    (cider-eval-defun-at-point)
    (delete-region beg (point))))

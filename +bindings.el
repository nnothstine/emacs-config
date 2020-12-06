;;; +bindings.el -*- lexical-binding: t; -*-

(map!
 (:leader
  (:desc "kill" :prefix "k"
   :desc "delete-window"           :n "k" #'delete-window
     :desc "doom/kill-other-buffers" :n "B" #'doom/kill-other-buffers)))

(map!
 (:leader
   :desc "Open vertical split" :n "v" #'evil-window-vsplit
   :desc "Open vertical split" :n "|" #'evil-window-split))

(map!
 ;; movement
 "s-h"    #'evil-window-left
 "s-l"    #'evil-window-right
 "s-j"    #'evil-window-down
 "s-k"    #'evil-window-up)

;; Files
(map!
 :leader
 (:desc "Edit" :prefix "e"
  :desc "Edit .zshrc" :n "z" (cmd! (find-file "~/.dotfiles/shell/zsh/.zshrc"))
  :desc "Edit journal" :n "j" (cmd! (find-file "~/org/journal.org"))))


(map!
 (:leader
   (:desc "Edit" :prefix "e"
     :desc "Create new snippet" :n "s" #'+snippets/new
     :desc "Edit snippet" :n "e" #'+snippets/find
     :desc "Find snippet" :n "f" #'+snippets/find))
 (:after yasnippet
   (:map yas-keymap
     "C-e"           #'+snippets/goto-end-of-field
     "C-a"           #'+snippets/goto-start-of-field
     "<M-right>"     #'+snippets/goto-end-of-field
     "<M-left>"      #'+snippets/goto-start-of-field
     "<M-backspace>" #'+snippets/delete-to-start-of-field
     [backspace]     #'+snippets/delete-backward-char
     [delete]        #'+snippets/delete-forward-char-or-field)
   (:map yas-minor-mode-map
     :ig "<tab>" yas-maybe-expand
     :v  "<tab>" #'yas-insert-snippet)))

(use-package! dired
  :init
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))
  :config
  (map!
   :n "-" #'dired-jump
   :map dired-mode-map
   :n "-" #'dired-up-directory
   :n "q" (cmd! (quit-window t))))


(map!
 (:map help-mode-map
   :n "q"   #'quit-window))

(map!
 :i "TAB" #'+company/complete
 ;; TODO: Need a more generic mechanism of doing this to allow for four or two tabs
 :i "M-TAB" (lambda () (interactive) (insert "\s\s")))

(map!
 (:after company
   (:map company-active-map
     ;; Don't interfere with `evil-delete-backward-word' in insert mode
     "C-w"        nil

     ;; Navigate candidates
     "C-n"        #'company-other-backend
     "C-p"        #'company-other-backend
     "C-j"        #'company-select-next
     "C-k"        #'company-select-previous
     "C-l"        #'company-complete-selection
     "<down>"       #'company-select-next
     "<up>"         #'company-select-previous
     "<right>"       #'company-complete-selection
     "C-SPC"      #'company-complete-common
     "TAB"     #'company-complete-common-or-cycle
     [backtab]    #'company-select-previous
     [escape]     (λ! (company-abort) (evil-normal-state 1))

     ;; filter or show docs for candidate
     "C-h"        #'company-show-doc-buffer
     "<right>"        #'company-show-doc-buffer
     "C-s"        #'company-filter-candidates)))

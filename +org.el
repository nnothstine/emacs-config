;;; +org.el -*- lexical-binding: t; -*-

(after! org-capture
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/todo.org" "Tasks")
           "* TODO %i%?")
          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Notes")
           "* %i%T%?"))))

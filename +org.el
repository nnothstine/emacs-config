;;; +org.el -*- lexical-binding: t; -*-

(after! org-capture
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Inbox")
           "* TODO %?\n%i\n%a")
          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Notes")
           "* %T %?\n%i\n%a"))))

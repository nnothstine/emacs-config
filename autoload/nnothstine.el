;;; ~/.config/doom/autoload/nnothstine.el -*- lexical-binding: t; -*-


;;;###autoload
(defun find-in-dotfiles ()
   "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/.dotfiles")))

;;;###autoload
(defun browse-dotfiles ()
  (interactive)
  (doom-project-browse (expand-file-name "~/.dotfiles")))

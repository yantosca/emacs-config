;;; my-require.el --- Load a package without risking the whole config  -*- lexical-binding: t; -*-

;; 13 Sep 2026 -- Bob Yantosca -- yantosca@seas.harvard.edu

;;; Commentary:

;; `org-babel-load-file' loads a tangled .el, and an error anywhere in
;; it aborts the rest of that file and the org file that loaded it.  So
;; one vendored package that will not load does not cost you that
;; package, it costs you everything configured after it.
;;
;; `my-require' downgrades that to a message and a missing package.
;; Use it for anything vendored under elisp/ or elpa/; plain `require'
;; is fine for what Emacs itself ships.  Where the code after a require
;; needs the package, guard it: (when (my-require 'foo) ...).
;;
;; Note that `require's own NOERROR argument is not a substitute -- it
;; only covers a missing file, not an error signalled while the file
;; loads.
;;
;; This lives in its own file rather than in emacs-config.org because
;; emacs-config.org only reaches ~/.emacs.d when install.sh copies it,
;; while elisp.org and elpa.org are loaded in place from the repository.
;; Defining it here means a git pull can never deliver callers without
;; the definition they need.

;;; Code:

(defun my-require (feature &optional description)
  "Require FEATURE, returning non-nil on success.
Unlike `require', a failure to load is reported and swallowed rather
than aborting the rest of the configuration.  DESCRIPTION names the
package in the message if FEATURE alone is not obvious."
  (condition-case err
      (progn (require feature) t)
    (error
     (message "emacs-config: %s not loaded (%s)"
              (or description feature)
              (error-message-string err))
     nil)))

(provide 'my-require)

;;; my-require.el ends here

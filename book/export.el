(require 'package)
(setq package-user-dir "~/.emacs.d/elpa") ; Ensure it points to your user packages
(package-activate-all)

;; Dynamically add all system ELPA source directories to prevent version-lock
(let ((default-directory "/usr/share/emacs/site-lisp/elpa-src/"))
  (when (file-directory-p default-directory)
    (normal-top-level-add-subdirs-to-load-path)))

(require 'htmlize)
(require 'ox-latex)

;; Whitelist the ReadTheOrg theme domain for remote downloads
(setq org-safe-remote-resources '("https://fniessen\\.github\\.io/.*"))

;; Tell Org to export clean CSS classes instead of looking up Emacs face colors
(setq org-html-htmlize-output-type 'css)

;; ---- Create a local symlink for layout dependencies natively ----
(let ((symlink-path "kernel-source")
      (target-path "/home/zengxu/Projects/kernel-source-2.6.8"))
  (when (file-exists-p symlink-path)
    (delete-file symlink-path))
  (make-symbolic-link target-path symlink-path))

;; Define custom latex class
(add-to-list 'org-latex-classes
             '("report-no-parts"
               "\\documentclass[12pt]{report}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;; ---- PDF Export Options ----
(setq org-latex-remove-logfiles nil)
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\footnotesize")
        ("breaklines" "true")))

(setq org-latex-pdf-process
      '("latexmk -xelatex -silent -shell-escape -interaction=nonstopmode -output-directory=%o %f"))

;; ---- Hooks ----

;; 1. Untabify buffer before parsing
(add-hook 'org-export-before-parsing-hook
          (lambda (backend)
            (setq tab-width 8)
            (untabify (point-min) (point-max))))

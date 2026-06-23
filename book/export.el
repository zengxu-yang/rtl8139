(require 'ox-latex)

;; We use double backslashes here so Emacs safely reads them as literal single backslashes
(add-to-list 'org-latex-classes
             '("report-no-parts"
               "\\documentclass[12pt]{report}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

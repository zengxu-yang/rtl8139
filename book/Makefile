# Variables
EMACS     = emacs
EMACSOPTS = --batch -Q -l export.el

SOURCE    = book.org
HTML_OUT  = book.html
PDF_OUT   = book.pdf

.PHONY: all html pdf clean

# Default target builds both HTML and PDF layouts
all: html pdf

# Export to clean HTML
html: $(HTML_OUT)

$(HTML_OUT): $(SOURCE)
	@echo "Exporting $(SOURCE) to HTML..."
	$(EMACS) $(EMACSOPTS) \
		--visit=$(SOURCE) \
		--funcall org-html-export-to-html

# Export to PDF via LaTeX (No \part tags)
pdf: $(PDF_OUT)

$(PDF_OUT): $(SOURCE)
	@echo "Exporting $(SOURCE) to PDF..."
	$(EMACS) $(EMACSOPTS) \
		--visit=$(SOURCE) \
		--eval '(progn (setq org-latex-listings '"'"'minted) (setq org-latex-minted-options '"'"'(("frame" "lines") ("fontsize" "\\footnotesize") ("linenos" "true") ("breaklines" "true"))) (setq org-latex-pdf-process '"'"'("xelatex -shell-escape -interaction=nonstopmode -output-directory=%o %f" "xelatex -shell-escape -interaction=nonstopmode -output-directory=%o %f")))' \
		--funcall org-latex-export-to-pdf

# Clean up build artifacts and LaTeX intermediate debris
clean:
	@echo "Cleaning up generated documentation files..."
	rm -f $(HTML_OUT) $(PDF_OUT)
	rm -rf _minted-*
	rm -f *.tex *.aux *.log *.out *.toc *.tex~
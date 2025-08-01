# Makefile for GAN Theory Thesis
# Author: Bryan Paget

# Variables
LATEX = pdflatex
BIBTEX = bibtex
THESIS = thesis
SETTINGS = settings
CHAPTERS = $(wildcard sections/*.tex)
FIGURES = $(wildcard images/*.*)
CODE = $(wildcard src/*.R)
BIB = references.bib

# Default target
.PHONY: all clean view help

all: $(THESIS).pdf

# Main target: build the thesis
$(THESIS).pdf: $(THESIS).tex $(SETTINGS).tex $(CHAPTERS) $(BIB) $(FIGURES)
    @echo "Building thesis..."
    $(LATEX) $(THESIS)
    $(BIBTEX) $(THESIS)
    $(LATEX) $(THESIS)
    $(LATEX) $(THESIS)
    @echo "Thesis built successfully!"

# Alternative build using latexmk
latexmk: $(THESIS).tex
    @echo "Building thesis with latexmk..."
    latexmk -pdf -interaction=nonstopmode $(THESIS)
    @echo "Thesis built successfully with latexmk!"

# Quick build (no bibliography)
quick: $(THESIS).tex $(SETTINGS).tex $(CHAPTERS)
    @echo "Quick build (no bibliography)..."
    $(LATEX) $(THESIS)
    @echo "Quick build complete!"

# Run R code to generate plots
plots: $(CODE)
    @echo "Running R code to generate plots..."
    cd code && Rscript gan_dynamics.R
    cd code && Rscript plot_generation.R
    cd code && Rscript optimal_transport_demo.R
    @echo "Plots generated successfully!"

# Clean auxiliary files
clean:
    @echo "Cleaning auxiliary files..."
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.fls *.fdb_latexmk *.fdb_kpsewhich
    rm -f *.synctex.gz *.nav *.snm *.vrb *.fls *.glo *.gls *.glg *.idx *.ilg *.ind
    rm -f *.maf *.mlf* *.mlt* *.mltx* *.mlz* *.upa *.upb *.xdv *.bcf *.run.xml *.tdo
    rm -f *.fls *.glo *.gls *.glsdefs *.glg *.idx *.ilg *.ind *.lof *.lot
    rm -f *.maf *.mlf* *.mlt* *.mltx* *.mlz* *.nav *.snm *.soc *.upa *.upb *.vrb *.xdv
    @echo "Clean complete!"

# Clean everything including PDF
cleanall: clean
    @echo "Removing PDF files..."
    rm -f $(THESIS).pdf
    @echo "All files cleaned!"

# View the PDF (Linux/macOS)
view: $(THESIS).pdf
    @if command -v xdg-open >/dev/null 2>&1; then \
        xdg-open $(THESIS).pdf & \
    elif command -v open >/dev/null 2>&1; then \
        open $(THESIS).pdf & \
    else \
        echo "Could not determine how to open PDF. Please open $(THESIS).pdf manually." \
    fi

# Count words in the thesis
wordcount:
    @echo "Counting words in thesis..."
    @if command -v texcount >/dev/null 2>&1; then \
        texcount -inc $(THESIS).tex; \
    else \
        echo "texcount not installed. Please install it to count words." \
    fi

# Spell check
spellcheck:
    @echo "Spell checking thesis..."
    @if command -v aspell >/dev/null 2>&1; then \
        aspell -t -c $(THESIS).tex; \
    else \
        echo "aspell not installed. Please install it to spell check." \
    fi

# Archive the project
archive: clean
    @echo "Creating archive..."
    tar -czf $(THESIS)-archive.tar.gz \
        --exclude=*.pdf \
        --exclude=*.aux \
        --exclude=*.log \
        --exclude=*.out \
        --exclude=*.toc \
        --exclude=*.bbl \
        --exclude=*.blg \
        --exclude=*.fls \
        --exclude=*.fdb* \
        --exclude=*.synctex.gz \
        --exclude=*.backup \
        --exclude=*.swp \
        --exclude=*.swo \
        --exclude=*~ \
        --exclude=.DS_Store \
        --exclude=.git \
        .
    @echo "Archive created: $(THESIS)-archive.tar.gz"

# Show help
help:
    @echo "Available targets:"
    @echo "  all         - Build the thesis (default)"
    @echo "  latexmk     - Build thesis using latexmk"
    @echo "  quick       - Quick build (no bibliography)"
    @echo "  plots       - Run R code to generate plots"
    @echo "  clean       - Clean auxiliary files"
    @echo "  cleanall    - Clean all files including PDF"
    @echo "  view        - View the PDF"
    @echo "  wordcount   - Count words in thesis"
    @echo "  spellcheck  - Spell check the thesis"
    @echo "  archive     - Create archive of the project"
    @echo "  help        - Show this help message"

# Check for required dependencies
check-deps:
    @echo "Checking dependencies..."
    @if command -v $(LATEX) >/dev/null 2>&1; then \
        echo "✓ $(LATEX) is installed"; \
    else \
        echo "✗ $(LATEX) is not installed"; \
    fi
    @if command -v $(BIBTEX) >/dev/null 2>&1; then \
        echo "✓ $(BIBTEX) is installed"; \
    else \
        echo "✗ $(BIBTEX) is not installed"; \
    fi
    @if command -v Rscript >/dev/null 2>&1; then \
        echo "✓ R is installed"; \
    else \
        echo "✗ R is not installed"; \
    fi
    @if command -v latexmk >/dev/null 2>&1; then \
        echo "✓ latexmk is installed (optional)"; \
    else \
        echo "✗ latexmk is not installed (optional)"; \
    fi
    @if command -v texcount >/dev/null 2>&1; then \
        echo "✓ texcount is installed (optional)"; \
    else \
        echo "✗ texcount is not installed (optional)"; \
    fi
    @if command -v aspell >/dev/null 2>&1; then \
        echo "✓ aspell is installed (optional)"; \
    else \
        echo "✗ aspell is not installed (optional)"; \
    fi

TARGETS=index.md index.pdf

all: $(TARGETS)

%.md : %.R
	Rscript -e "library(sowsear); library(knitr); sowsear(\"$<\", \"Rmd\");knit(\"$<md\")"
# ideally this would happen always, actually.
	rm -f $<md

%.pdf : %.md
	pandoc $<  --include-in-header=include.tex -V linkcolor:black -o $@

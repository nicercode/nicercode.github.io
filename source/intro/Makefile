TARGETS=getting-started.md loading-data.md

all: $(TARGETS)

%.md : %.R
	Rscript -e "library(sowsear);sowsear(\"$<\", \"Rmd\");knit(\"$<md\")"
# ideally this would happen always, actually.
	rm -f $<md



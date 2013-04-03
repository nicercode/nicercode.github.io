TARGETS=getting-started.md loading-data.md writing-functions.md \
	data-types.md repeating-things.md missing-data.md \
	plotting.md

all: $(TARGETS)

%.md : %.R
	Rscript -e "library(sowsear);sowsear(\"$<\", \"Rmd\");knit(\"$<md\")"
# ideally this would happen always, actually.
	rm -f $<md



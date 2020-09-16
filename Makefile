SUBDIRS := $(wildcard slides/lectures/week*)
OUTDIR=docs


lectures: $(SUBDIRS) ## Compile lecture slides
$(SUBDIRS):
	cp make_subdirs $@/Makefile; $(MAKE) -C $@

slides_web: FORCE ## Create website for slides
	Rscript -e "rmarkdown::render_site('slides')"
	cp -r docs/slides_top/* docs/slides


toplevel: FORCE ## Create top level website
	Rscript -e "rmarkdown::render_site('.')"
	cp -r docs/toplevel/* docs

all: lectures slides_web toplevel

.PHONY: $(SUBDIRS) FORCE

.PHONY: dirs
dirs:
	@echo $(SUBDIRS)

FORCE:

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST

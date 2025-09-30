# Here's a reference guide for [make](https://www.gnu.org/software/make/manual/html_node/index.html)

# --- config ---
RESUME_MD    := resume.md
DIST         := dist
HTML_OUT     := $(DIST)/resume.html
PDF_OUT      := $(DIST)/resume.pdf

CSS          := css/resume.css
TEMPLATE     := templates/tohtml.html
RESOURCE_PATH:= .:css:templates

# PDF engine to generate PDF output (override at CLI if needed)
PDF_ENGINE   ?= wkhtmltopdf

PANDOC       := pandoc

.PHONY: all html pdf clean
.DELETE_ON_ERROR:

all: html pdf

html: $(HTML_OUT)
pdf:  $(PDF_OUT)

# Build HTML (ensure output dir exists right here)
$(HTML_OUT): $(RESUME_MD) $(CSS) $(TEMPLATE)
	@mkdir -p "$(dir $@)"
	$(PANDOC) \
	  --standalone \
	  --from markdown+yaml_metadata_block \
	  --to html5 \
	  --template=$(TEMPLATE) \
	  --css=$(CSS) \
	  --embed-resources \
	  --resource-path="$(RESOURCE_PATH)" \
	  --metadata pagetitle="Resume" \
	  -o "$@" \
	  $(RESUME_MD)

# Build PDF via selected engine (wkhtmltopdf by default)
$(PDF_OUT): $(RESUME_MD) $(CSS) $(TEMPLATE)
	@mkdir -p "$(dir $@)"
	$(PANDOC) \
	  --standalone \
	  --from markdown+yaml_metadata_block \
	  --to html5 \
	  --template=$(TEMPLATE) \
	  --css=$(CSS) \
	  --embed-resources \
	  --resource-path="$(RESOURCE_PATH)" \
	  --metadata pagetitle="Resume" \
	  --pdf-engine=$(PDF_ENGINE) \
	  -o "$@" \
	  $(RESUME_MD)

clean:
	rm -rf "$(DIST)"

# Here's a reference guide for [make](https://www.gnu.org/software/make/manual/html_node/index.html)

# Pandoc resume build (with embedded CSS for HTML & PDF)
RESUME_MD := resume.md # resume source
DIST      := dist # output folder (created automatically, but you can create it yourself)
HTML_OUT  := $(DIST)/resume.html # html output
PDF_OUT   := $(DIST)/resume.pdf # pdf output

CSS       := css/resume.css # styling (for both html and pdf)
TEMPLATE  := templates/tohtml.html #template for html output

# Where Pandoc should look for referenced assets (CSS, templates, fonts, images)
RESOURCE_PATH := .:css:templates

# PDF engine to generate PDF output
PDF_ENGINE ?= wkhtmltopdf

PANDOC := pandoc


.PHONY: all html pdf clean

all: html pdf


# Ensure output directory exists, orelse make it.
$(DIST):
	mkdir -p $(DIST)

html: $(HTML_OUT)

# HTML with embedded CSS (portable single file)
$(HTML_OUT): $(RESUME_MD) $(CSS) $(TEMPLATE) | $(DIST)
	$(PANDOC) \
	  --standalone \
	  --from markdown+yaml_metadata_block \
	  --to html5 \
	  --template=$(TEMPLATE) \
	  --css=$(CSS) \
	  --embed-resources \
	  --resource-path="$(RESOURCE_PATH)" \
	  --metadata pagetitle="Resume" \
	  --output $(HTML_OUT) \
	  $(RESUME_MD)

pdf: $(PDF_OUT)

# PDF via wkhtmltopdf; also embedded resources
$(PDF_OUT): $(RESUME_MD) $(CSS) $(TEMPLATE) | $(DIST)
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
	  --output $(PDF_OUT) \
	  $(RESUME_MD)

# delete any existing html or pdf output in the /dist folder
clean:
	rm -f $(HTML_OUT) $(PDF_OUT)




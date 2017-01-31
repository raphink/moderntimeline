CTANUPLOAD=ctanupload

CONTRIBUTION  = moderntimeline
VERSION       = v0.10
SUMMARY       = Add timelines to moderncv entries
NAME          = Raphaël Pinson
EMAIL         = raphink@gmail.com
DIRECTORY     = /macros/latex/contrib/$(CONTRIBUTION)
DONOTANNOUNCE = 0
LICENSE       = free
FREEVERSION   = lppl
FILE          = $(CONTRIBUTION).tar.gz

SOURCEFILES   = $(CONTRIBUTION).dtx $(CONTRIBUTION).ins
PKGFILES      = $(CONTRIBUTION).sty
DOCFILES      = $(CONTRIBUTION).pdf

TEXINSTALLDIR = /usr/local/texlive/texmf-local

# Checks
EXPECTED_PAGES = 9

export CONTRIBUTION VERSION NAME EMAIL SUMMARY DIRECTORY DONOTANNOUNCE ANNOUNCE NOTES LICENSE FREEVERSION FILE

# default rule
ctanify: $(FILE)

$(FILE): README $(SOURCEFILES) $(DOCFILES) $(PKGFILES)
	ctanify --pkgname $(CONTRIBUTION) $^

%.sty: %.dtx %.ins
	latex $*.ins

%.pdf: %.tex
	pdflatex -interaction=batchmode $<
	pdflatex -interaction=batchmode $<

$(CONTRIBUTION).pdf: $(CONTRIBUTION).sty
	pdflatex -interaction=batchmode $(CONTRIBUTION).dtx
	makeindex -s gind.ist $(CONTRIBUTION).idx
	makeindex -s gglo.ist -o $(CONTRIBUTION).gls $(CONTRIBUTION).glo
	pdflatex -interaction=batchmode $(CONTRIBUTION).dtx

upload: ctanify
	$(CTANUPLOAD) -P

%.tds.zip: %.tar.gz
	tar xzf $< $@

install: $(CONTRIBUTION).tds.zip
	unzip $< -d $(TEXINSTALLDIR)
	mktexlsr

test: $(CONTRIBUTION)-test.pdf

clean:
	rm -f *.aux *.glo *.idx *.log
	rm -f $(DOCFILES) $(PKGFILES)
	rm -f $(FILE)

check: $(CONTRIBUTION).pdf
	test -e $(CONTRIBUTION).pdf
	rspec spec/pdf_spec.rb


empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar)):../../lib
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main -c ../../.calabash

TARGETS=changelog.html Overview.html

all: $(TARGETS)

# ============================================================

Overview.html: ,xproc20.xml \
               ../../style/docbook.xsl ../../style/dbspec.xsl \
               ../../style/xprocns.xsl ../../style/rngsyntax.xsl
	@echo Format spec: $@
	@$(CALABASH) -isource=$< -oresult=$@ \
	            -pschemaext.schema=../../../../../schema/dbspec.rng \
                    -pxml.toc.filename=xproc20.toc.xml \
                    -potherspec=../xproc20-steps/,steps.xml \
                    -potherprefix="../" \
	            -pothersuffix="" \
                    -potherlabel="XPS" \
                    ../../style/formatspec.xpl style=xproc-specs.xsl

# N.B. ,,xproc20.xml has a bogus glossary, you must re-validate (which
#      re-XIncludes) the sources to create ,xproc20.xml
,xproc20.xml: xproc20.xml
	@echo Validate spec: $<
	@$(CALABASH) -isource=$< -oresult=$@ \
                    ../../style/validate.xpl \
                    schema=../../schema/dbspec.rng \
                    schematron=../../schema/docbook.sch

,,xproc20.xml: xproc20.xml
	@echo XInclude spec: $<
	@$(CALABASH) -isource=$< -oresult=$@ \
                    ../../style/validate.xpl \
                    schema=../../schema/dbspec.rng \
                    schematron=../../schema/docbook.sch

# ============================================================

diff.html: Overview.html
	../../lib/make-diff.sh xproc20

changelog.html: changelog.xml
	@echo Format changelog
	@$(CALABASH) -isource=$< -oresult=$@ ../../style/formatspec.xpl

clean:
	rm -f $(TARGETS) ,xproc20.xml ,,xproc20.xml glossary.xml
	rm -f diff.html error-list.xml


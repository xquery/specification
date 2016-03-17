empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar)):../../lib
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main -c ../../.calabash

TARGETS=changelog.html Overview.html

all: $(TARGETS)

# ============================================================

Overview.html: ,steps.xml \
               ../../style/docbook.xsl ../../style/dbspec.xsl \
               ../../style/xprocns.xsl ../../style/rngsyntax.xsl
	@echo Format spec: $@
	@$(CALABASH) -isource=$< -oresult=$@ \
	            -pschemaext.schema=../../../../../schema/dbspec.rng \
                    -pxml.toc.filename=steps.toc.xml \
                    -potherspec=../xproc20/,xproc20.xml \
                    -potherprefix="../" \
	            -pothersuffix="" \
                    -potherlabel="XP" \
                    ../../style/formatspec.xpl style=xproc-specs.xsl

,steps.xml: steps.xml
	@echo XInclude spec: $<
	@$(CALABASH) -isource=$< -oresult=$@ \
                    ../../style/validate.xpl \
                    schema="" schematron=""

# ============================================================

diff.html: Overview.html
	../../lib/make-diff.sh xproc20-steps

changelog.html: changelog.xml
	@echo Format changelog
	@$(CALABASH) -isource=$< -oresult=$@ \
                     ../../style/formatspec.xpl

clean:
	rm -f $(TARGETS) ,steps.xml ,steps.xml


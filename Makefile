STYLES=$(wildcard style/*.xsl)
STAGETYPE=WD
STAGEROOT=/tmp/xproc20
STAGEDATE=19670616
STAGEXPROC=$(STAGEROOT)/$(STAGETYPE)-xproc20-$(STAGEDATE)
STAGESTEPS=$(STAGEROOT)/$(STAGETYPE)-xproc20-steps-$(STAGEDATE)

all: xproc20

xproc20:
	$(MAKE) -C schema
	$(MAKE) -C langspec
	mkdir -p build/langspec/xproc20
	mkdir -p build/langspec/xproc20-steps
	cp style/base.css build/langspec/xproc20/base.css
	cp langspec/xproc20/Overview.html build/langspec/xproc20/index.html
	cp langspec/xproc20/,xproc20.xml  build/langspec/xproc20/xproc20.xml
	if [ -f langspec/xproc20/diff.html ]; then cp langspec/xproc20/diff.html build/langspec/xproc20/; fi
	cp langspec/xproc20/changelog.xml build/langspec/xproc20/
	cp langspec/xproc20/changelog.html build/langspec/xproc20/
	cp style/xproc.css build/langspec/xproc20/
	cp style/prism.css build/langspec/xproc20/
	cp js/prism.js build/langspec/xproc20/
	@echo ==================================================
	cp build/langspec/xproc20/base.css build/langspec/xproc20-steps/
	cp langspec/xproc20-steps/Overview.html build/langspec/xproc20-steps/index.html
	cp langspec/xproc20-steps/,steps.xml  build/langspec/xproc20-steps/xproc20-steps.xml
	if [ -f langspec/xproc20-steps/diff.html ]; then cp langspec/xproc20-steps/diff.html build/langspec/xproc20-steps/; fi
	cp langspec/xproc20-steps/changelog.xml build/langspec/xproc20-steps/
	cp langspec/xproc20-steps/changelog.html build/langspec/xproc20-steps/
	cp style/xproc.css build/langspec/xproc20-steps/
	cp style/prism.css build/langspec/xproc20-steps/
	cp js/prism.js build/langspec/xproc20-steps/

stage-xproc20: xproc20
	mkdir -p $(STAGEXPROC) $(STAGESTEPS)
	rsync -ar build/langspec/xproc20/ $(STAGEXPROC)/
	rsync -ar build/langspec/xproc20-steps/ $(STAGESTEPS)/
	echo "<!DOCTYPE html>" > $(STAGEXPROC)/Overview.html
	echo "<!DOCTYPE html>" > $(STAGESTEPS)/Overview.html
	cat $(STAGEXPROC)/index.html >> $(STAGEXPROC)/Overview.html
	cat $(STAGESTEPS)/index.html >> $(STAGESTEPS)/Overview.html
	rm -f $(STAGEXPROC)/index.html $(STAGESTEPS)/index.html

clean:
	rm -rf build
	$(MAKE) -C schema clean
	$(MAKE) -C langspec clean


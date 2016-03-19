empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../lib/*.jar)):../lib
SAXON=java -cp $(CLASSPATH) -jar ../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main -c ../.calabash

all:
	$(MAKE) -C xproc20-steps
	$(MAKE) -C xproc20

clean:
	$(MAKE) -C xproc20 clean
	$(MAKE) -C xproc20-steps clean

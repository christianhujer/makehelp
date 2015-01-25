PREFIX:=/usr/local/
BINDIR=$(PREFIX)/bin/
INCDIR=$(PREFIX)/include/

## Installs makehelp on your system.
.PHONY: install
install:
	install -d $(INCDIR)/makehelp/ $(BINDIR)/
	install -t $(INCDIR)/makehelp/ include/makehelp/*
	install -t $(BINDIR)/ bin/makehelp.pl

## Removes makehelp from your system.
.PHONY: uninstall
uninstall:
	$(RM) -r $(INCDIR)/makehelp/ $(BINDIR)/makehelp.pl

include include/makehelp/Help.mak

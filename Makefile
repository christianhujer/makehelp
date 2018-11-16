## Installation prefix.
# Defaults to /usr/local/.
PREFIX:=/usr/local/

## Installation directory for binaries.
BINDIR=$(PREFIX)/bin/

## Installation directory for include files.
INCDIR=$(PREFIX)/include/

## Installation directory for man files.
MANDIR=$(PREFIX)/share/man/

.PHONY: install
## Installs makehelp on your system.
install:
	install -d $(INCDIR)/makehelp/ $(BINDIR)/ $(MANDIR)/man1/
	install -m 0644 -t $(INCDIR)/makehelp/ include/makehelp/*
	install -t $(BINDIR)/ bin/makehelp
	install -m 0644 -t $(MANDIR)/man1/ man/makehelp.1

.PHONY: uninstall
## Removes makehelp from your system.
uninstall:
	$(RM) -r $(INCDIR)/makehelp/ $(BINDIR)/makehelp

control.Description:=makehelp - Extract and print help information from Makefiles.
control.Version:=1.4.0

-include makedist/MakeDist.mk
include include/makehelp/Help.mk

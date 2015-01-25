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

.PHONY: dist
## Creates the distribution archives.
dist: dist/makehelp.tar.gz dist/makehelp.tar.bz2 dist/makehelp.zip

dist/makehelp.tar.gz: dist/makehelp.tar
dist/makehelp.tar.bz2: dist/makehelp.tar

%.gz: %
	<$< gzip -9 >$@

%.bz2: %
	<$< bzip2 -9 >$@

dist/makehelp.tar dist/makehelp.zip:
	mkdir -p dist
	git archive -o $@ --prefix makehelp/ HEAD .

.PHONY: clean
clean:
	$(RM) -r dist

include include/makehelp/Help.mak

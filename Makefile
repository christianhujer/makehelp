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
dist: dist/makehelp.tar.gz dist/makehelp.tar.bz2 dist/makehelp.zip dist/makehelp.deb

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
	$(RM) -r dist control data/ data.tar.gz control.tar.gz debian-binary

control:
	echo "Package: makehelp\nVersion: 1.4.0\nSection: user/hidden\nPriority: optional\nArchitecture: all\nInstalled-Size: `du -cks bin/ include/ | tail -n 1 | cut -f 1`\nMaintainer: Christian Hujer <cher@riedquat.de>\nDescription: makehelp - Extract and print help information from Makefiles." >$@

control.tar.gz: control
	tar czf $@ $^

data.tar.gz: data/
	tar czf $@ --transform 's,^\./,/,' -C $< .

data/:
	$(MAKE) PREFIX=data/usr/

debian-binary:
	mkdir -p $(dir $@)
	echo 2.0 >$@

dist/makehelp.deb: debian-binary control.tar.gz data.tar.gz
	ar -Drc $@ $^

include include/makehelp/Help.mak

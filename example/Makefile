## The prefix path for installation: $(PREFIX)
PREFIX:=/usr/local/

## The path to install binary files: $(BINDIR)
BINDIR=$(PREFIX)bin/

.PHONY: all
## Builds everything.
all: hello

.PHONY: clean
## Removes generated files.
clean:
	rm -rf hello hello.o

.PHONY: install
## Installs the binary program to $(BINDIR).
# On most systems, this needs to be run as root, i.e. using sudo.
install: all
	install -d $(BINDIR) hello

help: export PREFIX:=$(value PREFIX)
help: export BINDIR:=$(value BINDIR)

-include ../include/makehelp/Help.mak

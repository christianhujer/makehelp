override CFLAGS+=-std=c99

.PHONY: all
## Builds everything.
all: hello

.PHONY: clean
## Removes generated files.
clean:
	rm -rf hello hello.o

.PHONY: help
## Prints this help text.
help:
	perl ../makehelp.pl $(MAKEFILE_LIST)

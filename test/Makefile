include OtherMakefile

## Set FOO to value bar to foobar.
FOO:=foo

.PHONY: all
## Builds everything.
all:
	echo all

.PHONY: help
## Prints this help text.
help:
	@perl ../makehelp.pl $(MAKEFILE_LIST)

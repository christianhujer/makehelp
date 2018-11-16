ifeq (undefined,$(origin MAKEHELP/HELP.MAK))
MAKEHELP/HELP.MAK:=$(lastword $(MAKEFILE_LIST))
MAKEHELP:=$(firstword $(wildcard $(firstword $(dir $(lastword $(MAKEFILE_LIST)))/../../bin/makehelp)) makehelp)

# File to include from your Makefile like this:
# -include makehelp/Help.mk

.PHONY: help
## Prints this help message.
help:
	@$(MAKEHELP) $(MAKEFILE_LIST)

ifeq "help" "$(filter help,$(MAKECMDGOALS))"
include .help.mk
endif

.PHONY: distclean
distclean::
	$(RM) .help.mk

.help.mk: $(filter-out .help.mk, $(MAKEFILE_LIST))
	@$(MAKEHELP) -d $^ >$@

endif

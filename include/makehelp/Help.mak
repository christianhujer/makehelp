ifeq (undefined,$(origin MAKEHELP/HELP.MAK))
MAKEHELP/HELP.MAK:=$(lastword $(MAKEFILE_LIST))
MAKEHELP:=$(firstword $(wildcard $(firstword $(dir $(lastword $(MAKEFILE_LIST)))/../../bin/makehelp)) makehelp)

# File to include from your Makefile like this:
# -include makehelp/Help.mak

.PHONY: help
## Prints this help message.
help:
	@$(MAKEHELP) $(MAKEFILE_LIST)

ifeq "help" "$(filter help,$(MAKECMDGOALS))"
include .help.mak
endif

.PHONY: distclean
distclean: include/makehelp/Help.mak+distclean

.PHONY: include/makehelp/Help.mak+distclean
include/makehelp/Help.mak+distclean:
	$(RM) .help.mak

.help.mak: $(filter-out .help.mak, $(MAKEFILE_LIST))
	@$(MAKEHELP) -d $^ >$@

endif

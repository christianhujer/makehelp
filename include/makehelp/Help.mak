ifeq (,$(MAKEHELP/HELP.MAK))
MAKEHELP/HELP.MAK:=$(lastword $(MAKEFILE_LIST))

# File to include from your Makefile.
# To update these files, run

.PHONY: help
## Prints this help message.
help:
	@makehelp $(MAKEFILE_LIST)

ifeq "updateMakehelp" "$(filter updateMakehelp,$(MAKECMDGOALS))"
.PHONY: makehelp Help.mak
endif
# If -N does not work, that's because github doesn't send Last-Modified header.
makehelp Help.mak:
	wget -N -q --no-check-certificate https://github.com/christianhujer/makehelp/raw/master/$@

.PHONY: updateMakehelp
## Updates makehelp
updateMakehelp: makehelp Help.mak

ifeq "help" "$(filter help,$(MAKECMDGOALS))"
include .help.mak
endif

.help.mak: $(MAKEFILE_LIST)
	@makehelp -d $^ >$@

endif

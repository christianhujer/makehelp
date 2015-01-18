# File to include from your Makefile.
# To update these files, run

.PHONY: help
## Prints this help message.
help: makehelp.pl
	perl makehelp.pl $(MAKEFILE_LIST)

makehelp.pl Help.mak:
	wget -N -q --no-check-certificate https://github.com/christianhujer/makehelp/raw/master/$@

.PHONY: updateMakehelp
## Updates makehelp.pl
updateMakehelp:
	$(MAKE) -B makehelp.pl Help.mak

# makehelp

`makehelp.pl` is a small perl script which provides built-in doxygen-style help in `Makefile`s.
Special comments in the `Makefile` are used to provide user documentation for goals and variables.
These comments are extracted by makehelp to print a nice documentation.
That documentation is similar to the built-in help texts of UNIX commands.

Makehelp comments start with `##` instead of `#`.
They should be positioned before variables or goals.
Included makefiles are supported.

To use `makehelp` in your project, simply copy `Help.mak` and `makehelp.pl` to your project directory.

For an example, see directory example.

For more examples, see
* https://github.com/christianhujer/sclog4c

Sample Makefile:

~~~~
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

-include ../Help.mak
~~~~

Sample output:

~~~~
Usage: make [OPTION|GOAL|VARIABLE]...
Runs make to make the specified GOALs.
If no GOAL is specified, the default goal is made (usually "all").

Popular make OPTIONs:
  -s    Silent mode, disables command echo.
  -k    Keep going, continues after errors.
  -j N  Run N jobs in parallel.
  -n    Don't run the commands, just print them.
  -q    Run no commands; exit status says if up to date.
  -h    Print make help text.
Use option -h to lists the GNUmake part of the help.

A VARIABLE is specified as name=value pair.
Supported VARIABLEs:
  BINDIR            The path to install binary files: $(PREFIX)bin/
  PREFIX            The prefix path for installation: /usr/local/

Supported GOALs:
  all               Builds everything.
  clean             Removes generated files.
  help              Prints this help message.
  install           Installs the binary program to $(PREFIX)bin/.
                    On most systems, this needs to be run as root, i.e. using sudo.
~~~~

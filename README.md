# makehelp

<div style="font-size: 150%; font-weight: bold; text-align: center;">! Doxygen (sort of) for GNU make !</div>

## What is `makehelp`?
`makehelp.pl` is a Makefile and a Perl script which provide built-in doxygen-style help in `Makefile`s.
Special comments in the `Makefile` are used to provide user documentation for goals and variables.
These comments are extracted by makehelp to print a nice documentation.
That documentation is similar to the built-in help texts of UNIX commands.


## Installing `makehelp`
Makehelp can run with or without installation.
If you want to install makehelp, run `sudo make install`.

Per default, the include files are installed in `/usr/local/include/makehelp/` and the binary files are installed in `/usr/local/bin/`.

## Using `makehelp`.

### Running `makehelp` from your `Makefile`
To run `makehelp` from your `Makefile`, simply include the following line in your `Makefile`:

~~~~make
-include makehelp/Help.mak
~~~~

The best position to include this is at the **end** of your `Makefile`.

### Using `makehelp` in your `Makefile`
Makehelp comments start with `##` instead of `#`.
They should be positioned before those variables or goals that you want to document.

Included makefiles are supported.

#### Example for a variable documentation

~~~~make
## The prefix path for installation: $(PREFIX)
PREFIX:=/usr/local/
~~~~

#### Example for goal documentation

~~~~make
.PHONY: all
## Builds everything.
all: hello
~~~~

#### Sample Makefile

~~~~make
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

-include makehelp/Help.mak
~~~~

Sample output of running `make help`:

~~~~none
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

For more examples, see
* https://github.com/christianhujer/sclog4c


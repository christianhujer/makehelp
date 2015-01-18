# makehelp

`makehelp.pl` is a small perl script which provides built-in doxygen-style help in `Makefile`s.
Special comments in the `Makefile` are used to provide user documentation for goals and variables.
These comments are extracted by makehelp to print a nice documentation.
That documentation is similar to the built-in help texts of UNIX commands.

Makehelp comments start with ## instead of #.
They should be positioned before variables or goals.
Included makefiles are supported.

To use `makehelp` in your project, simply copy `Help.mak` and `makehelp.pl` to your project directory.

For an example, see directory example.

For more examples, see
* https://github.com/christianhujer/sclog4c

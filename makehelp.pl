#!/bin/perl
# Prints help for a Makefile.
# Usual invocation (from make):
# help:
# 	perl makehelp.pl $(MAKEFILE_LIST)
#
# To make your make inline help documentation work, start documentation comments before a target or variable with double-hash.
# Example:
# ## Compiles and linkes all sources.
# # This is the default target.
# all: ...

if ($ARGV[0] =~ /^-(h|-?help)$/) {
    print <<END;
Usage: perl $0 MAKEFILE...
Prints the help text of one or more MAKEFILEs.

To be invoked from the Makefile with a rule like this:
help:
	perl $0 \$(MAKEFILE_LIST)

Supported options:
  -h, --help    Print this help text.

$0 prints the documentation of variables and goals.
A documentation comment is recognized as one or more comment lines right before a goal or variable definition,
of which the first comment line starts with ##.
The documentation comment may contain references to environment variables.
All references to environment variables will be replaced with their values.
This includes the make goal.
Note: To reference variables which are defined in the Makefile, don't forget to export them.

Example:
  ## Performs the complete build of the project.
  # This is the default target.
  all: mybinary

  ## Flags for the C preprocessor.
  CPPFLAGS?=

  ## Prints this help text.
  help:
  	perl $0 \$(MAKEFILE_LIST)

Report bugs to cher\@riedquat.de.
END
    exit 0;
}

while (<>) {
    if (/^## .*$/ ... /^([^.#\t][^:=]*:([^=]|$)|([^.#\t][^:=?]*(\?=|:=|=))|$)/) {
        s/^##? ?//;
        $h .= $p;
        $p = $_;
    } elsif ($h) {
        $p =~ s/(\?=|:=|=).*/=/;
        $p =~ s/:.*/:/;
        chomp $p;
        $p =~ s/\$\(([^)]*)\)/$ENV{$1}/ge;
        $h =~ s/\$\(([^)]*)\)/$ENV{$1}/ge;
        if ($p =~ /=$/) {
            $p =~ s/=$//;
            if ($h ne $vars{$p}) {
                $vars{$p} .= $h;
            }
        } else {
            $p =~ s/:$//;
            if ($h ne $goals{$p}) {
                $goals{$p} .= $h;
            }
        }
        undef $h;
        undef $p;
    }
}

print <<END;
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
Use option -h to lits the GNUmake part of the help.

A VARIABLE is specified as name=value pair.
Supported VARIABLEs:
END

my $indent = " " x 20;
for (sort keys %vars) {
    $vars{$_} =~ s/^/$indent/gm;
    if (length > 16) {
        print "  $_\n$vars{$_}";
    } else {
        $tmpIndent = " " x (2 + length);
        $vars{$_} =~ s/^$tmpIndent//;
        print "  $_$vars{$_}";
    }
}

print <<END;

Supported GOALs:
END

for (sort keys %goals) {
    $goals{$_} =~ s/^/$indent/gm;
    if (length > 16) {
        print "  $_\n$goals{$_}";
    } else {
        $tmpIndent = " " x (2 + length);
        $goals{$_} =~ s/^$tmpIndent//;
        print "  $_$goals{$_}";
    }
}

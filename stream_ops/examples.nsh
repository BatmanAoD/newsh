#!/bin/nsh
# Examples demonstrating the table of operators in the README

# `tee`: passthrough write to `${filename}`
# usage: `cmd | tee filename | cmd`)
o>&@0(${filename}) o>&o

# `tee -a`
o>&@(${filename}) o>&o

# Switch `stdout` and `stderr`
e>&o o>&e

# The same three examples, but with 'source/sink redundancy' syntactic sugar
o> &@0(${filename}) &o
o> &@(${filename}) &o
e>&o o>&e   # No redundancy

# Combine stdout and stderr on stdout stream (Bash `2>&1`) -- but see below for
# alternate version
e>&o

# Source/sink grouping
# Combine stdout and stderr on one combined (unnamed) stream
(o> e>)
# Bash `2>&1 | tee -a`
(o> e>) (&@(${filename}) &o)

# TODO - forking (below) and 'background' proc?
# Bash `vi $(which myprog) &`
which myprog >&{!} 0| vi ${!}
# Bash `vi $(which myprog)`
which myprog >&{!} ; vi ${!}

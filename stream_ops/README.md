# Stream operators

Handle redirection and piping, including error-code propagation and
simultaneous control of multiple streams and multiple processes

## Temporary names

Inside of parentheses of braces, `!` or `!id` can be used to indicate a
temporary instance of whatever type is syntactically required; if `id` is
present, it is a named instance. (`id` is required ONLY if multiple temporaries
of the same type are present in the same input/output scope.)

E.g. `@(!)` is a temporary file; `@(!tempfile)` is a *different* temporary
file.

## Table of input/output operators

This is an idea for how to create one consistent set of operators for
stream-redirection, error-code capturing, piping, etc. These would replace (or
in some cases include) Bash's `>`, `2>`, `|`, `<()`, `$()`, `<<`, etc.

| string source/sink type         | 'from'; sigil: `>` | 'to'; sigil: `&` |
|---------------------------------|--------------------|------------------|
| Error code (as string)          | ?>                 | -                |
| "closed" and/or `/dev/null` (?) | 0>                 | &0               |
| Standard out                    | >, o>, 1>          | &o, &1           |
| Standard error                  | e>, 2>             | &e, &2           |
| Combined stdout/stderr          | &>, >>             | &&               |
| Fork without stdin              | -                  | `0|`             |
| Stdin (fork immediately)        | -                  | `|`, `|(!id)`    |
| Stdin (fork later)              | -                  | `&|`, `&|(!id)`  |
| String variable                 | {var}>             | &{var}           |
| Temp variable                   | {!}>, {!id}>       | &{!}, &{!id}     |
| File (append)                   | @(file)>           | &@(file)         |
| File (overwrite; '0's the file) | -                  | &@0(file)        |
| Temp file                       | @(!)>, @(!id)>     | &@(!), &@(!id)   |
| Meta-variable                   | *{var}>            | &*{var}          |

A "meta-variable" in the above table is a variable that represents one of the
source/sink types. It obviates the need for using `eval` in the following Bash
snippet:

    stream_to_redirect='2>'
    eval ${cmd} ${stream_to_redirect} ${file}

`&0`, `&o`, `&e`, `&&` and synonymous 'sinks' are for redirecting streams.

`file` must evaluate to a literal filename; e.g. if `${myfile}` contains the
name of a file, then `@(${myfile})` would be the corresponding source/sink
specifier.

Temp file names can be accessed as strings (e.g. to pass as an argument to a
function or external process) using `@(!id)` or `@(!)` (if unambiguous) with no
`>` or `&`.

TODO:
 * Reconsider `&@0(file)` syntax.
 * For "in-place" evaluation (a la Bash's `$()`, `${}`): use `$` as the sigil;
   place it on the left-hand side of the source/sink.
 * Consider replacing `&` with `>` as the generic 'to' sigil. This looks better
   and is more intuitive but might lead to ambiguity.
 * Consider whether it makes sense to have 'passthrough' operators, e.g.
   `&@(file)>` would write to the specified file and continue piping the input
   as a stream.

## Usage

The above are supposed to be used in combination, with each 'source' mapped to
a 'sync':

    SRC>&SINK

### Source/sink redundancy

To re-use the same source, specify it once followed by multiple sinks;
conversely, to re-use a sink, specify multiple sources followed by a single
sink.

### Source/sink grouping

Multiple sources can be combined into a single source using parentheses.

#Thoughts on shells in general

### "Things" that can be evaluated/manipulated by a shell:

 * strings (literals, other...)
 * variables
 * arithmetic
 * builtins
 * subshells
 * forked processes (non-shell)
 * File contents (reading)
 * File contents (writing/appending)
 * Temp files (reading, writing...)
 * Shell builtins/operators/etc via 'eval'

### ...These can be evaluated *as*...

 * nothing (e.g. no output captured from a subshell)
 * strings
 * ints/floats (...not in most shells!)
 * arrays of strings
 * assoc-arrays of strings (fairly recent in Bash)
 * string-streams (e.g. w/ pipes & redirection)
 * file-handles
 * interpretable shell code

### Strings/code have multiple levels of "expansion." In Bash, in order:

 1. Brace expansion
 1. Tilde expansion
 1. Together:
    * Parameter expansion
    * Arithmetic expansion
    * Command substitution
 1. Word splitting
 1. Pathname expansion

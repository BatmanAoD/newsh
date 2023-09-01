# Thoughts on the purpose and scope of a shell

## Nu

I really like a lot of Nu ideas. I tried it early on and have even tried a few times to make it my daily driver. I would honestly love to see Nu or something like it "win," i.e. gain widespread usage and recognition.

But reading ["The Case for Nushell"](https://www.jntrnr.com/case-for-nushell/), I don't get a sense of what JT think the purpose of a shell *is*, and that makes me worry that Nu will never be able to replace "standard" interactive shells for most users, or even for me specifically.

Perl is better for data manipulation than "classic" shells, and is syntactically a lot like a shell. So why haven't people been setting `chsh /usr/bin/perl` since the 90s?

I believe that a shell is, at its core, primarily a convenient way to fork & exec processes, connecting their input and output streams to various things (primarily the pTTY itself, files, and each other, via pipes).

Nu is very clearly designed with the "streams" part of this definition in mind: like PowerShell, its primary value proposition is that whenever possible, I/O data is more structured than classic newline-delimited ASCII text. But it [doesn't actually have](https://github.com/nushell/nushell/issues/247) background processes or any built-in form of process control. It is impossible to suspend a process (though control-C `SIGINT` works). This feels to me not just like a missing feature but a fundamental gap in its utility as a shell (as opposed to a scripting language).

## Shell behaviors and data

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
 * ints
 * floats (...not in most shells!)
 * arrays of strings
 * assoc-arrays of strings (fairly recent in Bash)
 * string-streams (e.g. w/ pipes & redirection)
 * file-handles
 * interpretable shell code
 * in Nu/PowerShell/etc: structured data of some kind

### Strings/code have multiple levels of "expansion." In Bash, in order:

 1. Brace expansion
 1. Tilde expansion
 1. Together:
    * Parameter expansion
    * Arithmetic expansion
    * Command substitution
 1. Word splitting
 1. Pathname expansion

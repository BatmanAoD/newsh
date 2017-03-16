# New shell-language project

Thoughts about how the API for a cleaner, easier shell language might work

## Pain-points of existing shells

 * Quoting/eval-ing (not safe or consistent)
 * Redirection and piping (not flexible or easy)
   * Hard to simultaneously capture exit code, error output, and stdout from a
     process, and impossible to "correctly" pipe stderr and stdout separately
     but simultaneously (e.g. to separate processes)
 * Hard or impossible to create and propagate useful data
   * Everything is a string, array-of-strings, or (slow and not widely
     supported) associative-array-of-strings.
   * Functions implicitly always have both string-stream output (stdout and
     stderr) and a uint8 return-value, but some or all are typically unused,
     which is inconsistent and inflexible
 * No built-in floating-point math
 * Difficult/impossible to save/restore/diff env setups
 * Miscellaneous feature variability within the same shell (e.g. Bash set/shopt)


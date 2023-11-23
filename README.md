# Lisp QBF
I love qbfs and wanted to learn lisp, so here we are with a small, incomplete project which will probably get lost in the matrix.

## Tools

### normalize.lisp
**Package:** ```qbf-normalize```
**exports:** 
* ```(defun normalize (path))```: this function accepts a file path to a qdimacs file and will normalize the ids, i.e. re-maps them from 1 to the number of variables. Result is written to stdout.

### qdimacs.lisp
**Package:** ```qbf-qdimacs```
**exports:** 
* ```(defun parse (path))```: this function accepts a file path to a qdimacs file and will parse it into lists. Return value is a list of two lists (prefix and clauses) where the prefix-elements are of format ([a | e] lit) and the clauses are a list of lists of literals.



Example
-------------

```lisp
CL-USER> (defvar ht (ia-hash-table:make-ia-hash-table))
HT
CL-USER> (setf (gethash "qwe" ht) 1)
1
CL-USER> (gethash :qwe ht)
1
T
```

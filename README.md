ia-hash-table
=============

Main purpose is to be able to use strings as real keys but do gethash with symbols and vice versa. Inspired by http://api.rubyonrails.org/classes/ActiveSupport/HashWithIndifferentAccess.html


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

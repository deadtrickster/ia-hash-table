## Examples
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

```lisp

```
(enable-ia-syntax)

(defparameter response (alist-ia-hash-table '(("name" . "John Smith")
                                              ("age" . 34)
                                              ("city" . "New York")
                                              ("account" . (("checking" . 36223)
                                                            ("saving" . 468300))))))

>> #Iresponse.name
"John Smith"

>> #Iresponse.account.saving
468300

>> #Iresponse.address
NIL

>> #Iresponse.address.state
The value NIL is not of type HASH-TABLE.

>> #Iresponse.address?.state
NIL

;; or even
(defparameter nil-response nil)

>> #Inil-response?.account.saving
NIL
```

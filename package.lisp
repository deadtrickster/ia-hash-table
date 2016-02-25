(defpackage :ia-hash-table
  (:use :cl)
  (:export #:make-ia-hash-table
           #:alist-ia-hash-table
           #:plist-ia-hash-table
           #:string-equalp
           #:string-sxhash

           #:enable-ia-syntax
           #:disable-ia-syntax))

(in-package :ia-hash-table)

(defun string-sxhash (f)
  (sxhash (string-downcase (string f))))

(defun string-equalp (f1 f2)
  (declare (type (or symbol string) f1 f2))
  (string-equal (string f1)
                (string f2)))

#+ (or sbcl cmu)
(sb-ext:define-hash-table-test string-equalp string-sxhash)

(declaim (inline make-ia-hash-table))

(defun make-ia-hash-table (&rest options)
  #-(or sbcl allegro ccl lispworks) (declare (ignore options))
  #+(or sbcl allegro ccl lispworks)
  (apply #'make-hash-table :test #'string-equalp :hash-function #'string-sxhash options)
  #-(or sbcl allegro ccl lispworks)
  (error "MAKE-IA-HASH-TABLE not supported"))

(defun alist-ia-hash-table (alist &rest hash-table-initargs)
  "Adopted version of alexandria:alist-hash-table"
  (let ((table (apply #'make-ia-hash-table hash-table-initargs)))
    (dolist (cons alist)
      (setf (gethash (car cons) table) (cdr cons)))
    table))

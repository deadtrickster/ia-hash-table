(in-package :ia-hash-table)

(defun string-sxhash (f)
  (sxhash (string-downcase (string f))))

(defun string-equalp (f1 f2)
  (declare (type (or symbol string) f1 f2))
  (string-equal f1 f2))

#+ (or sbcl cmu)
(sb-ext:define-hash-table-test string-equalp string-sxhash)

(declaim (inline make-ia-hash-table))

(deftype alist ()
  `(and list (satisfies list-is-alist)))

(defun list-is-alist (list)
  (when (typep list 'list)
    (every #'consp list)))

(defun make-ia-hash-table (&rest options)
  #-(or sbcl allegro ccl lispworks) (declare (ignore options))
  #+(or sbcl allegro ccl lispworks)
  (apply #'make-hash-table :test #'string-equalp :hash-function #'string-sxhash options)
  #-(or sbcl allegro ccl lispworks)
  (error "MAKE-IA-HASH-TABLE not supported"))

(defun deep-alist-ia-hash-table (value hash-table-initargs)
  (if (typep value 'alist)
      (apply #'alist-ia-hash-table value hash-table-initargs)
      value))

(defun alist-ia-hash-table (alist &rest hash-table-initargs)
  "Adopted version of alexandria:alist-hash-table"
  (let ((table (apply #'make-ia-hash-table hash-table-initargs)))
    (dolist (cons alist)
      (setf (gethash (car cons) table) (deep-alist-ia-hash-table (cdr cons) hash-table-initargs)))
    table))

(defun plist-ia-hash-table (plist &rest hash-table-initargs)
  "Adopted version of alexandria:plist-hash-table"
  (let ((table (apply #'make-ia-hash-table hash-table-initargs)))
    (do ((tail plist (cddr tail)))
        ((not tail))
      (setf (gethash (car tail) table) (cadr tail)))
    table))

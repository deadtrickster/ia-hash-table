(in-package :ia-hash-table)

(defun string-sxhash (f)
  (sxhash (string-downcase (string f))))

(defun string-equalp (f1 f2)
  (declare (type (or symbol string) f1 f2))
  (string-equal (string f1)
                (string f2)))

(sb-ext:define-hash-table-test string-equalp string-sxhash)

(declaim (inline make-ia-hash-table))

(defun make-ia-hash-table ()
  (make-hash-table :test 'string-equalp))

(in-package :ia-hash-table)

(defun get-deep-hash (ht keys)
  (let ((value ht))
    (loop for (key . nullable) in keys do
             (setf value (gethash key value))
             (when (and (null value) (alexandria:ends-with #\? key))
               (return)))
    value))

(defun have-nullable-p (keys)
  (loop for (key . nullable) in keys
        if nullable
        return t))

(defun gen-get-deep-hash-nullables (ht keys)
  (alexandria:with-gensyms (block-name value)
    `(block ,block-name
       (let ((,value ,ht))
         ,(let ((form ht)) 
            (loop for (key . nullable) in keys do
                     (setf form (if nullable
                                    `(progn
                                       (setf ,value (gethash ,key ,form))
                                       (unless ,value
                                         (return-from ,block-name))
                                       ,value)
                                    `(setf ,value (gethash ,key ,form)))))
            form)
         ,value))))

(defun gen-get-deep-hash-w/o-nullables (ht keys)
  (let ((form ht)) 
     (loop for (key . nullable) in keys do
              (setf form `(gethash ,key ,form)))
     form))

(defun gen-get-deep-hash (ht keys)
  (if (have-nullable-p keys)
      (gen-get-deep-hash-nullables ht keys)
      (gen-get-deep-hash-w/o-nullables ht keys)))

(defun process-?. (keys)
  (loop for key in keys 
        if (alexandria:ends-with #\? key)
        collect (cons (subseq key 0 (1- (length key))) t)
        else
        collect (cons key nil)))

(defun ia-syntax-reader (stream char arg)
  (declare (ignorable char arg))
  (let ((symbol (read stream)))
    (assert (symbolp symbol) nil "IA-syntax: ~a is not a symbol" symbol)
    (destructuring-bind (var-name &rest raw-keys)
        (split-sequence:split-sequence #\. (string symbol) :remove-empty-subseqs t)
      (destructuring-bind ((var-name . nullable)) (process-?. (list var-name))
        (let ((var-symbol (intern var-name *package*))
              (keys (process-?. raw-keys)))
          (if nullable
              `(if ,var-symbol
                   ,(gen-get-deep-hash var-symbol keys))
              `,(gen-get-deep-hash var-symbol keys)))))))

(defvar *previous-readtables* nil
  "A stack which holds the previous readtables that have been pushed
here by ENABLE-IA-SYNTAX.")

(defun %enable-ia-syntax ()
  (push *readtable*
        *previous-readtables*)
  (setq *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\I #'ia-syntax-reader)
  (values))

(defmacro enable-ia-syntax ()
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (%enable-ia-syntax)))

(defun %disable-ia-syntax ()
  "Internal function used to restore previous readtable." 
  (if *previous-readtables*
    (setq *readtable* (pop *previous-readtables*))
    (setq *readtable* (copy-readtable nil)))
  (values))

(defmacro disable-binary-string-syntax ()
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (%disable-ia-syntax)))

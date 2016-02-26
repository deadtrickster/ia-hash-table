(asdf:defsystem :ia-hash-table
  :serial t
  :version "0.2.1"
  :licence "MIT"
  :depends-on ("alexandria" "split-sequence")
  :author "Ilya Khaprov <ilya.kharpov@publitechs.com>"
  :components ((:file "package")
               (:file "ia-hash-table")
               (:file "reader"))
  :description "Main purpose is to be able to use strings as real keys but do gethash with symbols and vice versa.
Can be useful for things like http headers parsing (no more intern leaks), json apis with/without https://github.com/AccelerationNet/access.
Only tested on SBCL. Expected to work on Allegro, CCL and LW.
Also provides nil safe dot syntax")

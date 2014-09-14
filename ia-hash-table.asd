(asdf:defsystem :ia-hash-table
  :serial t
  :version "0.0.1"
  :licence "MIT"
  :depends-on (:trivial-gray-streams)
  :components ((:file "package")
               (:file "ia-hash-table"))
  :description "Main purpose is to be able to use strings as real keys but do gethash with symbols.
Can be useful for things like http headers parsing (no more intern leaks), json apis with/without https://github.com/AccelerationNet/access.
Only SBCL support for now.")

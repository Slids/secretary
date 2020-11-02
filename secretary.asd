(defsystem :secretary
  :author "Jonathan Godbout"
  :version "0.0.1"
  :licence "MIT-style"
  :description      "Secretary Problem"
  :long-description "Testing secretary problem"
  :depends-on (:cl-permutation)
  :components
  ((:module "src"
    :serial t
    :pathname ""
    :components ((:file "secretary")))))

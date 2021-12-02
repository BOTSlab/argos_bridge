
(cl:in-package :asdf)

(defsystem "argos_bridge-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Proximity" :depends-on ("_package_Proximity"))
    (:file "_package_Proximity" :depends-on ("_package"))
    (:file "ProximityList" :depends-on ("_package_ProximityList"))
    (:file "_package_ProximityList" :depends-on ("_package"))
    (:file "Puck" :depends-on ("_package_Puck"))
    (:file "_package_Puck" :depends-on ("_package"))
    (:file "PuckList" :depends-on ("_package_PuckList"))
    (:file "_package_PuckList" :depends-on ("_package"))
  ))
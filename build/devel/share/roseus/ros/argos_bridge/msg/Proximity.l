;; Auto-generated. Do not edit!


(when (boundp 'argos_bridge::Proximity)
  (if (not (find-package "ARGOS_BRIDGE"))
    (make-package "ARGOS_BRIDGE"))
  (shadow 'Proximity (find-package "ARGOS_BRIDGE")))
(unless (find-package "ARGOS_BRIDGE::PROXIMITY")
  (make-package "ARGOS_BRIDGE::PROXIMITY"))

(in-package "ROS")
;;//! \htmlinclude Proximity.msg.html


(defclass argos_bridge::Proximity
  :super ros::object
  :slots (_value _angle ))

(defmethod argos_bridge::Proximity
  (:init
   (&key
    ((:value __value) 0.0)
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _value (float __value))
   (setq _angle (float __angle))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; float32 _value
    4
    ;; float32 _angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _value
       (sys::poke _value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _value
     (setq _value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get argos_bridge::Proximity :md5sum-) "60c9942057be757c415e4f5523971867")
(setf (get argos_bridge::Proximity :datatype-) "argos_bridge/Proximity")
(setf (get argos_bridge::Proximity :definition-)
      "float32 value
float32 angle

")



(provide :argos_bridge/Proximity "60c9942057be757c415e4f5523971867")



;; Auto-generated. Do not edit!


(when (boundp 'argos_bridge::Puck)
  (if (not (find-package "ARGOS_BRIDGE"))
    (make-package "ARGOS_BRIDGE"))
  (shadow 'Puck (find-package "ARGOS_BRIDGE")))
(unless (find-package "ARGOS_BRIDGE::PUCK")
  (make-package "ARGOS_BRIDGE::PUCK"))

(in-package "ROS")
;;//! \htmlinclude Puck.msg.html


(defclass argos_bridge::Puck
  :super ros::object
  :slots (_type _range _angle ))

(defmethod argos_bridge::Puck
  (:init
   (&key
    ((:type __type) 0)
    ((:range __range) 0.0)
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _range (float __range))
   (setq _angle (float __angle))
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; int32 _type
    4
    ;; float32 _range
    4
    ;; float32 _angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _type
       (write-long _type s)
     ;; float32 _range
       (sys::poke _range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _range
     (setq _range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get argos_bridge::Puck :md5sum-) "5678c53e9498ce2896027816b599c523")
(setf (get argos_bridge::Puck :datatype-) "argos_bridge/Puck")
(setf (get argos_bridge::Puck :definition-)
      "int32 type
float32 range
float32 angle

")



(provide :argos_bridge/Puck "5678c53e9498ce2896027816b599c523")



;; Auto-generated. Do not edit!


(when (boundp 'argos_bridge::PuckList)
  (if (not (find-package "ARGOS_BRIDGE"))
    (make-package "ARGOS_BRIDGE"))
  (shadow 'PuckList (find-package "ARGOS_BRIDGE")))
(unless (find-package "ARGOS_BRIDGE::PUCKLIST")
  (make-package "ARGOS_BRIDGE::PUCKLIST"))

(in-package "ROS")
;;//! \htmlinclude PuckList.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass argos_bridge::PuckList
  :super ros::object
  :slots (_header _n _pucks ))

(defmethod argos_bridge::PuckList
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:n __n) 0)
    ((:pucks __pucks) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _n (round __n))
   (setq _pucks __pucks)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:n
   (&optional __n)
   (if __n (setq _n __n)) _n)
  (:pucks
   (&rest __pucks)
   (if (keywordp (car __pucks))
       (send* _pucks __pucks)
     (progn
       (if __pucks (setq _pucks (car __pucks)))
       _pucks)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _n
    4
    ;; argos_bridge/Puck[] _pucks
    (apply #'+ (send-all _pucks :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _n
       (write-long _n s)
     ;; argos_bridge/Puck[] _pucks
     (write-long (length _pucks) s)
     (dolist (elem _pucks)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _n
     (setq _n (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; argos_bridge/Puck[] _pucks
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pucks (let (r) (dotimes (i n) (push (instance argos_bridge::Puck :init) r)) r))
     (dolist (elem- _pucks)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get argos_bridge::PuckList :md5sum-) "1ed88113db7382b436a7373d69b2ce8f")
(setf (get argos_bridge::PuckList :datatype-) "argos_bridge/PuckList")
(setf (get argos_bridge::PuckList :definition-)
      "Header header
int32 n
Puck[] pucks

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: argos_bridge/Puck
int32 type
float32 range
float32 angle

")



(provide :argos_bridge/PuckList "1ed88113db7382b436a7373d69b2ce8f")



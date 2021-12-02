;; Auto-generated. Do not edit!


(when (boundp 'argos_bridge::ProximityList)
  (if (not (find-package "ARGOS_BRIDGE"))
    (make-package "ARGOS_BRIDGE"))
  (shadow 'ProximityList (find-package "ARGOS_BRIDGE")))
(unless (find-package "ARGOS_BRIDGE::PROXIMITYLIST")
  (make-package "ARGOS_BRIDGE::PROXIMITYLIST"))

(in-package "ROS")
;;//! \htmlinclude ProximityList.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass argos_bridge::ProximityList
  :super ros::object
  :slots (_header _n _proximities ))

(defmethod argos_bridge::ProximityList
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:n __n) 0)
    ((:proximities __proximities) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _n (round __n))
   (setq _proximities __proximities)
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
  (:proximities
   (&rest __proximities)
   (if (keywordp (car __proximities))
       (send* _proximities __proximities)
     (progn
       (if __proximities (setq _proximities (car __proximities)))
       _proximities)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _n
    4
    ;; argos_bridge/Proximity[] _proximities
    (apply #'+ (send-all _proximities :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _n
       (write-long _n s)
     ;; argos_bridge/Proximity[] _proximities
     (write-long (length _proximities) s)
     (dolist (elem _proximities)
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
   ;; argos_bridge/Proximity[] _proximities
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _proximities (let (r) (dotimes (i n) (push (instance argos_bridge::Proximity :init) r)) r))
     (dolist (elem- _proximities)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get argos_bridge::ProximityList :md5sum-) "e65bda67898b0db91bc0613a6eb91e50")
(setf (get argos_bridge::ProximityList :datatype-) "argos_bridge/ProximityList")
(setf (get argos_bridge::ProximityList :definition-)
      "Header header
int32 n
Proximity[] proximities

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
MSG: argos_bridge/Proximity
float32 value
float32 angle

")



(provide :argos_bridge/ProximityList "e65bda67898b0db91bc0613a6eb91e50")



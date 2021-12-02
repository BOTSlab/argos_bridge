; Auto-generated. Do not edit!


(cl:in-package argos_bridge-msg)


;//! \htmlinclude ProximityList.msg.html

(cl:defclass <ProximityList> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (n
    :reader n
    :initarg :n
    :type cl:integer
    :initform 0)
   (proximities
    :reader proximities
    :initarg :proximities
    :type (cl:vector argos_bridge-msg:Proximity)
   :initform (cl:make-array 0 :element-type 'argos_bridge-msg:Proximity :initial-element (cl:make-instance 'argos_bridge-msg:Proximity))))
)

(cl:defclass ProximityList (<ProximityList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProximityList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProximityList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name argos_bridge-msg:<ProximityList> is deprecated: use argos_bridge-msg:ProximityList instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ProximityList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:header-val is deprecated.  Use argos_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'n-val :lambda-list '(m))
(cl:defmethod n-val ((m <ProximityList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:n-val is deprecated.  Use argos_bridge-msg:n instead.")
  (n m))

(cl:ensure-generic-function 'proximities-val :lambda-list '(m))
(cl:defmethod proximities-val ((m <ProximityList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:proximities-val is deprecated.  Use argos_bridge-msg:proximities instead.")
  (proximities m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProximityList>) ostream)
  "Serializes a message object of type '<ProximityList>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'n)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'proximities))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'proximities))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProximityList>) istream)
  "Deserializes a message object of type '<ProximityList>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'n) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'proximities) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'proximities)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'argos_bridge-msg:Proximity))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProximityList>)))
  "Returns string type for a message object of type '<ProximityList>"
  "argos_bridge/ProximityList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProximityList)))
  "Returns string type for a message object of type 'ProximityList"
  "argos_bridge/ProximityList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProximityList>)))
  "Returns md5sum for a message object of type '<ProximityList>"
  "e65bda67898b0db91bc0613a6eb91e50")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProximityList)))
  "Returns md5sum for a message object of type 'ProximityList"
  "e65bda67898b0db91bc0613a6eb91e50")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProximityList>)))
  "Returns full string definition for message of type '<ProximityList>"
  (cl:format cl:nil "Header header~%int32 n~%Proximity[] proximities~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: argos_bridge/Proximity~%float32 value~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProximityList)))
  "Returns full string definition for message of type 'ProximityList"
  (cl:format cl:nil "Header header~%int32 n~%Proximity[] proximities~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: argos_bridge/Proximity~%float32 value~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProximityList>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'proximities) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProximityList>))
  "Converts a ROS message object to a list"
  (cl:list 'ProximityList
    (cl:cons ':header (header msg))
    (cl:cons ':n (n msg))
    (cl:cons ':proximities (proximities msg))
))

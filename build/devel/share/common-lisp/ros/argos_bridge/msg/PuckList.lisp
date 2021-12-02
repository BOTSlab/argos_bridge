; Auto-generated. Do not edit!


(cl:in-package argos_bridge-msg)


;//! \htmlinclude PuckList.msg.html

(cl:defclass <PuckList> (roslisp-msg-protocol:ros-message)
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
   (pucks
    :reader pucks
    :initarg :pucks
    :type (cl:vector argos_bridge-msg:Puck)
   :initform (cl:make-array 0 :element-type 'argos_bridge-msg:Puck :initial-element (cl:make-instance 'argos_bridge-msg:Puck))))
)

(cl:defclass PuckList (<PuckList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PuckList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PuckList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name argos_bridge-msg:<PuckList> is deprecated: use argos_bridge-msg:PuckList instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PuckList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:header-val is deprecated.  Use argos_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'n-val :lambda-list '(m))
(cl:defmethod n-val ((m <PuckList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:n-val is deprecated.  Use argos_bridge-msg:n instead.")
  (n m))

(cl:ensure-generic-function 'pucks-val :lambda-list '(m))
(cl:defmethod pucks-val ((m <PuckList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:pucks-val is deprecated.  Use argos_bridge-msg:pucks instead.")
  (pucks m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PuckList>) ostream)
  "Serializes a message object of type '<PuckList>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'n)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pucks))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pucks))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PuckList>) istream)
  "Deserializes a message object of type '<PuckList>"
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
  (cl:setf (cl:slot-value msg 'pucks) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pucks)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'argos_bridge-msg:Puck))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PuckList>)))
  "Returns string type for a message object of type '<PuckList>"
  "argos_bridge/PuckList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PuckList)))
  "Returns string type for a message object of type 'PuckList"
  "argos_bridge/PuckList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PuckList>)))
  "Returns md5sum for a message object of type '<PuckList>"
  "1ed88113db7382b436a7373d69b2ce8f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PuckList)))
  "Returns md5sum for a message object of type 'PuckList"
  "1ed88113db7382b436a7373d69b2ce8f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PuckList>)))
  "Returns full string definition for message of type '<PuckList>"
  (cl:format cl:nil "Header header~%int32 n~%Puck[] pucks~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: argos_bridge/Puck~%int32 type~%float32 range~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PuckList)))
  "Returns full string definition for message of type 'PuckList"
  (cl:format cl:nil "Header header~%int32 n~%Puck[] pucks~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: argos_bridge/Puck~%int32 type~%float32 range~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PuckList>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pucks) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PuckList>))
  "Converts a ROS message object to a list"
  (cl:list 'PuckList
    (cl:cons ':header (header msg))
    (cl:cons ':n (n msg))
    (cl:cons ':pucks (pucks msg))
))

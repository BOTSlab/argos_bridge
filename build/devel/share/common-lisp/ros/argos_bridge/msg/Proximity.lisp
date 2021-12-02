; Auto-generated. Do not edit!


(cl:in-package argos_bridge-msg)


;//! \htmlinclude Proximity.msg.html

(cl:defclass <Proximity> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:float
    :initform 0.0)
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass Proximity (<Proximity>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Proximity>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Proximity)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name argos_bridge-msg:<Proximity> is deprecated: use argos_bridge-msg:Proximity instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <Proximity>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:value-val is deprecated.  Use argos_bridge-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <Proximity>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader argos_bridge-msg:angle-val is deprecated.  Use argos_bridge-msg:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Proximity>) ostream)
  "Serializes a message object of type '<Proximity>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Proximity>) istream)
  "Deserializes a message object of type '<Proximity>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'value) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Proximity>)))
  "Returns string type for a message object of type '<Proximity>"
  "argos_bridge/Proximity")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Proximity)))
  "Returns string type for a message object of type 'Proximity"
  "argos_bridge/Proximity")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Proximity>)))
  "Returns md5sum for a message object of type '<Proximity>"
  "60c9942057be757c415e4f5523971867")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Proximity)))
  "Returns md5sum for a message object of type 'Proximity"
  "60c9942057be757c415e4f5523971867")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Proximity>)))
  "Returns full string definition for message of type '<Proximity>"
  (cl:format cl:nil "float32 value~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Proximity)))
  "Returns full string definition for message of type 'Proximity"
  (cl:format cl:nil "float32 value~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Proximity>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Proximity>))
  "Converts a ROS message object to a list"
  (cl:list 'Proximity
    (cl:cons ':value (value msg))
    (cl:cons ':angle (angle msg))
))

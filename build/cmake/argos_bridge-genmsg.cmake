# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "argos_bridge: 4 messages, 0 services")

set(MSG_I_FLAGS "-Iargos_bridge:/home/peter/catkin_ws/src/argos_bridge/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(argos_bridge_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_custom_target(_argos_bridge_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "argos_bridge" "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" ""
)

get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_custom_target(_argos_bridge_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "argos_bridge" "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" "argos_bridge/Puck:std_msgs/Header"
)

get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_custom_target(_argos_bridge_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "argos_bridge" "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" ""
)

get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_custom_target(_argos_bridge_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "argos_bridge" "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" "std_msgs/Header:argos_bridge/Proximity"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
)
_generate_msg_cpp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg"
  "${MSG_I_FLAGS}"
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
)
_generate_msg_cpp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
)
_generate_msg_cpp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
)

### Generating Services

### Generating Module File
_generate_module_cpp(argos_bridge
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(argos_bridge_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(argos_bridge_generate_messages argos_bridge_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_cpp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_cpp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_cpp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_cpp _argos_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(argos_bridge_gencpp)
add_dependencies(argos_bridge_gencpp argos_bridge_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS argos_bridge_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
)
_generate_msg_eus(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg"
  "${MSG_I_FLAGS}"
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
)
_generate_msg_eus(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
)
_generate_msg_eus(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
)

### Generating Services

### Generating Module File
_generate_module_eus(argos_bridge
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(argos_bridge_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(argos_bridge_generate_messages argos_bridge_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_eus _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_eus _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_eus _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_eus _argos_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(argos_bridge_geneus)
add_dependencies(argos_bridge_geneus argos_bridge_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS argos_bridge_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
)
_generate_msg_lisp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg"
  "${MSG_I_FLAGS}"
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
)
_generate_msg_lisp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
)
_generate_msg_lisp(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
)

### Generating Services

### Generating Module File
_generate_module_lisp(argos_bridge
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(argos_bridge_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(argos_bridge_generate_messages argos_bridge_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_lisp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_lisp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_lisp _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_lisp _argos_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(argos_bridge_genlisp)
add_dependencies(argos_bridge_genlisp argos_bridge_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS argos_bridge_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
)
_generate_msg_nodejs(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg"
  "${MSG_I_FLAGS}"
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
)
_generate_msg_nodejs(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
)
_generate_msg_nodejs(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
)

### Generating Services

### Generating Module File
_generate_module_nodejs(argos_bridge
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(argos_bridge_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(argos_bridge_generate_messages argos_bridge_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_nodejs _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_nodejs _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_nodejs _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_nodejs _argos_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(argos_bridge_gennodejs)
add_dependencies(argos_bridge_gennodejs argos_bridge_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS argos_bridge_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
)
_generate_msg_py(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg"
  "${MSG_I_FLAGS}"
  "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
)
_generate_msg_py(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
)
_generate_msg_py(argos_bridge
  "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
)

### Generating Services

### Generating Module File
_generate_module_py(argos_bridge
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(argos_bridge_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(argos_bridge_generate_messages argos_bridge_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Puck.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_py _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/PuckList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_py _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/Proximity.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_py _argos_bridge_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/peter/catkin_ws/src/argos_bridge/msg/ProximityList.msg" NAME_WE)
add_dependencies(argos_bridge_generate_messages_py _argos_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(argos_bridge_genpy)
add_dependencies(argos_bridge_genpy argos_bridge_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS argos_bridge_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/argos_bridge
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(argos_bridge_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/argos_bridge
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(argos_bridge_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/argos_bridge
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(argos_bridge_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/argos_bridge
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(argos_bridge_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/argos_bridge
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(argos_bridge_generate_messages_py std_msgs_generate_messages_py)
endif()

add_library(kheperaiv_ros MODULE kheperaiv_ros.h kheperaiv_ros.cpp)
target_link_libraries(kheperaiv_ros
  argos3core_simulator
  argos3plugin_simulator_footbot
  argos3plugin_simulator_genericrobot
  argos3plugin_simulator_kheperaiv
  /opt/ros/$ENV{ROS_DISTRO}/lib/libtf.so
  /opt/ros/$ENV{ROS_DISTRO}/lib/libroscpp.so)

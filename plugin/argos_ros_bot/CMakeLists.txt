add_library(argos_ros_bot MODULE argos_ros_bot.h argos_ros_bot.cpp)
target_link_libraries(argos_ros_bot
  argos3core_simulator
  argos3plugin_simulator_footbot
  argos3plugin_simulator_genericrobot
  /opt/ros/$ENV{ROS_DISTRO}/lib/libroscpp.so)

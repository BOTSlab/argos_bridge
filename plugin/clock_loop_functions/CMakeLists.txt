add_library(clock_loop_functions MODULE
  clock_loop_function.h
  clock_loop_function.cpp
  )

target_link_libraries(clock_loop_functions
  argos3core_simulator
  argos3plugin_simulator_kheperaiv
  /opt/ros/$ENV{ROS_DISTRO}/lib/libtf.so
  /opt/ros/$ENV{ROS_DISTRO}/lib/libroscpp.so
  )


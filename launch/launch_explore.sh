#!/bin/bash

# run a full exploration demo of argos, runs the argos experiments and launch files
ros_name=$2
exp_name=$1
ARGOS_EXP=~/catkin_ws/src/coms/argos_bridge/argos_worlds/${exp_name}
cd  ~/catkin_ws/devel/lib/
argos3 -c ${ARGOS_EXP} &
roslaunch mdis_state_machine ${ros_name}

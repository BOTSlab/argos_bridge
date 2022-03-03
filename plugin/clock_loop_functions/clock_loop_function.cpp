#include "clock_loop_function.h"
/* Logging */
#include <iostream>
#include <ros/console.h>


void CClockLoopFunction::Init(TConfigurationNode& t_tree){
  std::cout << "clock init" << std::endl;
  ros::NodeHandle* nodeHandle = initROS();
  ROS_INFO("clock_init");
  std::stringstream clockTopic;
  clockTopic << "/clock";
  clockPub = nodeHandle->advertise<rosgraph_msgs::Clock>(clockTopic.str(), 1);

  clock = ros::Time(0.0);
}

ros::NodeHandle* CClockLoopFunction::initROS() {
  int argc = 0;
  char *argv = (char *) "";
  ros::init(argc, &argv, "argos_clock");
  return new ros::NodeHandle();
}

void CClockLoopFunction::Reset(){
  // set time to zero
  clock = ros::Time(0.0);
  rosgraph_msgs::Clock msg;
  msg.clock = clock;
  clockPub.publish(msg);
}

void CClockLoopFunction::PreStep(){
  // update time
  clock += ros::Duration(timestep);
  rosgraph_msgs::Clock msg;
  msg.clock = clock;
  clockPub.publish(msg);
}

REGISTER_LOOP_FUNCTIONS(CClockLoopFunction, "clock_loop_functions");

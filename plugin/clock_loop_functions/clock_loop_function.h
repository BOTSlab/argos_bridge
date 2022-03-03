#ifndef CLOCK_LOOP_FUNCTIONS_H
#define CLOCK_LOOP_FUNCTIONS_H

#include <ros/ros.h>
#include <rosgraph_msgs/Clock.h>
#include <argos3/core/simulator/loop_functions.h>

using namespace argos;

class CClockLoopFunction : public CLoopFunctions { 

  public:

    virtual ~CClockLoopFunction() {}
    
    ros::NodeHandle* initROS();

    virtual void Init(TConfigurationNode& t_tree);

    virtual void Reset();

    virtual void PreStep();

  private:
    static ros::NodeHandle* nodeHandle;
    ros::Publisher clockPub;
    ros::Time clock;
    float timestep = 0.01;
};

#endif

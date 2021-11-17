/*
 * AUTHOR: Andrew Vardy <av@mun.ca>
 *
 * Connects an ARGoS robot with a particular configuration to ROS by publishing
 * sensor values and subscribing to a desired wheel speeds topic.
 *
 */

#ifndef ARGOS_ROS_BOT_H
#define ARGOS_ROS_BOT_H

#include <argos3/core/control_interface/ci_controller.h>
#include <argos3/plugins/robots/generic/control_interface/ci_differential_steering_actuator.h>
#include <argos3/plugins/robots/foot-bot/control_interface/ci_footbot_proximity_sensor.h>
#include <argos3/plugins/robots/generic/control_interface/ci_colored_blob_omnidirectional_camera_sensor.h>
//#include <argos3/plugins/robots/foot-bot/control_interface/ci_footbot_gripper_actuator.h>

#include <ros/ros.h>
#include <string>
#include "geometry_msgs/Twist.h"
#include "std_msgs/Bool.h"

using namespace argos;

class CArgosRosBot : public CCI_Controller {

public:

  CArgosRosBot();
  virtual ~CArgosRosBot() {}

  /*
   * This function initializes the controller.
   * The 't_node' variable points to the <parameters> section in the XML
   * file in the <controllers><footbot_ccw_wander_controller> section.
   */
  virtual void Init(TConfigurationNode& t_node);

  /*
   * This function is called once every time step.
   * The length of the time step is set in the XML file.
   */
  virtual void ControlStep();

  /*
   * This function resets the controller to its state right after the
   * Init().
   * It is called when you press the reset button in the GUI.
   * In this example controller there is no need for resetting anything,
   * so the function could have been omitted. It's here just for
   * completeness.
   */
  virtual void Reset() {}

  /*
   * Called to cleanup what done by Init() when the experiment finishes.
   * In this example controller there is no need for clean anything up,
   * so the function could have been omitted. It's here just for
   * completeness.
   */
  virtual void Destroy() {}

  /*
   * The callback method for getting new commanded speed on the cmd_vel topic.
   */
  void cmdVelCallback(const geometry_msgs::Twist& twist);

  /*
   * The callback method for getting the desired state of the gripper.
   */
//  void gripperCallback(const std_msgs::Bool& value);

private:

  CCI_DifferentialSteeringActuator* m_pcWheels;
  CCI_FootBotProximitySensor* m_pcProximity;
  CCI_ColoredBlobOmnidirectionalCameraSensor* m_pcOmniCam;
//  CCI_FootBotGripperActuator* m_pcGripper;

  // The following constant values were copied from the argos source tree from
  // the file src/plugins/robots/foot-bot/simulator/footbot_entity.cpp
  static constexpr Real HALF_BASELINE = 0.07f; // Half the distance between wheels
  static constexpr Real WHEEL_RADIUS = 0.029112741f;

  /*
   * The following variables are used as parameters for the
   * algorithm. You can set their value in the <parameters> section
   * of the XML configuration file, under the
   * <controllers><argos_ros_bot_controller> section.
   */

  // The number of time steps from the time step of the last callback
  // after which leftSpeed and rightSpeed will be set to zero.  Useful to
  // shutdown the robot after the controlling code on the ROS side has quit.
  int stopWithoutSubscriberCount;

  // The number of time steps since the last callback.
  int stepsSinceCallback;

  // Most recent left and right wheel speeds, converted from the ROS twist
  // message.
  Real leftSpeed, rightSpeed;

  // The state of the gripper.
//  bool gripping;

  // Puck list publisher
  ros::Publisher puckListPub;

  // Proximity sensor publisher
  ros::Publisher proximityPub;

  // Subscriber for cmd_vel (Twist message) topic.
  ros::Subscriber cmdVelSub;

  // Subscriber for gripper (Bool message) topic.
//  ros::Subscriber gripperSub;

public:
  // We need only a single ROS node, although there are individual publishers
  // and subscribers for each instance of the class.
  static ros::NodeHandle* nodeHandle;
};

#endif

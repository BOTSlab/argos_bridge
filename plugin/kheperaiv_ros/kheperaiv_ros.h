/*
 * AUTHOR: Peter Nikopoulos <peter@nikopoulos.net>
 *
 * Connects Kheperaiv IV robot to ROS
 *
 */

#ifndef KHEPERAIV_ROS_H
#define KHEPERAIV_ROS_H

#include <argos3/core/control_interface/ci_controller.h>
#include <argos3/plugins/robots/generic/control_interface/ci_differential_steering_actuator.h>
#include <argos3/plugins/robots/generic/control_interface/ci_differential_steering_sensor.h>
#include <argos3/plugins/robots/generic/control_interface/ci_leds_actuator.h>  
#include <argos3/plugins/robots/kheperaiv/control_interface/ci_kheperaiv_ground_sensor.h>
#include <argos3/plugins/robots/kheperaiv/control_interface/ci_kheperaiv_proximity_sensor.h>
#include <argos3/plugins/robots/kheperaiv/control_interface/ci_kheperaiv_light_sensor.h>
#include <argos3/plugins/robots/kheperaiv/control_interface/ci_kheperaiv_ultrasound_sensor.h>
/* Definition of the kheperaiv lidar sensor */
#include <argos3/plugins/robots/kheperaiv/control_interface/ci_kheperaiv_lidar_sensor.h>
/* Definition of the kheperaiv measurements */
#include <argos3/plugins/robots/kheperaiv/simulator/kheperaiv_measures.h>
/* Definition of the range and bearing actuator */
#include <argos3/plugins/robots/generic/control_interface/ci_range_and_bearing_actuator.h>
/* Definition of the range and bearing sensor */
#include <argos3/plugins/robots/generic/control_interface/ci_range_and_bearing_sensor.h>

#include <memory.h>
#include <tf/transform_broadcaster.h>
#include <ros/ros.h>
#include <string>
#include "geometry_msgs/Twist.h"
#include "std_msgs/Bool.h"
#include "math.h"

using namespace argos;

class CKheperaIVRos : public CCI_Controller {

public:

  CKheperaIVRos();
  virtual ~CKheperaIVRos() {}

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
   * published on the clock topic to sync ros and argos
   */
  void updateTime();

  /*
   * publishes proximity messages
   */
  void publishProximity();

  /*
   * publishes line of sight info
   */
  void publishLineOfSight();
  
  /*
   * removes chars from id string
   */
  char const* parse_id_number(const std::string data);

  /*
   * publishes odometry data collected by argos encoder sensor
   */
  void publishOdometry();

  /*
   * publishes lidar data
   */
  void publishLIDAR();

  /*
   * debugging output, you can enable or disable this in the argos config
   */
  void debug(bool debug);


private:
  /* Pointer to the differential steering actuator */                                                                                                                      
  CCI_DifferentialSteeringActuator* m_pcWheels;
  /* Pointer to the differential steering sensor */                                                                                                                        
  CCI_DifferentialSteeringSensor* m_pcEncoder;                                                                                                                             
  /* Pointer to the Khepera IV proximity sensor */                                                                                                                         
  CCI_KheperaIVProximitySensor* m_pcProximity;
  /* Pointer to the range and bearing actuator */
  CCI_RangeAndBearingActuator*  m_pcRABA;
  /* Pointer to the range and bearing sensor */
  CCI_RangeAndBearingSensor* m_pcRABS;
  /* Pointer to the kheperaiv lidar sensor */
  CCI_KheperaIVLIDARSensor* m_pcLIDAR;

  /* Wheel speed */
  Real m_fWheelVelocity;
  /* Angle Tolerance range to go straight.
   * set to [-alpha, alpha] */
  CRange<CRadians> m_cGoStraightAngleRange;
  
  // Most recent left and right wheel speeds, converted from the ROS twist
  // message.
  Real leftSpeed, rightSpeed;
  
  // Proximity sensor publisher
  ros::Publisher proximityPub;

  // Line of sight sensor publisher
  ros::Publisher losPub; 
  
  // Laser scan publisher
  ros::Publisher laserScanPub; 

  // odometry publisher
  ros::Publisher odomPub; 

  // clock publisher (needed to sync ros and argos)
  ros::Publisher clockPub;

  // Subscriber for cmd_vel (Twist message) topic.
  ros::Subscriber cmdVelSub;

  std::unique_ptr<tf::TransformBroadcaster> odom_broadcaster;
  /* physics info */
  float timestep = 0.01; // time between updates in seconds
  ros::Time time;
  double odom_x = 0.0;
  double odom_y = 0.0;
  double odom_yaw = 0.0;
  double odom_dx;
  double odom_dy;
  double odom_w;
  double odom_R;
  double odom_Vr;
  double odom_Vl;

  double goStraightConstant = 0.00001;
public:
  // We need only a single ROS node, although there are individual publishers
  // and subscribers for each instance of the class.
  static ros::NodeHandle* nodeHandle;
};

#endif

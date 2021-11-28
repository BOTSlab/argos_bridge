/* Include ros */
#include "ros/ros.h"
#include "argos_bridge/Proximity.h"
#include "argos_bridge/ProximityList.h"
/* Include the controller definition */
#include "kheperaiv_ros.h"
/* Function definitions for XML parsing */
#include <argos3/core/utility/configuration/argos_configuration.h>
/* 2D vector definition */
#include <argos3/core/utility/math/vector2.h>
/* Logging */
#include <argos3/core/utility/logging/argos_log.h>


#include <iostream>
#include <sstream>

#include <ros/callback_queue.h>

using namespace std;
using namespace argos_bridge;

// Initialize ROS node.  There will be only one ROS node no matter how many robots are created in
// ARGoS.  However, we will have one instance of the CKheperaIVRos class for each ARGoS robot.
ros::NodeHandle* initROS() {
  int argc = 0;
  char *argv = (char *) "";
  ros::init(argc, &argv, "argos_bridge");
  return new ros::NodeHandle();
}

ros::NodeHandle* CKheperaIVRos::nodeHandle = initROS();

/****************************************/
/****************************************/

CKheperaIVRos::CKheperaIVRos() :
   m_pcWheels(NULL),
   m_pcProximity(NULL),
   m_fWheelVelocity(2.5f)
{}
/****************************************/
/****************************************/

void CKheperaIVRos::Init(TConfigurationNode& t_node) {
  // Create the topics to publish
  stringstream puckListTopic, proximityTopic;
  proximityTopic << "/" << GetId() << "/proximity";
//  encoderTopic   << "/" << GetId() << "/encoder";
  proximityPub = nodeHandle->advertise<ProximityList>(proximityTopic.str(), 1);
// encoderPub = nodeHandle->advertise<
  // Create the subscribers
  stringstream cmdVelTopic;//, gripperTopic;
  cmdVelTopic << "/" << GetId() << "/cmd_vel";
  cmdVelSub = nodeHandle->subscribe(cmdVelTopic.str(), 1, &CKheperaIVRos::cmdVelCallback, this);

  // Get sensor/actuator handles
   m_pcWheels    = GetActuator<CCI_DifferentialSteeringActuator>("differential_steering");
   m_pcEncoder   = GetSensor  <CCI_DifferentialSteeringSensor  >("differential_steering");
   m_pcProximity = GetSensor  <CCI_KheperaIVProximitySensor    >("kheperaiv_proximity"  );
  /*
   * Parse the configuration file
   *
   * The user defines this part. Here, the algorithm accepts three
   * parameters and it's nice to put them in the config file so we don't
   * have to recompile if we want to try other settings.
   */
}

void CKheperaIVRos::ControlStep() {
   /* Get readings from proximity sensor */
   const CCI_KheperaIVProximitySensor::TReadings& tProxReads = m_pcProximity->GetReadings();
	 ProximityList proxList;
	 proxList.n = tProxReads.size();
	 for (size_t i = 0; i < proxList.n; ++i) {
			Proximity prox;
			prox.value = tProxReads[i].Value;
			prox.angle = tProxReads[i].Angle.GetValue();
			proxList.proximities.push_back(prox);
		}

	 /* Print encoder values */
	 RLOG << "Encoder values: "
		<< "VL=" << m_pcEncoder->GetReading().VelocityLeftWheel << ", "
		<< "VR=" << m_pcEncoder->GetReading().VelocityRightWheel << ", "
		<< "DL=" << m_pcEncoder->GetReading().CoveredDistanceLeftWheel << ", "
		<< "DR=" << m_pcEncoder->GetReading().CoveredDistanceRightWheel
		<< std::endl;
}

void CKheperaIVRos::cmdVelCallback(const geometry_msgs::Twist& twist) {
  cout << "cmdVelCallback: " << GetId() << endl;

  Real v = twist.linear.x;  // Forward speed
  Real w = twist.angular.z; // Rotational speed

  // Use the kinematics of a differential-drive robot to derive the left
  // and right wheel speeds.
  leftSpeed = (v - HALF_BASELINE * w) / WHEEL_RADIUS;
  rightSpeed = (v + HALF_BASELINE * w) / WHEEL_RADIUS;
}

/*
 * This statement notifies ARGoS of the existence of the controller.
 * It binds the class passed as first argument to the string passed as
 * second argument.
 * The string is then usable in the configuration file to refer to this
 * controller.
 * When ARGoS reads that string in the configuration file, it knows which
 * controller class to instantiate.
 * See also the configuration files for an example of how this is used.
 */
REGISTER_CONTROLLER(CKheperaIVRos, "kheperaiv_ros_controller")

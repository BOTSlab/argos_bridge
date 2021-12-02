/* Include ros */
#include "ros/ros.h"
#include "argos_bridge/Proximity.h"
#include "argos_bridge/ProximityList.h"
#include "argos_bridge/los.h"
#include "argos_bridge/losList.h"
#include "sensor_msgs/LaserScan.h"
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
   m_fWheelVelocity(2.5f),
   m_pcRABA(NULL),
   m_pcRABS(NULL),
   m_pcLIDAR(NULL)
{}
/****************************************/
/****************************************/

void CKheperaIVRos::Init(TConfigurationNode& t_node) {
  // Create the topics to publish
  stringstream proximityTopic;
  proximityTopic << "/" << GetId() << "/proximity";
  proximityPub = nodeHandle->advertise<ProximityList>(proximityTopic.str(), 1);
  stringstream losTopic;
  losTopic << "/" << GetId() << "/lineOfSight";
  losPub = nodeHandle->advertise<losList>(losTopic.str(), 1);
  // Create the subscribers
  stringstream cmdVelTopic;
  cmdVelTopic << "/" << GetId() << "/cmd_vel";
  cmdVelSub = nodeHandle->subscribe(cmdVelTopic.str(), 1, &CKheperaIVRos::cmdVelCallback, this);
  stringstream laserScanTopic;
  laserScanTopic << "/" << GetId() << "/scan";
  laserScanPub = nodeHandle->advertise<sensor_msgs::LaserScan>(laserScanTopic.str(), 1);

  // Get sensor/actuator handles
   m_pcWheels    = GetActuator<CCI_DifferentialSteeringActuator>("differential_steering");
   m_pcEncoder   = GetSensor  <CCI_DifferentialSteeringSensor  >("differential_steering");
   m_pcProximity = GetSensor  <CCI_KheperaIVProximitySensor    >("kheperaiv_proximity"  );
   m_pcRABA      = GetActuator<CCI_RangeAndBearingActuator     >("range_and_bearing"    );
   m_pcRABS      = GetSensor  <CCI_RangeAndBearingSensor       >("range_and_bearing"    );
   m_pcLIDAR     = GetSensor  <CCI_KheperaIVLIDARSensor        >("kheperaiv_lidar"      );
  /*
   * Parse the configuration file
   *
   * The user defines this part. Here, the algorithm accepts three
   * parameters and it's nice to put them in the config file so we don't
   * have to recompile if we want to try other settings.
   */
}

void CKheperaIVRos::ControlStep() {
  this->publishLineOfSight();
  this->publishProximity();
  this->publishLIDAR();

  this->debug(true);
}

void CKheperaIVRos::debug(bool debug){
  if (!debug){
    return;
  }
  /* Print encoder values */
  RLOG << "Encoder values: "
    << "VL=" << m_pcEncoder->GetReading().VelocityLeftWheel << ", "
    << "VR=" << m_pcEncoder->GetReading().VelocityRightWheel << ", "
    << "DL=" << m_pcEncoder->GetReading().CoveredDistanceLeftWheel << ", "
    << "DR=" << m_pcEncoder->GetReading().CoveredDistanceRightWheel
    << std::endl;
}

void CKheperaIVRos::publishLIDAR(){
  sensor_msgs::LaserScan scan;
  scan.angle_min = -KHEPERAIV_LIDAR_ANGLE_SPAN.GetValue()* 0.5;
  scan.angle_max = KHEPERAIV_LIDAR_ANGLE_SPAN.GetValue() * 0.5;
  scan.angle_increment = KHEPERAIV_LIDAR_ANGLE_SPAN.GetValue() / m_pcLIDAR->GetNumReadings();
  scan.time_increment = 1.0/10.0;
  scan.scan_time = 1.0/10.0;
  scan.range_min = KHEPERAIV_LIDAR_SENSORS_FAN_RADIUS + KHEPERAIV_LIDAR_SENSORS_RING_RANGE.GetMin();
  scan.range_max = KHEPERAIV_LIDAR_SENSORS_FAN_RADIUS + KHEPERAIV_LIDAR_SENSORS_RING_RANGE.GetMax();

  vector<float> lidarReadings;
  for(size_t j = 0; j < m_pcLIDAR->GetNumReadings(); ++j ){
    lidarReadings.push_back((float)m_pcLIDAR->GetReading(j)/100);
  }
  scan.ranges = lidarReadings;
  laserScanPub.publish(scan);
}

void CKheperaIVRos::publishLineOfSight(){
  // broadcast current robot to all LOS
  char const *c = GetId().c_str();
  for(int i=0;i<10;i++){
    int offset = -1*i+(10);
    m_pcRABA->SetData(i, c[GetId().length()-offset]);
  }

  // write all robot names within los to rosmsg
  const CCI_RangeAndBearingSensor::TReadings& packets = m_pcRABS->GetReadings();
  losList loslist;
  loslist.n = packets.size();
  for(size_t i = 0; i < packets.size(); ++i){
    los losmsg;
    const unsigned char *data = packets[i].Data.ToCArray();
    std::string s( reinterpret_cast<char const*>(data), packets[i].Data.Size());
    losmsg.robotName = s;
    loslist.robots.push_back(losmsg);
  }
  losPub.publish(loslist);
}

void CKheperaIVRos::publishProximity(){
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
   proximityPub.publish(proxList);
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

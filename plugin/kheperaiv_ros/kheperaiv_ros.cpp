/* Include ros */
#include "ros/ros.h"
#include "argos_bridge/Proximity.h"
#include "argos_bridge/ProximityList.h"
#include "argos_bridge/los.h"
#include "argos_bridge/losList.h"
#include "sensor_msgs/LaserScan.h"
#include "nav_msgs/Odometry.h"
#include "rosgraph_msgs/Clock.h"

/* Include the controller definition */
#include "kheperaiv_ros.h"
/* Function definitions for XML parsing */
#include <argos3/core/utility/configuration/argos_configuration.h>
/* 2D vector definition */
#include <argos3/core/utility/math/vector2.h>
/* Logging */
#include <argos3/core/utility/logging/argos_log.h>


#include <iostream>
#include <memory>
#include <sstream>

#include <tf/transform_broadcaster.h>
#include <ros/callback_queue.h>
#include <std_msgs/String.h>

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
{
  odom_broadcaster = std::make_unique<tf::TransformBroadcaster>();
}
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
  stringstream odomTopic;
  odomTopic << "/" << GetId() << "/odom";
  odomPub = nodeHandle->advertise<nav_msgs::Odometry>(odomTopic.str(), 1);
  stringstream laserScanTopic;
  laserScanTopic << "/" << GetId() << "/scan";
  laserScanPub = nodeHandle->advertise<sensor_msgs::LaserScan>(laserScanTopic.str(), 1);
  
  // Create the subscribers
  stringstream cmdVelTopic;
  cmdVelTopic << GetId() << "/cmd_vel";
  cmdVelSub = nodeHandle->subscribe(cmdVelTopic.str(), 1, &CKheperaIVRos::cmdVelCallback, this);



  // Get sensor/actuator handles
   m_pcWheels    = GetActuator<CCI_DifferentialSteeringActuator>("differential_steering");
   m_pcEncoder   = GetSensor  <CCI_DifferentialSteeringSensor  >("differential_steering");
   m_pcProximity = GetSensor  <CCI_KheperaIVProximitySensor    >("kheperaiv_proximity"  );
   m_pcRABA      = GetActuator<CCI_RangeAndBearingActuator     >("range_and_bearing"    );
   m_pcRABS      = GetSensor  <CCI_RangeAndBearingSensor       >("range_and_bearing"    );
   m_pcLIDAR     = GetSensor  <CCI_KheperaIVLIDARSensor        >("kheperaiv_lidar"      );
}

void CKheperaIVRos::ControlStep() {
  this->updateTime();
  this->publishLineOfSight();
  this->publishProximity();
  this->publishLIDAR();
  this->publishOdometry();
  this->debug(true);
  // Wait for any callbacks to be called.
  ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0.1));
}

void CKheperaIVRos::debug(bool debug){
  if (!debug){
    return;
  }
  RLOG << time.toSec() << std::endl;
  /* Print encoder values */
  RLOG << "Encoder values: "
    << "VL=" << m_pcEncoder->GetReading().VelocityLeftWheel << ", "
    << "VR=" << m_pcEncoder->GetReading().VelocityRightWheel << ", "
    << "DL=" << m_pcEncoder->GetReading().CoveredDistanceLeftWheel << ", "
    << "DR=" << m_pcEncoder->GetReading().CoveredDistanceRightWheel
    << std::endl;
}

void CKheperaIVRos::updateTime(){
  // updates rostime to sync all ros processes to argos clock

}

void CKheperaIVRos::publishLIDAR(){
  sensor_msgs::LaserScan scan;
  scan.header.stamp = time;
  string frame = GetId() + "/base_footprint";
  scan.header.frame_id = frame;
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
  char const *c = parse_id_number(GetId());
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

    // I believe the packets are encoded in a non ASCII format.
    // Therefore, when converting to a string, we still see crazy characters.
    // Question: Where is the data from m_pcRABS->GetReadings() comming from? 

    // argos::CByteArray packets[i]
    // Docs: https://www.argos-sim.info/api/a02302.php

    const unsigned char* data = packets[i].Data.ToCArray();
    std::string s(reinterpret_cast<const char*>(data), packets[i].Data.Size());
    losmsg.robotName.data = s;
    loslist.robots.push_back(losmsg);
  }
  losPub.publish(loslist);
}

char const* CKheperaIVRos::parse_id_number(const std::string data){
  return data.c_str();
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

void CKheperaIVRos::publishOdometry(){
  odom_Vl = m_pcEncoder->GetReading().VelocityLeftWheel;
  odom_Vr = m_pcEncoder->GetReading().VelocityRightWheel;
  odom_w = (odom_Vr - odom_Vl)/2*KHEPERAIV_BASE_RADIUS;

  /*
   * Update forward kinematic model of differental drive robot.
   */
  
  if (abs(odom_w) < goStraightConstant*2*KHEPERAIV_BASE_RADIUS){
    // R is infinte so manually set x,y translations to drive straight
    odom_w = 0.0;
    odom_x += ((odom_Vl + odom_Vr)/2)*cos(odom_yaw)*timestep;
    odom_dx = ((odom_Vl + odom_Vr)/2)*cos(odom_yaw);  
    odom_y += ((odom_Vl + odom_Vr)/2)*sin(odom_yaw)*timestep; 
    odom_dy = ((odom_Vl + odom_Vr)/2)*sin(odom_yaw);  
  }else if ((odom_Vr - odom_Vl) < goStraightConstant){
    // R is zero so manually set the yaw translation to drive in a circle
    odom_yaw += ((odom_Vl+odom_Vr)*timestep)/KHEPERAIV_BASE_RADIUS;
    odom_dx = 0.0;
    odom_dy = 0.0;
  }else{
    // set x,y and yaw as normal
    double R = KHEPERAIV_BASE_RADIUS *((odom_Vr + odom_Vl)/(odom_Vr - odom_Vl));
    double ICCx = odom_x -  R*sin(odom_yaw);
    double ICCy = odom_y +  R*cos(odom_yaw);
    odom_x += cos(odom_w*timestep)*(odom_x - ICCx) - sin(odom_w*timestep)*(odom_y - ICCy) + ICCx;
    odom_dx = (cos(odom_w*timestep)*(odom_x - ICCx) - sin(odom_w*timestep)*(odom_y - ICCy) + ICCx)/timestep;
    odom_y += sin(odom_w*timestep)*(odom_x - ICCx) + cos(odom_w*timestep)*(odom_y - ICCy) + ICCy;
    odom_dy = (sin(odom_w*timestep)*(odom_x - ICCx) + cos(odom_w*timestep)*(odom_y - ICCy) + ICCy)/timestep;
    odom_yaw += odom_w*timestep;
  }

  /*
   * publish odom messages and TF transform
   */
  string header_frame_id = GetId() + "/odom";
  string child_frame_id = GetId() + "/base_footprint";
  geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(odom_yaw);

  geometry_msgs::TransformStamped odom_trans;
  odom_trans.header.stamp = time;
  odom_trans.header.frame_id = header_frame_id;
  odom_trans.child_frame_id = child_frame_id;
  odom_trans.transform.translation.x = odom_x;
  odom_trans.transform.translation.y = odom_y;
  odom_trans.transform.translation.z = 0.0;
  odom_trans.transform.rotation = odom_quat;
  odom_broadcaster->sendTransform(odom_trans);

  nav_msgs::Odometry odom;
  odom.header.stamp = time;
  odom.header.frame_id = header_frame_id;
  odom.pose.pose.position.x = odom_x;
  odom.pose.pose.position.y = odom_y;
  odom.pose.pose.position.z = 0.0;
  odom.pose.pose.orientation = odom_quat;
  odom.child_frame_id = child_frame_id;
  odom.twist.twist.linear.x = odom_dx;
  odom.twist.twist.linear.y = odom_dy;
  odom.twist.twist.angular.z = odom_w;

  odomPub.publish(odom);
}

void CKheperaIVRos::cmdVelCallback(const geometry_msgs::Twist& twist) {
  RLOG << "cmdVelCallback: " << GetId() << endl;

  Real v = twist.linear.x;  // Forward speed
  Real w = twist.angular.z; // Rotational speed
  if (abs(w) < goStraightConstant*2*KHEPERAIV_BASE_RADIUS){
    w = 0.0;
  }
  // Use the kinematics of a differential-drive robot to derive the left
  // and right wheel speeds.
  leftSpeed = (v - KHEPERAIV_BASE_RADIUS * w) / KHEPERAIV_WHEEL_RADIUS;
  rightSpeed = (v + KHEPERAIV_BASE_RADIUS * w) / KHEPERAIV_WHEEL_RADIUS;
  m_pcWheels->SetLinearVelocity(leftSpeed, rightSpeed);
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

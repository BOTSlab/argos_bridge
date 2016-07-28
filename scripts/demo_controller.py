#!/usr/bin/env python

"""
Demo controller for controlling an ARGoS simulated robot via argos_bridge.
The algorithm implemented here is a simple state machine designed to push
pucks to the walls.  If the proximity sensor detects an obstacle (other robot
or wall) then it moves away from it for a fixed period.
"""
import rospy
import math, random
from argos_bridge.msg import Puck
from argos_bridge.msg import PuckList
from argos_bridge.msg import Proximity
from argos_bridge.msg import ProximityList
from geometry_msgs.msg import Twist

class DemoController:

    cmdVelPub = None
    puckList = None
    state = "WANDER"
    time = 0
    stateStartTime = 0
    lastTwist = None
    
    # Constants
    MAX_FORWARD_SPEED = 1
    MAX_ROTATION_SPEED = 2.5

    def __init__(self):
        self.cmdVelPub = rospy.Publisher('cmd_vel', Twist, queue_size=1)
        rospy.Subscriber('puck_list', PuckList, self.pucks_callback)
        rospy.Subscriber('proximity', ProximityList, self.prox_callback)

    def pucks_callback(self, puckList):
        # All the action happens in 'prox_callback'.  Just store this most
        # list of pucks for use there.
        self.puckList = puckList

    def prox_callback(self, proxList):
        self.time += 1

        # Find the closest obstacle (other robot or wall).  The closest obstacle
        # is the one with the greatest 'value'.
        closestObs = None
        highestValue = 0
        for prox in proxList.proximities:
            if prox.value > highestValue:
                closestObs = prox
                highestValue = prox.value

        # Find the closest puck
        closestPuck = None
        closestRange = float('inf')
        if self.puckList != None:
            for puck in self.puckList.pucks:
                if puck.range < closestRange:
                    closestPuck = puck
                    closestRange = puck.range

        #
        # Handle state transitions
        #
        if self.state == "AVOID":
            # Only leave this state upon timeout.
            if self.time - self.stateStartTime > 50:
                self.transition("WANDER")

        elif self.state == "PUSHING_PUCK":
            if closestObs != None:
                self.transition("AVOID")
            elif closestPuck == None or \
                 self.time - self.stateStartTime > 50:
                self.transition("WANDER")

        elif self.state == "WANDER":
            if closestObs != None:
                self.transition("AVOID")
            elif closestPuck != None:
                self.transition("PUSHING_PUCK")

        else:
            die("Error: Invalid state")
        
        #
        # Handle state actions
        #
        print "State: " + self.state
        twist = None
        if self.state == "AVOID":
            if closestObs == None:
                twist = self.lastTwist
            else:
                twist = self.twistTowardsThing(closestObs, True)

        elif self.state == "PUSHING_PUCK":
            twist = self.twistTowardsThing(closestPuck)

        elif self.state == "WANDER":
            twist = self.twistRandom()

        else:
            die("Error: Invalid state")
        
        self.cmdVelPub.publish(twist)
        self.lastTwist = twist

    def transition(self, newState):
        self.state = newState
        self.stateStartTime = self.time

    def twistTowardsThing(self, thing, backwards=False):
        """ Using Python's duck typing to move towards the 'thing' whether it
            is a puck or an obstacle. If backwards is true then back away. """
        v = 0
        w = 0
        if math.fabs(thing.angle) < 0.5:
            # The thing is roughly forwards, go towards it
            if backwards:
                v = -self.MAX_FORWARD_SPEED
            else:
                v = self.MAX_FORWARD_SPEED
        elif thing.angle < 0:
            # Turn right
            w = -self.MAX_ROTATION_SPEED
        elif thing.angle > 0:
            # Turn left
            w = self.MAX_ROTATION_SPEED
        twist = Twist()
        twist.linear.x = v
        twist.angular.z = w
        return twist

    def twistRandom(self):
        twist = Twist()
        twist.linear.x = self.MAX_FORWARD_SPEED * random.random()
        twist.angular.z = self.MAX_ROTATION_SPEED * (random.random() - 0.5)
        return twist

if __name__ == '__main__':
    rospy.init_node("demo_controller")
    controller = DemoController()
    rospy.spin()

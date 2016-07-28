#!/usr/bin/env python

"""
Launch a demo controller for an ARGoS simulated robot via argos_bridge.
"""

import rospy, sys
import demo_controller

if __name__ == '__main__':

    # The command line argument gives the name of the node and the
    # corresponding bot.
    if len(sys.argv) != 2:
        sys.exit("usage:\n\tlaunch_demo_controller.py BOT_NAME")
    name = sys.argv[1]

    controller = demo_controller.DemoController(name)
    rospy.spin()

#!/bin/bash
autopep8 carla_ros_bridge/src/carla_ros_bridge/*.py --in-place --max-line-length=100
autopep8 carla_ros_bridge_lifecycle/src/carla_ros_bridge_lifecycle/*.py --in-place --max-line-length=100
autopep8 carla_ackermann_control/src/carla_ackermann_control/*.py --in-place --max-line-length=100

pylint --rcfile=.pylintrc carla_ackermann_control/src/carla_ackermann_control/ carla_ros_bridge/src/carla_ros_bridge/ carla_ros_bridge_lifecycle/src/carla_ros_bridge_lifecycle/

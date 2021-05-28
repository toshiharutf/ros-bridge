#!/bin/sh

usage() { echo "Usage: $0 [-t <tag>] [-i <image>]" 1>&2; exit 1; }

# Defaults
DOCKER_IMAGE_NAME="carla-ros-bridge"
TAG="foxy"

while getopts ":ht:i:" opt; do
  case $opt in
    h)
      usage
      exit
      ;;
    t)
      TAG=$OPTARG
      ;;
    i)
      DOCKER_IMAGE_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

echo "Using $DOCKER_IMAGE_NAME:$TAG"

xhost +local:root

docker run \
    -it --rm \
     --runtime=nvidia \
    -e DISPLAY=$DISPLAY \
    --privileged \
    --gpus all \
    --net=host \
    --label=docker_ros2 \
    "$DOCKER_IMAGE_NAME:$TAG" "$@" \
    ros2 launch carla_ros_bridge carla_ros_bridge.launch.py

xhost -local:root
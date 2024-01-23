#!/bin/bash

DOCKER_REGISTORY=`yq eval '.registory' ../config.yaml`
CONTROLLER_REPOS=`yq eval '.images.linetrace_control.repository' ../config.yaml`
CONTROLLER_TAG=`yq eval '.images.linetrace_control.tag' ../config.yaml`
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

docker run -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix --net=host $CONTROLLER_IMAGE python controller.py

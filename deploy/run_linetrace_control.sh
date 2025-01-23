#!/bin/bash

DOCKER_REGISTORY=`envsubst < ../config.yaml | yq eval '.registory'`
CONTROLLER_REPOS=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.tag'`
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

docker run -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix --net=host $CONTROLLER_IMAGE python controller.py

#!/bin/bash

# Before running this script,
# set the AWS account ID to the environment variable AWS_ACCOUNT.

CONFIG=$(cat config.yaml | sed "s/__AWS_ACCOUNT__/${AWS_ACCOUNT}/")
DOCKER_REGISTORY=`echo "$CONFIG" | yq eval '.registory'`
CONTROLLER_REPOS=`echo "$CONFIG" | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`echo "$CONFIG" | yq eval '.images.linetrace_control.tag'`
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

docker run -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix --net=host $CONTROLLER_IMAGE python controller.py

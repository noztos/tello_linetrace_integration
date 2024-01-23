#!/bin/bash

DOCKER_REGISTORY=`yq eval '.registory' ../config.yaml`
TELEOPKEY_REPOS=`yq eval '.images.teleop_key.repository' ../config.yaml`
TELEOPKEY_TAG=`yq eval '.images.teleop_key.tag' ../config.yaml`
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

docker run -it --net=host $TELEOPKEY_IMAGE python teleop_key.py

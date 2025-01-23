#!/bin/bash

DOCKER_REGISTORY=`envsubst < ../config.yaml | yq eval '.registory'`
TELEOPKEY_REPOS=`envsubst < ../config.yaml | yq eval '.images.teleop_key.repository'`
TELEOPKEY_TAG=`envsubst < ../config.yaml | yq eval '.images.teleop_key.tag'`
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

docker run -it --net=host $TELEOPKEY_IMAGE python teleop_key.py

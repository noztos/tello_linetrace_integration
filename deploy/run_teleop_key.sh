#!/bin/bash

# Before running this script,
# set the AWS account ID to the environment variable AWS_ACCOUNT.

CONFIG=$(cat config.yaml | sed "s/__AWS_ACCOUNT__/${AWS_ACCOUNT}/")
DOCKER_REGISTORY=`echo "$CONFIG" | yq eval '.registory'`
TELEOPKEY_REPOS=`echo "$CONFIG" | yq eval '.images.teleop_key.repository'`
TELEOPKEY_TAG=`echo "$CONFIG" | yq eval '.images.teleop_key.tag'`
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

docker run -it --net=host $TELEOPKEY_IMAGE python teleop_key.py

#!/bin/bash

# Before running this script,
# set the AWS account ID to the environment variable AWS_ACCOUNT.

CONFIG=$(cat config.yaml | sed "s/__AWS_ACCOUNT__/${AWS_ACCOUNT}/")
DOCKER_REGISTORY=`echo "$CONFIG" | yq eval '.registory'`
CONTROLLER_REPOS=`echo "$CONFIG" | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`echo "$CONFIG" | yq eval '.images.linetrace_control.tag'`
TELEOPKEY_REPOS=`echo "$CONFIG" | yq eval '.images.teleop_key.repository'`
TELEOPKEY_TAG=`echo "$CONFIG" | yq eval '.images.teleop_key.tag'`

CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.ap-northeast-1.amazonaws.com

docker pull $CONTROLLER_IMAGE
docker pull $TELEOPKEY_IMAGE

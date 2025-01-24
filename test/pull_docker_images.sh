#!/bin/bash

# Before running this script,
# set the AWS account ID to the environment variable AWS_ACCOUNT.

CONFIG=$(cat config.yaml | sed "s/__AWS_ACCOUNT__/${AWS_ACCOUNT}/")
DOCKER_REGISTORY=`echo "$CONFIG" | yq eval '.registory'`
SIMULATOR_REPOS=`echo "$CONFIG" | yq eval '.images.simulator.repository'`
SIMULATOR_TAG=`echo "$CONFIG" | yq eval '.images.simulator.tag'`
BRIDGE_REPOS=`echo "$CONFIG" | yq eval '.images.bridge.repository'`
BRIDGE_TAG=`echo "$CONFIG" | yq eval '.images.bridge.tag'`
CONTROLLER_REPOS=`echo "$CONFIG" | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`echo "$CONFIG" | yq eval '.images.linetrace_control.tag'`
SIMULATOR_IMAGE=$DOCKER_REGISTORY/$SIMULATOR_REPOS:$SIMULATOR_TAG
BRIDGE_IMAGE=$DOCKER_REGISTORY/$BRIDGE_REPOS:$BRIDGE_TAG
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.ap-northeast-1.amazonaws.com

docker pull $SIMULATOR_IMAGE
docker pull $BRIDGE_IMAGE
docker pull $CONTROLLER_IMAGE

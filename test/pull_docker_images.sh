#!/bin/bash

DOCKER_REGISTORY=`envsubst < ../config.yaml | yq eval '.registory'`
SIMULATOR_REPOS=`envsubst < ../config.yaml | yq eval '.images.simulator.repository'`
SIMULATOR_TAG=`envsubst < ../config.yaml | yq eval '.images.simulator.tag'`
BRIDGE_REPOS=`envsubst < ../config.yaml | yq eval '.images.bridge.repository'`
BRIDGE_TAG=`envsubst < ../config.yaml | yq eval '.images.bridge.tag'`
CONTROLLER_REPOS=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.tag'`
SIMULATOR_IMAGE=$DOCKER_REGISTORY/$SIMULATOR_REPOS:$SIMULATOR_TAG
BRIDGE_IMAGE=$DOCKER_REGISTORY/$BRIDGE_REPOS:$BRIDGE_TAG
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.ap-northeast-1.amazonaws.com

docker pull $SIMULATOR_IMAGE
docker pull $BRIDGE_IMAGE
docker pull $CONTROLLER_IMAGE

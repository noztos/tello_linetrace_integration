#!/bin/bash

DOCKER_REGISTORY=`yq eval '.registory' ../config.yaml`
CONTROLLER_REPOS=`yq eval '.images.linetrace_control.repository' ../config.yaml`
CONTROLLER_TAG=`yq eval '.images.linetrace_control.tag' ../config.yaml`
TELEOPKEY_REPOS=`yq eval '.images.teleop_key.repository' ../config.yaml`
TELEOPKEY_TAG=`yq eval '.images.teleop_key.tag' ../config.yaml`

CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 964246069091.dkr.ecr.ap-northeast-1.amazonaws.com

docker pull $CONTROLLER_IMAGE
docker pull $TELEOPKEY_IMAGE

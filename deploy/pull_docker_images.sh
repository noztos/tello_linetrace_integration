#!/bin/bash

DOCKER_REGISTORY=`envsubst < ../config.yaml | yq eval '.registory'`
CONTROLLER_REPOS=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.repository'`
CONTROLLER_TAG=`envsubst < ../config.yaml | yq eval '.images.linetrace_control.tag'`
TELEOPKEY_REPOS=`envsubst < ../config.yaml | yq eval '.images.teleop_key.repository'`
TELEOPKEY_TAG=`envsubst < ../config.yaml | yq eval '.images.teleop_key.tag'`

CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG
TELEOPKEY_IMAGE=$DOCKER_REGISTORY/$TELEOPKEY_REPOS:$TELEOPKEY_TAG

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.ap-northeast-1.amazonaws.com

docker pull $CONTROLLER_IMAGE
docker pull $TELEOPKEY_IMAGE

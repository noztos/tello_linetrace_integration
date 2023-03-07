#!/bin/bash

DOCKER_REGISTORY=`yq eval '.registory' ../config.yaml`
SIMULATOR_REPOS=`yq eval '.images.simulator.repository' ../config.yaml`
SIMULATOR_TAG=`yq eval '.images.simulator.tag' ../config.yaml`
BRIDGE_REPOS=`yq eval '.images.bridge.repository' ../config.yaml`
BRIDGE_TAG=`yq eval '.images.bridge.tag' ../config.yaml`
CONTROLLER_REPOS=`yq eval '.images.linetrace_control.repository' ../config.yaml`
CONTROLLER_TAG=`yq eval '.images.linetrace_control.tag' ../config.yaml`
SIMULATOR_IMAGE=$DOCKER_REGISTORY/$SIMULATOR_REPOS:$SIMULATOR_TAG
BRIDGE_IMAGE=$DOCKER_REGISTORY/$BRIDGE_REPOS:$BRIDGE_TAG
CONTROLLER_IMAGE=$DOCKER_REGISTORY/$CONTROLLER_REPOS:$CONTROLLER_TAG

export SIMULATOR_IMAGE
export BRIDGE_IMAGE
export CONTROLLER_IMAGE

docker-compose up -d
sleep 10
python3 test.py
sleep 10
docker-compose down

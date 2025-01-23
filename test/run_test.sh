#!/bin/bash

if [ -z "$1" ]; then
  echo "Missing simulator_env.json file path argument"
  exit 1
fi
SIMULATOR_ENV_PATH="$1"
echo $SIMULATOR_ENV_PATH

xhost +

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

export SIMULATOR_IMAGE
export BRIDGE_IMAGE
export CONTROLLER_IMAGE
export SIMULATOR_ENV=$SIMULATOR_ENV_PATH

docker-compose up -d
sleep 10
python3 test.py
sleep 10
docker-compose down

xhost -

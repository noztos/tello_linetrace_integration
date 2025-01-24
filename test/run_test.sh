#!/bin/bash

# Before running this script,
# set the AWS account ID to the environment variable AWS_ACCOUNT.

if [ -z "$1" ]; then
  echo "Missing simulator_env.json file path argument"
  exit 1
fi
SIMULATOR_ENV_PATH="$1"
echo $SIMULATOR_ENV_PATH

xhost +

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

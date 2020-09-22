#!/bin/bash


export COMPONENT="$1"
if [ -z "$COMPONENT" ]
then
  echo "Please provide component name"
  exit -1
fi

export SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPT_DIR/${COMPONENT}


if [ -z "$ACCOUNT_ID" ]
then
  export ACCOUNT_ID=150233218091
fi


docker build -t ${COMPONENT} .

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com


docker tag ${COMPONENT}:latest ${ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com/${COMPONENT}:latest

docker push ${ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com/${COMPONENT}:latest

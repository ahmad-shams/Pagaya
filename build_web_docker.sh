#!/bin/bash


export COMPONENT="$1"
if [ -z "$COMPONENT" ]
then
  echo "Please provide component name"
  exit -1
fi

export SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPT_DIR/${COMPONENT}


if [ -z "$AWS_ACCOUNT_ID" ]
then
  export AWS_ACCOUNT_ID=150233218091
fi


docker build -t ${COMPONENT} .

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com


docker tag ${COMPONENT}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com/${COMPONENT}:latest

docker push ${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-2.amazonaws.com/${COMPONENT}:latest

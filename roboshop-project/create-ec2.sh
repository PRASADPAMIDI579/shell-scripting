#!/bin/bash

#LOG=/tmp/instance-create.log
#rm -f $LOG

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo -e "\e[1;31mInstance Name argument is needed\e[0m"
  exit
  fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;34mUnable to find image AMI_ID\e[0m"
  exit
  else
    echo -e "\e[1;33mAMI ID = ${AMI_ID}\e[0m"
  fi

PRIVATE_IP=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${INSTANCE_NAME} --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

if [ -z "${PRIVATE_IP}" ]; then

    aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,
    Tags=[{key=Name,value=${INSTANCE_NAME}}]"
 #  echo -e "\e[1m Instance Created"
  else
    echo "Instance ${INSTANCE_NAME} is already exists, Hence not creating"
    exit
fi


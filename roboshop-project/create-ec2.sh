#!/bin/bash

aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text

if [ -z "${AMI_ID}" ]; then
  echo "unable to find image AMI_ID"
  fi
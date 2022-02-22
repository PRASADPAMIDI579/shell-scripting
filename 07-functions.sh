#!/bin/bash

# declare a function
SAMPLE() {

  a=20
  b=20
  echo " WELCOME TO DEVOPS TRAINING "
  echo " WELCOME TO DEVOPS TRAINING "
  return
  echo " WELCOME TO DEVOPS TRAINING "
  echo " WELCOME TO DEVOPS TRAINING "
}

#main program
#call the function
a=10
SAMPLE
SAMPLE
b=10

SAMPLE1(){
  echo First Argument in Function =$1
  return 1
}

echo First argument in main program =$1
SAMPLE1 ABC
echo $?

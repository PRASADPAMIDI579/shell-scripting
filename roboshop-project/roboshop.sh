#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ]; then  # -ne is not equal to
  echo -e "\e[1;33m you shouls be a root user to execute the script \e[0m"
  exit
  fi

if [ -f component/$1.sh ]; then
  bash component/$1.sh
  else
    echo -e "\e[1;31mInvalid Input\e[0m"
    echo -e "\e[1;33mAvailable Inputs - frontend|MongoDB|catalouge|redis|user|cart|mysql|shipping|payment|rabbitmq|dispatch\e[0m"
    
fi
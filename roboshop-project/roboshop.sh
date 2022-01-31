#!/bin/bash

if [ -f component/$1.sh ]; then
  bash component/$1.sh
  else
    echo -e "\e[1;31mInvalid Input\e[0m"
    echo -e "\e[1;33mAvailable Inputs - frontend|MongoDB|catalouge|redis|user|cart|mysql|shipping|payment|rabbitmq|dispatch\e[0m"
    
fi
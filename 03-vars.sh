#!/bin/bash

student_name="Prasad"

echo student_name = $student_name
echo student_name = ${student_name}

DATE=2022-01-27
echo Good morning, today date is $DATE

##command substution
DATE=$(date +%F)
echo Good morning, today date is $DATE

##arthimatic substution
EXPR1=$((2+4*5*6\5))
echo EXPR1 OUTPUT = $EXPR1
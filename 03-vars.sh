#!/bin/bash

student_name="Prasad"

echo student_name = $student_name
echo student_name = ${student_name}

DATE=2022-01-27
echo Good morning, today date is $DATE

##command substution
DATE=$(date %f)
echo Good morning, today date is $DATE
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT()
{
  if [ $1 -eq 0 ]; then                   ## -eq is equal to
    echo -e "\e[1;32m SUCCESS\e[0m"
    else
      echo -e "\e[1;33m FAILED\e[0m"
      exit
      fi
}
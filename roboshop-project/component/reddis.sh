#Redis is used for in-memory data storage and allows users to access the data over API.
#**Manual Installation of Redis.**
#1. Install Redis.
#
#```bash
#
## curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
## yum install redis -y
#```
#
#2. Update the BindIP from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`
#
#3. Start Redis Database
#
#```bash
## systemctl enable redis
## systemctl start redis
#```
#
#
#source component/common.sh

echo "configuring redis repo"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>$LOG_file
STAT $?

echo "install redis"
yum install redis -y &>>$LOG_FILE
STAT $?

echo "update redis configuration"
if [ -f /etc/redis.conf ]; then
  sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf
  elif [ -f /etc/redis/redis.conf ]; then
    sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf
    fi

STAT $?
      

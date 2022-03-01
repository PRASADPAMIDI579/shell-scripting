#This service is responsible for User Logins and Registrations Service in RobotShop e-commerce portal.
#
#1. This service is written in NodeJS, Hence need to install NodeJS in the system.
#
#```bash
## curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
## yum install nodejs gcc-c++ -y
#```
#
#1. Let's now set up the User application.
#
#As part of operating system standards, we run all the applications and databases as a normal user but not with root user.
#
#So to run the User service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use `roboshop` as the username to run the service.
#
#```bash
## useradd roboshop
#```
#
#1. So let's switch to the `roboshop` user and run the following commands.
#
#```bash
#$ curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/user.zip
#$ mv user-main user
#$ cd /home/roboshop/user
#$ npm install
#```
#
#1. Update SystemD service file,
#
#    Update `REDIS_ENDPOINT` with Redis Server IP
#
#    Update `MONGO_ENDPOINT` with MongoDB Server IP
#
#2. Now, lets set up the service with systemctl.
#
#```bash
## mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
## systemctl daemon-reload
## systemctl start user
## systemctl enable user
#```
#
#
echo instaling user
source component/common.sh

echo " setup nodejs.repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -  &>>LOG_FILE
STAT $?

echo " installing nodejs "
yum install nodejs gcc-c++ -y
STAT $?

echo " create app user"
useradd RoboShop &>>LOG_FILE
STAT $?

echo " download the user code "
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>LOG_FILE
STAT $?

echo " extract user file "
cd /tmp/
unzip -o /tmp/user.zip &>>LOG_FILE
STAT $?

echo " clean old content "
rm -rf /home/roboshop/user
STAT $?

echo " copy user content "
cp -r user-main /home/roboshop/user &>>LOG_FILE
STAT $?

echo " install nodeJS dependencies "
cd /home/roboshop/user
npm install &>>LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>LOG_FILE
STAT $?

echo " update systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'
/home/roboshop/user/systemd.service &>>LOG_FILE
STAT $?

echo "setup user SystemD file"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service &>>LOG_FILE
STAT $?

echo " start user"
systemctl daemon-reload &>>LOG_FILE
systemctl start catalogue &>>LOG_FILE
systemctl enable catalogue &>>LOG_FILE
STAT $?

sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'
STAT $?

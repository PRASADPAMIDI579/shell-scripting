#echo instaling catalouge
#
#This service is responsible for showing the list of items that are to be sold by the RobotShop e-commerce portal.
#
##1. This service is written in NodeJS, Hence need to install NodeJS in the system.
#
#```bash
## curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
# yum install nodejs gcc-c++ -y
#
#```
#
#1. Let's now set up the catalogue application.
#
#As part of operating system standards, we run all the applications and databases as a normal user but not with root user.
#
#So to run the catalogue service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use `roboshop` as the username to run the service.
#
#```bash
## useradd roboshop
#
#```
#
#1. So let's switch to the `roboshop` user and run the following commands.
#
#```bash
#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install
#
#```
#
#1. Update SystemD file with correct IP addresses
#
#    Update `MONGO_DNSNAME` with MongoDB Server IP#
#
#2. Now, lets set up the service with systemctl.
#
#```bash
## mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
## systemctl daemon-reload
## systemctl start catalogue
## systemctl enable catalogue
#
#```#

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

echo " download the catalouge code "
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>LOG_FILE
STAT $?

echo " extract catalouge file"
cd /tmp
unzip -o tmp/catalouge.zip &>>LOG_FILE
STAT $?

echo " clean old content "
rm -rf /home/roboshop/catalouge
STAT $?

echo " copy catolouge content "
cp -r catalouge-main /home/roboshop/catalouge &>>LOG_FILE
STAT $?

echo " install nodeJS dependencies "
npm install &>>LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>LOG_FILE
STAT $?

echo " update systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'
/home/roboshop/catalouge/systemd.service &>>LOG_FILE
STAT $?

echo "setup catalouge SystemD file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>LOG_FILE
STAT $?

echo " start catalouge"
systemctl daemon-reload &>>LOG_FILE
systemctl start catalogue &>>LOG_FILE
systemctl enable catalogue &>>LOG_FILE
STAT $?

sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'
STAT $?

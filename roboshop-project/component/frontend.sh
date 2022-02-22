#echo instaling frontend
#
#```
## yum install nginx -y
## systemctl enable nginx
## systemctl start nginx
#
#```
#
#Let's download the HTDOCS content and deploy under the Nginx path.
#
#```
## curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#
#```
#
#Deploy in Nginx Default Location.
#
#```
## cd /usr/share/nginx/html
## rm -rf *
## unzip /tmp/frontend.zip
## mv frontend-main/* .
## mv static/* .
## rm -rf frontend-master README.md
## mv localhost.conf /etc/nginx/default.d/roboshop.conf
#
#```
#
#Finally restart the service once to effect the changes.
#
#```
## systemctl restart nginx
#
#```


#...  > redirecting a file


#echo "installing nginx"
#yum install nginx -y >/tmp/roboshop.log

source common.sh

echo "installing nginx"
yum install nginx -y &>>$LOG_FILE
if [ $? -eq 0 ]; then                   ## -eq is equal to
  echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;33m FAILED\e[0m"
    exit
    fi

#...   >> appending a file
#echo "Download frontend content"
#curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>/tmp/roboshop.log

echo "Download frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

echo "clean the old content"
rm -rf /usr/share/nginx/html/* &>>LOG_FILE

echo "Extract the front content"
cd /tmp
unzip -o /frontend.zip &>>LOG_FILE

echo "copy extracted content to nginx path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>LOG_FILE

echo "copy nginx roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>LOG_FILE

echo "start nginx service"
systemctl enable nginx &>>LOG_FILE
systemctl start nginx >>LOG_FILE
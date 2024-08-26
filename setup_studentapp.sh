#!/bin/bash

sudo setsebool -P httpd_can_network_connect 1

cd /opt/student-app/

#pulling the latest code from the github

git init

git clone https://gitlab.com/rns-app/student-app.git

git clone https://gitlab.com/rns-app/static-project.git

#git pull origin master

#creating the db's and tables along with the username and password

mysql -uroot < /opt/student-app/dbscript/studentapp.sql

#Modifying the managers context.xml file to access the managers application in tomcat

cp /opt/student-app/tomcat/manager/context.xml /opt/appserver/webapps/manager/META-INF/

#Adding user to the tomcat

cp /opt/student-app/tomcat/conf/tomcat-users.xml /opt/appserver/conf/

#Loading db driver to the tomcat to integrate with db

cp /opt/student-app/tomcat/lib/mysql-connector.jar /opt/appserver/lib/

#Integrating tomcat with db

cp /opt/student-app/tomcat/conf/context.xml /opt/appserver/conf/

sudo systemctl restart tomcat

#Setting the java path to java1.8 to build the application

echo 2 | sudo alternatives --config java

#Building the application using Maven

cd /opt/student-app/

mvn clean

#Setting the java path to java1.11 as per the tomcat

echo 1 | sudo alternatives --config java

#Deploying the build artifact to the tomcat webapps folder

cp /opt/student-app/target/*.war /opt/appserver/webapps/student.war

#Deploying static application

sudo rm -rf /usr/share/nginx/html/*

sudo cp -R /opt/static-project/iPortfolio/* /usr/share/nginx/html/

#Reverse proxy config

sudo cp /opt/student-app/nginx/nginx.conf /etc/nginx/

sudo systemctl restart nginx

 


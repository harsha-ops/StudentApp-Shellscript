#!/bin/bash

#updating the system packages

sudo yum update -y

#stopping the firewall

sudo systemctl stop firewalld

#setting the hostname for the server

#sudo hostnamectl set-hostname appserver

#Adding the user devops

sudo useradd devops

#Assigning the devops password to the devops user

echo "devops" | passwd --stdin devops

#Assigning the sudo permissions to the devops user

echo "devops	ALL=(ALL)	NOPASSWD:ALL" | sudo tee -a /etc/sudoers

#changing password authentication no to yes in the sshd_config file

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config


sudo systemctl restart sshd 

#installing all the basic tools

sudo yum install git wget tree zip unzip net-tools bind-utils python2-pip jq -y

sudo su - devops -c "git config --global user.name 'devops'"
sudo su - devops -c "git config --global user.email 'devops@gmail.com'" 

#Installing java11

#sudo yum install java-11-openjdk-devel.x86_64 -y

#sudo yum install

sudo chown -R devops:devops /opt/

cd /opt/

# Maven installation

#wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
#tar -xvzf apache-maven-3.9.6-bin.tar.gz
#rm -rf apache-maven-3.9.6-bin.tar.gz
#mv apache-maven-3.9.6 maven
#sudo su - devops -c "sudo ln -s /opt/maven/bin/mvn /usr/local/bin/mvn"

# Tomcat Installation

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz
tar -xvzf apache-tomcat-9.0.96.tar.gz
rm -rf apache-tomcat-9.0.96.tar.gz
mv apache-tomcat-9.0.96 appserver

sudo chown -R devops:devops /opt/


# Configuring Tomcat as a service

echo "[Unit]
        Description=Tomcat Server
        After=syslog.target network.target

        [Service]
        Type=forking
        User=devops
        Group=devops

        Environment=JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto.x86_64
        Environment='JAVA_OPTS=-Djava.awt.headless=true'
        Environment=CATALINA_HOME=/opt/appserver/
        Environment=CATALINA_BASE=/opt/appserver/
        Environment=CATALINA_PID=/opt/appserver/temp/tomcat.pid
        Environment='CATALINA_OPTS=-Xms512M -Xmx512M'
        ExecStart=/opt/appserver/bin/catalina.sh start
        ExecStop=/opt/appserver/bin/catalina.sh stop

        [Install]
        WantedBy=multi-user.target" > /etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat


# Nginx Setup

sudo yum install nginx -y
systemctl start nginx
systemctl enable nginx

# mariadb setup

sudo yum install mariadb105-server.x86_64 -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

#cloning the source code

#git clone https://gitlab.com/rns-app/student-app.git
git clone https://gitlab.com/rns-app/static-project.git
#sudo yum install java-1.8.0-openjdk-devel.x86_64 -y

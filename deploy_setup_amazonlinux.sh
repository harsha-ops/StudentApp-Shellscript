sudo setsebool -P httpd_can_network_connect 1

# mysql -uroot < ./dbscript/studentapp.sql

# Modifying the managers context.xml file to access the managers application in tomcat

sudo su devops -c "cp ./tomcat/manager/context.xml /opt/appserver/webapps/manager/META-INF/"

# Adding user to the tomcat

sudo su devops -c "cp ./tomcat/conf/tomcat-users.xml /opt/appserver/conf/"

# Loading db driver to the tomcat to integrate with db

sudo su devops -c "cp ./tomcat/lib/mysql-connector.jar /opt/appserver/lib/"

# Integrating tomcat with db

sudo su devops -c "cp ./tomcat/conf/context.xml /opt/appserver/conf/"

#Deploying the build artifact to the tomcat webapps folder

sudo su devops -c "cp /opt/student-app/target/*.war /opt/appserver/webapps/student.war"

sudo systemctl restart tomcat


# Deploying static application

# sudo rm -rf /usr/share/nginx/html/*

# sudo cp -R /opt/static-project/iPortfolio/* /usr/share/nginx/html/

# Reverse proxy config

# sudo cp /opt/student-app/nginx/nginx.conf /etc/nginx/

# sudo systemctl restart nginx

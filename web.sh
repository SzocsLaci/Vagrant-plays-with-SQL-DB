#!/bin/bash
# Create your provisioning script here
echo "Running web.sh provisioner"

apt-get update
apt-get install -y openjdk-11-jre-headless
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
wget -N https://downloads.apache.org/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
mkdir /opt/tomcat
tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
chgrp -vR tomcat /opt/tomcat
chmod -vR g+r conf
chmod -v g+x conf
chown -vR tomcat webapps/ work/ temp/ logs/

# Create service
cat > /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start tomcat
systemctl status tomcat
systemctl enable tomcat


rm -r /opt/tomcat/webapps/*
cp /vagrant/web.war /opt/tomcat/webapps/ROOT.war
systemctl restart tomcat

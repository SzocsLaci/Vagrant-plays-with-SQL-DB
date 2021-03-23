#!/bin/bash
# Create your provisioning script here
echo "Running web1.sh provisioner"

cat > /opt/tomcat/bin/setenv.sh << EOF
export SPRING_DATASOURCE_url=jdbc:postgresql://IP ADDRESS:5432/chinook
export SPRING_DATASOURCE_USERNAME=web1
export SPRING_DATASOURCE_PASSWORD=web1
EOF
systemctl restart tomcat


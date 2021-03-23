#!/bin/bash
# Create your provisioning script here
echo "Running web3.sh provisioner"

cat > /opt/tomcat/bin/setenv.sh << EOF
export SPRING_DATASOURCE_url=jdbc:postgresql://IP ADDRESS:5432/chinook
export SPRING_DATASOURCE_USERNAME=web3
export SPRING_DATASOURCE_PASSWORD=web3
EOF
systemctl restart tomcat


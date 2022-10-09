#!/bin/bash

# NOTE: This entrypoint script will be replace later for 
# master and worker images

# Create pivate and public keys
mkdir .ssh
ssh-keygen -t rsa -b 4096 -f .ssh/id_rsa -P ""
chmod 400 .ssh/id_rsa

# Format Namenode
# Ваш код

# Start SSH Service
echo "Start SSH"
sudo service ssh start

# Start namenode and datanode
# Ваш код

echo "The entrypoint script is completed"

tail -f /dev/null
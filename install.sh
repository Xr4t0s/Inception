#!/bin/bash

############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd mkcert libnss3-tools ntpsec-ntpdate -y

# For snapshots outdated
sudo ntpdate pool.ntp.org

# Start snapd service and install docker and chromium
sudo systemctl start snapd
sudo snap install docker
sudo snap install chromium

# Create browsers trust store
chromium --headless &
sleep 3
pkill chrome

# Generate and install certificates
bash ./requirements/nginx/tools/make-certs.sh

# Adding hostnames to map nitadros.42.fr to localhost
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

sudo mkdir -p /home/nitadros/data/{wp,db}

# Starting containers
sudo docker compose up -d --build

echo "Installed successfully, to run docker without sudo, execute -> newgrp docker"
#!/bin/bash

############ Configure host ############

if [ -f .config ]; then
	docker compose up -d --build
	echo "Installed successfully, to avoid https alert open \
	chrome for the first time if not already done, then execute -> mkcert -install"
	exit
fi

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

# Installing essentials tools
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

# Install CA store and create a certificate for localhost
mkcert -install

# Create certificates for theses addresses
mkcert nitadros.42.fr 127.0.0.1 localhost ::1

# Giving pem files to nginx  
mkdir -p ./requirements/nginx/certs && mv *pem ./requirements/nginx/certs

# Extract root Certificate and install it on host
# This do not work without executin "mkcert -install" again in a new shell
sudo cp $(mkcert -CAROOT)/rootCA.pem /usr/local/share/ca-certificates/mkcert.crt
sudo update-ca-certificates

# Adding hostnames to map nitadros.42.fr to localhost
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

# Creating volumes folders for mariadb and wordpress
sudo mkdir -p /home/inception/data/{wp,db}

echo "{\n\t"installed": true\n}" >> .config 

# Starting containers
sudo docker compose up -d --build

# Success
echo "Installed successfully, to avoid https alert open \
	chrome for the first time if not already done, then execute -> mkcert -install"
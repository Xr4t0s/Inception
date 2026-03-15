#!/bin/bash


############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd mkcert libnss3-tools ntpsec-ntpdate -y

# For snapshots
sudo ntpdate pool.ntp.org

sudo systemctl start snapd

sudo snap install docker

if ! groups | grep docker; then
	sudo groupadd docker
fi
if ! groups "$USER" | grep docker; then
	sudo usermod -aG docker $USER
fi

sudo bash ./requirements/nginx/tools/make-certs.sh
# Adding hostnames
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

sudo docker compose up -d --build

CAROOT=$(sudo docker exec nginx mkcert -CAROOT)
sudo docker exec nginx cat $CAROOT/rootCA.pem > ./rootCA.pem
sudo cp rootCA.pem /usr/local/share/ca-certificates/mkcert.crt
sudo update-ca-certificates
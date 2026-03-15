#!/bin/bash
set -euo pipefail

############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd -y

sudo systemctl start snapd

sudo snap install docker

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Adding hostnames
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

sudo docker compose up -d --build

CAROOT=$(docker exec "$CONTAINER" mkcert -CAROOT)
sudo docker cp nginx:$CAROOT/rootCA.pem .
sudo cp rootCA.pem /usr/local/share/ca-certificates/mkcert.crt
sudo update-ca-certificates
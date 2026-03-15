#!/bin/bash
set -euo pipefail

############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd mkcert libnss3 -y

sudo systemctl start snapd

sudo snap install docker

# Adding hostnames
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

sudo docker compose up -d --build

sudo docker cp nginx:/root/.local/share/mkcert/rootCA.pem .
sudo cp rootCA.pem /usr/local/share/ca-certificates/mkcert.crt
sudo update-ca-certificates
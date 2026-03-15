#!/bin/bash
set -euo pipefail

############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd

sudo systemctl start snapd

sudo snap install docker

# Adding hostnames
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts

sudo docker compose up -d --build
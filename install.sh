#!/bin/bash
set -euo pipefail

############ Configure host ############

# Update environnement
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install snap -y

# Installing docker
sudo snap install docker

# Adding hostnames
echo "127.0.0.1 nitadros.42.fr" | sudo tee -a /etc/hosts
 

#!/bin/bash
set -euo pipefail

############ Install nginx ############

# Installing nginx following the documentation on https://nginx.org/en/docs/install.html
apt-get install -y \
	gnupg2 ca-certificates lsb-release debian-archive-keyring \
	mkcert libnss3-tools \
	curl procps iproute2

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
	| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
https://nginx.org/packages/debian `lsb_release -cs` nginx" \
	| tee /etc/apt/sources.list.d/nginx.list

apt-get update
apt-get install nginx -y

# Install CA store and create a certificate for localhost
mkcert -install
mkcert localhost 127.0.0.0 ::1 nitadros.42.fr

# Adding files to nginx config
mkdir -p /etc/nginx/certs
cp ./localhost+2.pem ./localhost+2-key.pem /etc/nginx/certs/
cp /tmp/conf/nginx.conf /etc/nginx/nginx.conf
cp /tmp/conf/ssl-params.conf /etc/nginx/ssl-params.conf

############ NGINX SHOULD BE READY ############

apt-get update && apt-get upgrade -y
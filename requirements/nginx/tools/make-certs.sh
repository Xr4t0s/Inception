#!/bin/bash

sudo apt-get install -y \
	mkcert libnss3-tools

# Install CA store and create a certificate for localhost
mkcert -install
mkcert nitadros.42.fr 127.0.0.1 localhost ::1

mkdir -p ./requirements/nginx/certs && mv *pem ./requirements/nginx/certs

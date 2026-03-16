#!/bin/bash

# Install CA store and create a certificate for localhost
mkcert -install
mkcert nitadros.42.fr 127.0.0.1 localhost ::1

mkdir -p ./requirements/nginx/certs && mv *pem ./requirements/nginx/certs

sudo cp $(mkcert -CAROOT)/rootCA.pem /usr/local/share/ca-certificates/mkcert.crt
sudo update-ca-certificates


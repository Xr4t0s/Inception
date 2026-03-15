#!/bin/bash
set -euo pipefail

apt-get install -y \
	wget unzip iproute2 procps \
	php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip

wget https://wordpress.org/latest.zip
unzip ./latest.zip

rm -rf /var/www/html/* /var/www/html/.*
mv wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html

sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

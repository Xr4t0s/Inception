#!/bin/bash
set -euo pipefail

wget https://wordpress.org/latest.zip
unzip ./latest.zip

rm -rf /var/www/html/* /var/www/html/.*
mv wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html

sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

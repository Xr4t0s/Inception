#!/bin/bash


curl https://wordpress.org/latest.zip -o ./latest.zip
unzip ./latest.zip

rm -rf /var/www/html/*
mkdir -p /var/www/html
mv wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html

cp ./conf/wp-config.php /var/www/html/wp-config.php

sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

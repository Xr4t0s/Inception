#!/bin/bash
set -euo pipefail

wget https://wordpress.org/latest.zip
unzip ./latest.zip

rm -rf /var/www/html/* /var/www/html/.*
mv wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html

sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

wget 

php8.4-cli ./wp-cli.phar

php8.4-cli /usr/local/bin/wp-cli.phar core install \
  --url="https://${DOMAIN_NAME}" \
  --title="Inception" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASSWORD}" \
  --admin_email="${WP_ADMIN_EMAIL}" \
  --allow-root

php /usr/local/bin/wp-cli.phar user create "$WP_USER" "$WP_USER_EMAIL" \
  --user_pass="$WP_USER_PASSWORD" \
  --path=/website \
	--allow-root
#!/bin/bash

until mysqladmin ping -h mariadb --silent; do
	sleep 1
done

cd /var/www/html

if [ -f wp-config.php ]; then
	rm wp-config.php
fi

if [ ! -f wp-config.php ]; then

	wp core download --allow-root

	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb \
		--allow-root

	wp core install \
		--url=$DOMAIN \
		--title="Inception" \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--allow-root

	wp user create \
		test test@test.com \
		--user_pass=test \
		--allow-root

fi

exec php-fpm8.2 -F
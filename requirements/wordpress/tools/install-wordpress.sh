#!/bin/bash

# Replacing the socket mode to activate port 9000 for nginx
# Docker doesn't permit unix socket between container in a network 
sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

# Check db state
until mysqladmin ping -h mariadb --silent; do
	sleep 1
done

# For file cached by docker
# If wp-config.php is here means that docker cached wordpress files
if [ -f wp-config.php ]; then
	rm -rf *
fi

if [ ! -f wp-config.php ]; then

	# Auto download of https://wordpress.org/latest.zip 
	wp core download --allow-root

	# Create wp-config.php
	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb \
		--allow-root

	# Automated wordpress first configuration
	wp core install \
		--url=$DOMAIN \
		--title="Inception" \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--allow-root

	# Automated user creation
	wp user create \
		test test@test.com \
		--user_pass=test \
		--allow-root

fi

# Success, our wordpress is ready
exec php-fpm8.2 -F
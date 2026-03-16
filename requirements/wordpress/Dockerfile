FROM debian:bookworm

RUN apt update

RUN apt install curl php8.2-fpm php-mysql -y

WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& wp-cli.phar /usr/local/bin/wp-cli

RUN php /usr/local/bin/wp-cli.phar core install \
  --url="https://${DOMAIN_NAME}" \
  --title="Inception" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASSWORD}" \
  --admin_email="${WP_ADMIN_EMAIL}" \
  --allow-root \
	&& php /usr/local/bin/wp-cli.phar user create "$WP_USER" "$WP_USER_EMAIL" \
		--user_pass="$WP_USER_PASSWORD" \
		--path=/website \
		--allow-root	


RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

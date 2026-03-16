FROM debian:bookworm

RUN apt update && apt install -y \
	curl unzip iproute2 procps \
	php8.2-fpm php-mysql mariadb-client

# installer wp-cli
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./tools/install-wordpress.sh /install.sh
RUN chmod +x /install.sh

CMD ["/install.sh"]
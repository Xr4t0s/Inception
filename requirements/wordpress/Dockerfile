FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	wget unzip iproute2 procps \
	php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip

WORKDIR /tmp

RUN wget https://wordpress.org/latest.zip && unzip ./latest.zip
RUN rm -rf /var/www/html/* /var/www/html/.*

COPY ./wordpress/* /var/www/html/

RUN sed -i 's|/run/php/php.*sock|9000|' /etc/php/*/fpm/pool.d/www.conf

COPY ./conf/wp-config.php /var/www/html/wp-config.php

RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]
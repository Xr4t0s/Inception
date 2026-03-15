FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

WORKDIR /tmp

COPY . .

RUN bash ./install-wordpress.sh

COPY ./conf/wp-config.php /var/www/html/wp-config.php

CMD ["php-fpm8.2", "-F"]
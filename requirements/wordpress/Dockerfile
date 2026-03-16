FROM debian:bookworm

RUN apt update && apt full-upgrade -y

RUN apt install php8.4-cli -y

WORKDIR /tmp

COPY . .

RUN bash ./install-wordpress.sh

RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

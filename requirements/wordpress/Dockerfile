FROM debian:bookworm

RUN apt update && apt full-upgrade -y

WORKDIR /tmp

COPY . .

RUN bash ./install-wordpress.sh

RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

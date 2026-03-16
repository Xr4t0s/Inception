FROM debian:bookworm

WORKDIR /tmp

COPY . .

RUN bash ./install-wordpress.sh

RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

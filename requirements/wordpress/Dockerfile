FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	wget unzip iproute2 procps \
	php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip

RUN  apt install php8.4-cli -y
WORKDIR /tmp

COPY . .

RUN bash ./install-wordpress.sh

RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

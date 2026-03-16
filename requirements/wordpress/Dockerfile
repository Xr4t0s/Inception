FROM debian:bookworm

RUN apt update

RUN apt install curl unzip php8.2-fpm php-mysql -y

WORKDIR /tmp

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o ./wp-cli.phar
RUN chmod +x ./wp-cli.phar
RUN mv ./wp-cli.phar /usr/local/bin/wp

COPY . .

RUN ./install-wordpress.sh

RUN wp core install \
	--path="/var/www/html/" \
  --url="https://nitadros.42.fr" \
  --title="Inception" \
  --admin_user="wpuser" \
  --admin_password="password" \
  --admin_email="wpuser@inception.fr" \
  --allow-root \
	&& wp user create "test" "test@test.com" \
		--user_pass="test" \
		--path="/var/www/html/" \
		--allow-root	


RUN rm -rf /tmp/*

CMD ["php-fpm8.2", "-F"]

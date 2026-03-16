FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	curl iproute2 procps \
	mariadb-server mariadb-client

RUN sed -i 's|bind-address = 127.0.0.1|bind-address = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY . .

RUN bash ./install-mariadb.sh

CMD ["mariadbd", "--user=mysql", "--bind-address=0.0.0.0"]
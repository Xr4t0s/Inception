FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	curl iproute2 procps \
	mariadb-server mariadb-client

# Permit other using in the network to access
RUN sed -i 's|bind-address = 127.0.0.1|bind-address = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf

# I don't if useful, legacy
RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/install-mariadb.sh /install.sh

CMD ["bash", "/install.sh"]
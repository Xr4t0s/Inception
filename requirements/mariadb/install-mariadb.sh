#!/bin/bash
set -euo pipefail

apt-get install -y \
	curl iproute2 procps \
	mariadb-server mariadb-client

sed -i 's|bind-address = 127.0.0.1|bind-address = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d /var/lib/mysql ]; then
	echo "Initializing database..."
	mariadbd-install-db --user-mysql --datadir=/var/lib/mysql --skip-test-db
fi

echo "Starting temporary MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock --skip-networking &
pid="$!"

# Attend que ça réponde
for i in {1..30}; do
  if mysql --protocol=socket -S /run/mysqld/mysqld.sock -uroot -e "SELECT 1" &>/dev/null; then
    break
  fi
  sleep 1
done

# Création base + user
mysql --protocol=socket -S /run/mysqld/mysqld.sock -uroot <<-EOSQL
	CREATE DATABASE IF NOT EXISTS wordpress;
	CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';
	GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
	FLUSH PRIVILEGES;
EOSQL

mysqladmin --protocol=socket -S /run/mysqld/mysqld.sock -uroot shutdown
wait "$pid"
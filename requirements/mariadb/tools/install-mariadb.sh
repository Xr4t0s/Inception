#!/bin/bash
set -euo pipefail

# Starting temporary mariadb instance
mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock --skip-networking &
pid="$!"

# Waiting for mariadb to start
for i in {1..30}; do
  if mysql --protocol=socket -S /run/mysqld/mysqld.sock -uroot -e "SELECT 1" &>/dev/null; then
    break
  fi
  sleep 1
done

# When started, execute minmal commandline to create the user for wordpress
mysql --protocol=socket -S /run/mysqld/mysqld.sock -uroot <<-EOSQL
	CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
	CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
	FLUSH PRIVILEGES;
EOSQL

# Now shutdown temporary instance
mysqladmin --protocol=socket -S /run/mysqld/mysqld.sock -uroot shutdown
# Waiting
wait "$pid"

# Success, we can now launch mariadbd
exec mariadbd --user=mysql --bind-address=0.0.0.0
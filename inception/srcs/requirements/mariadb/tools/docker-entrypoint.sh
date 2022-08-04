#!/bin/bash

if [ ! -d /var/lib/mysql/$DB_NAME ]; then
  mysql_install_db
  /usr/share/mariadb/mysql.server start
  mysql -e "\
    CREATE DATABASE IF NOT EXISTS ${DB_NAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; \
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; \
    FLUSH PRIVILEGES; \
    "
  mysqladmin --user=root --password=$DB_ROOT_PASSWORD shutdown
fi

exec "$@"

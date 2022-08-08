#!/bin/bash

if [ ! -d /var/lib/mysql/$DB_NAME ]; then
  mysql_install_db
  mysql -uroot -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
  mysql -uroot -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
  mysql -uroot -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
  mysql -uroot -e "FLUSH PRIVILEGES;"
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
fi

mysqld_safe

#!/bin/bash

if [ ! -d /var/lib/mysql/$DB_NAME ]; then
  service mysql start
  mysql -u root -e "\
    CREATE DATABASE IF NOT EXISTS ${DB_NAME}; \
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; \
    FLUSH PRIVILEGES; \
    "
fi

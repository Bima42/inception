#!/bin/bash

cd /var/www/wordpress

wp core download --allow-root

wp core install \
    --allow-root \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_email=${WP_ADMIN_MAIL} \
    --admin_password=${WP_ADMIN_PASSWORD}

wp user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root

cd -

/usr/sbin/php-fpm7.3 -F

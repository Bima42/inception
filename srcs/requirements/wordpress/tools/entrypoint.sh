#!/bin/bash

# WP="./wp-cli.phar --path=/wordpress"
cd /var/www/wordpress

# $WP core config \
#    --dbname=$DB_NAME \
#    --dbuser=$DB_USER \
#    --dbpass=$DB_PASSWORD \
#    --dbhost=mariadb \
#    --locale=en_EN

wp core install \
    --url=$WP_URL \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_email="$WP_ADMIN_MAIL" \
    --admin_password="$WP_ADMIN_PASSWORD"

wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD"

cd -

php-fpm7.3 -F

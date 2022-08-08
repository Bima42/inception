#!/bin/bash

WP="wp --path=/var/www/wordpress"

cd /var/www/wordpress

$WP core download --allow-root

#wp core config \
#    --dbhost=$DB_HOST \
#    --dbname=$DB_NAME \
#    --dbuser=$DB_USER \
#    --dbpass=$DB_PASSWORD \
#    --dbhost=mariadb \
#    --locale=en_EN

$WP core install \
    --url=$WP_URL \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_email="$WP_ADMIN_MAIL" \
    --admin_password="$WP_ADMIN_PASSWORD"

$WP user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD" --allow-root

cd -

php-fpm7.3 -F

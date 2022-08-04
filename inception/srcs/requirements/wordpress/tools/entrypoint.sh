#!/bin/sh

until mysql --host=mariadb --user=$DB_USER --password=$DB_PASSWORD -e '\c'; do
  echo >&2 "mariadb is unavailable - sleeping"
  sleep 1
done

echo >&2 "mariadb is up - start next wordpress bootstrap"

if ! wp core is-installed; then
  echo >&2 "wordpress is unavailable - start wordpress install"
  wp core download --locale=en_EN --version=5.9.1
  wp config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=mariadb \
    --locale=en_EN

  wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_email="$WP_ADMIN_MAIL" \
    --admin_password="$WP_ADMIN_PASSWORD"

  wp user create --porcelain \
    "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD"

  php-fpm7.3 -F
fi

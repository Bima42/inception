FROM debian:buster

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	mariadb-client \
	php7.3-fpm \
	php7.3-mysql \
	curl

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz

RUN cd /var/www && tar -xvf latest.tar.gz && rm -rf latest.tar.gz && \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir /run/php

COPY wp-config.php /var/www/wp-config.php

COPY ./tools/entrypoint.sh /var/www/wordpress/entrypoint.sh
RUN chmod +x /var/www/wordpress/entrypoint.sh

CMD ["bash", "/var/www/wordpress/entrypoint.sh"]

FROM debian:buster

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	mariadb-client \
	php7.3-fpm \
	php7.3-mysql \
	curl \
	less \
	net-tools

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir /run/php

COPY wp-config.php /var/www/wordpress/wp-config.php

COPY ./tools/entrypoint.sh /var/www/wordpress/entrypoint.sh
RUN chmod 777 /var/www/wordpress/entrypoint.sh

RUN chmod -R 755 /var/www/wordpress

CMD ["bash", "/var/www/wordpress/entrypoint.sh"]

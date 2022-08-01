FROM debian:buster

RUN apt-get -y update && apt-get -y install \
	nginx \
	openssl

COPY conf/nginx.conf /etc/nginx/sites-available/nginx.conf

RUN openssl req -x509 -days 365\
	-newkey rsa:2048 -nodes \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt \
	-sha256 -subj "/CN=tpauvret.42.fr"

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

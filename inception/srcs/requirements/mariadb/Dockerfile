FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

# Describes some variables. This image will be independant from docker-compose file
# Future container will not get those variable (ARG is used, not ENV who pass variables to future container) if container is build without docker-compose
ARG DB_NAME=${DB_NAME}
ARG DB_USER=${DB_USER}
ARG DB_PASSWORD=${DB_PASSWORD}
ARG DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}

# Exposes port only to the other docker containers, not to host
EXPOSE 3306

COPY conf/mariadb-server.cnf /etc/mysql/my.cnf

# Here we run script
COPY tools/docker-entrypoint.sh /
RUN bash ./docker-entrypoint.sh

RUN rm docker-entrypoint.sh

CMD ["mysqld_safe"] 

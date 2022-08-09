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

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

# Here we run script
COPY tools/create_user.sql /
RUN chmod 777 create_user.sql

RUN service mysql start && mysql < create_user.sql && rm -f create_user.sql

CMD ["/usr/bin/mysqld_safe"] 


# Connect to DB :

# sudo docker exec -it mariadb mariadb --user tpauvret -p root
# SHOW DATABASES;
# USE wordpress;
# SHOW TABLES

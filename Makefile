# Colors variables
GREEN = \033[1;32m
RESET = \033[0m

NAME = inception

FILE = srcs/docker-compose.yml

COMPOSE = docker-compose -f ${FILE} -p ${NAME}

all:	volumes build up

build:
	@echo "$(GREEN)██████████████████████████ BUILDING.. ███████████████████████████$(RESET)"
	${COMPOSE} build --no-cache

up:
	@echo "$(GREEN)██████████████████████████ STARTING.. ███████████████████████████$(RESET)"
	${COMPOSE} up -d

launch: rmvolumes volumes
	@echo "$(GREEN)██████████████████████████ BUILD & START ███████████████████████████$(RESET)"
	${COMPOSE} build --no-cache && ${COMPOSE} up -d

nginx:
	@echo "$(GREEN)██████████████████████████ LAUNCH NGINX ████████████████████████████$(RESET)"
	${COMPOSE} build nginx
	${COMPOSE} up -d nginx

mariadb:
	@echo "$(GREEN)██████████████████████████ LAUNCH MARIADB ██████████████████████████$(RESET)"
	${COMPOSE} build mariadb
	${COMPOSE} up -d mariadb

wordpress:
	@echo "$(GREEN)█████████████████████████ LAUNCH WORDPRESS █████████████████████████$(RESET)"
	${COMPOSE} build wordpress
	${COMPOSE} up -d wordpress

down: 
	@echo "$(GREEN)█████████████████████████ DOWN CONTAINERS ██████████████████████████$(RESET)"
	${COMPOSE} down

images:
	@echo "$(GREEN)█████████████████████████████ IMAGES ███████████████████████████████$(RESET)"
	docker images

container:
	@echo "$(GREEN)████████████████████████████ CONTAINERS ████████████████████████████$(RESET)"
	docker ps

rmvolumes: 
	@echo "$(GREEN)█████████████████████ REMOVING VOLUMES ██████████████████████$(RESET)"
	@rm -rf /home/tpauvret/data/mariadb/*
	echo "Successfully removed MariaDB volume in /home/tpauvret/data/mariadb"
	@rm -rf /home/tpauvretdata/wordpress/*
	echo "Successfully removed Wordpress volume in /home/tpauvret/data/wordpress"

volumes:
	@echo "$(GREEN)█████████████████████ CREATING VOLUMES ██████████████████████$(RESET)"
	mkdir -p /home/tpauvret/data/mariadb
	mkdir -p /home/tpauvret/data/wordpress

clean:	rmvolumes
	@echo "$(GREEN)████████████████████████ CLEANING CONTAINERS AND IMAGES █████████████████████████$(RESET)"
	${COMPOSE} down --rmi all -v
	docker system prune -a
#	To remove all images which are not used by existing containers, use the -a flag
	@echo "$(GREEN)████████████████████████ EVERYTHING IS CLEAR ████████████████████████$(RESET)"

re:	clean all

.PHONY:	all build up launch clean nginx mariadb wordpress images container

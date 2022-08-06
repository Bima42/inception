# Colors variables
RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
RESET = \033[0m

NAME = inception

FILE = srcs/docker-compose.yml

COMPOSE = docker-compose -f ${FILE} -p ${NAME}

all:	build up

build:
	@echo "$(GREEN)██████████████████████████ BUILDING.. ███████████████████████████$(RESET)"
	${COMPOSE} build --no-cache

up:
	@echo "$(GREEN)██████████████████████████ STARTING.. ███████████████████████████$(RESET)"
	${COMPOSE} up -d

launch:
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

clean:
	@echo "$(GREEN)████████████████████████ CLEANING CONTAINERS AND IMAGES █████████████████████████$(RESET)"
	${COMPOSE} down --rmi all -v
	docker system prune -a

#	To remove all images which are not used by existing containers, use the -a flag

fclean: clean
	@echo "$(GREEN)██████████████████████████ REMOVE VOLUMES ███████████████████████████$(RESET)"
	@rm -rf /home/tpauvret/data/mariadb/*
	@rm -rf /home/tpauvretdata/wordpress/*
	@echo "$(GREEN)████████████████████████ EVERYTHING IS CLEAR ████████████████████████$(RESET)"

re:	fclean all

.PHONY:	all clean fclean down launch up build nginx mariadb wordpress images container

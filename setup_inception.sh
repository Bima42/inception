#!/bin/bash

GREEN=`tput setaf 2`
RESET=`tput sgr0`


echo "${GREEN}██████████████████████████ SETUP VM ███████████████████████████${RESET}"
echo -e

sudo apt-get update
sudo apt-get upgrade -y

echo -e
echo "${GREEN}██████████████████████████ Install tools ███████████████████████████${RESET}"
echo -e

sudo apt-get install openssh-server make curl ca-certificates git vim curl lsb-release -y

echo -e
echo "${GREEN}██████████████████████████ Install docker ███████████████████████████${RESET}"
echo -e

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli -y
sudo apt-get update

echo -e
echo "${GREEN}██████████████████████████ Install docker-compose ███████████████████████████${RESET}"
echo -e

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e
echo "${GREEN}██████████████████████████ Create volumes ███████████████████████████${RESET}"
echo -e

if [ -d "/home/$USER/data" ]; then \
	echo "Data directory already exists"; else \
	mkdir /home/$USER/data; \
	echo "Data directory created successfully"; \
fi

if [ -d "/home/$USER/data/wordpress" ]; then \
	echo "Wordpress volume already exists"; else \
	mkdir /home/$USER/data/wordpress; \
	echo "Wordpress directory created successfully"; \
fi

if [ -d "/home/$USER/data/mariadb" ]; then \
	echo "MariaDB volume already exists"; else \
	mkdir /home/$USER/data/mariadb; \
	echo "Mariadb directory created successfully"; \
fi

sudo sed-i "s/localhost/tpauvret.42.fr/g" /etc/hosts

echo -e
echo "${GREEN}██████████████████████████ Setup done ███████████████████████████${RESET}"
echo -e

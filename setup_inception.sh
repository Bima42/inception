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

sudo apt-get install openssh-server make curl ca-certificates apt-transport-https software-properties-common gnupg git vim curl lsb-release -y

# Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


echo -e
echo "${GREEN}██████████████████████████ Install docker ███████████████████████████${RESET}"
echo -e

sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt-get update

echo -e
echo "${GREEN}██████████████████████████ Install docker-compose ███████████████████████████${RESET}"
echo -e

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e
echo "${GREEN}██████████████████████████ Create volumes ███████████████████████████${RESET}"
echo -e

if [ -d "/home/tpauvret/data" ]; then \
	echo "Data directory already exists"; else \
	mkdir -p /home/tpauvret/data; \
	echo "Data directory created successfully"; \
fi

if [ -d "/home/tpauvret/data/wordpress" ]; then \
	echo "Wordpress volume already exists"; else \
	mkdir -p /home/tpauvret/data/wordpress; \
	echo "Wordpress directory created successfully"; \
fi

if [ -d "/home/tpauvret/data/mariadb" ]; then \
	echo "MariaDB volume already exists"; else \
	mkdir -p /home/tpauvret/data/mariadb; \
	echo "Mariadb directory created successfully"; \
fi

sudo sed -i "s/localhost/tpauvret.42.fr/g" /etc/hosts

echo -e
echo "${GREEN}██████████████████████████ Setup done ███████████████████████████${RESET}"
echo -e

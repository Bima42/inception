# Inception
- [1. Get Started](#get-started)
- [2. Resume](#resume)
- [3. Docker](#docker)
- [4. Docker Commands](#docker-commands)
- [5. Dockerfile](#dockerfile)
  - [5.1 Dockerfile Commands](dockerfile-commands)
    - [5.1.1 ENV](#env)
    - [5.1.2 USER](#user)
    - [5.1.3 ADD](#add)
    - [5.1.4 COPY](#copy)
    - [5.1.5 EXPOSE](#expose)
    - [5.1.6 CMD / ENTRYPOINT](#cmd-and-entrypoint)
- [6. Docker-compose](#docker-compose)
  - [6.1 Docker-compose commands](#docker-compose-commands)
    - [6.1.1 build](#build)
    - [6.1.2 command](#command)
    - [6.1.3 depends-on](#depends-on)
    - [6.1.4 environment](#environment)
    - [6.1.5 expose](#expose)
    - [6.1.6 networks](#networks)
    - [6.1.7 restart](#restart)
    - [6.1.8 volume](#volume)
- [7. Services](#services)
  - [7.1 MariaDB](#mariadb)
  - [7.2 Wordpress](#wordpress)
  - [7.3 Nginx](#nginx)
- [8. Sources](#sources)

# Get Started
- Set up your VM. I used Debian 10 for my project

- Once your VM is correctly installed, run the script

```
bash ./setup_inception.sh
```

```
make
```

- Go to username.42.fr (if you don't make any changes, use `tpauvret` as username)

# Resume

![resume](/docs/Inception.png)

# Docker
- It's an open source containerization platform.
- Enables developers to package applications into containers—standardized executable components combining application source code with the operating system (OS) libraries and dependencies required to run that code in any environment.
- Based on LCX (LinuX Containers).
- Docker was created to address the portability and efficiency issues of virtual machines.

# Docker Commands
```
/// Main Commands ///
> docker build	             # Build an image from a Dockerfile
> docker ps                  # View active containers
> docker ps -a               # View all containers
> docker rm [container]      # Delete inactive container
> docker images              # List existing images
> docker rmi [image]         # Delete image
> docker inspect [container] # Show container config
> docker build -t [image] .  # Build image from Dockerfile with name [image]
> docker inspect             # Return low-level information on Docker objects
> docker run                 # Run a command in a new container
> docker system prune -a     # Clear system


/// DOCKER COMPOSE ///
> docker-compose up          # Launch group of containers
> docker-compose up -d       # Launch group of containers in background
> docker-compose down        # Stop processes


/// Manage /// 
> docker container           # Manage containers
> docker volume              # Manage volumes
> docker image               # Manage images

```
And [more](https://docs.docker.com/engine/reference/commandline/docker/) ... 

# Dockerfile
- contains the necessary instructions to build a docker image
- instructions describe the actions the image should perform once it is created
- docker image is built by running the **docker build** command.
- by launching a docker build, the **docker daemon** reads each line found in the dockerfile, then performs the requests requested by it

## Dockerfile Commands
| Commands         | Description                                  |
| :----------      |:------------------------------------------   |
| FROM             | Image source                                 |
| ARG              | Variables used as parameters for building    |
| ENV              | Environment variables                        |
| USER             | User ID                                      |
| ADD              | Add file to image                            |
| COPY             | Add file to image                            |
| RUN              | Commands used to build image                 |
| EXPOSE           | Ports listened by container                  |
| CMD/ENTRYPOINT   | Run command at container start               |

![dockerfile](/docs/exemple_dockerfile.png)

### ENV
- ARG is only available at runtime
- ENV can be accessed even when the container created by the image will be launched
- Environment variable = variables necessary for the very execution of the container and the application
- Database credentials are often declared in environment variables.

### USER
- Determine the user or user group that can interact with the image that will be created.

### ADD
- Allows you to copy a file or folder from an internal or external directory to a destination path.
- Generally, this is the source code and dependencies of the application that will be running in the container.

### COPY
- COPY and ADD act the same way BUT
- COPY does not allow importing documents from a remote source such as a URL.
- In general, COPY is used to avoid inconveniences caused by the use of external links authorized by ADD.
- If the destination is not specified, the file or folder will be copied to the root of the file system of the created image.

### EXPOSE
- On the port that will be mentioned that the container will be accessible when a **docker run** command is executed.
- Port exposed using the EXPOSE command can be overridden using the **docker run -p** command.

### CMD and ENTRYPOINT
- CMD allows you to perform an action without the need for additional parameters
- ENTRYPOINT is unchangeable and performs the same action throughout container activation. In this case, it acts as an executable file.

---

# Docker-compose
- Allows you to start multiple containers at the same time
- **docker-compose.yml**: required file that will serve as a guide to run the containers correctly
- used to describe different containers

*Example of docker-compose.yml file*

~~~yml
version: "3.5"

networks:
    inception: {}

services:

#---------------------NGINX------------------------#
    nginx:
        container_name: nginx
        build: ./requirements/nginx
        image: nginx
        networks:
            - inception
        ports:
            - 443:443
        depends_on:
            - wordpress
            - mariadb
        restart: always
        volumes:
            - wordpress_data:/var/www/wordpress


#-------------------WORDPRESS---------------------#
    wordpress:
        container_name: wordpress
        image: wordpress
        build: 
            context: ./requirements/wordpress
        env_file:
            - .env
        networks:
            - inception
        depends_on:
            - mariadb
        restart: always
        volumes:
            - wordpress_data:/var/www/wordpress


#-------------------MARIADB---------------------#
    mariadb:
        container_name: mariadb
        image: mariadb
        build: 
            context: ./requirements/mariadb
        networks:
            - inception
        volumes:
            - mariadb_data:/var/lib/mysql
        env_file:
            - .env
        restart: always

#------------------VOLUMES---------------------#
volumes:
    mariadb_data:
        driver_opts:
            type: "none"
            o: "bind"
            device: "/home/tpauvret/data/mariadb"

    wordpress_data:
        driver_opts:
            type: "none"
            o: "bind"
            device: "/home/tpauvret/data/wordpress"
~~~

## build
- Specifies the build configuration for creating container image from source

## command
- Overrides the default command declared by the container images 
- Can also be a list, similar to Dockerfile

~~~yml
command: bundle exec thin -p 3000

command: [ "bundle", "exec", "thin", "-p", "3000" ]
~~~

## Docker-compose commands
### depends-on
- Expresses startup and shutdown dependencies between services
- Compose implementations MUST create services in dependency order
- Compose implementations MUST remove services in dependency order

~~~yml
services:
  web:
    build: .
    depends_on:
      - db
      - redis
  redis:
    image: redis
  db:
    image: postgres
~~~
_Here, `db` and `redis` are created before `web`. Then `web`, is removed before `db` and `redis`_

### environment
- Defines environment variables set in the container
- Can use either array or map
- Boolean should be enclosed in QUOTE
- Array syntax :

~~~yml
environment:
  - RACK_ENV=development
  - SHOW=true
  - USER_INPUT
~~~

### expose
- Defines ports that Compose implementation MUST expose from container
- Ports **must be accessible to linked services and should not be published to the host machine**

~~~yml
expose:
  - "3000"
  - "8000"
~~~

### networks
- Defines the networks that service containers are attached to

~~~yml
services:
  some-service:
    networks:
      - some-network
      - other-network
~~~

### ports
- Expose container ports
- Port mapping MUST NOT be used with `network_mode: host`

~~~yml
ports:
  - "3000"
  - "3000-3005"
  - "8000:8000"
  - "9090-9091:8080-8081"
  - "49100:22"
~~~

### restart
Define the policy that platform will apply on container termination
- no: The default restart policy. Does not restart a container under any circumstances.
- always: The policy always restarts the container until its removal.
- on-failure: The policy restarts a container if the exit code indicates an error.
- unless-stopped: The policy restarts a container irrespective of the exit code but will stop restarting when the service is stopped or removed.

~~~yml
restart: always
~~~

### volume
- Defines mount hosts paths or named volumes that MUST be accessible by service containers
- **If the mount is a host path and only used by a single service, it MAY be declared as part of the service definition instead of the top-level volumes key.**
- **To reuse a volume across multiple services, a named volume MUST be declared in the top-level volumes key.**

_This example shows a named volume (db-data) being used by the backend service, and a bind mount defined for a single service_

~~~yml
services:
  backend:
    image: awesome/backend
    volumes:
      - type: volume
        source: db-data
        target: /data
        volume:
          nocopy: true
      - type: bind
        source: /var/run/postgres/postgres.sock
        target: /var/run/postgres/postgres.sock

volumes:
  db-data:
~~~
There is some target : 
- type: the mount type volume, bind, tmpfs or npipe
- source: the source of the mount, a path on the host for a bind mount, or the name of a volume defined in the top-level volumes key. Not applicable for a tmpfs mount.
- target: the path in the container where the volume is mounted
- read_only: flag to set the volume as read-only

## EVERYTHING IS [HERE](https://docs.docker.com/compose/compose-file/)

---
# Services

I'll let you find it by yourselves, i'll only give you some docs to check

## MariaDB
- [Definition](https://en.wikipedia.org/wiki/MariaDB)
- [RDBMS](https://fr.wikipedia.org/wiki/Système_de_gestion_de_base_de_données)
- [SQL Commands](https://dev.mysql.com/doc/refman/5.7/en/mysql-command-options.html#option_mysql_execute)

## Wordpress
- [Docs](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lamp-on-debian-10)
- [Other Docs](https://www.inmotionhosting.com/support/edu/wordpress/install-wordpress-debian-10/)

## Nginx
- [Definition](https://kinsta.com/knowledgebase/what-is-nginx/#:~:text=NGINX%20or%20Apache-,How%20Does%20Nginx%20Work%3F,can%20control%20multiple%20worker%20processes.)
- [Create Container](https://www.baeldung.com/linux/nginx-docker-container)
- [OpenSSL req](https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html)
- [Certificates](https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm)
---

## Virtualization / Containers
- Share the same operating system kernel and isolate application processes from the rest of the system
- Run natively on their shared operating system
- Applications and services stay lightweight and run fast in parallel
- Linux container images provide portability and version control of applications
- Uses less resources than a virtual machine
![virtualization_containers](/docs/virtualization_vs_container.png)

## Docker Containers
**Modularity**
- repair or update part of an application without having to deactivate the whole of it
- allows to share processes between different applications

**Layers and image version control**
- each Docker image file is composed of a series of layers
- layers assembled in single image
- each modification of the image leads to the creation of a new layer
- each `run or copy` command -> new layer is created
- Docker reuses its layers for building new containers -> much faster

**Restoration**
- Possible to restore the versions of an image by returning to the ocuches

**Rapid deployment**
- A container for each process, can quickly share similar processes with new applications
- No need to restart OS to add or move container
![lxc_docker](/docs/container_linux_vs_docker.png)

# Sources
- [Docker docs](https://docs.docker.com)
- [Docker Compose](https://docs.docker.com/compose/compose-file/)
- [Docker Compose Tuto](https://www.youtube.com/watch?v=HG6yIjZapSA)
- [FR Tuto](https://www.youtube.com/watch?v=fZZwN_e3LYg)
- [Another tuto](https://www.youtube.com/watch?v=sn6PlRf-UHk&t=1387s)
- [Docker network](https://devopssec.fr/article/fonctionnement-manipulation-reseau-docker#:~:text=Ce%20type%20de%20réseau%20permet,IP%20que%20votre%20machine%20hôte.)
- [MySQL Docs](https://dev.mysql.com/doc/refman/5.7/en/mysql-command-options.html#option_mysql_execute)
- [Creating CSR One command](https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm)
- [Doc OpenSSL req](https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html)

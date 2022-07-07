# Inception
This project is an introduction to Docker. You will find here some docs concerning Docker.

# Docker
- It's an open source containerization platform.
- Enables developers to package applications into containers—standardized executable components combining application source code with the operating system (OS) libraries and dependencies required to run that code in any environment.
- Based on LCX (LinuX Containers).
- Docker was created to address the portability and efficiency issues of virtual machines.

## Docker Commands
```
/// Basic Commands ///
> docker login               # Connect to registry
> docker logout              # Disonnect
> docker search [name]       # Search image
> docker pull [image]        # Pull image
> docker push [image]        # Push image to registry


/// Main Commands ///
> docker build	             # Build an image from a Dockerfile
> docker create	             # Create a new container
> docker ps                  # View active containers
> docker ps -a               # View all containers
> docker rm [container]      # Delete inactive container
> docker images              # List existing images
> docker rmi [image]         # Delete image
> docker inspect [container] # Show container config
> docker build -t [image] .  # Build image from Dockerfile with name [image]
> docker history [image]     # View layers of image
> docker inspect             # Return low-level information on Docker objects
> docker run                 # Run a command in a new container
> docker info                # Display system-wide information
> docker system prune        # Clear system


/// DOCKER COMPOSE ///
> docker-compose up          # Launch group of containers
> docker-compose up -d       # Launch group of containers in background
> docker-compose down        # Stop processes
> docker-compose exec        # Execute command inside service


/// Manage /// 
> docker config              # Manage Docker configs
> docker container           # Manage containers
> docker volume              # Manage volumes
> docker image               # Manage images
> docker service             # Manage services
> docker stack               # Manage Docker stacks
> docker network             # Manage networks
> docker plugin              # Manage plugins
> docker system              # Manage Docker


/// More Commands ///
> docker cp                  # Copy files/folders between a container and the local filesystem
> docker exec                # Run a command in a running container
> docker history             # Show the history of an image
> docker kill                # Kill one or more running containers
> docker port                # List port mappings or a specific mapping for the container
> docker rename              # Rename a container
> docker restart             # Restart one or more containers
> docker search              # Search the Docker Hub for images
> docker start               # Start one or more stopped containers
> docker stats               # Display a live stream of container(s) resource usage statistics
> docker stop                # Stop one or more running containers

```
And [more](https://docs.docker.com/engine/reference/commandline/docker/) ... 

## Dockerfile
- contains the necessary instructions to build a docker image
- instructions describe the actions the image should perform once it is created
- docker image is built by running the **docker build** command.
- by launching a docker build, the **docker daemon** reads each line found in the dockerfile, then performs the requests requested by it

### Dockerfile Commands
| Commands         | Description                                  |
| :----------      |:------------------------------------------   |
| FROM             | Image source                                 |
| ARG              | Variables used as parameters for building    |
| ENV              | Environment variables                        |
| WORKDIR          | Change current path                          |
| USER             | User ID                                      |
| ADD              | Add file to image                            |
| COPY             | Add file to image                            |
| RUN              | Commands used to build image                 |
| EXPOSE           | Ports listened by container                  |
| CM/ENTRYPOINT    | Run command at container start               |

![dockerfile](/docs/exemple_dockerfile.png)

#### ENV
- ARG is only available at runtime
- ENV can be accessed even when the container created by the image will be launched
- Environment variable = variables necessary for the very execution of the container and the application
- Database credentials are often declared in environment variables.

#### WORKDIR
- Build commands (RUN, ADD and COPY) will therefore be assigned to the path mentioned in WORKDIR.
- Same for execution commands (EXPOSE, CMD and ENTRYPOINT)

#### USER
- Determine the user or user group that can interact with the image that will be created.

#### ADD
- Allows you to copy a file or folder from an internal or external directory to a destination path.
- Generally, this is the source code and dependencies of the application that will be running in the container.

#### COPY
- COPY and ADD act the same way BUT
- COPY does not allow importing documents from a remote source such as a URL.
- In general, COPY is used to avoid inconveniences caused by the use of external links authorized by ADD.
- If the destination is not specified, the file or folder will be copied to the root of the file system of the created image.

#### EXPOSE
- On the port that will be mentioned that the container will be accessible when a **docker run** command is executed.
- Port exposed using the EXPOSE command can be overridden using the **docker run -p** command.

#### CMD / ENTRYPOINT
- CMD allows you to perform an action without the need for additional parameters
- ENTRYPOINT is unchangeable and performs the same action throughout container activation. In this case, it acts as an executable file.

## Docker-compose
- Allows you to start multiple containers at the same time
- **docker-compose.yml**: required file that will serve as a guide to run the containers correctly
- used to describe different containers

*Example of docker-compose.yml file*

![docker-compose](/docs/exemple_docker_compose.png)

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
- [FR Tuto](https://www.youtube.com/watch?v=fZZwN_e3LYg)
- [Another tuto](https://www.youtube.com/watch?v=sn6PlRf-UHk&t=1387s)
- [Docker network](https://devopssec.fr/article/fonctionnement-manipulation-reseau-docker#:~:text=Ce%20type%20de%20réseau%20permet,IP%20que%20votre%20machine%20hôte.)

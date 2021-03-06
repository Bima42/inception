# Inception
This project is an introduction to Docker. You will find here some docs concerning Docker.

# Docker
- It's an open source containerization platform.
- Enables developers to package applications into containersâ€”standardized executable components combining application source code with the operating system (OS) libraries and dependencies required to run that code in any environment.
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

---

## Docker-compose
- Allows you to start multiple containers at the same time
- **docker-compose.yml**: required file that will serve as a guide to run the containers correctly
- used to describe different containers

*Example of docker-compose.yml file*

![docker-compose](/docs/exemple_docker_compose.png)

We'll see some object inside Service Element

### build
- Specifies the build configuration for creating container image from source

### command
- Overrides the default command declared by the container images 
- Can also be a list, similar to Dockerfile
~~~yml
command: bundle exec thin -p 3000

command: [ "bundle", "exec", "thin", "-p", "3000" ]
~~~

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
- create_host_path: create a directory at the source path on host if there is nothing present. Do nothing if there is something present at the path. This is automatically implied by short syntax for backward compatibility with docker-compose legacy.
- volume: configure additional volume options
- nocopy: flag to disable copying of data from a container when a volume is created
- size: the size for the tmpfs mount in bytes (either numeric or as bytes unit)

### EVERYTHING IS [HERE](https://docs.docker.com/compose/compose-file/)

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
- [Docker network](https://devopssec.fr/article/fonctionnement-manipulation-reseau-docker#:~:text=Ce%20type%20de%20rĂ©seau%20permet,IP%20que%20votre%20machine%20hĂ´te.)

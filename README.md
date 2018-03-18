# 7 Days To Die Server in a Docker Container

## Maintainers
Mudfly <mudfly@gmail.com>

## Prerequisites
1. Docker Engine
2. docker-compose

## Build and Run Server
1. Clone this repository, and change into the cloned directory
2. Build the Docker image `docker-compose build`
3. Start the 7 Days To Die server `docker-compose up -d`

Note: This container makes use of a data volume under /srv/7dtd on the docker host, in order to persist the generated worlds between container restarts. If you would like to move this to another location, update docker-compose.yaml before launching the container.

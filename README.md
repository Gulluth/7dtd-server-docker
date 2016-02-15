#Docker file for a 7 Days To Die Server

##Maintainers
Mudfly <mudfly@gmail.com>

##Build and Run Server
1. Clone this repository, and change into the directory
2. Copy `server.xml.example` to `server.xml`, and edit to your linking
3. Build the Docker image `docker build --build-arg STEAM_USER=<user> --build-arg STEAM_PASS=<password> --build-arg STEAM_GUARD=<steam guard code> -t 7dtd .`
4. Start the 7 Days To Die server `./7dtd-server.run`

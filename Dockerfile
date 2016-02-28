FROM debian:latest

MAINTAINER mudfly

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    lib32gcc1 \
    wget \
    xmlstarlet \
&& rm -rf /var/lib/apt/lists/*

# Creates 7dtd server as a service
RUN useradd -ms /bin/bash livingdead
WORKDIR /home/livingdead
COPY serverconfig.xml serverconfig.xml
COPY 7dtd.sh bin/7dtd
RUN chown -R livingdead:livingdead /home/livingdead

# Expose the default 7dtd server port
EXPOSE 8080/tcp 8081/tcp
EXPOSE 26900 26901 26902

CMD ["/home/livingdead/bin/7dtd"]

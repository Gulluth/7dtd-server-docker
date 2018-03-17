FROM debian:latest
MAINTAINER mudfly <mudfly@gmail.com>

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
      lib32gcc1 \
      wget \
      xmlstarlet && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash zed && \
    mkdir -p /7dtd/bin

COPY serverconfig.xml /7dtd/serverconfig.xml
COPY 7dtd.sh /7dtd/bin/7dtd.sh
RUN chown -R zed:zed /7dtd

VOLUME ["/7dtd"]
EXPOSE 8080/tcp 8081/tcp 26900 26901 26902
WORKDIR /7dtd
CMD ["/7dtd/bin/7dtd.sh"]
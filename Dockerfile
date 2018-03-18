
FROM debian:latest
LABEL maintainer="mudfly <mudfly@gmail.com>"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
      curl \
      lib32gcc1 \
      xmlstarlet && \
    apt-get clean all

ENV STEAM_HOME="/steam"
ENV DATA_HOME="/data"

RUN /usr/sbin/useradd -d ${DATA_HOME} -M -s /bin/bash zed && \
    /bin/mkdir ${STEAM_HOME} && \
    /bin/chown -R zed:zed ${STEAM_HOME}

USER zed

RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar xvz -C ${STEAM_HOME}

COPY --chown=zed:zed 7dtd.sh /7dtd.sh

VOLUME ["/data"]
EXPOSE 8080/tcp 8081/tcp 26900/udp 26901/udp 26902/udp
CMD ["/bin/bash", "/7dtd.sh"]

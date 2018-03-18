
FROM debian:latest
LABEL maintainer="mudfly <mudfly@gmail.com>"

RUN dpkg --add-architecture i386 ; apt-get update && \
    apt-get install -y \
      adduser \
      curl \
      lib32gcc1 \
      xmlstarlet ; \
    apt-get clean all

RUN /usr/sbin/useradd -d /data -M -s /bin/bash zed && \
    /bin/mkdir -p /7dtd/bin && \
    /bin/chown -R zed:zed /7dtd

USER zed
ENV ZED_HOME="/7dtd"
ENV DATA_HOME="/data"

RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar xvz -C ${ZED_HOME}/bin 

COPY --chown=zed:zed serverconfig.xml.example /7dtd/serverconfig.xml
COPY --chown=zed:zed 7dtd.sh /7dtd/bin/7dtd.sh

VOLUME ["/data"]
EXPOSE 8080/tcp 8081/tcp 26900 26901 26902
WORKDIR /7dtd
CMD ["/bin/bash", "/7dtd/bin/7dtd.sh"]

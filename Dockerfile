FROM ubuntu:latest

MAINTAINER mudfly

ARG STEAM_USER
ARG STEAM_PASS
ARG STEAM_GUARD
ENV LIVINGDEAD_HOME /opt/7dtd

# Install dependencies
RUN apt-get update \
&& apt-get install -y \
lib32gcc1 \
wget \
xmlstarlet \
&& groupadd --system flesh && useradd --system --gid flesh --home /opt/7dtd --shell /bin/bash rotting \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

WORKDIR $LIVINGDEAD_HOME

# Gets SteamCMD
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
&& tar -xzf steamcmd_linux.tar.gz \
&& rm steamcmd_linux.tar.gz \
&& chown -R rotting:flesh /opt/7dtd

# Install 7dtd
RUN ./steamcmd.sh +login $STEAM_USER $STEAM_PASS $STEAM_GUARD +force_install_dir ./engine/ +app_update 294420 validate +quit \
&& chown -R rotting:flesh /opt/7dtd

# Creates 7dtd server as a service
ADD ./serverconfig.xml $LIVINGDEAD_HOME/engine/serverconfig.xml
RUN chown rotting:flesh /opt/7dtd/engine/serverconfig.xml
ADD ./7dtd.sh $LIVINGDEAD_HOME/bin/7dtd
RUN chown -R rotting:flesh /opt/7dtd/bin

# Expose the default 7dtd server port
EXPOSE 8080/tcp 8081/tcp
EXPOSE 26900 26901 26902

USER rotting
VOLUME $LIVINGDEAD_HOME

CMD ["/opt/7dtd/bin/7dtd"]

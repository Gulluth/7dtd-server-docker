#!/bin/bash
set -e

# This script manages the 7 days to Die server.
# $DATA_HOME and $STEAM_HOME are set in Dockerfile

PARAMS="$@"

if [ ! -d ${DATA_HOME}/log ]; then
  mkdir ${DATA_HOME}/log
fi

LOGFILE="${DATA_HOME}/log/7dtd-launcher-$(date +%Y%m%d).log"

echo "$(date +%Y%m%d %T) Checking for server updates" >> ${LOGFILE}
${STEAM_HOME}/steamcmd.sh \
  +login anonymous \
  +force_install_dir ${DATA_HOME}/server \
  +app_update 294420 \
  +quit >> ${LOGFILE}

if [ ! -f ${DATA_HOME}/serverconfig.xml ]; then
  echo "$(date +%Y%m%d %T) Installing default serverconfig.xml into ${DATA_HOME}/serverconfig.xml" >> ${LOGFILE}
  echo "$(date +%Y%m%d %T) Make sure to update the configuration and restart your server." >> ${LOGFILE}
  cp ${DATA_HOME}/server/serverconfig.xml ${DATA_HOME}/serverconfig.xml
fi

echo "$(date +%Y%m%d% %T) Launching 7 Days to Die Server" >> ${LOGFILE}
export LD_LIBRARY_PATH=${DATA_HOME}/server:$LD_LIBRARY_PATH
${DATA_HOME}/server/7DaysToDieServer.x86_64 \
  -configfile=${DATA_HOME}/serverconfig.xml \
  -logfile ${DATA_HOME/log/7dtd-server-$(date +%Y%m%d).log} \
  -quit -batchmode -nographics -dedicated ${PARAMS}

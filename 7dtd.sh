#!/bin/bash
set -e

PARAMS=$@

# $DATA_HOME and $ZED_HOME are set in Dockerfile
if [ ! -d ${DATA_HOME}/log ]; then
  mkdir ${DATA_HOME}/log
fi

# Copy default serverconfig.xml if doesn't exist
if [ ! -f ${DATA_HOME}/serverconfig.xml ]; then
  cp ${ZED_HOME}/serverconfig.xml ${DATA_HOME}/serverconfig.xml
fi

${ZED_HOME}/bin/steamcmd.sh \
  +login anonymous \
  +force_install_dir ${DATA_HOME}/server \
  +app_update 294420 \
  +quit

echo "$(date +%Y%m%d) Launching 7 Days to Die Server" >> ${DATA_HOME}/log/7dtd-server.log
export LD_LIBRARY_PATH=${DATA_HOME}/server:$LD_LIBRARY_PATH
${DATA_HOME}/server/7DaysToDieServer.x86_64 \
  -configfile=${DATA_HOME}/serverconfig.xml \
  -logfile ${DATA_HOME}/log/7dtd-server.log \
  -quit -batchmode -nographics -dedicated ${PARAMS}

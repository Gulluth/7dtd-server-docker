#!/bin/bash
set -e

PARAMS=$@
LIVINGDEAD_HOME=/home/livingdead

cd $LIVINGDEAD_HOME

echo "Downloading Steam Cmd"
su -l livingdead -c "wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz -O steamcmd_linux.tar.gz"
su -l livingdead -c "tar -zxf steamcmd_linux.tar.gz -C ./bin"

echo "Downloading 7 Days to Die Server"
su -l livingdead -c "mkdir -p ${LIVINGDEAD_HOME}/server"
su -l livingdead -c "${LIVINGDEAD_HOME}/bin/steamcmd.sh \
   +login anonymous \
   +force_install_dir ${LIVINGDEAD_HOME}/server \
   +app_update 294420 \
   +quit"

echo "Launching 7 Days to Die"
export LD_LIBRARY_PATH=$LIVINGDEAD_HOME/server
su -l livingdead -c "${LIVINGDEAD_HOME}/server/7DaysToDieServer.x86_64 \
   -configfile=${LIVINGDEAD_HOME}/serverconfig.xml \
   -logfile ${LIVINGDEAD_HOME}/server/output.log \
   -quit -batchmode -nographics -dedicated $PARAMS"

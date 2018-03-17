#!/bin/bash
set -e

PARAMS=$@
ZED_HOME=/7dtd

cd ${ZED_HOME}

echo "Downloading Steam Cmd"
su -l zed -c "wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz -O steamcmd_linux.tar.gz"
su -l zed -c "tar -zxf steamcmd_linux.tar.gz -C ./bin"

echo "Downloading 7 Days to Die Server"
su -l zed -c "mkdir -p ${ZED_HOME}/server"
su -l zed -c "${ZED_HOME}/bin/steamcmd.sh \
   +login anonymous \
   +force_install_dir ${ZED_HOME}/server \
   +app_update 294420 \
   +quit"

echo "Launching 7 Days to Die"
export LD_LIBRARY_PATH=$ZED_HOME/server
su -l zed -c "${ZED_HOME}/server/7DaysToDieServer.x86_64 \
   -configfile=${ZED_HOME}/serverconfig.xml \
   -logfile ${ZED_HOME}/server/output.log \
   -quit -batchmode -nographics -dedicated $PARAMS"

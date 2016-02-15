#!/bin/bash

PARAMS=$@
LIVINGDEAD_HOME=/opt/7dtd

cd $LIVINGDEAD_HOME/engine
export LD_LIBRARY_PATH=$LIVINGDEAD_HOME/engine/ 
./7DaysToDieServer.x86 -configfile=serverconfig.xml -logfile $LIVINGDEAD_HOME/engine/output.log -quit -batchmode -nographics -dedicated $PARAMS 

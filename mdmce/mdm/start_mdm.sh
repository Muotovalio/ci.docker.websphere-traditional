#!/bin/bash
#####################################################################################
#                                                                                   #
#  Script to start MDM CE and wait until process exits.                             #
#                                                                                   #
#  Usage : start_mdm                                                                #
#                                                                                   #
#####################################################################################

start_server()
{
  echo "Starting server ..................."
  /opt/IBM/MDM/bin/go/start_local.sh
}

start_server || exit $?
PID=$(ps -C java -o pid | sed -n '2p' | tr -d " ")
tail --pid=$PID -f /dev/null

#!/bin/bash
#####################################################################################
#                                                                                   #
#  Script to reset the wsadmin password                                             #
#                                                                                   #
#  Usage : reset_password.sh                                                        #
#                                                                                   #
#####################################################################################

ADMIN_USER_NAME=${ADMIN_USER_NAME:-"wsadmin"}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-"wsadminpwd"}

echo $ADMIN_PASSWORD > /tmp/PASSWORD

#if [ -f /tmp/PASSWORD ]
#then
#  password=$(cat /tmp/PASSWORD)
#else
#  password=$(openssl rand -base64 6)
#  echo $password > /tmp/PASSWORD
#fi

/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -conntype NONE -f /work/updatePassword.py $ADMIN_USER_NAME $ADMIN_PASSWORD > /dev/null 2>&1
touch /work/passwordupdated
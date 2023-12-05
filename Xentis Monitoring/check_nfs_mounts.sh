#!/bin/bash
#---------------------------------------------------------------------------------------------------
#
# Check NFS mounts, pass the NFS mount to check as an argument
#
cat /proc/mounts | grep "$1">/dev/null
if [ $? == 0 ];
then
   echo "OK"
else
   echo "BAD"
fi

#!/bin/sh
#Author: Vinod.N K
#Distro : Linux -Centos, Rhel, and any fedora
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free avilable) percentage
# of space is >= 90%
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

ADMIN="admin@domain.com"
# set alert level 90% is default
ALERT=60
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  #echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge $ALERT ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
     mail -s "Alert: Almost out of disk space $usep" $ADMIN
  fi
done

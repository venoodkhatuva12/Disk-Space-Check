#!/bin/bash
#Author: Vinod.N K
#Distro : Linux -Centos, Rhel, and any fedora
# Shell script to check CPU Usage
# Set up limit below
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

ADMIN="admin@domain.com"
NOTIFY="4.0"
FTEXT='load average:'

# 15 min
F15M="$(uptime | awk -F "$FTEXT" '{ print $2 }' | cut -d, -f3)"

# compare it with last 15 min load average
RESULT=$(echo "$F15M > $NOTIFY" | bc)

if [ "$RESULT" == "1" ]; then
        echo "Heavy Load  $F15M on $(hostname) as on $(date)" |
     mail -s "Alert:Load on Server $F15M" $ADMIN
fi

#done

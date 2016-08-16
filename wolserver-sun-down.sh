#!/bin/bash
#
# wake up server on last sunday every month via mikrotik script

# export this snippet to mikrotik device
# /system script
# add name=wol_server owner=user policy=\
#     reboot,read,write,test,password,sensitive source="
#     \n# ::> Server\r\
#     \n/tool wol interface=ether1 mac=74:D4:35:51:36:F9"

now=$(date +"%d")
if [ "$(date '+%m')" == 01 ] ; then end=24
	elif [ "$(date '+%m')" == 02 ] ; then
		if [ "$[`date +%Y` % 4]" == 0 ] ; then end=22 ; else end=21 ; fi
        elif [ "$(date '+%m')" == 03 ] ; then end=24
        elif [ "$(date '+%m')" == 04 ] ; then end=23
        elif [ "$(date '+%m')" == 05 ] ; then end=24
        elif [ "$(date '+%m')" == 06 ] ; then end=23
        elif [ "$(date '+%m')" == 07 ] ; then end=24
        elif [ "$(date '+%m')" == 08 ] ; then end=24
        elif [ "$(date '+%m')" == 09 ] ; then end=23
        elif [ "$(date '+%m')" == 10 ] ; then end=24
        elif [ "$(date '+%m')" == 11 ] ; then end=23
        else end=24
fi

if [ "$(date '+%a')" == "Sat" ] && [ "$[$now]" -ge "$[$end]" ]
then
	/usr/bin/ssh admin@172.16.10.254 /system scheduler set run_wol_server_sun disabled=yes
fi

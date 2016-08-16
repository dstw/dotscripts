#!/bin/bash
#
# use rsnapshot to generate incremental backup to external drive
#
# required parameter
diskname1="exthdd"
reportdate=`date +"%T %m-%d-%Y"`

# verify disk storage
if [ `ls /media/$diskname1/ | wc -l` -ne 0 ] 
then
	start1=$(date +%s)

	# start process copy
	rsnapshot -c $HOME/rsnapshot-$diskname1.conf weekly

	end1=$(date +%s)

	# write report
	diff1=$(( $end1 - $start1 ))
	seconds1=(`printf '%02d:%02d:%02d:%02d\n' $((diff1/86400)) $((diff1/3600%24)) $((diff1/60%60)) $((diff1%60))`)
	echo -e "$reportdate: backup $diskname1\t: time elapsed $seconds1" >> $HOME/report.txt
else
	# if error occured
	echo -e "$reportdate: backup $diskname1\t: failed. did you forget to mount?" >> $HOME/report.txt
fi


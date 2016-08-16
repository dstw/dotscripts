#!/bin/bash
#
# use rsnapshot to generate incremental backup on weekly basis
#
# required parameter
diskname1="fullbackup"
reportdate=`date +"%T %m-%d-%Y"`

# verify disk storage
if [ `ls /media/$diskname1/ | wc -l` -ne 0 ] 
then
	start=$(date +%s)

	# start process copy
	rsnapshot -c $HOME/rsnapshot-$diskname1.conf weekly

	end=$(date +%s)

	# write report
	diff=$(( $end - $start ))
	seconds=(`printf '%02d:%02d:%02d:%02d\n' $((diff/86400)) $((diff/3600%24)) $((diff/60%60)) $((diff%60))`)
	echo -e "$reportdate: backup weekly\t: time elapsed $seconds" >> $HOME/report.txt

else
	# if error occured
	echo -e "$reportdate: backup weekly\t: failed. did you forget to mount?" >> $HOME/report.txt
fi

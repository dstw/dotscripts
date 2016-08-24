#!/bin/bash

# download google drive folders
# use 3rd party "gdrive" application
# https://github.com/prasmussen/gdrive
# to access folders on google drive

gdrive_home="/media/backup_db"
reportdate=`date +"%T %m-%d-%Y"`
start=$(date +%s)
while read i; do
        $gdrive_home/gdrive download $i --path $gdrive_home --recursive
done < $gdrive_home/url.txt
end=$(date +%s)
diff=$(( $end - $start ))
seconds=(`printf '%02d:%02d:%02d:%02d\n' $((diff/86400)) $((diff/3600%24)) $((diff/60%60)) $((diff%60))`)
echo -e "$reportdate: download success\t: time elapsed $seconds" >> $gdrive_home/report.log

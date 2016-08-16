#!/bin/bash

# download google drive folders
# use 3rd party "gdrive" application
# https://github.com/prasmussen/gdrive
# to access folders on google drive

fileurl="$HOME/backup_psho/url.txt"
reportdate=`date +"%T %m-%d-%Y"`
start=$(date +%s)
while read i; do
	gdrive download $i --path $HOME/backup_psho --recursive
done < $fileurl
end=$(date +%s)
diff=$(( $end - $start ))
seconds=(`printf '%02d:%02d:%02d:%02d\n' $((diff/86400)) $((diff/3600%24)) $((diff/60%60)) $((diff%60))`)
echo -e "$reportdate: download success\t: time elapsed $seconds" >> $HOME/app.log

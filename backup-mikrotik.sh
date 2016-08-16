#!/bin/bash
#
# automatic mikrotik device configuration backup using ssh & sftp
#
# requirement:
# - passwordless login on mikrotik using ssh key 

# required variables
now=$(date +"%Y%m%d")
reportdate=`date +"%T %m-%d-%Y"`
tmpdir="/tmp/backup"
userfileserver="edp11"
ipfileserver="172.16.10.250"
dirfileserver="/srvdrv01/edp/mikrotik/"
usermt="admin"

# check existence of local temporary directory for upload/download transaction
if [ ! -d $tmpdir ]
then
        mkdir $tmpdir
fi
cd $tmpdir

# list of remote sites
host=("172.16.10.254" "172.16.1.1" "172.16.5.2" "172.16.61.254" "172.16.62.254" "172.16.63.254" "172.16.64.254" "172.16.65.254" "172.16.91.2" "172.16.92.78" "172.16.131.1" "172.16.132.1" "172.16.181.1" "172.16.191.1" "172.16.201.100" "172.16.21.1" "172.16.22.254" "172.16.31.254" "172.16.32.254" "172.16.251.2" "131.68.5.254" "131.68.7.3" "131.68.7.4" "172.16.251.123" "172.16.251.124" "172.16.251.127" "172.16.251.125" "172.16.251.126") #"172.16.93.1"
hostcount=${#host[@]}

# list of branch offices code
branch=( "11" "01" "05" "61" "62" "63" "64" "65" "91" "92" "131" "132" "18" "19" "20" "21" "22" "31" "32" "25" "17" "11.17" "17.11" "11.25" "25.11" "25.dist" "25.barat" "barat.25") #"93"

# start process backup
start=$(date +%s)
for i in $(seq 0 $((hostcount-1)))
do 
	# check ssh connection to remote site
	ssh -q $usermt@${host[$i]} exit
	if [ $? == 0 ]
	then
	# generate backup file
	ssh $usermt@${host[$i]} <<EOF
	/system backup save name="${host[$i]}-$now"
	/export file="${host[$i]}-$now"
EOF
	# download and delete backup file
	sftp $usermt@${host[$i]} <<EOF
	get "${host[$i]}-$now.backup"
	get "${host[$i]}-$now.rsc"
	rm "${host[$i]}-$now.backup"
	rm "${host[$i]}-$now.rsc"
	bye
EOF
	# check existence of branch offices directory on file server
	#ssh $userfileserver@$ipfileserver <<EOF
	#if [ ! -d $dirfileserver${branch[$i]}/ ]
	#then
	#	mkdir $dirfileserver${branch[$i]}/
	#fi
	#EOF
	
	# upload to file server
	sftp $userfileserver@$ipfileserver <<EOF
	cd $dirfileserver${branch[$i]}/
	put $tmpdir/*
	bye
EOF
	# clean local temporary directory
	rm -rf $tmpdir/*
	fi
done

# end process copy and write report
end=$(date +%s)
diff=$(( $end - $start ))
seconds=(`printf '%02d:%02d:%02d:%02d\n' $((diff/86400)) $((diff/3600%24)) $((diff/60%60)) $((diff%60))`)
echo -e "$reportdate: backup mikrotik\t: time elapsed $seconds" >> $HOME/report.txt

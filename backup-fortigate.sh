#!/bin/bash
#
# automatic fortigate device configuration backup using scp
#
# requirement:
# - passwordless login on fortigate using ssh key 

# required variables 
now=$(date +"%Y%m%d")
reportdate=`date +"%T %m-%d-%Y"`
tmpdir="/tmp/backup-fortigate"
userfileserver="edp11"
ipfileserver="172.16.10.250"
dirfileserver="/srvdrv01/edp/fortigate"
userfg="admin"
host="172.16.10.222"

# check existence of local temporary directory for upload/download transaction
if [ ! -d $tmpdir ]
then
        mkdir $tmpdir
fi
cd $tmpdir

# start process copy backup
start=$(date +%s)
scp $userfg@$host:fgt-config $tmpdir
mv $tmpdir/fgt-config $tmpdir/fortigate-$now.conf
# upload to file server
sftp $userfileserver@$ipfileserver <<EOF
cd $dirfileserver${branch[$i]}/
put $tmpdir/*
bye
EOF
# clean local temporary directory
rm -rf $tmpdir/*
end=$(date +%s)
diff=$(( $end - $start ))
seconds=(`printf '%02d:%02d:%02d:%02d\n' $((diff/86400)) $((diff/3600%24)) $((diff/60%60)) $((diff%60))`)
echo -e "$reportdate: backup fortigate\t: time elapsed $seconds" >> /root/report.txt

# conf-serv

My collections of various shell script with various functionality such as
file backup, automatic download and control other servers. 

Prerequisites
-------------

* openssh-client 
* rsync
* rsnapshot
* [gdrive](https://github.com/prasmussen/gdrive)
* Passwordless access to remote host using ssh-key

Description and Usage
---------------------

	git clone git@github.com:dstw/conf-serv.git
	cd conf-serv
	cp * ~/
	cd ~
	cat crontab | crontab -

### backup-exthdd.sh
Use rsnapshot to generate incremental backup to external drive

### backup-full.daily.sh
Use rsnapshot to generate incremental backup daily

### backup-full.weekly.sh
Use rsnapshot to generate incremental backup weekly

### backup-full.monthly.sh
Use rsnapshot to generate incremental backup monthly

### backup-mikrotik.sh
Automatic mikrotik device configuration backup using ssh & sftp

### gdrive-download.sh
Download google drive folders use 3rd party "gdrive" application

### backup-fortigate.sh
Automatic fortigate device configuration backup using scp

### wolserver-sun-down.sh
Wake up server on last sunday of the month via mikrotik script

### wolserver-sun-up.sh
Disable wake up server on every week via mikrotik script

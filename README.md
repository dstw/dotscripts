# conf-serv

My collections of various shell script with various functionality such as
file backup, automatic download and control other servers. 

General Requirements
--------------------

* openssh-client 
* rsync
* rsnapshot
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
Script to download google drive files/folders use 3rd party "gdrive"
application.  
Go to [gdrive](https://github.com/prasmussen/gdrive) and choose your platform.  
Edit gdrive-download.sh, specify your $gdrive_home, and put gdrive app here.  
Create url.txt, to store google drive fileid.
	touch url.txt
Test and initialize:
	$ /path/to/gdrive_home/gdrive download 0B-yXnTjUyJusiInZjRUJjcW1OMVE --path /path/to/gdrive_home --recursive
	Authentication needed
	Go to the following url in your browser:
	https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=367116221053-7n0vf5akeru7on6o2f.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=state

	Enter verification code: 4svvfHm0_CMRlskdfjKckIGRPUCxBvb7wItnwtubfClyuw
	Downloading file.bak -> /path/to/gdrive_home/file.bak
For first use, it will need google authentication, just do as the instructions.  
Once download succeeded, you can install new crontab to automating this task.
	# batch download from google drive
	# download every monday on 17:30
	00 17 * * 1 rm -rf /path/to/gdrive_home/28*
	30 17 * * 1 /path/to/gdrive_home/gdrive_download.sh

### backup-fortigate.sh
Automatic fortigate device configuration backup using scp

### wolserver-sun-down.sh
Wake up server on last sunday of the month via mikrotik script

### wolserver-sun-up.sh
Disable wake up server on every week via mikrotik script

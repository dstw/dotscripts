#!/bin/bash

folder_github=(
### Github ###
	"asciinema"
	"asciinema2gif"
	"atom"
	"best-resume-ever"
	"brotli"
	"ccextractor.git"
	"certbot"
	"cmus"
	"coala.git"
	"curl"
	"dircolors-solarized"
	"everything-curl"
	"freeCodeCamp"
	"fsarchiver"
	"git"
	"gitignore"
	"h2o"
	"irssi"
	"libmicrohttpd"
	"libpsl"
	"libreswan"
	"linux-insides"
	"lolcat.git"
	"mad.git"
	"neomutt"
	"neovim"
	"offlineimap.git"
	"oh-my-zsh"
	"powerline"
	"ranger.git"
	"rspamd"
	"scancode-toolkit"
	"sl"
	"spectre-meltdown-checker"
	"speed-test"
	"squid"
	"strace"
	"systemd"
	"tldr.git"
	"tmux"
	"todo.txt-cli"
	"urlview.git"
	"vibreoffice"
	"vifm"
	"vim"
	"watch"
	"wget"
	"wget2"
	"zsh-autosuggestions"
	"zsh-completions"
	"zzuf"
)

folder_gitlab=(
### Gitlab ###
	"gnutls"
	"libidn2"
	"libmicrohttpd"
	"wget"
	"wget2"
)

folder_others=(
### Others ###
	"gnulib"
	"iptables"
	"libnftnl"
	"libunistring"
	"linux-kernel"
	"nftables"
	"postgresql.git"
	"readline"
)

folder_hg=(
#	"firefox.hg"
#	"mutt.hg"
)

github_count=${#folder_github[@]}

for i in $(seq 0 $((github_count-1)))
do
	echo "Processing ${folder_github[$i]}"
	cd $HOME/${folder_github[$i]}
	branch_name=$(git branch | grep \* | awk '{print $2}')
	if [ $branch_name != "master" ]
	then
		git checkout master
	fi
	git fetch origin
	git merge origin/master
	if $(git remote show | grep github > /dev/null)
	then
		git push github master
	else
		repo_name=$(echo ${folder_github[i]} | cut -d '.' -f1)
		if [ $(echo ${folder_github[i]} | cut -d '.' -f2) == "git" ]
		then
			git remote add github git@github.com:dstw/$repo_name
		else
			git remote add github git@github.com:dstw/${folder_github[i]}
		fi
		git push github master
	fi
	if [ $branch_name != "master" ]
	then
		git checkout $branch_name
	fi
done

gitlab_count=${#folder_gitlab[@]}

for i in $(seq 0 $((gitlab_count-1)))
do
	echo "Processing ${folder_gitlab[$i]}"
	cd $HOME/${folder_gitlab[$i]}
	branch_name=$(git branch | grep \* | awk '{print $2}')
	if [ $branch_name != "master" ]
	then
		git checkout master
	fi
	git fetch origin
	git merge origin/master
	if $(git remote show | grep gitlab > /dev/null)
	then
		git push gitlab master
	else
		repo_name=$(echo ${folder_gitlab[i]} | cut -d '.' -f1)
		if [ $(echo ${folder_gitlab[i]} | cut -d '.' -f2) == "git" ]
		then
			git remote add gitlab git@gitlab.com:dstw/$repo_name
		else
			git remote add gitlab git@gitlab.com:dstw/${folder_gitlab[i]}
		fi
		git push gitlab master
	fi
	if [ $branch_name != "master" ]
	then
		git checkout $branch_name
	fi
done

#echo "Processing $folder_hg"
#cd $HOME/$folder_hg
#hg pull

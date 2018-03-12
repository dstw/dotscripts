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
	"coala"
	"curl"
	"dircolors-solarized"
	"everything-curl"
	"freeCodeCamp"
	"fsarchiver"
	"git"
	"gitignore"
	"h2o"
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
	"rspamd"
	"scancode-toolkit"
	"sl"
	"spectre-meltdown-checker"
	"speed-test"
	"squid"
	"strace"
	"tldr"
	"tmux"
	"todo.txt-cli"
	"vibreoffice"
	"vifm"
	"vim"
	"watch"
	"wget"
	"wget2"
	"zsh-autosuggestions"
	"zsh-completions"
	"zzuf"

#### Others ###
#	"gnulib"
#	"iptables"
#	"libnftnl"
#	"libunistring"
#	"linux-kernel"
#	"nftables"
#	"postgresql.git"
#	"readline"
)

folder_gitlab=(
#### Gitlab ###
	"gnutls"
	"libidn2"
	"libmicrohttpd"
	"wget"
	"wget2"
)

folder_hg=(
#	"firefox.hg"
#	"mutt.hg"
)

github_count=${#folder_github[@]}

for i in $(seq 0 $((github_count-1)))
do
	if [ ${folder_github[$i]} == "oh-my-zsh" ]
	then
		continue
	fi
	echo "Processing ${folder_github[$i]}"
	cd $HOME/${folder_github[$i]}
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
done

gitlab_count=${#folder_gitlab[@]}

for i in $(seq 0 $((gitlab_count-1)))
do
	echo "Processing ${folder_gitlab[$i]}"
	cd $HOME/${folder_gitlab[$i]}
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
done

#echo "Processing $folder_hg"
#cd $HOME/$folder_hg
#hg pull

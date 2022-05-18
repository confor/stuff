#!/usr/bin/bash

set -euxo pipefail

if [[ ! -f /etc/debian_version ]]; then
	echo "Error: missing /etc/debian_version, are you running debian?"
	exit 1
fi

# curl: http client
# wget: http downloader
# git: cvs
# neovim: text editor
# nmap: network exploration
# bat: pager, cat clone
# jq: json processor
# zip: archiver, compression
# unzip: decompression
# fd-find: finder, find clone
# htop: interactive process viewer, task manager
# file: magic bytes reader
# bind9-host: dns lookup
# bind9-dnsutils: dns clients: dig, nslookup, nsupdate
# strace: system call debugging
apt-get install --quiet --yes curl wget git neovim nmap bat jq zip unzip \
	fd-find htop file bind9-host bind9-dnsutils strace

if [[ ! -L /usr/bin/bat ]]; then
	ln -s /usr/bin/batcat /usr/bin/bat
fi

if [[ ! -L /usr/bin/fd ]]; then
	ln -s /usr/bin/fdfind /usr/bin/fd
fi

if [[ ! -f /usr/bin/duf ]]; then
	wget --quiet -O /tmp/duf_0.8.1.deb 'https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb'
	dpkg --install /tmp/duf_0.8.1.deb
	rm /tmp/duf_0.8.1.deb
fi

if [[ ! -f /usr/bin/sd ]]; then
	wget --quiet -O /usr/bin/sd 'https://github.com/chmln/sd/releases/download/v0.7.6/sd-v0.7.6-x86_64-unknown-linux-gnu'
	chmod +x /usr/bin/sd
fi

if [[ ! -f /usr/bin/choose ]]; then
	wget --quiet -O /usr/bin/choose 'https://github.com/theryangeary/choose/releases/download/v1.3.4/choose-x86_64-unknown-linux-gnu'
	chmod +x /usr/bin/choose
fi

if [[ ! -f /usr/bin/tldr ]]; then
	wget --quiet -O /usr/bin/tldr 'https://github.com/dbrgn/tealdeer/releases/download/v1.5.0/tealdeer-linux-x86_64-musl'
	chmod +x /usr/bin/tldr
fi

if [[ ! -f /usr/bin/rmate ]]; then
	wget --quiet -O /usr/bin/rmate 'https://raw.githubusercontent.com/aurora/rmate/5f8a56678eacee80388c9dbd10fe28e6f83196a4/rmate'
	chmod +x /usr/bin/rmate
fi

if [[ ! -f /usr/bin/croc ]]; then
	wget --quiet -O /tmp/croc_9.5.5.deb 'https://github.com/schollz/croc/releases/download/v9.5.5/croc_9.5.5_Linux-64bit.deb'
	dpkg --install /tmp/croc_9.5.5.deb
	rm /tmp/croc_9.5.5.deb
fi

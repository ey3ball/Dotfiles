#!/bin/bash
# Deploy sytem-wide configuration files on the system

set -e

# Origin path
DOTPATH=$(cd $(dirname ${0}) && pwd)

. ${DOTPATH}/common.bash

if [ "$(whoami)" != "root" ]; then
	echo "System wide install. Please run me as root !" >&2
	exit 1
fi

echo "> Deploying system wide dotfiles from ${DOTPATH}"

# Bash configuration files
deploy_link bash/bash_aliases	/etc/bash_aliases
deploy_link bash/bash_colors	/etc/bash_colors
deploy_link bash/bash_prompt	/etc/bash_prompt
deploy_link bash/bashrc_loader	/etc/bash_loader

BASHRC_STATUS=$(grep -c "bash_loader" /etc/bash.bashrc || :)

if [ ${BASHRC_STATUS} -eq 0 ]; then
	echo '[ -r /etc/bash_loader ] && . /etc/bash_loader' >> /etc/bash.bashrc
fi

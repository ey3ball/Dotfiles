#!/bin/bash
# Deploy local configuration files on the system

set -e

# Origin path
DOTPATH=$(cd $(dirname $0) && pwd)

. $DOTPATH/common.bash

if [[ ! "$@" =~ "-global" ]] && [[ ! "$@" =~ "-local" ]]; then
	echo "Please choose between bare local deployment (-local) or local deployment after global install (-global)"
	exit 1
fi

echo "> Deploying system wide dotfiles from $DOTPATH"

# Replace original bashrc with distributed one
if [ -f ~/.bashrc ]; then
	if [ $(grep -c "__EY3BALL_DOTFILES__" ~/.bashrc || :) -eq 0 ]; then
		mv ~/.bashrc ~/.bashrc_local
	fi
fi

if [ ! -f ~/.bashrc ]; then
	deploy_link bash/bashrc_local	~/.bashrc
fi

# Bash configuration files
if [[ "$@" =~ "-local" ]]; then
	deploy_link bash/bash_aliases	~/.bash_aliases
	deploy_link bash/bash_colors	~/.bash_colors
	deploy_link bash/bash_prompt	~/.bash_prompt
fi

deploy_link bash/bash_shell_utils   ~/.bash_shell_utils

deploy_link nvim/init.lua ~/.config/nvim/init.lua
deploy_link nvim/remap.vim ~/.config/nvim/plugins/remap.vim
deploy_link 3rdparty/awesome-copycats ~/.config/awesome
deploy_link 3rdparty/tamzen-font ~/.fonts/tamzen-font
deploy_link env/tmux.conf ~/.tmux.conf

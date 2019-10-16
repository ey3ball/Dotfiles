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

deploy_link vim/vimrc ~/.vimrc
deploy_link nvim/init.vim ~/.config/nvim/init.vim
deploy_link 3rdparty/zenburn/colors/zenburn.vim ~/.vim/colors/zenburn.vim
deploy_link 3rdparty/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
deploy_link 3rdparty/awesome-copycats ~/.config/awesome
deploy_link 3rdparty/tamzen-font ~/.fonts/tamzen-font
deploy_link env/tmux.conf ~/.tmux.conf
deploy_link 3rdparty/awesome-copycats/rc.lua.template ~/.config/awesome/rc.lua

xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash


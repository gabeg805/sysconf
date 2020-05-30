# ------------------------------------------------------------------------------
# 
# File: ~/.zshenv
# Author: Gabe Gonzalez
# 
# Brief: Set environment variables.
# 
# ------------------------------------------------------------------------------

# Add colors to prompt and "ls" command
autoload -U colors && colors
case ${UID} in
	0)
		PROMPT="%{$bg[white]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}"$'\n'"> "
		;;
	1000)
		PROMPT="%{$bg[cyan]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}"$'\n'"> "
		;;
	*)
		PROMPT="%{$bg[blue]%}%{$fg[white]%}%n@%M: %d\$%{$reset_color%}"$'\n'"> "
		;;
esac

if [ -x /usr/bin/dircolors ]
then
    eval "$(dircolors -b)"
    export LS_COLORS=${LS_COLORS}:"*~=00;31":"*.pdf=00;32":"*.bak=00;33":"*.ps=01;35":"*.orig=00;33"
fi

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export SAVEHIST=${HISTSIZE}
#export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export SUDO_EDITOR=/usr/bin/vim
export PYTHONSTARTUP=${HOME}/.pystartup
# Disable warnings from GTK accessibility
#export NO_AT_BRIDGE=1
# Force Mullvad to use GTK3
#export MULLVAD_USE_GTK3=yes
export TEXMFHOME=${HOME}/.texmf
# Android SDK home
# export ANDROID_HOME=/opt/android-sdk
# Change where GO programming language has its directory. I hate that it's
# in HOME by default.
export GOPATH=${HOME}/.local/share
export PATH="${PATH}":"${HOME}":"${HOME}/.local/bin":"${HOME}/projects/bin":"${HOME}/bin":"${HOME}/projects/lib":"${HOME}/lib":/opt/android-studio-ide/android-studio/bin

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
export EDITOR=/usr/bin/vim
export SUDO_EDITOR=/usr/bin/vim
export PYTHONSTARTUP=${HOME}/.pystartup
export TEXMFHOME=${HOME}/.texmf
export ANDROID_SDK_ROOT=/opt/android-sdk/Android/Sdk
export GOPATH=${HOME}/.local/share
export PAGER=/usr/bin/less

# Add to path in a cleaner manner
#export PATH="${PATH}":"${HOME}/projects/bin":/opt/android-studio/bin
path+=(${HOME}/projects/bin)
path+=(/opt/android-sdk/emulator)
path+=(/opt/android-sdk/platform-tools)
path+=(/opt/android-sdk/tools)
path+=(/opt/android-sdk/tools/bin)
path+=(/opt/android-studio/bin)
typeset -U path

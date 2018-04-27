# ------------------------------------------------------------------------------
# File: ~/.zshenv
# Author: Gabe Gonzalez
# Brief: Set environment variables.
# 
# ------------------------------------------------------------------------------

# History size
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=${HISTSIZE}

# Add colors to prompt
autoload -U colors && colors
case ${UID} in
    0) PROMPT="%{$bg[white]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}"$'\n'"> " ;;
    *) PROMPT="%{$bg[cyan]%}%n@%M: %d\$%{$reset_color%}"$'\n'"> " ;;
esac

# Python startup history
export PYTHONSTARTUP=${HOME}/.pystartup

# Default Editor
export VISUAL=/usr/bin/emacs
export EDITOR=/usr/bin/emacs
export SUDO_EDITOR=/usr/bin/emacs

# Latex user class files
export TEXMFHOME=${HOME}/.texmf

# Force Mullvad to use GTK3
export MULLVAD_USE_GTK3=yes

# Android SDK home
export ANDROID_HOME=/opt/android-sdk

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]
then
    eval "$(dircolors -b)"
    export LS_COLORS=${LS_COLORS}:"*~=00;31":"*.pdf=00;32":"*.bak=00;33":"*.ps=01;35":"*.orig=00;33"
fi

# Editing The Path
PATH="${PATH}":"${HOME}/projects/bin":"${HOME}/bin":"${HOME}/projects/lib":"${HOME}/lib"
typeset -U path

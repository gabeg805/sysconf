#!/bin/sh
# ------------------------------------------------------------------------------
# 
# File: ~/.xinitrc
# Author: Gabe Gonzalez
# 
# Brief: Executed by startx (run your window manager from here).
# 
# ------------------------------------------------------------------------------

if [ -d /etc/X11/xinit/xinitrc.d ]
then
	for f in /etc/X11/xinit/xinitrc.d/*
	do
		if [ -x "${f}" ]
		then
			. "${f}"
		fi
	done
	unset f
fi

background="${HOME}/projects/system/images/background"

if [ -f "${background}" ]
then
	feh --bg-fill "${background}"
fi

if [ -f "${HOME}/.Xresources" ]
then
	xrdb -merge "${HOME}/.Xresources"
fi

if [ -f "${HOME}/.xbindkeysrc" ]
then
	setxkbmap -option caps:none
	xbindkeys
fi

if [ -f "${HOME}/.Xmodmap" ]
then
	xmodmap "${HOME}/.Xmodmap"
fi

xcompmgr &

exec ssh-agent i3

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

# Set background image
background="${HOME}/projects/system/images/background"

if [ -f "${background}" ]
then
	feh --bg-fill "${background}"
fi

# Xresources
if [ -f "${HOME}/.Xresources" ]
then
	xrdb -merge "${HOME}/.Xresources"
fi

# X keybindings
if [ -f "${HOME}/.xbindkeysrc" ]
then
	setxkbmap -option terminate:ctrl_alt_bksp
	setxkbmap -option caps:none
	xbindkeys
fi

# Modify key mapping
if [ -f "${HOME}/.Xmodmap" ]
then
	xmodmap "${HOME}/.Xmodmap"
fi

# Enable NumLock
if hash numlockx 2> /dev/null
then
	numlockx &
fi

# USB mounter
#udiskie -a -n -t &

# Geoclue (for redshift)
geoclue=/usr/lib/geoclue-2.0/demos/agent

if [ -f "${geoclue}" ]
then
	"${geoclue}" &
fi

# Composite manager (for transparency)
xcompmgr &

exec i3

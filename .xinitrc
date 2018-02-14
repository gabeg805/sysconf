#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "${f}" ] && . "${f}"
    done
    unset f
fi

[ -f "${HOME}/.Xresources" ] && xrdb -merge "${HOME}/.Xresources"
[ -f "${HOME}/.Xmodmap" ]    && xmodmap "${HOME}/.Xmodmap"

# exec openbox-session
exec i3

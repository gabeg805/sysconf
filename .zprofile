##
# ~/.zprofile
##

if [ -f "${HOME}/.zshenv" ]
then
	. "${HOME}/.zshenv"
fi

if [ -z "${DISPLAY}" ] && [[ "$(tty)" == "/dev/tty1" ]] && [ ${UID} -eq 1000 ]
then
	startx
fi

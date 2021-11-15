##
# ~/.zprofile
##

# Source environment rc
if [ -f "${HOME}/.zshenv" ]
then
	. "${HOME}/.zshenv"
fi

# Start X if on TTY1 and logged in to main user
if [ -z "${DISPLAY}" ] && [[ "$(tty)" == "/dev/tty1" ]] && [ ${UID} -eq 1000 ]
then
	startx
fi

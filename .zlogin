# ------------------------------------------------------------------------------
# File: ~/.zlogin
# Author: Gabe Gonzalez
# Brief: Execute commands when starting the login shell.
# 
# ------------------------------------------------------------------------------

# Xmodmap
if [ -n "${DISPLAY}" -a -f "${HOME}/.Xmodmap" ]
then
    xmodmap "${HOME}/.Xmodmap"
fi

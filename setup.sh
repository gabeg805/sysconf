#!/bin/bash
# ------------------------------------------------------------------------------
# 
# Name: symhome.sh
# Author: Gabe Gonzalez
# 
# Brief: Create symbolic links of all system files (contained in this repo) and
#		 have the destination be the running user's home directory.
# 
# ------------------------------------------------------------------------------

##
# Project name.
##
PROJECT="${0##*/}"
PROJECT_DIR=$(readlink -e $(dirname "${0}"))

##
# Options.
##
CONF=
GIT=
SYSTEM=

##
# Exit statuses.
##
EXIT_NO_OPT_ENTERED=10
EXIT_SETUP_MAIN_PROJECT_DIR_DOES_NOT_EXIST=11
EXIT_SETUP_DST_DOES_NOT_EXIST=12

##
# Create symbolic links.
##
main()
{
	local short="hcfgs"
	local long="help,conf,git,system"
	local args=$(getopt -o "${short}" --long "${long}" --name "${PROJECT}" \
		-- "${@}")
	if [ $? -ne 0 ]
	then
		usage
		exit 1
	fi

	if [ $# -eq 0 ]
	then
		usage
		exit 0
	fi

	# Parse options
	eval set -- "${args}"

	while true
	do
		case "${1}" in
			-h|--help)
				usage
				exit 0
				;;
			-c|--conf)
				CONF=true
				;;
			-g|--git)
				GIT=true
				;;
			-s|--system)
				SYSTEM=true
				;;
			*)
				break
				;;
		esac
		shift
	done

	# Run options
	if [ -n "${CONF}" ]
	then
		setup_conf
	elif [ -n "${GIT}" ]
	then
		setup_git
	elif [ -n "${SYSTEM}" ]
	then
		setup_system
	else
		:
	fi

	return $?
}

##
# Print program usage.
##
usage()
{
	echo "Usage: ${PROJECT} [options]"
	echo 
	echo "Options:"
	echo "	  -h, --help"
	echo "		  Print program usage."
	echo 
	echo "	  -c, --conf"
	echo "		  Create symbolic links of the system configuration files."
	echo 
	echo "	  -g, --git"
	echo "		  Download git repos."
	echo 
	echo "	  -s, --system"
	echo "		  Setup the system files."
}

##
# Create symbolic links to configuration files.
##
setup_conf()
{
	ln -svi "${PROJECT_DIR}/.aliases" "${HOME}"
	ln -svi "${PROJECT_DIR}/.pystartup" "${HOME}"
	ln -svi "${PROJECT_DIR}/.texmf" "${HOME}"
	ln -svi "${PROJECT_DIR}/.urxvt" "${HOME}"
	ln -svi "${PROJECT_DIR}/.vim" "${HOME}"
	ln -svi "${PROJECT_DIR}/.vimrc" "${HOME}"
	ln -svi "${PROJECT_DIR}/.xbindkeysrc" "${HOME}"
	ln -svi "${PROJECT_DIR}/.xinitrc" "${HOME}"
	ln -svi "${PROJECT_DIR}/.Xmodmap" "${HOME}"
	ln -svi "${PROJECT_DIR}/.Xresources" "${HOME}"
	ln -svi "${PROJECT_DIR}/.zprofile" "${HOME}"
	ln -svi "${PROJECT_DIR}/.zshenv" "${HOME}"
	ln -svi "${PROJECT_DIR}/.zshrc" "${HOME}"

	local configDir="${HOME}/.config"
	mkdir -pv "${configDir}"

	ln -svi "${PROJECT_DIR}/i3" "${configDir}"
	ln -svi "${PROJECT_DIR}/i3blocks" "${configDir}"

	local shareDir="${HOME}/.local/share"
	mkdir -pv "${shareDir}"

	ln -svi "${PROJECT_DIR}/fonts" "${shareDir}"
}

##
# Download git repos.
##
setup_git()
{
	if [ ! -d "${HOME}/projects" ]
	then
		return ${EXIT_SETUP_MAIN_PROJECT_DIR_DOES_NOT_EXIST}
	fi

	setup_git_personal
	#setup_git_misc
}

##
# Setup the system files.
##
setup_system()
{
	local systemdDir="${HOME}/.config/systemd/user"
	mkdir -pv "${systemdDir}"

	ln -svi "${PROJECT_DIR}/.pam_environment" "${HOME}"

	for f in "${PROJECT_DIR}"/systemd/*.service
	do
		ln -svi "${f}" "${systemdDir}"
		systemctl --user enable ${name}
	done
}

##
# Download personal git repos.
##
setup_git_personal()
{
	local repos=("aria" "atlasbar" "automnt" "backup" "battery" "brightness" \
				 "mocwrap" "musiclib" "templates" "trash" "volume" "weather" \
				 "wifi")
	local r=
	local e=

	builtin cd "${HOME}/projects"
	mkdir -pv bin

	for r in "${repos[@]}"
	do
		git clone "ssh://git@github.com/gabeg805/${r}"
		builtin cd bin

		for e in "../${r}/"*
		do
			if [ -x "${e}" -a ! -d "${e}" ]
			then
				ln -sv "${e}"
			fi
		done

		builtin cd ..
	done
}

##
# Download miscellaneous git repos.
##
setup_git_misc()
{
	builtin cd "${HOME}/projects"
	mkdir -pv misc
	builtin cd misc
	git clone http://github.com/Airblader/i3blocks-gaps
	git clone ssh://git@github.com/gabeg805/resume
	git clone ssh://git@github.com/gabeg805/website
}

##
# Run script.
##
main "${@}"

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
	local short="hcg"
	local long="help,conf,git"
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
}

##
# Create symbolic links to configuration files.
##
setup_conf()
{
	setup_mksym .aliases "${HOME}"
	setup_mksym .pyhistory "${HOME}"
	setup_mksym .pystartup "${HOME}"
	setup_mksym .vimrc "${HOME}"
	setup_mksym .xbindkeysrc "${HOME}"
	setup_mksym .xinitrc "${HOME}"
	setup_mksym .Xmodmap "${HOME}"
	setup_mksym .Xresources "${HOME}"
	setup_mksym .zshenv "${HOME}"
	setup_mksym .zshrc "${HOME}"
	setup_mksym .texmf "${HOME}"
	setup_mksym .urxvt "${HOME}"
	setup_mksym i3 "${HOME}/.config"
	setup_mksym i3blocks "${HOME}/.config"
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
# Create a symbolic link.
##
setup_mksym()
{
	local file="${1}"
	local src="${PROJECT_DIR}/${file}"
	local dst="${2}"

	if [ ! -d "${dst}" ]
	then
		return ${EXIT_SETUP_DST_DOES_NOT_EXIST}
	else
		builtin cd "${dst}"
	fi

	if [ -e "${dst}/${file}" ]
	then
		local msg="Replace '$(basename "${src}")' in '${dst}'? "
		local response=

		read -p "${msg}" response
		case "${response}" in
			y|Y) ln -svf "${src}" ;;
			*) return ;;
		esac
	else
		ln -svi "${src}"
	fi
}

##
# Run script.
##
main "${@}"

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
	#ln -svi "${PROJECT_DIR}/.aliases" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.pystartup" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.texmf" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.urxvt" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.vim" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.vimrc" "${HOME}"
	##ln -svi "${PROJECT_DIR}/.xbindkeysrc" "${HOME}"
	##ln -svi "${PROJECT_DIR}/.xinitrc" "${HOME}"
	##ln -svi "${PROJECT_DIR}/.Xmodmap" "${HOME}"
	##ln -svi "${PROJECT_DIR}/.Xresources" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.zprofile" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.zshenv" "${HOME}"
	#ln -svi "${PROJECT_DIR}/.zshrc" "${HOME}"

	#local configDir="${HOME}/.config"
	#mkdir -pv "${configDir}"

	#ln -svi "${PROJECT_DIR}/i3" "${configDir}"
	#ln -svi "${PROJECT_DIR}/i3blocks" "${configDir}"

	#local shareDir="${HOME}/.local/share"
	#mkdir -pv "${shareDir}"

	#ln -svi "${PROJECT_DIR}/fonts" "${shareDir}"

	# Check if oh my zsh does not exist yet
	local ohMyZshDir="${HOME}/projects/oh-my-zsh"

	if [ ! -d "${ohMyZshDir}" ]
	then

		# Prompt to see if oh my zsh should be downloaded
		read -p "Download Oh My ZSH? (y/n) " -n 1
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
			exit 0
		fi

		# Download oh my zsh
		ZSH="${ohMyZshDir}" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

		# Check that oh my zsh directory exists
		if [ ! -d "${ohMyZshDir}" ]
		then
			echo "Error: Unable to find Oh My Zsh directory: '${ohMyZshDir}'"
			exit 1
		fi

	fi

	# Move oh my zsh files in place
	mv -f "${HOME}/.zshrc" "${HOME}/.zshrc.post-oh-my-zsh"
	ln -svi "${PROJECT_DIR}/.zshrc.oh-my-zsh" "${HOME}/.zshrc"
	ln -svi "${PROJECT_DIR}/goob.zsh-theme" "${ohMyZshDir}/themes"

	# Download autosuggestion plugin if need be
	if [ ! -d "${ohMyZshDir}/plugins/zsh-autosuggestions" ]
	then
		builtin cd "${ohMyZshDir}/plugins"
		git clone https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions
		builtin cd -
	fi
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
	local name=

	mkdir -pv "${systemdDir}"

	ln -svi "${PROJECT_DIR}/.pam_environment" "${HOME}"

	for f in "${PROJECT_DIR}"/systemd/*.service
	do
		name=$(basename "${f}" ".service")

		ln -svi "${f}" "${systemdDir}"
		systemctl --user enable ${name}
	done

	if hash redshift 2> /dev/null
	then
		systemctl --user enable redshift-gtk.service
	fi
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

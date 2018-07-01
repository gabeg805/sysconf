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
PACKAGE=

##
# Exit statuses.
##
EXIT_NO_OPT_ENTERED=10

##
# Create symbolic links.
##
main()
{
	# Parse options
	local short="hcgp"
	local long="help,conf,git,package"
	local args=$(getopt -o "${short}" --long "${long}" --name "${PROJECT}" \
					-- "${@}")
	if [ $? -ne 0 ]
	then
		usage
		exit 1
	fi
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
			-p|--package)
				PACKAGE=true
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
	elif [ -n "${PACKAGE}" ]
	then
		setup_packages
	else
		:
	fi

	exit $?
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
	echo "	  -p, --package"
	echo "		  Install packages."
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
		return ${EXIT_SYMCONF_MAIN_PROJECT_DIR_DOES_NOT_EXIST}
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
	git clone ssh://git@github.com/gabeg805/arch
	git clone ssh://git@github.com/gabeg805/resume
	git clone ssh://git@github.com/gabeg805/website
}

##
# Install packages.
##
setup_packages()
{
	pacman -S acpi \
		alsa-firmware \
		alsa-oss \
		alsa-plugins \
		alsa-tools \
		alsa-utils \
		bc \
		dmenu \
		doxygen \
		evince \
		feh \
		firefox \
		gdb \
		gimp \
		git \
		gparted \
		gsimplecal \
		i3-wm \
		i3status \
		ifplugd \
		iproute2 \
		iputils \
		iw \
		libpam-google-authenticator \
		logrotate \
		lsof \
		moc \
		nmap \
		openssh \
		openvpn \
		os-prober \
		otf-font-awesome \
		pulseaudio \
		pulseaudio-alsa \
		python-gobject \
		python-matplotlib \
		qrencode \
		redshift \
		rsync \
		rxvt-unicode \
		scrot \
		transmission-gtk \
		ttf-dejavu \
		ttf-droid \
		ttf-inconsolata \
		unzip \
		urxvt-perls \
		vim \
		vlc \
		wget \
		wpa_supplicant \
		xbindkeys \
		xcompmgr \
		xorg-server \
		xorg-fonts-misc \
		xorg-xdm \
		xorg-xev \
		xorg-xhost \
		xorg-xinit \
		xorg-xkill \
		xorg-xlsfonts \
		xorg-xprop \
		xorg-xwininfo \
		zsh

		# gohufont
		# ttf-ms-fonts
		# udisks
		# youtube-dl-mp3
		# xorg-server-utils

		# pacman -S android-platform
		# pacman -S android-sdk
		# pacman -S android-sdk-build-tools
		# pacman -S android-sdk-platform-tools
		# pacman -S android-studio
		# pacman -S arduino
		# pacman -S arduino-mk
		# pacman -S aspell
		# pacman -S aspell-en
		# pacman -S audacity
		# pacman -S brother-mfc-j480dw
		# pacman -S cups
		# pacman -S device-mapper
		# pacman -S incron
		# pacman -S inetutils
		# pacman -S inotify-tools
		# pacman -S intltool
		# pacman -S jdk7-openjdk
		# pacman -S net-tools
		# pacman -S openjdk7-src
		# pacman -S pciutils
		# pacman -S pcmciautils
		# pacman -S python-pyserial
		# pacman -S python2-matplotlib
		# pacman -S python2-pyserial
		# pacman -S python2-virtualenv
		# pacman -S qiv
		# pacman -S strace
		# pacman -S sudo
		# pacman -S sysfsutils
		# pacman -S sysstat
		# pacman -S systemd-sysvcompat
		# pacman -S thunar
		# pacman -S usbutils
		# pacman -S util-linux
		# pacman -S valgrind
		# pacman -S vi
		# pacman -S vpnc
		# pacman -S wavpack
		# pacman -S xdotool
		# pacman -S xf86-input-synaptics
		# pacman -S xfsprogs
}

##
# Create a symbolic link.
##
setup_mksym()
{
	local src="${PROJECT_DIR}/${1}"
	local dst="${2}"
	builtin cd "${dst}"
	if [ -e "${src}" ]
	then
		return
	fi
	ln -sv "${src}"
}

##
# Run script.
##
main "${@}"

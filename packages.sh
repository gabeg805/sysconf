#!/bin/bash
# ------------------------------------------------------------------------------
# 
# Name:   packages.sh
# Author: Gabe Gonzalez
# 
# Brief: Download and install the required (according to what I use on a daily
#        basis) packages needed after a fressh install.
# 
# ------------------------------------------------------------------------------

##
# Project name.
##
PROJECT="${0##*/}"

##
# Options.
##
INSTALL=

##
# Download packages.
##
main()
{
	local short="hi"
	local long="help,install"
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
			-i|--install)
				INSTALL=true
				;;
			*)
				break
				;;
		esac
		shift
	done

	# Run options
	if [ -n "${INSTALL}" ]
	then
		packages_install
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
	echo "	  -i, --install"
	echo "		  Install packages."
}

##
# Install packages.
##
packages_install()
{
	pacman -S acpi \
		alsa-firmware \
		alsa-oss \
		alsa-plugins \
		alsa-tools \
		alsa-utils \
		bc \
		cronie \
		dhcpcd \
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
		ntfs-3g \
		ntp \
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
		sysstat \
		transmission-gtk \
		ttf-anonymous-pro \
		ttf-dejavu \
		ttf-droid \
		ttf-inconsolata \
		udisks2 \
		unzip \
		urxvt-perls \
		vim \
		vlc \
		wget \
		wpa_supplicant \
		xbindkeys \
		xcompmgr \
		xorg-server \
		xorg-server-common \
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
# Run the script.
##
main "${@}"

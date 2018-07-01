#!/bin/bash
# ------------------------------------------------------------------------------
# 
# Name: symhome.sh
# Author: Gabe Gonzalez
# 
# Brief: Create symbolic links of all system files (contained in this repo) and
#        have the destination be the running user's home directory.
# 
# ------------------------------------------------------------------------------

##
# Project name.
##
PROJECT="${0##*/}"

##
# Options.
##
RUN=

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
    local short="hr"
    local long="help,run"
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
            -r|--run)
                RUN=true
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    # Run options
    if [ -n "${RUN}" ]
    then
        symconf_run
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
    echo "    -h, --help"
    echo "        Print program usage."
    echo 
    echo "    -r, --run"
    echo "        Create symbolic links of the system files."
}

##
# Create all symbolic links.
##
symconf_run()
{
    symconf_mksym .aliases "${HOME}"
    symconf_mksym .pyhistory "${HOME}"
    symconf_mksym .pystartup "${HOME}"
    symconf_mksym .xbindkeysrc "${HOME}"
    symconf_mksym .xinitrc "${HOME}"
    symconf_mksym .Xmodmap "${HOME}"
    symconf_mksym .Xresources "${HOME}"
    symconf_mksym .zshenv "${HOME}"
    symconf_mksym .zshrc "${HOME}"
    symconf_mksym .texmf "${HOME}"
    symconf_mksym .urxvt "${HOME}"
    symconf_mksym i3 "${HOME}/.config"
    symconf_mksym i3blocks "${HOME}/.config"
}

##
# Create a symbolic link.
##
symconf_mksym()
{
    local src="${1}"
    local dst="${2}"
    local dir=$(readlink -e $(dirname "${0}"))
    builtin cd "${dst}"
    ln -sv "${dir}/${src}"
}

##
# Run script.
##
main "${@}"

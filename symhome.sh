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
CREATE=

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
    local short="hc"
    local long="help,create"
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
            -c|--create)
                CREATE=true
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    # Run options
    if [ -n "${CREATE}" ]
    then
        symhome_create
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
    echo "    -c, --create"
    echo "        Create symbolic links of the system files and set them in the"
    echo "        user's home."
}

##
# Create symbolic links.
##
symhome_create()
{
    local dir=$(readlink -e $(dirname "${0}"))
    builtin cd "${HOME}"
    for f in $(find "${dir}" -maxdepth 1)
    do
        if [ "${f}" == "${dir}" -o -e $(basename "${f}") ] \
               || symhome_is_ignore "${f}"
        then
            continue
        fi
        ln -sv "${f}"
    done
}

##
# Check if input is a file/directory to ignore or if a symbolic link should be
# made for it.
##
symhome_is_ignore()
{
    local input=$(basename "${1}")
    local ignore=("images" ".fonts" ".git" ".urxvt" ".gitignore" "${PROJECT}")
    for i in "${ignore[@]}"
    do
        if [ "${i}" == "${input}" ]
        then
            return 0
        fi
    done
    return 1
}

##
# Run script.
##
main "${@}"

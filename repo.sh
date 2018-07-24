#!/bin/bash
# ------------------------------------------------------------------------------
# 
# Name:   repo.sh
# Author: Gabriel Gonzalez
# 
# Brief: Update the git repos.
# 
# ------------------------------------------------------------------------------

##
# Project name.
##
PROJECT="${0##*/}"

##
# Files/directories.
##
REPO_DIR=/data/projects

##
# Options.
##
UPDATE=

##
# Main.
##
main()
{
    local short="hu"
    local long="help,update"
    local args=$(getopt -o "${short}" --long "${long}" \
                        --name "${PROJECT}" -- "${@}")

    if [ $? -ne 0 ]; then
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
                return 0
                ;;
			-u|--update)
				UPDATE=true
				;;
            *)
                break
                ;;
        esac
        shift
    done

    # Run options
    if [ -n "${UPDATE}" ]; then
        repo_update
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
    echo "    -h, --help"
    echo "        Print program usage."
    echo 
    echo "    -u, --update"
    echo "        Update the git repos."
}

##
# Update git repos.
##
repo_update()
{
	local print=false
	local d=

	for d in "${REPO_DIR}"/*
	do
		if [ ! -e "${d}/.git" ]
		then
			continue
		fi

		builtin cd "${d}"

		if [ $(git status | wc -l) -eq 4 ]
		then
			git remote update &> /dev/null

			if [ $(git status | grep -c behind) -eq 1 ]
			then
				if ${print}
				then
					echo
				else
					print=true
				fi

				echo ":: Updating repo '$(basename "${d}")'."
				git pull
			fi
		fi

		builtin cd ..
	done
}

##
# Run script.
##
main "${@}"

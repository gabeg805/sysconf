## ~/.zshenv
##
## Purpose: Contains commands to set important environment variables and to 
##          set the command search path.
## 


## #################
## ZSH Set Variables
## #################

## History size
HISTFILE=~/.histfile
HISTSIZE=1000000000000
SAVEHIST=1000000000000



## ***********
## Set Options
## ***********

## Append history list to history file (rather than replace it)
setopt appendhistory 

## If directory name is entered (w/o issuing cd command) then assume cd was intended
setopt autocd 

## Treat the '#', '~' and '^' characters as part of patterns for filename generation
setopt extendedglob

## Prevent aliases on command line from being substituted before completion is attempted
setopt completealiases

## Do not require a leading '.' in a filename to be matched explicitly
setopt globdots

## Enables brace expansion for alphabetic characters
setopt braceccl



## *************
## Unset Options
## *************

## Beep on error in ZLE
unsetopt beep 

## If a pattern for filename generation has no matches, print an error
unsetopt nomatch


## Miscellaneous commands
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/gabeg/.zshrc'
autoload -Uz compinit
compinit



## ##################
## User Set Variables
## ##################

## user environment variabls (out of laziness)
export dls=/mnt/Linux/Share/docs/dls
export sch=/mnt/Linux/Share/docs/school/spr14
export share=/mnt/Linux/Share

## Python startup history
export PYTHONSTARTUP=/home/gabeg/.pystartup


## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Default Editor
export VISUAL=/usr/bin/emacs
export EDITOR=/usr/bin/emacs
export SUDO_EDITOR=/usr/bin/emacs



## IDL License
export IDL_LMGRD_LICENSE_FILE="1700@astroidl.bu.edu"
export IDL_HELP_BROWSER='firefox'



## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    
    LS_COLORS=$LS_COLORS:'*~=00;31':'*.pdf=00;32':'*.bak=00;33':'*.ps=01;35':'*.orig=00;33'
    export LS_COLORS
fi


## Stop "Warning: couldn't register with accessibility bus" errors
export NO_AT_BRIDGE=1


## ################
## Editing The Path
## ################


PATH=` echo "${PATH}": \
    "/opt/qcad": \
    "/mnt/Linux/Share/scripts": \
    "/mnt/Linux/Share/scripts/random": \
    "/mnt/Linux/Share/scripts/system": \
    "/mnt/Linux/Share/scripts/programs": \
    "/mnt/Linux/Share/scripts/programs/aria": \
    "/mnt/Linux/Share/scripts/programs/atlas/c++": \
    "/mnt/Linux/Share/scripts/programs/android": \
    "/mnt/Linux/Share/scripts/programs/automount": \
    "/mnt/Linux/Share/scripts/programs/automount/dep": \
    "/mnt/Linux/Share/scripts/programs/backup": \
    "/mnt/Linux/Share/scripts/programs/battery": \
    "/mnt/Linux/Share/scripts/programs/bday": \
    "/mnt/Linux/Share/scripts/programs/brightness": \
    "/mnt/Linux/Share/scripts/programs/cpu": \
    "/mnt/Linux/Share/scripts/programs/flash": \
    "/mnt/Linux/Share/scripts/programs/hex": \
    "/mnt/Linux/Share/scripts/programs/music": \
    "/mnt/Linux/Share/scripts/programs/music/dep": \
    "/mnt/Linux/Share/scripts/programs/trash": \
    "/mnt/Linux/Share/scripts/programs/tree": \
    "/mnt/Linux/Share/scripts/programs/volume": \
    "/mnt/Linux/Share/scripts/programs/weather": \
    "/mnt/Linux/Share/scripts/programs/weather/dep": \
    "/mnt/Linux/Share/scripts/programs/wifi" \
    | sed 's/ //g'`

typeset -U path

# ~/.zshenv
#
# Purpose: Contains commands to set important environment variables and to 
#          set the command search path.
# 

# History size
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=${HISTSIZE}

# Ignore duplicates
setopt hist_ignore_all_dups

# Prevent preceding spaces from being recorded in histfile
setopt hist_ignore_space

# Append history list to history file (rather than replace it)
setopt appendhistory 

# If directory name is entered (w/o issuing cd command) then assume cd was
# intended
setopt autocd 

# Treat the '#', '~' and '^' characters as part of patterns for filename
# generation
setopt extendedglob

# Prevent aliases on command line from being substituted before completion
# is attempted
setopt completealiases

# Do not require a leading '.' in a filename to be matched explicitly
setopt globdots

# Enables brace expansion for alphabetic characters
setopt braceccl

# Beep on error in ZLE
unsetopt beep 

# If a pattern for filename generation has no matches, print an error
unsetopt nomatch

# Miscellaneous commands
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/gabeg/.zshrc'
autoload -Uz compinit
compinit

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Python startup history
export PYTHONSTARTUP=${HOME}/.pystartup

# Default Editor
export VISUAL=/usr/bin/emacs
export EDITOR=/usr/bin/emacs
export SUDO_EDITOR=/usr/bin/emacs

# Latex user class files
export TEXMFHOME=${HOME}/.texmf

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    export LS_COLORS=${LS_COLORS}:'*~=00;31':'*.pdf=00;32':'*.bak=00;33':'*.ps=01;35':'*.orig=00;33'
fi

# Editing The Path
PROJDIR="${HOME}/projects"
PATH="${PATH}":/opt/android-studio/bin:/opt/android-studio/gradle/latest/bin:${HOME}/Android/Sdk/tools:${HOME}/Android/Sdk/platform-tools:${PROJDIR}/automount:${PROJDIR}/backup:${PROJDIR}/battery:${PROJDIR}/brightness:${PROJDIR}/cpu:${PROJDIR}/Trash:${PROJDIR}/volume:${PROJDIR}/weather:${PROJDIR}/wifi
typeset -U path

# ------------------------------------------------------------------------------
# 
# File: ~/.zshrc
# Author: Gabe Gonzalez
# 
# Brief: Interactive shell configuration. Started every time a terminal is run.
# 
# ------------------------------------------------------------------------------

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
zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Emacs key bindings
bindkey -e

if [ "$(hostname)" == "magnumopus" ]
then
	bindkey "\e[1;3C" forward-word                      # alt + right
	bindkey "\e[1;3D" backward-word                     # alt + left
	bindkey "\e[1;5C" forward-word                      # ctrl + right
	bindkey "\e[1;5D" backward-word                     # ctrl + left
	bindkey "\e[1;3B" history-beginning-search-forward  # alt + down
	bindkey "\e[1;3A" history-beginning-search-backward # alt + up
	bindkey "\e[1;5B" history-beginning-search-forward  # ctrl + down
	bindkey "\e[1;5A" history-beginning-search-backward # ctrl + up
	bindkey "\e[3~"   delete-char                       # delete
	bindkey "\e[3;3~" kill-word                         # alt + delete
	bindkey "\e[3;5~" kill-word                         # ctrl + delete
	bindkey "^H"      backward-kill-word                # ctrl + backspace
else
	bindkey "^[^[[C"  forward-word                      # alt + right
	bindkey "^[^[[D"  backward-word                     # alt + left
	#bindkey "" forward-word                            # ctrl + right
	#bindkey "" backward-word                           # ctrl + left
	bindkey "^[^[[B"  history-beginning-search-forward  # alt + down
	bindkey "^[^[[A"  history-beginning-search-backward # alt + up
	bindkey "^[[B"    history-beginning-search-forward  # ctrl + down
	bindkey "^[[A"    history-beginning-search-backward # ctrl + up
	bindkey "^[[3~"   delete-char                       # delete
	bindkey "^[^[[3~" kill-word                         # alt + delete
	bindkey "^[[3^"   kill-word                         # ctrl + delete
	bindkey "^H"      backward-kill-word                # ctrl + backspace
fi

unset WORDCHARS
autoload -U select-word-style
select-word-style bash

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} ))
then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

## Ignore commands
function zshaddhistory()
{
	emulate -L zsh

	if ! [[ "$1" =~ "(^ |^ykchalresp|--password)" ]]
	then
		print -sr -- "${1%%$'\n'}"
		fc -p
	else
		return 1
	fi
}

# Aliases
if [ -f "${HOME}/.aliases" ]
then
	. "${HOME}/.aliases"
fi

# Environment variables
if [ -f "${HOME}/.zshenv" ]
then
	. "${HOME}/.zshenv"
fi

# Amazon Web Services
if [ -f "${HOME}/.awsenv" ]
then
	. "${HOME}/.awsenv"
fi

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

# Menu driven completion
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Squeese slashes so that // does NOT expand to /*/
zstyle ':completion:*' squeeze-slashes true

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Tells compinstall where the zstyle statements are, if you need to run
# compinstall again
zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

#key[Home]="${terminfo[khome]}"
#key[End]="${terminfo[kend]}"
#key[Insert]="${terminfo[kich1]}"
#key[Backspace]="${terminfo[kbs]}"
#key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
#key[PageUp]="${terminfo[kpp]}"
#key[PageDown]="${terminfo[knp]}"
#key[Shift-Tab]="${terminfo[kcbt]}"

#if [ "$(hostname)" == "magnumopus" ]
#then
#	bindkey "\e[1;3C" forward-word                      # alt + right
#	bindkey "\e[1;3D" backward-word                     # alt + left
#	bindkey "\e[1;5C" forward-word                      # ctrl + right
#	bindkey "\e[1;5D" backward-word                     # ctrl + left
#	bindkey "\e[1;3B" history-beginning-search-forward  # alt + down
#	bindkey "\e[1;3A" history-beginning-search-backward # alt + up
#	bindkey "\e[1;5B" history-beginning-search-forward  # ctrl + down
#	bindkey "\e[1;5A" history-beginning-search-backward # ctrl + up
#	bindkey "\e[3~"   delete-char                       # delete
#	bindkey "\e[3;3~" kill-word                         # alt + delete
#	bindkey "\e[3;5~" kill-word                         # ctrl + delete
#	bindkey "^H"      backward-kill-word                # ctrl + backspace
#else
	#bindkey "^[^[[C"  forward-word                      # alt + right
	#bindkey "^[^[[D"  backward-word                     # alt + left
	#bindkey "" forward-word                            # ctrl + right
	#bindkey "" backward-word                           # ctrl + left
	#bindkey "^[^[[B"  history-beginning-search-forward  # alt + down
	#bindkey "^[^[[A"  history-beginning-search-backward # alt + up
	#bindkey "^[[B"    history-beginning-search-forward  # ctrl + down
	#bindkey "^[[A"    history-beginning-search-backward # ctrl + up

	bindkey "^[[1;5C" forward-word                      # ctrl + right
	bindkey "^[[1;5D" backward-word                     # ctrl + left
	bindkey "^H"      backward-kill-word                # ctrl + backspace
	bindkey "^[[3;5~" kill-word                         # ctrl + delete
	bindkey "^[[3~"   delete-char                       # delete
#fi

#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search
#bindkey "^[[B" down-line-or-beginning-search

#bindkey '\e[A' history-search-backward
#bindkey '\e[B' history-search-forward

#autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search

#autoload -Uz history-beginning-search-forward history-beginning-search-backward
#zle -N history-beginning-search-backward
#zle -N history-beginning-search-forward

[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-beginning-search-backward
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-beginning-search-forward

#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-search-backward
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-search-forward
#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history

# Vim key bindings
bindkey -v

unset WORDCHARS
autoload -U select-word-style
select-word-style bash

#  Start vim (in command line) in normal mode
#autoload -Uz add-zle-hook-widget
#add-zle-hook-widget line-init vi-cmd-mode

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
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

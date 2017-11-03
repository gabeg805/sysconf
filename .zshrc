## ~/.zshrc file
##
## Purpose: Main ZSH config file.
##

## Emacs key bindings
bindkey -e

bindkey '^[^[[D' backward-word     # alt+left
bindkey '^[^[[C' forward-word      # alt+right
bindkey '^[Od' backward-word       # alt+left
bindkey '^[Oc' forward-word        # alt+right
bindkey '^[[3^' kill-word          # cltr+del
bindkey '^H' backward-kill-word    # ctrl+backspace
bindkey '^[[A' history-beginning-search-backward   # up arrow
bindkey '^[[B' history-beginning-search-forward    # down arrow
# echo $WORDCHARS
unset WORDCHARS

autoload -U select-word-style
select-word-style bash

## Add special keys to use
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char

## Finally, make sure the terminal is in application mode, when zle is
## active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

## Edit prompt 
autoload -U colors && colors   ## add colors to prompt
case $UID in
    0)
        newline=$'\n'
        PROMPT="%{$bg[white]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}${newline}> "
        # PROMPT="%D{%a %b %-d, %I:%M:%S}${newline}%{$bg[white]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}${newline}> "
        ;;
    *)
        newline=$'\n'
        PROMPT="%{$bg[cyan]%}%n@%M: %d\$%{$reset_color%}${newline}> "
        ;;
esac

## Aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

## Environment variables
if [ -f ~/.zshenv ]; then
    . ~/.zshenv
fi

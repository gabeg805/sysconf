## ~/.zshrc file
##
## Purpose: Main ZSH config file.
##



## #################
## USER KEY BINDINGS
## #################

## emacs key bindings
bindkey -e

bindkey '^[[A' history-beginning-search-backward   ## up arrow
bindkey '^[[B' history-beginning-search-forward    ## down arrow
## bindkey '^[^[[C' forward-word      ## alt+right
## bindkey '^[^[[D' backward-word     ## alt+left


## echo $WORDCHARS
unset WORDCHARS

autoload -U select-word-style
select-word-style bash

## SEPCHARS='*?_-.[]~=/&;!#$%^(){}<>'
## SEPCHARS='[/-.&*|;!#$%^(){}<>_ ]'

## my-forward-word() {
##     if [[ "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; then
##         (( CURSOR += 1 ))
##         return
##     fi
##     while [[ CURSOR -lt "${#BUFFER}" && ! "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; do
##         (( CURSOR += 1 ))
##     done
## }

## my-backward-word() {
##     if [[ "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; then
##         (( CURSOR -= 1 ))
##         return
##     fi
##     while [[ CURSOR -gt 0 && ! "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; do
##         (( CURSOR -= 1 ))
##     done
## }

## zle -N my-backward-word
## zle -N my-forward-word

bindkey '^[^[[C' forward-word      ## alt+right
bindkey '^[^[[D' backward-word     ## alt+left

bindkey '^[[3^' kill-word          ## cltr+del
bindkey '^H' backward-kill-word    ## ctrl+backspace

## bindkey '^[Oc' forward-word        ## ctrl+right
## bindkey '^[Od' backward-word       ## ctrl+left



## #######################
## ADD SPECIAL KEYS TO USE
## #######################

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




## ###########
## EDIT PROMPT 
## ###########

autoload -U colors && colors   ## add colors to prompt
case $UID in
    0)
        newline=$'\n'
        PROMPT="%{$bg[white]%}%{$fg[black]%}%n@%M: %d\$%{$reset_color%}${newline}> "
        ;;
    *)
        newline=$'\n'
        PROMPT="%{$bg[cyan]%}%n@%M: %d\$%{$reset_color%}${newline}> "
        ;;
esac



## ###########################
## ENABLE ALIASES AND ENV VARS 
## ###########################

## Aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

## Environment variables
if [ -f ~/.zshenv ]; then
    . ~/.zshenv
fi


## Store environment variables
envfile="${HOME}/.${USER}-env"
if [ ! -f "${envfile}" ]; then
    touch "${envfile}"
fi
printenv > "${envfile}"



## ####################
## DISABLE SCREEN SAVER
## ####################

## Check if graphical instance is running
# if [ ! -z "$DISPLAY" ]; then
#     screencheck=`xset q \
#         | grep -E '^Screen Saver' -A 1 \
#         | tail -1 \
#         | sed 's/ /\n/g' \
#         | grep -c 'no'`
    
#     if [ $screencheck -ne 2 ]; then
#         /usr/bin/xset s off -d "$DISPLAY"
#         /usr/bin/xset s 0 0
#         /usr/bin/xset s noblank
#         /usr/bin/xset s noexpose
#         /usr/bin/xset dpms 0 0 0
#     fi
# fi

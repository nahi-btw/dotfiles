#
# ~/.bashrc
#

# If not running interactively, don't do anything
export BROWSER="librewolf"
[[ $- != *i* ]] && return
export EDITOR="nvim"
export VISUAL="$EDITOR"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"
alias shb="shellbeats"
alias chatgpt="surf chatgpt.com &"
alias jfi='carbonyl https://lofiradio24.com/radio/jazzhop'
alias nv='nvim'
alias v='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cdwm="vim ~/suckless/dwm/config.h"
alias mdwm="cd ~/suckless/dwm; sudo make clean install;cd -"
alias pdf="zathura"
alias rd="redshift -P -O"
alias ci3="nvim ~/.config/i3/config"

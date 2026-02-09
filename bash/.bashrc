#
# ~/.bashrc
#

# If not running interactively, don't do anything
export BROWSER="qutebrowser"
[[ $- != *i* ]] && return
export EDITOR="vim"
export VISUAL="$EDITOR"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"
alias shb="shellbeats"
alias chatgpt="surf chatgpt.com &"
alias jfi='carbonyl https://lofiradio24.com/radio/jazzhop'
alias nv='nvim'

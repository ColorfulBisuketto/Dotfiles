#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -o'
alias la='ll -A'
alias grep='grep --color=auto'
alias icat='kitten icat'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

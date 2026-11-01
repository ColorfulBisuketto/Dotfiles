#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

export QT_PLUGIN_PATH=/usr/lib/qt/plugins
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='la -lh'
alias cl='clear'
alias grep='grep --color=auto'
alias rm='trash'
alias ping='ping -c 5'
alias cls='clear'
alias s='kitten ssh'
alias b='bluetui'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# add scripts folder to path
if [ -d "$HOME/scripts" ]; then
	PATH="$HOME/scripts:$PATH"
fi

# Customize to your needs...
export WORKON_HOME=~/Envs
alias hist='history -10'
alias hist0='history 0'
alias poweroff='sudo iwconfig wlan0 power off'

# start tmux automatically
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh

setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space # remove command line from history list when first character on the line is a space

# add date and time to history
export HISTTIMEFORMAT='%F %T '

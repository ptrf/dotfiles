# vim: set ts=4 et sts=4 foldmethod=marker :

# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# === INIT ===

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export BASH_RC_DIRECTORY="~/.bash.d"

# global bashrc
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# === SHOPTS - STTY - SETS ===

shopt -s cdspell      # minor spell check in cd
shopt -s extglob      # extensive pattern matching in expansion
shopt -s cmdhist      # save combined command as one
shopt -s checkjobs    # check for running jobs at exit
shopt -s hostcomplete # hostname completion
shopt -u mailwarn
#unset MAILCHECK

stty erase 
# dont accidentally fill existing files
set -o noclobber
# I don't use history expansion.
set +H

# === FUNCTIONS ===

source $BASH_RC_DIRECTORY/functions.sh

# === EXPORTS ===

source $BASH_RC_DIRECTORY/colors.sh
source $BASH_RC_DIRECTORY/environment.sh

# === ALIASES ===

source $BASH_RC_DIRECTORY/aliases.sh

# === OTHER ===

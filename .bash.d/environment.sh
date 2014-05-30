# System - OS and architecture
if [ -z "${!MY_SYSTEM_*}" ] ; then
    export MY_SYSTEM_ARCH=$(uname -m 2>&1)
    export MY_SYSTEM_KERNEL=$(uname -s 2>&1)
fi

# Make vim the default editor
export EDITOR="vim"

if [[ $EUID == 0 ]] ; then
    export PS1="$BLACK[ $WHITERED\u$BLACK @ $CYAN\h$BLACK ]$YELLOW \w \n$BLACK\$> \[\033[0m\]"
else
    export PS1="$BLACK[ $GREEN\u$BLACK @ $CYAN\h$PURPLE\$(parse_git_branch) $BLACK]$YELLOW \w \n$BLACK\$> \[\033[0m\]"
fi

# Pager
export PAGER=less

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# TERM options
if infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

# Don’t clear the screen after quitting a manual page
export MANPAGER="$PAGER -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# rbenv
if [ -x $(which rbenv 2> /dev/null) ] ; then
    # ok, this does more than just export PATH but w/e
    eval "$(rbenv init -)"
fi

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Darwin specifics

if [ "$MY_SYSTEM_ARCH" = "Darwin" ] ; then
    PATH_HELPER="/usr/libexec/path_helper"
    if [ -x $PATH_HELPER ] ; then
        unset PATH
        unset MANPATH
        eval $($PATH_HELPER -s)
    fi

    if [ -x $(which brew 2> /dev/null) ] ; then
        BREW_PREFIX="$(brew --prefix)/bin"
        export PATH=$BREW_PREFIX:$PATH
    fi

    export COPYFILE_DISABLE=1

    # Link Homebrew casks in `/Applications` rather than `~/Applications`
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

# FreeBSD specifics

if [ "$MY_SYSTEM_ARCH" = "FreeBSD" ] ; then
    echo $PATH | grep -q -s "/usr/local/bin"
    if [ $? -eq 1 ] ; then
        PATH=$PATH:/usr/local/bin
        export PATH
    fi
fi

# Linux specifics

if [ "$MY_SYSTEM_ARCH" = "Linux" ] ; then
    echo "WARN: No Linux specific environment config"
fi



if [[ "$MY_SYSTEM_KERNEL" = "Darwin" ]] ; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi
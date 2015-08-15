#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"

# optional pulling
[ ! -z "$PERFORM_GIT_PULL" ] && git pull origin master

# ensure target
[ -z "$TARGET_DEST" ] && echo "WARNING: TARGET_DEST unset, staging for ~" && TARGET_DEST=~

# ensure system
[ -z "$TARGET_SYSTEM" ] && TARGET_SYSTEM=$(uname -s)


function install_to_target() {
    rsync -avhL --exclude ".git/" --exclude ".gitkeep" --exclude ".DS_Store" --no-perms targets/$TARGET_SYSTEM/ $TARGET_DEST
    [ -x "hooks/${TARGET_SYSTEM}/runhook.sh" ] && echo "There was a run hook script!"
    source $TARGET_DEST/.bash_profile
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    install_to_target
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_to_target
    fi
fi
unset install_to_target

#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master

[ -z $TARGET_DEST ] && TARGET_DEST=~

function doIt() {
    rsync -avhL --exclude ".git/" --exclude ".DS_Store" --no-perms targets/$(uname -s)/ $TARGET_DEST
	source $TARGET_DEST/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt

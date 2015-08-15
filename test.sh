#!/usr/bin/env bash

set -e

export REPO_DIR="$(dirname "${BASH_SOURCE}")"
export TEST_DIR="$REPO_DIR/test"

cd $REPO_DIR

[ -d $TEST_DIR ] && rm -r $TEST_DIR
mkdir $TEST_DIR

unset PERFORM_GIT_PULL
export TARGET_DEST=$TEST_DIR

$REPO_DIR/install.sh

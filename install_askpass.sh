#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -f -v -s "$DIR"/ssh-askpass /opt/tmux-askpass

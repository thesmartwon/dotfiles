#!/bin/bash
ID=$(xdpyinfo | grep "focus" | sed -nr 's#.*(0x[[:xdigit:]]+).*#\1#p')
PID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
CHILD_PID=$(pgrep -P $PID)

workdir=~/src
if [ -e "/proc/$CHILD_PID/cwd" ]; then
	workdir=$(readlink /proc/$CHILD_PID/cwd)
fi
alacritty --working-directory "$workdir"

#!/bin/bash
ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
PID=$(($(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3) + 1))
if [ -e "/proc/$PID/cwd" ]
then
  i3-sensible-terminal --working-directory $(readlink /proc/$PID/cwd)
else
  i3-sensible-terminal
fi

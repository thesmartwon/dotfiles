#!/bin/bash
ID=$(xdpyinfo | grep "focus" | sed -nr 's#.*(0x[[:xdigit:]]+).*#\1#p')
PID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
CHILD_PID=$(pgrep -P $PID)
if [ -e "/proc/$CHILD_PID/cwd" ]; then
  i3-sensible-terminal --working-directory $(readlink /proc/$CHILD_PID/cwd)
else
	workhome=~/src/github.com/polygon-io
	homedir=~/src
	if [[ -d $workhome ]]
	then
		homedir=$workhome
	fi
	i3-sensible-terminal --working-directory $homedir
fi

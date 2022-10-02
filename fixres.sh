#!/bin/bash
xrandr --output DP-0 --mode 2560x1440 --rate 165 && xrandr --output DP-4 --primary --mode 2560x1440 --rate 165 --right-of DP-0 && xrandr --output DP-2 --mode 2560x1440 --rate 165 --right-of DP-4

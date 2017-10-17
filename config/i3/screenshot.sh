#!/usr/bin/env bash

cmd="$1"

fname=~/Pictures/Screenshots/$(date +%s).png

case "$cmd" in
    "window")
        maim -i $(xdotool getactivewindow) $fname
        ;;
    "desktop" | *)
        maim $fname
        ;;
esac

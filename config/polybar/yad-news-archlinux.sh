#!/bin/sh

URL=$(python ~/.config/polybar/news-archlinux.py | yad --list --column=Date --column=News --column=URL --print-column=3 --hide-column=3 | awk -F'|' '{printf $1}')

if [[ ! -z "$URL" ]]; then
    xdg-open "$URL"
fi

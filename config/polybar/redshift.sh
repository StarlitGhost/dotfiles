#!/usr/bin/env bash

icon=""

if pgrep -x redshift &> /dev/null; then
    temp=$(redshift -p 2>/dev/null | grep temp | cut -d' ' -f3)
    temp=${temp//K/}
fi

if [[ -z $temp ]]; then
    echo "%{F#65737e}$icon"
elif [[ $temp -ge 5000 ]]; then
    echo "%{F#81a2be}$icon"
elif [[ $temp -ge 4000 ]]; then
    echo "%{F#ebcb8b}$icon"
else
    echo "%{F#d08770}$icon"
fi

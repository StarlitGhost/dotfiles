#!/usr/bin/env bash

# keep the useless sink var for compatibility with volume-pulse.sh
sink="$1"
cmd="$2"

function notify_vol_change()
{
    # amixer output is " Mono: Playback 60 [41%] [-20.25dB] [on]"
    percentage="$(amixer -M get Master | awk '/Mono.+/ {print $4}' | tr -d '[]')"
    muted="$(amixer -M get Master | awk '/Mono.+/ {print $6=="[off]"?"  ":""}' | tr -d '[]')"
    notify-send -u low -h "int:value:$percentage" " " "$muted"
}

if [ "$cmd" == "up" ]; then
    amixer -M set Master 2.5%+
    notify_vol_change
elif [ "$cmd" == "down" ]; then
    amixer -M set Master 2.5%-
    notify_vol_change
elif [ "$cmd" == "mute" ]; then
    amixer set Master toggle
    notify_vol_change
fi

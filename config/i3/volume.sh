#!/usr/bin/env bash

sink="$1"
cmd="$2"

function notify_vol_change()
{
    vol=""
    if [ "$(pamixer --get-mute)" == "true" ]; then
        vol="  "
    fi
    notify-send -u low "$vol  $(pamixer --get-volume)%"
}

if [ "$cmd" == "up" ]; then
    pactl set-sink-volume $sink +2.5%
    notify_vol_change
elif [ "$cmd" == "down" ]; then
    pactl set-sink-volume $sink -2.5%
    notify_vol_change
elif [ "$cmd" == "mute" ]; then
    pactl set-sink-mute $sink toggle
    notify_vol_change
fi

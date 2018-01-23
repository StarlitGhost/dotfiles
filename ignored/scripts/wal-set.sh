#!/usr/bin/env bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=$(cat ${HOME}/.cache/dbusaddr)

. "${HOME}/.cache/wal/colors.sh"

reload_dunst() {
    pkill dunst
    dunst \
        -frame_color "${color2:-#8af4f4}" \
        -lb "${color0:-#2f343f}" \
        -nb "${color0:-#2f343f}" \
        -cb "${color0:-#2f343f}" \
        -lf "${color7:-#f3f4f5}" \
        -nf "${color7:-#f3f4f5}" \
        -cf "${color4:-#e53935}" \
        -cfr "${color4:-#ff0000}" &
}

main() {
    reload_dunst &
}

main

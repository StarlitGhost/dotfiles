#!/usr/bin/env bash

export DISPLAY=:0
DBUS_SESSION_BUS_ADDRESS=$(cat "${HOME}/.cache/dbusaddr")
export DBUS_SESSION_BUS_ADDRESS

# shellcheck source=/home/starlitghost/.cache/wal/colors.sh
. "${HOME}/.cache/wal/colors.sh"

hex2rgb() {
    printf "%d %d %d\n" "0x${1:1:2}" "0x${1:3:2}" "0x${1:5:2}"
}

saturatergb() {
    python -c "import colorsys
hls = colorsys.rgb_to_hls($1/255.0, $2/255.0, $3/255.0)
rgb = colorsys.hls_to_rgb(hls[0], hls[1], max(min(hls[2]*2.0, 1.0), 0.0))
rgb = tuple(int(i*255) for i in rgb)
print('{} {} {}'.format(*rgb))"
}

printrgb() {
    arr=("$@")
    printf "%d,%d,%d\n" ${arr[@]}
}

color2keyboard() {
    hex=$1
    rgb="$(hex2rgb "$hex")"
    saturated="$(saturatergb ${rgb[@]})"
    printrgb "${saturated[@]}"
}

set_keyboard() {
    msi-keyboard -m normal \
        -r "left,$(color2keyboard "$color2")" \
        -r "middle,$(color2keyboard "$color6")" \
        -r "right,$(color2keyboard "$color4")" &
}

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

set_bspwm() {
    if type "bspc" > /dev/null 2>&1; then
        bspc config normal_border_color "${color0:-#2f343f}"
        bspc config active_border_color "${color0:-#2f343f}"
        bspc config focused_border_color "${color2:-#8af4f4}"
    fi
}

main() {
    set_bspwm &
    reload_dunst &
    set_keyboard &
}

main

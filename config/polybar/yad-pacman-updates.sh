#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null); then
    updates_arch=""
fi

# if ! updates_aur=$(yay -Qum 2> /dev/null); then
# if ! updates_aur=$(paru -Qum 2> /dev/null); then
# if ! updates_aur=$(cower -u 2> /dev/null); then
# if ! updates_aur=$(trizen -Su --aur --quiet); then
# if ! updates_aur=$(pikaur -Qua 2> /dev/null); then
# if ! updates_aur=$(rua upgrade --printonly 2> /dev/null); then
if ! updates_aur=$(pikaur -Qua 2> /dev/null); then
    updates_aur=""
fi

updates=$((updates_arch + updates_aur))

if [ "$updates" -gt 0 ]; then
    yad --list --column=Packages "$updates_arch\n$updates_aur"
fi

#!/usr/bin/bash
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

numlockx &
xsetroot -cursor_name left_ptr

exec bspwm

# vim: sw=2 ts=2 et :

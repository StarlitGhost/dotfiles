#!/usr/bin/env bash
if pgrep -f redshift; then
    killall redshift
else
    nohup redshift &
fi

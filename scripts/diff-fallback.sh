#!/usr/bin/env bash
if type diff-so-fancy > /dev/null 2>&1; then
    diff-so-fancy | less --tabs=1,5 -RFX
else
    less --tabs=1,5 -RFX
fi

#!/usr/bin/env bash
if type diff-so-fancy 2&>1 /dev/null; then
    diff-so-fancy | less --tabs=1,5 -RFX
else
    less --tabs=1,5 -RFX
fi

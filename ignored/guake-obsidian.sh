#!/usr/bin/env bash

gconftool-2 -s -t string /apps/guake/style/font/style "DejaVu Sans Mono for Powerline 10"
gconftool-2 -s -t int /apps/guake/style/background/transparency 2
gconftool-2 -s -t string /apps/guake/style/font/color "#C8C8C8C8C8C8"
gconftool-2 -s -t string /apps/guake/style/background/color "#222228282A2A"
gconftool-2 -s -t string /apps/guake/style/font/palette "#111114141515:#DBDB64646464:#9191C8C86060:#FFFFCDCD2222:#64648C8CAFAF:#C4C47575CACA:#3838D1D1D1D1:#C8C8C8C8C8C8:#7F7F7F7F7F7F:#FFFF80808080:#8E8EFFFF2828:#FFFFFFFF7D7D:#8A8AC2C2F4F4:#D8D8A0A0DCDC:#8A8AF4F4F4F4:#F2F2F2F2F2F2"

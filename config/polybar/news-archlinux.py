#!/usr/bin/python
from datetime import datetime
from feedparser import parse

URL = 'https://www.archlinux.org/feeds/news/'
ENTRIES = 5

[print(f"{datetime.strptime(x.published, '%a, %d %b %Y %H:%M:%S %z').strftime('%Y-%m-%d')}\n{x.title}\n{x.link}") for x in parse(URL).entries[:ENTRIES]]

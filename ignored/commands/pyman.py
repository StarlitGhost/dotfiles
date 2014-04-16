#!/usr/bin/env python
 
from sys import argv, exit
 
if len(argv) < 2:
    print 'USAGE: %s MODULE [SYMBOL]\nOpen help() for given module, or given symbol from module.' % \
        argv[0]
    exit(1)
 
module = argv[1]
symbol = argv[2] if len(argv) > 2 else ''
if module == '.': module = ''
 
if module:
    exec 'import %s' % module
exec 'subject = %s' % ".".join((module, symbol)).strip('.')
 
help(subject)

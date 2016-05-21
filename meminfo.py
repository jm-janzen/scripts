#! /usr/bin/python

# WIP - just print some mem info

import sys, re

if not 'linux' in sys.platform:
    exit('Sorry, this script is only for linux systems')
else:
    meminfo = open('/proc/meminfo', 'r')

    for m in meminfo:
        if re.match('MemTotal', m):
            out = re.sub('[^0-9]', '', m)
            sys.stdout.write('Total Memory:\t' + out + '\n')
        elif re.match('MemFree', m):
            out = re.sub('[^0-9]', '', m)
            sys.stdout.write('Free Memory:\t' + out + '\n')


#!/usr/bin/env python3

import pexpect

p = pexpect.spawn('/opt/repo/soc_term/soc_term 54321', timeout=3600)
p.logfile = open('/opt/logs/secure.log', 'wb')

while True:
    p.expect('\r\n')

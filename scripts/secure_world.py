#!/usr/bin/env python

import pexpect

p = pexpect.spawn('/opt/optee/repo/soc_term/soc_term 54321', timeout=3600)
p.logfile = open('/opt/logs/secure.log', 'wb')

while True:
    p.expect('\r\n')
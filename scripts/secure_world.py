#!/usr/bin/env python

import pexpect

p = pexpect.spawn('/opt/optee/repo/soc_ter/soc_term 54321')
p.logfile = open('/opt/logs/secure.log')

while True:
    p.expect('\r\n')

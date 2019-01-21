#!/usr/bin/env python3

import os

import pexpect

os.chdir('/opt/repo/build')

p = pexpect.spawn('make run-only', timeout=3600)
p.logfile = open('/opt/logs/qemu.log', 'wb')

p.expect(r'\(qemu\) ')
p.sendline('c')

sig = input()
p.sendline('q')

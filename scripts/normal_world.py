#!/usr/bin/env python3

import sys

import pexpect

p = pexpect.spawn('/opt/repo/soc_term/soc_term 54320', timeout=3600)
p.logfile_read = open('/opt/logs/normal.log', 'wb')

p.expect('buildroot login: ')
p.sendline('root')
p.expect('# ')

def command(line):
    p.sendline(line)
    output = b''
    while True:
        mux = p.expect(['\r\n', '# '])
        output += p.before
        if mux == 1:
            break
    return output

def exit_code():
    ret = command('echo $?')
    return int(ret.split('\r')[1])

command('mount -t 9p -o trans=virtio host /mnt')
command('cd /mnt')
command('ls -al')
command(' '.join(sys.argv[1:]))

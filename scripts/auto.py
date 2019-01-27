#!/usr/bin/env python3

import os
import sys

from subprocess import Popen, PIPE

os.chdir('/opt/scripts')

q = Popen(['./qemu_console.py'], stdin=PIPE)
n = Popen(['./normal_world.py'] + sys.argv[1:])
s = Popen(['./secure_world.py'])

def trace(path, color):
    cmd  = "tail -f " + path + " | perl -pe 's/.*/\e[" + color + "$&\e[0m/g'"
    return Popen(cmd, shell=True, preexec_fn=os.setpgrp)

os.system('touch /opt/logs/qemu.log')
os.system('touch /opt/logs/normal.log')
os.system('touch /opt/logs/secure.log')
ql = trace('/opt/logs/qemu.log', '33m')
nl = trace('/opt/logs/normal.log', '35m')
sl = trace('/opt/logs/secure.log', '36m')

n.communicate()
q.stdin.write(b'q\n')
q.communicate()
s.kill()
exit()

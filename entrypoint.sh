#!/bin/sh

/opt/scripts/secure_world.py &

cd /opt/optee/repo/build
echo 'c' | make run-only

./soc_term/soc_term 54320

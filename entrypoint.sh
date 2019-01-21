#!/bin/sh

python3 /opt/optee/scripts/secure_world.py &

cd /opt/optee/repo/build
echo 'c' | make run-only &

cd /opt/optee/repo/soc_term
./soc_term 54320

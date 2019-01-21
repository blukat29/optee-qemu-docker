#!/bin/sh

if [ "$1" = "auto" ]; then
    # Auto-run mode. Automatically runs a script at shared directory.
    python3 /opt/scripts/auto.py
else
    # Manual mode. User can interactively use the normal world shell.
    python3 /opt/scripts/secure_world.py &

    cd /opt/repo/build
    echo 'c' |  make run-only &

    /opt/repo/soc_term/soc_term 54320
fi

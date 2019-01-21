#!/bin/sh

if [ "$1" = "auto" ]; then
    # Auto-run mode. Automatically runs a script at shared directory.
    python3 /opt/optee/scripts/auto.py
else
    # Manual mode. User can interactively use the normal world shell.
    python3 /opt/optee/scripts/secure_world.py &

    cd /opt/optee/repo/build
    echo 'c' |  make run-only &

    /opt/optee/repo/soc_term/soc_term 54320
fi

#!/bin/sh

if [ "$1" = "batch" ]; then
    # Pass arguments after 'batch'.
    shift
    # Auto-run mode. Automatically runs a script at shared directory.
    python3 /opt/scripts/auto.py "$@"
elif [ "$1" = "interactive" ]; then
    # Manual mode. User can interactively use the normal world shell.
    python3 /opt/scripts/secure_world.py &

    cd /opt/repo/build
    echo 'c' |  make run-only &

    /opt/repo/soc_term/soc_term 54320
else
    /bin/bash
fi

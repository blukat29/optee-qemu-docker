#!/bin/sh

docker build -t optee-qemu:latest .
mkdir -p workdir/logs
mkdir -p workdir/shared
docker run --rm --name optee \
    -v $(pwd)/workdir/logs:/opt/logs \
    -v $(pwd)/workdir/shared:/opt/shared \
    -it optee-qemu $@

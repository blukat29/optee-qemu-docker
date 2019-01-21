#!/bin/sh

docker build -t optee-qemu:latest .
docker run --rm --name optee -it optee-qemu $@

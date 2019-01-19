#!/bin/sh

docker build -t optee-qemu:latest .
docker run --rm -it optee-qemu /bin/bash

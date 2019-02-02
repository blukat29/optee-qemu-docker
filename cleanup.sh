#!/bin/sh

set -e

cd /opt/repo

rm -r .repo

rm -r toolchains

mv linux/arch/arm64/boot/Image /tmp
rm -r linux
mkdir -p linux/arch/arm64/boot/
mv /tmp/Image linux/arch/arm64/boot/

mv out-br/images /tmp
rm -r out-br
mkdir -p out-br/
mv /tmp/images out-br/

mv qemu/aarch64-softmmu/qemu-system-aarch64 /tmp
rm -r qemu
mkdir -p qemu/aarch64-softmmu/
mv /tmp/qemu-system-aarch64 qemu/aarch64-softmmu/


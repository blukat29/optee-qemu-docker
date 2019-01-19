FROM ubuntu:16.04

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    android-tools-adb \
    android-tools-fastboot \
    autoconf \
    automake \
    bc \
    bison \
    build-essential \
    ca-certificates \
    cscope \
    curl \
    device-tree-compiler \
    expect \
    flex \
    ftp-upload \
    gdisk \
    iasl \
    libattr1-dev \
    libc6:i386 \
    libcap-dev \
    libfdt-dev \
    libftdi-dev \
    libglib2.0-dev \
    libhidapi-dev \
    libncurses5-dev \
    libpixman-1-dev \
    libssl-dev \
    libstdc++6:i386 \
    libtool \
    libz1:i386 \
    make \
    mtools \
    netcat \
    python-crypto \
    python-serial \
    python-wand \
    repo \
    unzip \
    uuid-dev \
    xdg-utils \
    xterm \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/optee/repo \
    && cd /opt/optee/repo \
    && repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 3.3.0 \
    && repo sync

RUN cd /opt/optee/repo/build \
    && make toolchains -j2

RUN ln -s /opt/optee/repo/toolchains /opt/cross

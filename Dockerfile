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
    cpio \
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
    python3 \
    python3-pip \
    repo \
    rsync \
    unzip \
    uuid-dev \
    wget \
    xdg-utils \
    xterm \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/optee
ENV OPTEE_VERSION 3.3.0

RUN mkdir repo \
    && cd repo \
    && repo init -u https://github.com/OP-TEE/manifest.git \
        -m qemu_v8.xml -b $OPTEE_VERSION \
    && repo sync

RUN cd repo/build \
    && make toolchains -j2

RUN mkdir patches
COPY patches /opt/patches/
RUN cd repo/build && git apply --ignore-space-change --ignore-whitespace \
        /opt/patches/$OPTEE_VERSION/build.diff

RUN cd repo/build \
    && CFG_TEE_TA_LOG_LEVEL=3 CFG_TA_MBEDTLS_MPI=n CFG_TA_MBEDTLS=n \
        make -j4

RUN mkdir scripts
COPY scripts scripts/
RUN pip3 install -r scripts/requirements.txt

RUN mkdir /opt/logs
RUN mkdir /opt/shared

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

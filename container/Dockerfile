FROM docker.io/ubuntu:24.04 AS toolchain
RUN apt-get update && \
    apt-get install -y autoconf automake autotools-dev curl python3 \
        python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk \
        build-essential bison flex texinfo gperf libtool patchutils bc \
        zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev \
        libslirp-dev libcrypt-dev && \
    apt-get clean
COPY gitconfig /root/.gitconfig
RUN git clone --recursive --shallow-submodules \
   https://github.com/riscv/riscv-gnu-toolchain
WORKDIR /riscv-gnu-toolchain
ENV LDFLAGS="-L/usr/lib -lcrypt"
ENV CPPFLAGS="-I/usr/include"
RUN ./configure --prefix=/opt/riscv --with-arch=rv64g --with-abi=lp64d \
        --enable-libsanitizer && \
   make -j2 linux

FROM docker.io/ubuntu:24.04 AS spike
COPY gitconfig /root/.gitconfig
RUN apt-get update && \
    apt-get install -y build-essential device-tree-compiler \
        libboost-regex-dev libboost-system-dev libboost-thread-dev && \
    apt-get clean
RUN git clone \
    https://github.com/riscv-software-src/riscv-isa-sim.git
WORKDIR /riscv-isa-sim/build
RUN ../configure --prefix=/opt/riscv --with-arch=rv64g && \
    make && \
    make install

FROM docker.io/ubuntu:24.04 AS qemu
RUN apt-get update && \
    apt-get install -y build-essential meson ninja-build \
        python3-pip python3-venv python3-sphinx-rtd-theme && \
    apt-get clean
RUN curl -O https://download.qemu.org/qemu-9.0.0.tar.xz && \
    tar -xf qemu-9.0.0.tar.xz
WORKDIR /qemu-9.0.0
RUN ./configure --target-list=riscv64-linux-user && make -j

FROM docker.io/ubuntu:24.04
RUN apt-get update && \
    apt-get install -y python3-dev libmpc-dev libglib2.0 git \
        device-tree-compiler && \
    apt-get clean

# Add the various tools.
COPY --from=qemu /qemu-9.0.0/build/qemu-riscv64 /usr/local/bin/
COPY --from=toolchain /opt/riscv /opt/riscv
COPY --from=spike /opt/riscv /opt/riscv

# Create unprefixed symlinks to the GNU tools.
COPY mklinks.sh /
RUN bash /mklinks.sh

# Some useful configuration for Qemu.
ENV QEMU_LD_PREFIX=/opt/riscv/sysroot
ENV QEMU_GUEST_BASE=0x14000

env PATH $PATH:/opt/riscv/bin
WORKDIR /root

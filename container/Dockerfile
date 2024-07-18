FROM docker.io/ubuntu:22.04 AS qemu
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get install -y build-essential curl libglib2.0-dev meson ninja-build \
        python3-pip python3-venv python3-sphinx-rtd-theme && \
    apt-get clean
RUN curl -O https://download.qemu.org/qemu-9.0.2.tar.xz && \
    tar -xf qemu-9.0.2.tar.xz
WORKDIR /qemu-9.0.2
RUN ./configure --target-list=riscv64-linux-user && make -j

FROM docker.io/ubuntu:22.04
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get install -y python3-dev libmpc-dev libglib2.0 git make \
        device-tree-compiler gcc-12-riscv64-linux-gnu && \
    apt-get clean

# Add the various tools.
COPY --from=qemu /qemu-9.0.2/build/qemu-riscv64 /usr/local/bin/

# Create unprefixed symlinks to the GNU tools.
# TK restore this?????
# COPY mklinks.sh /
# RUN bash /mklinks.sh

# Some useful configuration for Qemu.
ENV QEMU_LD_PREFIX=/usr/riscv64-linux-gnu
ENV QEMU_GUEST_BASE=0x14000

env PATH $PATH:/opt/riscv/bin
WORKDIR /root

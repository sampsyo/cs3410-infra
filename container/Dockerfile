FROM docker.io/ubuntu:24.04
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get install -y python3-dev libmpc-dev libglib2.0 git make \
        device-tree-compiler gcc-14-riscv64-linux-gnu qemu-user-static && \
    apt-get clean

# Create unprefixed symlinks to the GNU tools.
COPY mklinks.sh /
RUN bash /mklinks.sh

# Some useful configuration for Qemu.
ENV QEMU_LD_PREFIX=/usr/riscv64-linux-gnu
ENV QEMU_GUEST_BASE=0x14000

env PATH /opt/riscv/bin:$PATH
WORKDIR /root

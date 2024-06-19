FROM docker.io/ubuntu:24.04 AS env
RUN apt-get update && \
    apt-get install -y build-essential curl git ninja-build \
        autoconf automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev \
        gawk build-essential bison flex texinfo gperf libtool patchutils \
        bc zlib1g-dev libexpat-dev cmake libglib2.0-dev libslirp-dev \
        python3-pip python3-venv python3-sphinx-rtd-theme && \
    apt-get clean

FROM env AS toolchain
COPY gitconfig /root/.gitconfig
RUN git clone --recursive --shallow-submodules \
   https://github.com/riscv/riscv-gnu-toolchain
WORKDIR /riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv --with-arch=rv32g --with-abi=ilp32d && \
   make -j2 linux

FROM env AS spike 
COPY gitconfig /root/.gitconfig
RUN apt-get update && \
    apt-get install -y device-tree-compiler libboost-regex-dev libboost-system-dev libboost-thread-dev && \
    apt-get clean
RUN git clone \
    https://github.com/riscv-software-src/riscv-isa-sim.git
WORKDIR /riscv-isa-sim/build
RUN ../configure --prefix=/opt/riscv --with-arch=rv32g && \
    make && \ 
    make install

FROM env AS qemu
RUN curl -O https://download.qemu.org/qemu-9.0.0.tar.xz && \
    tar -xf qemu-9.0.0.tar.xz
WORKDIR /qemu-9.0.0
RUN ./configure --target-list=riscv32-linux-user && make -j

FROM docker.io/ubuntu:24.04
RUN apt-get update && \
    apt-get install -y python3 libmpc-dev libglib2.0 git \
    device-tree-compiler \
    python3.12 python3.12-dev && \
    apt-get clean
COPY --from=qemu /qemu-9.0.0/build/qemu-riscv32 /usr/local/bin/
COPY --from=toolchain /opt/riscv /opt/riscv
COPY --from=spike /opt/riscv /opt/riscv
COPY cs3410-setup.sh /usr/local/bin/cs3410-setup.sh
RUN chmod +x /usr/local/bin/cs3410-setup.sh
env PATH $PATH:/opt/riscv/bin
WORKDIR /root
CMD ["source /usr/local/bin/cs3410-setup.sh"]

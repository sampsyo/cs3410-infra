FROM docker.io/ubuntu:24.04 AS env
RUN apt-get update && \
    apt-get install -y build-essential python3 && \
    apt-get clean

FROM env AS toolchain
RUN apt-get update && apt-get install -y git && apt-get clean
RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
WORKDIR /riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv && make -j linux

FROM env AS qemu
RUN curl -O https://download.qemu.org/qemu-9.0.0.tar.xz && \
    tar -xf qemu-9.0.0.tar.xz
WORKDIR /qemu-9.0.0
RUN ./configure --target-list=riscv64-linux-user && make -j

FROM env
COPY --from=toolchain /opt/riscv /opt/riscv
COPY --from=qemu /qemu-9.0.0/riscv64-linux-user/qemu-riscv64 /usr/local/bin/
RUN ln -s /opt/riscv/bin/* /usr/local/bin/
WORKDIR /root

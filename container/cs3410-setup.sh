# SETUP SCRIPT FOR CS 3410

export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
alias gcc='riscv32-unknown-linux-gnu-gcc -Wall -Wshadow -Wvla -Werror -pedantic'
alias gdb='riscv32-unknown-linux-gnu-gdb'
alias qemu='qemu-riscv32 -L /opt/riscv/sysroot'

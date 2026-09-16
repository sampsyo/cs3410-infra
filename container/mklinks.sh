#!/bin/bash
set -e

BIN=/opt/riscv/bin
PREFIX=riscv64-unknown-linux-gnu

# Look for all the executables in $BIN starting with $PREFIX and symlink them
# from an unprefixed (plain) name.
for fn in $BIN/$PREFIX-* ; do
    plainname=${fn#$BIN/$PREFIX-}
    ln -s $fn $BIN/$plainname
done

# Make a shorter name for qemu.
ln -s `which qemu-riscv64` /usr/local/bin/qemu

# Create asbin command
echo -e '#!/bin/bash\nas "$1" -o tmp.o && objcopy tmp.o -O binary "${1%.*}.bin" && rm tmp.o\n' > /usr/local/bin/asbin
chmod +x /usr/local/bin/asbin

# Easier debug utility
echo -e '#!/bin/bash\nqemu -g 1234 "$1" & (sleep 0.5 && gdb -q -ex "target remote localhost:1234" -ex "set sysroot /opt/riscv/sysroot" -ex "set can-use-hw-watchpoints 0" "$1")\n' > /usr/local/bin/qemu-debug
chmod +x /usr/local/bin/qemu-debug

# Nop in case someone pastes rv / rv-debug alias into environment:
echo -e '#!/bin/bash\neval "$@"\n' > /usr/local/bin/rv
chmod +x /usr/local/bin/rv
cp /usr/local/bin/rv /usr/local/bin/rv-debug 
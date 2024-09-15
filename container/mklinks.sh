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

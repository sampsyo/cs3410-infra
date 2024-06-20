#!/bin/bash
BIN=/opt/riscv/bin
PREFIX=riscv64-unknown-linux-gnu

# Look for all the executables in $BIN starting with $PREFIX and symlink them
# from an unprefixed (plain) name.
for fn in $BIN/$PREFIX-* ; do
    plainname=${fn#$BIN/$PREFIX-}
    ln -s $fn $BIN/$plainname
done

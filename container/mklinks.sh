#!/bin/bash
BIN=/opt/riscv/bin
PREFIX=riscv64-linux-gnu
SUFFIX=12

# Look for all the executables in $BIN starting with $PREFIX and symlink them
# from an unprefixed (plain) name.
for fn in $BIN/$PREFIX-* ; do
    plainname=${fn#$BIN/$PREFIX-}
    plainname=${plainname%-$SUFFIX}
    ln -s $fn $BIN/$plainname
done

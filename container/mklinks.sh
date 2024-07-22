#!/bin/bash
BIN=/usr/bin
DEST=/opt/riscv/bin
PREFIX=riscv64-linux-gnu
SUFFIX=14

# Look for all the executables in $BIN starting with $PREFIX and symlink them
# from an unprefixed (plain) name.
mkdir -p $DEST
for fn in $BIN/$PREFIX-* ; do
    plainname=${fn#$BIN/$PREFIX-}
    plainname=${plainname%-$SUFFIX}
    ln -s $fn $DEST/$plainname
done

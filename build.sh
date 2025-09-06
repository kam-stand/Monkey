#!/usr/bin/env bash
set -e  # stop on first error

APP="monkey"
SRC="src"
BIN="bin"
MAIN="main.d"

mkdir -p $BIN

# Compile all D files under src, put exe into bin/
ldc2 -Isrc -wi -of=$BIN/$APP $MAIN $SRC/*.d

echo "Built $BIN/$APP successfully."


$BIN/$APP
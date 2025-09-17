#!/usr/bin/env bash
set -e  # stop on first error

APP="monkey"
SRC="src/*"
BIN="bin"
MAIN="src/main.d"

mkdir -p $BIN

# Compile in debug mode with debug symbols
ldc2 -Isrc -g  -wi -of=$BIN/${APP}-debug $MAIN $SRC/*.d

echo "Built $BIN/${APP}-debug successfully."

$BIN/${APP}-debug

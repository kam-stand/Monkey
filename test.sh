#!/usr/bin/env bash
set -euo pipefail

APP="monkey-test"
SRC_DIR="src"
BIN_DIR="bin"
OUT="$BIN_DIR/$APP"

mkdir -p "$BIN_DIR"

# Find all .d files under src (including test directory)
SRC_FILES=$(find "$SRC_DIR" -name '*.d')

# Compile with unittest support
ldc2 -unittest -main $SRC_FILES -of="$OUT"

# Run the resulting binary (executes unittests)
echo "Running unittests..."
"$OUT"

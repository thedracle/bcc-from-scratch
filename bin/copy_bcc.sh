#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# Location of CMake BCC build.
BCCDIR="$SCRIPT_DIR"/../../bcc/

mkdir -p "$SCRIPT_DIR"/../bcc/include/api
mkdir -p "$SCRIPT_DIR"/../bcc/lib
mkdir -p "$SCRIPT_DIR"/../bcc/libbpf/include/uapi/linux

find "$BCCDIR" -name '*.a' -exec cp {} bcc/lib/ \;
if ! [ $? -eq 0 ]; then
    echo "Unable to copy in bcc libraries."
    exit 1
fi

if ! cp "$BCCDIR"/src/cc/*.h "$SCRIPT_DIR"/../bcc/include; then
    echo "Unable to copy bcc headers."
    exit 1
fi

if ! cp "$BCCDIR"/build/src/cc/*.h "$SCRIPT_DIR"/../bcc/include; then
    echo "Unable to copy bcc built headers."
    exit 1
fi

if [ -e "$SCRIPT_DIR"/../bcc/include/api ]; then
    rm -rf "$SCRIPT_DIR"/../bcc/include/api
fi

if ! cp -r "$BCCDIR"/src/cc/api "$SCRIPT_DIR"/../bcc/include; then
    echo "Unable to copy bcc api headers."
    exit 1
fi

if [ -e "$BCCDIR"/bcc/libbpf/include ]; then
    rm -rf bcc/libbpf/include
fi

if ! cp -r "$BCCDIR"/src/cc/libbpf/include bcc/libbpf/; then
    echo "Unable to copy libbpf headers."
    exit 1
fi

echo "Successfully copied bcc dependencies."

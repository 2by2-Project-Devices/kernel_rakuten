#!/bin/bash
set -euo pipefail

TC_DIR="$PWD/aarch64-linux-android-4.9/bin"
export PATH="$TC_DIR:$PATH"

OUT_DIR=out
DEFCONFIG=c330ae-perf_defconfig
CROSS_COMPILE="$TC_DIR/aarch64-linux-android-"
RAW_IMAGE=$OUT_DIR/arch/arm64/boot/Image.gz
COMBINED_IMAGE=$OUT_DIR/arch/arm64/boot/Image.gz-dtb
DTB_IMAGE=../../../device/rakuten/c330ae-kernel/dtb.img
TARGET_IMAGE=../../../device/rakuten/c330ae-kernel/Image.gz

make O=$OUT_DIR ARCH=arm64 $DEFCONFIG
make O=$OUT_DIR ARCH=arm64 CROSS_COMPILE="$CROSS_COMPILE" -j"$(nproc)" Image.gz

cat "$RAW_IMAGE" "$DTB_IMAGE" > "$COMBINED_IMAGE"
cp -f "$COMBINED_IMAGE" "$TARGET_IMAGE"

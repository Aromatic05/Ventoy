#!/bin/sh

VTOY_PATH=$PWD/..

date +"%Y/%m/%d %H:%M:%S"
echo downloading environment ...

CACHE_DIR=$VTOY_PATH/.cache
mkdir -p "$CACHE_DIR"

download() {
    URL=$1
    DESTINATION=$2
    FILENAME=$(basename "$DESTINATION")
    if [ ! -f "$CACHE_DIR/$FILENAME" ]; then
        wget -q -O "$CACHE_DIR/$FILENAME" "$URL"
    fi
    mkdir -p "$(dirname "$DESTINATION")"
    cp "$CACHE_DIR/$FILENAME" "$DESTINATION"
}

download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/dietlibc-0.34.tar.xz" "$VTOY_PATH/DOC/dietlibc-0.34.tar.xz"
download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/musl-1.2.1.tar.gz" "$VTOY_PATH/DOC/musl-1.2.1.tar.gz"
download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/grub-2.04.tar.xz" "$VTOY_PATH/GRUB2/grub-2.04.tar.xz"
download "https://codeload.github.com/tianocore/edk2/zip/edk2-stable201911" "$VTOY_PATH/EDK2/edk2-edk2-stable201911.zip"
download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz" "/opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz"
download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/aarch64--uclibc--stable-2020.08-1.tar.bz2" "/opt/aarch64--uclibc--stable-2020.08-1.tar.bz2"
download "https://github.com/ventoy/vtoytoolchain/releases/download/1.0/mips-loongson-gcc7.3-2019.06-29-linux-gnu.tar.gz" "/opt/mips-loongson-gcc7.3-2019.06-29-linux-gnu.tar.gz"
download "https://github.com/ventoy/musl-cross-make/releases/download/latest/output.tar.bz2" "/opt/output.tar.bz2"

date +"%Y/%m/%d %H:%M:%S"
echo downloading environment finish...

sh all_in_one.sh CI

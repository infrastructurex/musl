#!/usr/bin/env sh

VERSION=1.2.4
SOURCE=https://musl.libc.org/releases/musl-$VERSION.tar.gz

echo Downloading musl "$VERSION" ...
cd /build || exit
wget "$SOURCE"

echo Extracting musl "$VERSION" ...
tar -xf musl-$VERSION.tar.gz
mv musl-$VERSION musl

echo Building musl ...
cd /build/musl || exit
./configure
make "-j$(nproc)" || exit
strip lib/libc.so
ldd lib/libc.so

echo Packaging musl ...
mkdir -p /export/lib
cd /export || exit

cp /build/musl/lib/libc.so "lib/ld-musl-$LINUX_ARCH.so.1"
ln -s "/lib/ld-musl-$LINUX_ARCH.so.1" "lib/libc.musl-$LINUX_ARCH.so.1"

mkdir legal
cat > legal/musl<< EOF
Source  : $SOURCE
Version : $VERSION
Package : https://github.com/vmify/musl/musl/download/$TAG/musl-$ARCH-$TAG.tar.gz
License :

EOF
cat /build/musl/COPYRIGHT >> legal/musl
gzip legal/musl

tar -czvf /musl.tar.gz *

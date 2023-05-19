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
readonly prefix_dir=/dependencies/musl
mkdir -p $prefix_dir
cd /build/musl || exit
./configure --prefix=$prefix_dir --enable-wrapper=gcc
make "-j$(nproc)" install || exit

echo Packaging musl ...
cd $prefix_dir || exit

cp /build/musl/COPYRIGHT ./LICENSE
echo "Source  : $SOURCE" > ./SOURCE
echo "Version : $VERSION" >> ./SOURCE
echo "Package : https://github.com/vmify/musl/musl/download/$TAG/musl-$ARCH-$TAG.tar.gz" >> ./SOURCE

tar -czvf /musl.tar.gz *

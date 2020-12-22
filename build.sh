#!/bin/bash

# compile exploits and kernel module
mkdir -p rootfs/home/nobodyQQ
make -C src

# copy kernel module to root file system
cp src/demo.ko rootfs

# build initramfs
cd rootfs
mkdir -pv {bin,sbin,etc,proc,dev,tmp,sys,usr/{bin,sbin}}
find . -print0 | cpio --null -ov --format=newc 2>/dev/null | gzip -9 > ../initramfs.cpio.gz

# run qemu
cd .. && exec ./run.sh
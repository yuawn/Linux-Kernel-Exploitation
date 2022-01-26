# Linux Kernel Exploitation
Linux kernel exploitation lab.  
Slide: [speakerdeck.com/yuawn/kernel-exploitation](https://speakerdeck.com/yuawn/kernel-exploitation)

## Linux kernel exploitation techniques
- ret2user
    - status switch
- modify cr4 register
    - bypass smep
    - bypass smap
- kpti
    - fix cr3 register
    - swapgs_restore_regs_and_return_to_usermode()
- kernel information leak
    - useful kernel structure for UAF
- modprobe_path
- userfaultfd
    - race condition
- setxattr
    - setxattr + userfaultfd
- msg_msg
- signal handler


## Prepare files needed to compile kernel module
```sh
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.1.tar.xz
tar Jxvf linux-5.10.1.tar.xz
cp .config linux-5.10.1
cd linux-5.10.1
make menuconfig # load .config
make modules_prepare
```

## Compile linux kernel
```sh
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.1.tar.xz
tar Jxvf linux-5.10.1.tar.xz
cp .config linux-5.10.1
cd linux-5.10.1
make menuconfig # load .config
make -j $(nproc)
```

## busybox
```sh
wget https://busybox.net/downloads/busybox-1.32.0.tar.bz2
tar jxvf busybox-1.32.0.tar.bz2
cd busybox-1.32.0
mkdir build
export BUSYBOX_BUILD=$(pwd)/build
make O=$BUSYBOX_BUILD defconfig
make O=$BUSYBOX_BUILD menuconfig # Settings -> Build Options: enable Build static binary (no shared libs)
cd $BUSYBOX_BUILD
make -j 4
make install -j 4
```

## initramfs
```sh
mkdir rootfs
cd rootfs
mkdir -pv {bin,sbin,etc,proc,dev,tmp,sys,usr/{bin,sbin}}
cp -r $BUSYBOX_BUILD/_install/* .
vim init # Create init file
```
- Some files
    - /etc/passwd
    - /home/user
    - /flag

## Build Scripts and Toolchain Helpers

* activate-openwrt-toolchain.env - place file in prebuilt OpenWRT toolchain root, source it for productivity, etc.
* activate-musl-toolchain.env - place file in musl-cross-make toolchain root, source it for productivity, etc.
* gdbserver-7.12-static-build.sh - shell script to build a static gdb-7.12 gdbserver using a cross-compile toolchain

### First - If you just want to build a native gdb-7.12 gdbserver statically

You don't need any of this. These scripts just simplify doing it with different toolchains. If you're doing it natively it can be summarized pretty quickly

```
$ wget https://ftp.gnu.org/gnu/gdb/gdb-7.12.tar.xz
$ tar -xvf gdb-7.12.tar.xz
$ cd gdb-7.12/gdb/gdbserver
$ sed -i -e 's/srv_linux_thread_db=yes//' configure.srv
$ ./configure --prefix=/opt/gdbserver-7.12-static CXXFLAGS='fPIC -static'
$ make -j gdbserver GDBSERVER_LIBS="/path/to/libstdc++.a /path/to/libgcc_eh.a"
```

You will have a statically compiled GDB 7.12 gdbserver for your native OS. Read on for the cross-compile stuff.

### Use an env script with a pre-built OpenWrt Toolchain

Browse to https://downloads.openwrt.org/snapshots/trunk/ to find your toolchain

To use this script, assume you have a directory called /toolchains/ and that this is where you will keep the toolchains, one subdirectory per toolchain. You're a maniac- you're hoarding toolchains and probably up to no good.

To get a new toolchain up in such a way to use active-openwrt-toolchain, grab a file like OpenWrt-Toolchain-brcm63xx-generic_gcc-5.3.0_musl-1.1.16.Linux-x86_64.tar.bz2


```
$ cd ~/ && git clone https://github.com/mzpqnxow/gdb-7.12-crossbuilder
$ cd gdb-7.12-crossbuilder
$ wget https://.../OpenWrt-Toolchain-brcm63xx-generic_gcc-5.3.0_musl-1.1.16.Linux-x86_64.tar.bz2
$ tar -xvjf OpenWrt-Toolchain-brcm63xx-generic_gcc-5.3.0_musl-1.1.16.Linux-x86_64.tar.bz2
$ cd OpenWrt-Toolchain-brcm63xx-generic_gcc-5.3.0_musl-1.1.16.Linux-x86_64/
$ TOOLCHAIN=$(echo toolchain-*)
$ mv "$TOOLCHAIN" /openwrt-toolchains/
$ cp ~/gdb-7.12-crossbuilder/activate-openwrt-toolchain.env /openwrt-toolchains/$TOOLCHAIN/activate
$ source /openwrt-toolchains/$TOOLCHAIN/activate
```

### Use an env script with an installed toolchain built by musl-cross-make

Using musl-cross-make is a nice experience- I recommend you try it. If you do, all you need to do is edit config.mak, use make -j and make install. That's it. You're done. The activate-musl-toolchain file is for you to place in the root of the installed toolchain to use as a convenience to "activate" the toolchain in your environment.

```
$ export TOOLCHAIN_DEST=/musl-cross-make-toolchains/toolchain-mips_mips32_musl/
$ cd ~/
git clone https://github.com/richfelker/musl-cross-make
$ cd musl-cross-make
$ vi config.mak
... assume you're installing to $TOOLCHAIN_DEST ...
$ make -j && make install
$ cd ~/
$ git clone https://github.com/mzpqnxow/gdb-7.12-crossbuilder
$ cd gdb-7.12-crossbuilder
$ cp activate-musl-toolchain.env $TOOLCHAIN_DEST/activate
$ source $TOOLCHAIN_DEST/activate
$ wget https://ftp.gnu.org/gnu/gdb/gdb-7.12.tar.xz
$ tar -xvf gdb-7.12.tar.xz
$ cp gdbserver-7.12-static-build.sh gdb-7.12/gdb/gdbserver
$ cd gdb-7.12/gdb/gdbserver
$ ./gdbserver-7.12-static-build.sh
$ file gdbserver
gdbserver: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```

### Capabilities provided

See the end of each .env file. You will see variables exported. Those variables can now be accessed in your shell while building software. Tools like gcc, ar, ld, g++, etc. will also now be in your path and there will be a ```cross_configure``` alias in the shell to simplify using software packages that utilize ./configure build systems

#### Sample environment variables after activating an OpenWrt toolchain

```
DL_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/libdl.a
C_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/libc.a
STDCXX_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/libstdc++.a
UTIL_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/libutil.a
PTHREAD_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/libpthread.a
GCCEH_STATIC=/opt/openwrt/armel-gnu-eabi5-sysv/lib/gcc/arm-openwrt-linux-muslgnueabi/5.3.0/libgcc_eh.a
STAGING_DIR=/opt/openwrt/armel-gnu-eabi5-sysv
TOOLCHAIN_ROOT=/opt/openwrt/armel-gnu-eabi5-sysv
TOOLCHAIN_BIN=/opt/openwrt/armel-gnu-eabi5-sysv/bin
TOOLCHAIN_TARGET=arm-openwrt-linux-muslgnueabi
SYSTEM_ROOT=/opt/openwrt/armel-gnu-eabi5-sysv
```

#### Sample alias

```
alias cross_configure='./configure --host=arm-openwrt-linux-muslgnueabi --prefix=/opt/openwrt/armel-gnu-eabi5-sysv'
```

## License

# This software is released under the terms of GPLv2 by copyright@mzpqnxow.com
# Please see LICENSE or LICENSE.md for more information on GPLv2
#!/bin/bash
#
# This software is released under the terms of GPLv2
# This software is released by copyright@mzpqnxow.com
# Please see LICENSE or LICENSE.md for more information on GPLv2
#
# -- Perform a static build of gdbserver (gdb-7.12)
#
# This was designed particularly to demonstrate the way
# that the activate scripts can be used. You can use
# them for  for toolchains built by the excellent musl-cross-make
# tool:
#
#   https://github.com/richfelker/musl-cross-make
# 
# It also works fine with the OpenWRT toolchains that are
# available prebuilt:
#
#   https://downloads.openwrt.org/snapshots/trunk
#
# The easiest way to make this work without modification is
# to use one of the toolchain activation scripts in this
# repository. Otherwise you will need to set up stuff yourself
# like the path to libstdc++.a, libgcc_eh.a and the --host
# parameter. Which hopefully you can figure out how to do
# if you're planning on debugging native code on another
# architecture :>

#
#
#

CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$(basename $CURDIR)" != gdbserver ]; then
	echo "You should be in gdb-7.12/gdb/gdbserver when you run this !!"
	echo "Exiting..."
	exit 1
fi

make clean 2>/dev/null
make distclean 2>/dev/null
# Some toolchains include static libthread_db but MANY do not
# I don't have the need to even debug threaded apps so I disable it
# The configure flags do nothing to disable it in my experience...
sed -i -e 's/srv_linux_thread_db=yes//' configure.srv
./configure --host="$TOOLCHAIN_TARGET" --prefix="$SYSTEM_ROOT" CXXFLAGS="-fPIC -static"
make -j gdbserver GDBSERVER_LIBS="$STDCXX_STATIC $GCCEH_STATIC"
file gdbserver

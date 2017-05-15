## Pre-built gdbserver executables for many platforms

*NOTE: these were taken for my larger statically compiled executable repository @ https://github.com/mzpqnxow/arm-mips-tools which includes many more static bins (gawk, lsof, tcpdump, etc)*

This is a collection of statically compiled gdbserver executables for Linux for many embedded platforms. They were tested thoroughly (in real life use)  and work very well- most if not all should have the most compatible options, i.e. software floating point emulation, etc. Some are actually customized for a specific CPU (i.e. the lexra build) so you might need to try a few on an exotic target because I didn't document things well enough while building. If you don't use the right one or you will get funny errors or segmentation faults. An error that contain s a paren almost always means that the endianness is incorect. Note some of these were built with musl while some were built with uClibc. Note that not all are 7.12, they will be updated as locate the toolchains used to build them (or rebuild said toolchains)

## Inventory

```
gdbserver-6.8-mips-i-rtl819x-lexra:                                ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked
gdbserver-7.12-mipsel-i-v1-sysv:                                   ELF 32-bit LSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked, for GNU/Linux 2.2.15
gdbserver-7.12-mips-i-v1-rtl819x-rsdk-1.3.6-4181-EB-2.6.30-0.9.30: ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked
gdbserver-7.12-mips-i-v1-rtl819x-rsdk-1.3.6-5281-EB-2.6.30-0.9.30: ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked
gdbserver-7.12-mips-mip32rel2-v1-sysv:                             ELF 32-bit MSB executable, MIPS, MIPS32 rel2 version 1 (SYSV), statically linked
gdbserver-7.12-mips-mips64-v1-sysv:                                ELF 32-bit MSB executable, MIPS, MIPS64 version 1 (SYSV), statically linked
gdbserver-7.12-mips-mips-iii-v1-sysv:                              ELF 32-bit MSB executable, MIPS, MIPS-III version 1 (SYSV), statically linked
gdbserver-7.12-mips-mips-i-v1:                                     ELF 32-bit MSB executable, MIPS, MIPS-I version 1, statically linked
gdbserver-7.12-mips-mips-iv-v1-sysv:                               ELF 32-bit MSB executable, MIPS, MIPS-IV version 1 (SYSV), statically linked
gdbserver-7.7.1-armel-eabi5-v1-sysv:                               ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, for GNU/Linux 2.6.26
gdbserver-7.7.1-armel-v1:                                          ELF 32-bit LSB executable, ARM, version 1, statically linked, for GNU/Linux 2.4.3
gdbserver-7.7.1-armhf-eabi5-v1-sysv:                               ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, for GNU/Linux 2.6.26
gdbserver-7.7.1-mipsel-ii-v1:                                      ELF 32-bit LSB executable, MIPS, MIPS-II version 1, statically linked, for GNU/Linux 2.6.26
gdbserver-7.7.1-mipsel-mips32-v1:                                  ELF 32-bit LSB executable, MIPS, MIPS32 version 1 (SYSV), statically linked
gdbserver-7.7.1-mips-mips32-v1:                                    ELF 32-bit MSB executable, MIPS, MIPS32 version 1, statically linked, for GNU/Linux 2.6.26
gdbserver-7.7.1-mips-mips32-v1-sysv:                               ELF 32-bit MSB executable, MIPS, MIPS32 version 1 (SYSV), statically linked
gdbserver-7.7.1-mips-mips-ii-v1:                                   ELF 32-bit MSB executable, MIPS, MIPS-II version 1, statically linked, for GNU/Linux 2.6.26
gdbserver-7.7.1-mips-mips-i-v1-sysv::                              ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked
```

These are not stripped, go ahead and strip them if you want. And once more, there are now many more than just gdbserver executables in this repository, explore the directory tree. Note the special rtl819x-lexra build. This is a build specific to rtl819x SoC with Lexra CPU. Lexra CPUs are a MIPS-I with some standard MIPS instructions not implemented, specifically unaligned/half-word loads, stores, shifts. Silly. Thanks to https://github.com/KrabbyPatty/rtl819x-toolchain for making a toolchain available to build this specific binary. I was unable to get gdb 7.7.1 to build, so it is version 6.8.


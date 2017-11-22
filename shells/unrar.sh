#!/usr/bin/env bash
# this script is written to build linux unrar lib
# get leatest unrar source
unrarversion=5.5.8
wget -c https://www.rarlab.com/rar/unrarsrc-$unrarversion.tar.gz
tar zxvf unrarsrc-$unrarversion.tar.gz
cd unrar
make lib && make install-lib
echo "export UNRAR_LIB_PATH=/usr/lib/libunrar.so">>/etc/profile
source /etc/profile
# download win unrar should visit http://www.rarlab.com/rar/UnRARDLL.exe
# click Unrar for windows to download.
# new a var named UNRAR_LIB_PATH value to  C:\Program Files (x86)\UnrarDLL\x64\UnRAR64.dll for 64bit OS
# C:\Program Files (x86)\UnrarDLL\UnRAR.dll for 32bit OS
#!/usr/bin/env bash
# get leatest unrar source 
unrarversion=5.5.8
wget -c https://www.rarlab.com/rar/unrarsrc-$unrarversion.tar.gz
tar zxvf unrarsrc-$unrarversion.tar.gz
cd unrar
make lib && make install-lib
echo "export UNRAR_LIB_PATH=/usr/lib/libunrar.so">>/etc/profile
source /etc/profile
#!/bin/bash
# 如果你觉得下载国外python官网的网址有点慢，你可以下载自己觉得快的网址
#yum 安装制定安装包，如果以后更新后使用dnf，可能需要更新该脚本，不过CentOS7 目前还是使用的yum
yum install -y wget openssl* gcc*
# 下载安装包，如果有更新，请去python官网更新下载网址
wget -c https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar zxvf Python-2.7.13.tgz
cd Python-2.7.13
# 之所以不开启优化，是怕出问题，如果你不怕，可以自己添加
./configure --prefix=/usr/local/python27 --enable-optimizations
make && make install
ln -s /usr/local/python27/bin/python /usr/bin/python27
# 这个脚本是放在我自己的网址上的，如果网址失效了，请自行去网络上寻找，这个工具包的git应该会有备份
wget -c https://www.togit.cc/rffanlab/tools/raw/master/python/get-pip.py
/usr/local/python27/bin/python get-pip.py
ln -s /usr/local/python27/bin/pip /usr/bin/pip27
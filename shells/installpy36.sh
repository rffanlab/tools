#!/usr/bin/env bash
# 如果你觉得下载国外python官网的网址有点慢，你可以下载自己觉得快的网址
#yum 安装制定安装包，如果以后更新后使用dnf，可能需要更新该脚本，不过CentOS7 目前还是使用的yum
yum install -y wget openssl* gcc*
# 下载安装包，如果有更新，请去python官网更新下载网址
wget -c https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar zxvf Python-3.6.4.tgz
cd Python-3.6.4
# 之所以不开启优化，是怕出问题，如果你不怕，可以自己添加
./configure --prefix=/usr/local/python36
make && make install
ln -s /usr/local/python36/bin/python /usr/bin/python3
ln -s /usr/local/python36/bin/pip3 /usr/bin/pip3
#!/usr/bin/env bash
# this script only fit centos
#
yum install -y wget
wget -c https://dl.google.com/go/go1.10.linux-amd64.tar.gz
tar zxvf go1.10.linux-amd64.tar.gz
mv go /usr/local/
mkdir -p /home/go/gopath
mkdir -p /home/go/ugopath
cat >>/etc/profile<<EOF
export GOROOT=/usr/local/go
export GOPATH=/home/go/gopath:/home/go/ugopath
export PATH=\$PATH:\$GOROOT/bin:/home/go/gopath/bin:/home/go/ugopath/bin
EOF
echo "请在结束完成之后使用 source /etc/profile 来让环境变量生效"
echo "Please use command: source /etc/profile    to make path var take effect"



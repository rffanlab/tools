#!/usr/bin/env bash
# this script only fit centos
yum install -y wget
wget -c https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
tar zxvf go1.9.4.linux-amd64.tar.gz
mv go /usr/local/
mkdir -p /home/go/gopath
mkdir -p /home/go/ugopath
cat >>/etc/profile<<EOF
export GOROOT=/usr/local/go
export GOPATH=/home/go/gopath:/home/go/ugopath
export PATH=\$PATH:\$GOROOT/bin:/home/go/gopath/bin:/home/go/ugopath/bin
EOF




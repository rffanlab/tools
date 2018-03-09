#!/usr/bin/env bash

yum install deltarpm -y
yum install -y redhat-lsb
yum install -y wget
osrelease=$(lsb_release -rs|awk -F'.' '{print $1}')
cat >/etc/yum.repos.d/nginx.repo<<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$osrelease/\$basearch/
gpgcheck=0
enabled=1
EOF
yum install -y nginx
echo "SELINUX=disabled" > /etc/sysconfig/selinux
setenforce 0
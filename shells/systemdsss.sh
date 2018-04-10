#!/usr/bin/env bash
# This script is written for Setup Shadowsock server for users for CentOS7.
yum install -y git wget python-devel python-setuptools
easy_install pip
pip install shadowsocks
ssPort=10040
ssPass=rffanlab
ssMethod=rc4-md5

cat >/usr/lib/systemd/system/ss-server.service <<EOF
[Unit]
Description=ShadowSocks Server

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/usr/bin/ssserver -p $ssPort -k $ssPass -m $ssMethod --user nobody -d start
ExecStop=/usr/bin/ssserver -d stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable ss-server
systemctl start ss-server
systemctl status ss-server

firewall-cmd --zone=public --permanent --add-port=$ssPort/tcp
firewall-cmd --zone=public --permanent --add-port=$ssPort/udp
firewall-cmd --reload
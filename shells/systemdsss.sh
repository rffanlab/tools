#！/bin/bash
# This script is written for Setup Shadowsock server for users.
yum install -y git wget python-devel python-setuptools
easy_install pip
pip install shadowsocks
cat >/usr/lib/systemd/system/ss-server.service <<EOF
[Unit]
Description=ShadowSocks Server

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/usr/local/bin/ssserver -p 10040 -k rffanlab -m rc4-md5 --user nobody -d start
ExecStop=/usr/local/bin/ssserver -d stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable ss-server
systemctl start ss-server
systemctl status ss-server
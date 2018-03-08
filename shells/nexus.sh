#!/usr/bin/env bash
# This Script is written by RffanLAB For Setup Nexus For Java private Repository 
# Only Tested on CentOS 7 
yum install -y wget git
git clone http://www.togit.cc/rffanlab/tools.git
cd tools/shells
sh nginx.sh
sh jdk.sh
cd ~
wget -c https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.9.0-01-unix.tar.gz
tar zxvf nexus-3.9.0-01-unix.tar.gz
useradd -M nexus -s /sbin/nologin
mkdir -p /home/nexus
mv nexus-3.9.0-01 /home/nexus
cat >>/home/nexus/nexus-3.9.0-01/bin/nexus.rc<<EOF
run_as_user="nexus"
EOF

# https://help.sonatype.com/display/NXRM3/System+Requirements#filehandles
# If this start up file failed please visit site up.
cat >/usr/lib/systemd/system/nexus.service<<EOF
[Unit]
Description=Nexus daemon

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/home/nexus/nexus-3.9.0-01/bin/nexus start
ExecStop=/home/nexus/nexus-3.9.0-01/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service
systemctl status nexus.service

firewall-cmd --zone=public --permanent --add-port=8081/tcp
firewall-cmd --reload 

echo "默认用户名是：admin 默认密码是：admin123，请安装后赶紧修改"

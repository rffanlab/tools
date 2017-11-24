#!/usr/bin/env bash
# only could run under centos
yum install python-setuptools
easy_install pip
pip install supervisor
mkdir -p /etc/supervisor/conf.d
echo_supervisord_conf>/etc/supervisor/supervisord.conf
cat >>/etc/supervisor/supervisord.conf<<EOF
[include]
files = conf.d/*.ini
EOF
cat >/etc/supervisor/conf.d/example.ini<<EOF
#[program:myflask]  #声明应用名
#command=/home/www/myflask/myflaskenv/bin/uwsgi /home/www/myflask/config.ini # 声明命令地址
#directory=/home/www/myflask  # 声明程序路径
#autostart=true  # 声明随supervisor启动就启动
#autorestart=true  # 声明自动重启我们用supervisor就是为了这玩意！
#stdout_logfile=/home/www/myflask/uwsgi_supervisor.log # 声明日志地址
EOF
cat >/usr/lib/systemd/system/supervisor.service<<EOF
[Unit]
Description=Supervisor daemon

[Service]
Type=forking
ExecStart=/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
ExecStop=/usr/bin/supervisorctl \$OPTIONS shutdown
ExecReload=/usr/bin/supervisorctl \$OPTIONS reload
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOF
systemctl enable supervisor.service
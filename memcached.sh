#!/usr/bin/env bash
# Only fit on CentOS 7
MEMVERSION=1.5.3
yum install -y wget gcc* openssl openssl-devel make cmake
wget -c http://www.memcached.org/files/memcached-$MEMVERSION.tar.gz
tar zxvf memcached-$MEMVERSION.tar.gz
cd $MEMVERSION
./configure prefix=/usr/local/memcached
make && make test && make install

groupadd memcached
useradd -s /sbin/nologin -g memcached memcached
chown -R memcached:memcached /usr/local/memcached

cat >>/etc/systemd/system/memcached.service <<EOF
[Unit]
Description=Memcached Deamon Service

[Service]
ExecStart=/usr/local/memcached/bin/memcached -d -m 512 -u memcached -p 41214
ExecStop=/usr/local/memcached/bin/memcached -d stop
ExecReload=/usr/local/memcached/bin/memcached -d restart
KillSignal=SIGQUIT
Type=notify
NotifyAccess=all

[Install]
WantedBy=multi-user.target

EOF
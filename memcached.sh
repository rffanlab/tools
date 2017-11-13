#!/usr/bin/env bash
# Only fit on CentOS 7
MEMVERSION=1.5.3
yum install -y wget gcc* openssl openssl-devel make cmake
wget -c http://www.memcached.org/files/memcached-$MEMVERSION.tar.gz
tar zxvf memcached-$MEMVERSION.tar.gz
cd memcached-$MEMVERSION
./configure prefix=/usr/local/memcached
make && make test && make install

groupadd memcached
useradd -s /sbin/nologin -g memcached memcached
chown -R memcached:memcached /usr/local/memcached

cat >/etc/init.d/memcached <<EOF
#! /bin/bash
#
# memcached:    MemCached Daemon
#
# chkconfig:    - 90 25
# description:  MemCached Daemon
#
### BEGIN INIT INFO
# Provides:          memcached
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Should-Start:        $local_fs
# Should-Stop:        $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description:    memcached - Memory caching daemon
# Description:        memcached - Memory caching daemon
### END INIT INFO

IP=127.0.0.1
PORT=41214
USER=root
MAXCONN=1024
CACHESIZE=256
OPTIONS=""

RETVAL=0
prog="memcached"

start() {
    echo -n "Starting $prog: "
    /usr/local/memcached/bin/memcached -d -l $IP -p $PORT -u $USER -m $CACHESIZE -c $MAXCONN -P /var/run/memcached.pid $OPTIONS
    if [ "$?" != 0 ] ; then
        echo " failed"
        exit 1
    else
        touch /var/lock/subsys/memcached
        echo " done"
    fi
}
stop() {
    echo -n "Stopping $prog: "
    if [ ! -f "/var/run/$prog.pid" ]; then
        echo "$prog is not running."
        exit 1
    fi
    kill `cat /var/run/memcached.pid`
    if [ "$?" != 0 ] ; then
        echo " failed"
        exit 1
    else
        rm -f /var/lock/subsys/memcached
        rm -f /var/run/memcached.pid
        echo " done"
    fi
}

restart() {
    $0 stop
    sleep 2
    $0 start
}

status() {
    if [ -f "/var/run/$prog.pid" ]; then
        echo "$prog is running."
    else
        echo "$prog is stopped."
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart|reload)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart|reload}"
        exit 1
        ;;
esac

exit $?
EOF
chmod +x /etc/init.d/memcached
cd /etc/init.d
chkconfig --level 2345 memcached on


#!/usr/bin/env bash
# only could use under centos6
# please install pip first to use this script
# learn from https://www.cnblogs.com/sfnz/p/5578417.html
pip install supervisor
mkdir -p /etc/supervisor/conf.d
echo_supervisord_conf>/etc/supervisor/supervisord.conf
cat >>/etc/supervisor/supervisord.conf<<EOF
[include]
files = conf.d/*.ini
EOF
cat >/etc/init.d/<<EOF
#! /usr/bin/env bash
# chkconfig: - 85 15

PATH=/sbin:/bin:/usr/sbin:/usr/bin

PROGNAME=supervisord

DAEMON=/usr/bin/\$PROGNAME

CONFIG=/etc/supervisor/\$PROGNAME.conf

PIDFILE=/tmp/\$PROGNAME.pid

DESC="supervisord daemon"

SCRIPTNAME=/etc/init.d/\$PROGNAME

# Gracefully exit if the package has been removed.

test -x \$DAEMON || exit 0


start()

{

echo -n "Starting \$DESC: \$PROGNAME"

\$DAEMON -c \$CONFIG

echo ".............start success"

}

stop()

{

echo "Stopping \$DESC: \$PROGNAME"

if [ -f "\$PIDFILE" ];
then
supervisor_pid=\$(cat \$PIDFILE)
kill -15 \$supervisor_pid
echo "......"
echo "stop success"
else
echo "\$DESC: \$PROGNAME is not Runing"
echo ".........................stop sucess"
fi
}

status()

{ statusport=`netstat -lntp|grep 9001|awk -F ' ' '{print \$4}'|awk -F ':' '{print \$2}'`

if [ -f "\$PIDFILE" ];
then
supervisor_pid=\$(cat \$PIDFILE)
echo "\$DESC: \$PROGNAME is Runing pid=\$supervisor_pid"
else
echo "\$DESC: \$PROGNAME is not Runing"
echo "please use command /etc/init.d/supervisord start Run the service"
fi
}

case "\$1" in

start)

start

;;

stop)

stop

;;

restart)

stop

start

;;

status)

status

;;

*)

echo "Usage: \$SCRIPTNAME {start|stop|restart}" >&2

exit 1

;;

esac

exit 0

EOF
chkconfig supervisord  on
service supervisord start
service supervisord stop


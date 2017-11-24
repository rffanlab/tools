#!/usr/bin/env bash
action1=$1
action2=$1


nginxconfpath=/etc/nginx/conf.d
nginxgid=nginx

if [ ! -f "/etc/nginx" ]; then
    nginxconfpath=/usr/local/nginx/conf/vhost
    nginxgid=www
fi


add_vhost()
{
    read -p "Please input domain (example:lnmpy.org):"domain
    if [ "${domain}" = "" ];then
        echo "Please Enter a domain.It should not be empty"
        exit 1
    fi
    if [ ! -f "${nginxconfpath}/${domain}.conf" ]; then
        echo "====================================="
        echo "Your domain: ${domain}"
        echo "====================================="
    else
        echo "====================================="
        echo "domain is exist,please bind anthor"
        echo "====================================="
    fi
    echo "Do you wanna to add more domain name ?"
    echo "if you wanna to add just input ,if not please leave it blank"
    read -p "Addtional domain name:" additional_domainname
    vhostdir="/home/www/${domain}"
    echo "please input the directory for the domain:${domain}"
    read -p "(Default directory is :/home/www/${domain})" vhostdir
    if [ "${vhostdir}" = "" ]; then
        vhostdir="/home/www/${domain}"
    fi
    echo "Vhost dir is:${vhostdir}"

    pythonpath="/home/www/${domain}py"
    echo "Please input the python path"
    echo "Default is:/home/www/${domain}py"
    read -p "Python path is:"pythonpath
    if [ "${pythonpath}" = "" ]; then
        pythonpath="/home/www/${domain}py"
    fi
    # TODO 写wsgi配置
    mkdir -p ${vhostdir}
    mkdir -p ${pythonpath}/env
    cat >${pythonpath}/run.ini<<EOF
[uwsgi]
module = wsgi
master = true
processes = 5
socket = ${domain}.sock
chmod-socket = 600
git = ${nginxgid}
py-autoreload = 1
EOF
    virtualenv ${pythonpath}/env
    source ${pythonpath}/env/bin/activate
    pip install uwsgi




    # TODO 写Nginx配置
    cat >${nginxconfpath}/${domain}.conf<<EOF
upstream ${domain} {
    server unix:${pythonpath}/${domain}.sock;
}
server
{
    listen 80;
    server_name ${domain} ${additional_domainname};
    index index.html index.htm index.php default.html default.htm default.php;
    root ${vhostdir};

    location / {
        include uwsgi_params;
		uwsgi_pass ${domain};

    }
    access_log /home/wwwlogs/${domain}.log;
}
EOF

nginx -t
nginx -s reload


    # TODO 写supervisor配置
    cat >/etc/supervisor/conf.d/${domain}.ini<<EOF
[program:${domain}]
command=${pythonpath}/env/uwsgi ${pythonpath}/run.ini
directory=${pythonpath}
autostart=true
autorestart=true
stdout_logfile=${pythonpath}/uwsg_supervisor.log
EOF

supervicorctl reload

}


func_vhost()
{
    case "$1" in
    [aA][dD][dD])
        echo "进去了"
        add_vhost
        ;;
    [dD][eE][lL])


        ;;


    [eE][xX][iI][tT])
        exit 1
        ;;
    *)
        echo "Usage: lnmpy vhost {add|list|del}"
        exit 1
        ;;




    esac
}


case "${action1}" in
    start)
        echo "starting"
        ;;
    stop)
        echo "stopping"
        ;;
    restart)
        echo "restarting"
        ;;
    vhost)
        func_vhost ${action2}
        ;;
    *)

    ;;
esac




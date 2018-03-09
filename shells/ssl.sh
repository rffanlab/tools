#!/bin/bash
yum install -y python-devel python-setuptools && easy_install pip
yum install cronie
pip install certbot
echo "请输入域名"
read domain
echo "请输入附加域名"
read additionalDomain
echo "请输入邮箱"
read email
echo "请输入网站存储路径"
read path
/usr/bin/certbot certonly --email ${email} --agree-tos --webroot -w ${path} -d ${domain} -d ${additionalDomain}

count=$(crontab -l | grep '/usr/bin/certbot'| wc -l) 
if [[ "${count}" = "0" ]] ;then 
	# 如果你的使用ssl的并不是nginx web服务器，请将下面这一句引号里的/usr/sbin/nginx -s reload 替换成你需要的重载服务器的命令
	echo "0 3 */7 * * /usr/bin/certbot renew --disable-hook-validation --renew-hook \"/usr/sbin/nginx -s reload\"">> /var/spool/cron/root
	echo "还没有添加cron" 
fi



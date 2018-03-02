#!/bin/bash
yum install -y python-devel python-setuptools && easy_install pip
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
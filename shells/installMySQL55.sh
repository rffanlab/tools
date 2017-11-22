#!/usr/bin/env bash
#install dependence packages
yum install -y wget patch cmake make gcc gcc-c++ gcc-g77 flex bison* file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap

mysqlbv=5.5
mysqlv=5.5.58
wget -c https://dev.mysql.com/get/Downloads/MySQL-$mysqlbv/mysql-$mysqlv.tar.gz

echo "============================mysql install=================================="
read -p "Input your mysql root password:" mysqlrootpwd
cur_dir=`pwd`
cd $cur_dir
tar zxvf mysql-$mysqlv.tar.gz
yum install -y cmake
cd $cur_dir/mysql-$mysqlv/
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DENABLED_PROFILING=ON -DWITH_READLINE=1 -DWITH_DEBUG=0 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_DATADIR=/home/mysql/data/ -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1
make && make install
cd ../

rm -rf /etc/my.cnf

groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql
mkdir -p /home/mysql/data/

cd /usr/local/mysql/

scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/home/mysql/data --user=mysql

chown -R mysql:mysql /usr/local/mysql/
chown -R mysql:mysql /home/mysql

cp /usr/local/mysql/support-files/mysql.server /etc/rc.d/init.d/mysqld
chmod 755 /etc/rc.d/init.d/mysqld
chkconfig --add mysqld
chkconfig --level 35 mysqld on

ln -s /usr/local/mysql/bin/mysql* /usr/bin

/etc/rc.d/init.d/mysqld start

cat > /tmp/mysql_sec_script<<EOF
use mysql;
update user set password=password('$mysqlrootpwd') where user='root';
delete from user where not (user='root') ;
delete from user where user='root' and password='';
drop database test;
DROP USER ''@'%';
flush privileges;
EOF

/usr/local/mysql/bin/mysql -u root < /tmp/mysql_sec_script

rm -f /tmp/mysql_sec_script
#!/usr/bin/env bash
# this script is written for setting up phantomjs env for webdriver to run.
# written by Rffanlab
# Any question please visit https://ddns.togit.cc:7777/rffanlab/tools to raise an issue
wget -c https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
# wget -c https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2
tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local
mv /usr/local/phantomjs-2.1.1-linux-x86_64 /usr/local/phantomjs
echo "export PHANTOMJS=/usr/local/phantomjs">>/etc/profile
echo "export PATH=\$PATH:\$PHANTOMJS/bin">>/etc/profile
source /etc/profile

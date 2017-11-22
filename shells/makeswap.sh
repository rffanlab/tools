#!/usr/bin/env bash
read -p "Input the size of swap (KB):"size
dd if=/dev/zero of=/swapfile bs=1024 count=$size
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile
swapon /swapfile
swapon -s
echo '/swapfile     swap   swap     defaults     0 0' >> /etc/fstab
#!/bin/sh
yum update -y

mkdir /usr/local/ispmgr
wget http://ru.download.ispsystem.com/Linux-cc6/x86_64/ISPmanager-Lite/install.stable.tgz
tar zxvf install.stable.tgz -C /usr/local/ispmgr
rm -f install.stable.tgz

ip=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'

curl http://lic.ispsystem.com/ispmgr.lic?ip=$ip > /usr/local/ispmgr/etc/ispmgr.lic

wget -P /root/ http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh /root/epel-release-6-8.noarch.rpm

/usr/local/ispmgr/sbin/pkgctl -D cache
/usr/local/ispmgr/sbin/pkgctl install cron
/usr/local/ispmgr/sbin/pkgctl install apache
/usr/local/ispmgr/sbin/pkgctl install nginx
/usr/local/ispmgr/sbin/pkgctl install php
/usr/local/ispmgr/sbin/pkgctl install fcgi
/usr/local/ispmgr/sbin/pkgctl install ftp
/usr/local/ispmgr/sbin/pkgctl install mysql
/usr/local/ispmgr/sbin/pkgctl install myadmin
/usr/local/ispmgr/sbin/pkgctl install lda
/usr/local/ispmgr/sbin/pkgctl install pop3
/usr/local/ispmgr/sbin/pkgctl install smtp exim
/usr/local/ispmgr/sbin/pkgctl install dns

/usr/local/ispmgr/sbin/pkgctl activate cron
/usr/local/ispmgr/sbin/pkgctl activate apache
/usr/local/ispmgr/sbin/pkgctl activate nginx
/usr/local/ispmgr/sbin/pkgctl activate php
/usr/local/ispmgr/sbin/pkgctl activate fcgi
/usr/local/ispmgr/sbin/pkgctl activate ftp
/usr/local/ispmgr/sbin/pkgctl activate mysql
/usr/local/ispmgr/sbin/pkgctl activate myadmin
/usr/local/ispmgr/sbin/pkgctl activate pop3
/usr/local/ispmgr/sbin/pkgctl activate lda
/usr/local/ispmgr/sbin/pkgctl activate smtp exim
/usr/local/ispmgr/sbin/pkgctl activate dns
/usr/local/ispmgr/sbin/pkgctl -D cache
echo "Option Agree" >> /usr/local/ispmgr/etc/ispmgr.conf
echo "FSEncoding UTF-8" >>/usr/local/ispmgr/etc/ispmgr.conf

/usr/bin/killall -9 ispmgr
/sbin/iptables -F

/usr/local/ispmgr/sbin/ihttpd $ip 1500

yum install ntp unzip git vim nano screen vnstat htop php-gd php-mcrypt php-curl php-soap  php-bcmath -y

service ntpd restart
service httpd restart


#!/bin/bash
conf=$(echo "/usr/local/ispmgr/etc/ispmgr.conf")
bit=$(uname -m | sed s/_/-/g)
php=$(php -v | awk 'NR==1{print substr($2,1,3)}')
sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/atrpms.repo
if ! grep -q "Option DisableIspmgrEOLBannersDisplay" $conf
then echo "Option DisableIspmgrEOLBannersDisplay" >> $conf; fi
if ! grep -q "FSEncoding UTF-8" $conf
then echo "FSEncoding UTF-8" >> $conf; fi
yum update -y -q
yum install php-gd php-mcrypt php-curl php-soap php-bcmath -y -q
wget "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_$bit.tar.gz"
mkdir /usr/local/ioncube/
tar zxf "ioncube_loaders_lin_$bit.tar.gz" -C /usr/local/ioncube/ --strip 1
echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_$php.so" > /etc/php.d/0_ioncube.ini
echo "zend_extension_ts = /usr/local/ioncube/ioncube_loader_lin_"$php"_ts.so" >> /etc/php.d/0_ioncube.ini
rm -f "ioncube_loaders_lin_$bit.tar.gz"
rm -f $0
/etc/init.d/httpd restart
echo "ISPmanager 4 Lite tweaked. CentOS updated successfully. Also was installed php-gd-soap-bcmath-mcrypt-curl, Ioncube."

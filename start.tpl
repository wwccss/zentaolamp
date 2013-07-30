#!/bin/bash
# This file is used to start apache at {apacheToPort} port and mysql at {mysqlToPort} port.

# check the directory, must at /opt/lampp.
pwd | grep ^/opt/lampp > /dev/null 2>&1    # check the pwd is /opt/lampp or not.
if [ $? -ne 0 ]
then
  # if the pwd is not /opt/lampp, may be the /opt/lampp is a link, check /opt/lampp exists or not.
  ls /opt/lampp > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    echo "The lampp can only run at /opt/lampp"
  fi
fi

# check the run user, must be root.
if test "`id -u`" -ne 0
then
  echo "You need to start XAMPP as root!"
  exit
fi

# replace ports.
sed -e 's/{apacheFromPort}/{apacheToPort}/g' lampp | sed -e 's/{mysqlFromPort}/{mysqlToPort}/g'> lampp.{apacheToPort}
mv lampp.{apacheToPort} lampp

sed -e 's/{apacheFromPort}/{apacheToPort}/g' etc/httpd.conf > etc/httpd.conf.{apacheToPort}
mv etc/httpd.conf.{apacheToPort} etc/httpd.conf

sed -e 's/{mysqlFromPort}/{mysqlToPort}/g' etc/my.cnf > etc/my.cnf.{mysqlToPort}
mv etc/my.cnf.{mysqlToPort} etc/my.cnf

sed -e 's/{mysqlFromPort}/{mysqlToPort}/g' {product}/config/my.php > {product}/config/my.php.{mysqlToPort}
mv {product}/config/my.php.{mysqlToPort} {product}/config/my.php

sed -e 's/{mysqlFromPort}/{mysqlToPort}/g' phpmyadmin/config.inc.php > phpmyadmin/config.inc.php.{mysqlToPort}
mv phpmyadmin/config.inc.php.{mysqlToPort} phpmyadmin/config.inc.php

# change directory permissions.
chmod a+rx lampp
chown nobody -R var/mysql
chmod 777 temp
chmod a+rx -R {product}
chmod 777 -R {product}/tmp
chmod 777 -R {product}/www/data
chmod 777 {product}/module
find {product}/ -name ext |xargs chmod -R 777

# init the shells in {product}/bin
if [ ! -f ./{product}/bin/backup.sh ]; then  
  ip=`ifconfig |grep inet|head -n 1 |awk -F':' '{print $2}' |awk -F ' ' '{print $1}'` #{product}
  pmsRoot=http://$ip:{apacheToPort}/{product}/
 ./{product}/bin/init.sh /opt/lampp/bin/php $pmsRoot > /dev/null 2>&1
fi  # {product}

# start apache, mysql.
./lampp startapache
./lampp startmysql

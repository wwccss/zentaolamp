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
sed -i 's/{apacheFromPort}/{apacheToPort}/g' lampp | sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' lampp
sed -i 's/{apacheFromPort}/{apacheToPort}/g' etc/httpd.conf
sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' etc/my.cnf 

ls zentao/config/my.php      > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' zentao/config/my.php
ls zentaopro/config/my.php   > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' zentaopro/config/my.php
ls zentaostory/config/my.php > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' zentaostory/config/my.php
ls zentaotask/config/my.php  > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' zentaotask/config/my.php
ls zentaotest/config/my.php  > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' zentaotest/config/my.php
ls xirang/config/my.php      > /dev/null 2>&1 && sed -i 's/{mysqlFromPort}/{mysqlToPort}/g' xirang/config/my.php

# change directory permissions.
chmod a+rx lampp
chown nobody -R var/mysql
chmod 777 temp

# change permissions for products.
function changePermission
{
    product=$1
    if [ -d $product ]; 
    then
        chmod a+rx -R $product
        chmod 777 -R $product/tmp
        chmod 777 -R $product/www/data
        chmod 777 $product/module
        find $product/ -name ext |xargs chmod -R 777

        # init the shells in $product/bin
        if [ ! -f ./$product/bin/backup.sh ]; then  
            ip=`ifconfig |grep inet|head -n 1 |awk -F':' '{print $2}' |awk -F ' ' '{print $1}'`
            pmsRoot=http://$ip:{apacheToPort}/$product/
            ./$product/bin/init.sh /opt/lampp/bin/php $pmsRoot > /dev/null 2>&1
        fi
    fi
}
changePermission zentao
changePermission zentaopro
changePermission zentaostory
changePermission zentaotask
changePermission zentaotest
changePermission xirang

# start apache, mysql.
./lampp startapache
./lampp startmysql

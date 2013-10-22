source=$1
product=$2
tar zxvf $source/xampp.tar.gz
cd lampp

# rm useless files.
rm -frv RELEASENOTES
rm -frv error
rm -frv icons
rm -frv licenses
rm -frv logs/*
rm -frv htdocs/*
rm -frv cgi-bin
rm -frv libexec
rm -frv phpmyadmin
rm -frv php
rm -frv temp/*
rm -frv apache2
rm -frv ctlscript.sh
rm -frv manager-linux.run
rm -frv manager-linux-x64.run
rm -frv pear
rm -frv proftpd
rm -frv properties.ini
rm -frv uninstall*
rm -frv mysql
rm -frv img
chmod -R 777 temp

# rm useless settings.
rm -frv etc/proftpd.conf
rm -frv etc/webalizer.conf*
rm -frv etc/frveetds.conf
rm -frv etc/openssl.cnf
rm -frv etc/php.ini-pre1.7.2
rm -frv etc/pear.conf
rm -frv etc/pool.conf
rm -frv etc/openldap
rm -frv etc/original
rm -frv etc/httpd.conf.bak
rm -frv etc/lampp/startftp
rm -frv etc/ssl*
rm -frv etc/extra
rm -frv etc/magic
rm -frv etc/locales.conf

# process httpd conf
if [ $product = 'common' ]; then
    cp -v ../httpd.common.conf etc/httpd.conf
elif [ $product = 'chanzhi' ]; then
    cp -v ../httpd.chanzhi.conf etc/httpd.conf
else
    cp -v ../httpd.zentao.conf etc/httpd.conf
fi  

# process my.cnf
cp -v ../my.cnf etc/my.cnf

# process php.ini
cp -v ../php.ini etc/php.ini

# rm useless binaries.
mv -v bin bin.bak
mkdir -v bin
cd bin.bak 
cp -v htpasswd apachectl my_print_defaults mysql mysql.server mysqld_safe mysqldump php php-config phpize httpd gettext ../bin/
cd ../
rm -frv bin.bak

# rm useless binaries at sbin directory, keep mysqld.
mv -v sbin sbin.bak
mkdir -v sbin
mv -v sbin.bak/mysqld sbin/
rm -frv sbin.bak

# process share directory. keep english and lampp directory.
mv -v share share.bak
mkdir -v share
mv -v share.bak/english share/
mv -v share.bak/lampp share
mv -v share.bak/xampp share
rm -frv share.bak

# process lib directory.
mkdir libnew
awk -F'-' '{print $1}' lib/VERSION > libnew/VERSION
cp -v lib/libapr-1.so.0 libnew/
cp -v lib/libaprutil-1.so.0 libnew/
cp -v lib/libcrypto.so.1.0.0 libnew/
cp -v lib/libcurl.so.4 libnew/
cp -v lib/libexslt.so.0 libnew/
cp -v lib/libfrveetype.so.6 libnew/
cp -v lib/libgcc_s.so.1 libnew/
cp -v lib/libiconv.so.2 libnew/
cp -v lib/liblber-2.4.so.2.5.4 libnew/
cp -v lib/libmcrypt.so.4 libnew/
cp -v lib/libncurses.so.5 libnew/
cp -v lib/libpcre.so.0 libnew/
cp -v lib/libsqlite3.so.0 libnew/
cp -v lib/libssl.so.1.0.0 libnew/
cp -v lib/libstdc++.so.5 libnew/
cp -v lib/libsybdb.so.5 libnew/
cp -v lib/libxml2.so.2 libnew/
cp -v lib/libxslt.so.1 libnew/
cp -v lib/libz.so.1 libnew/
cp -v lib/libct.so.4 libnew/
cp -v lib/libpng15.so.15 libnew/
cp -v lib/libjpeg.so.8 libnew/
cp -v lib/libbz2.so  libnew/
cp -v lib/libicui18n.so.48  libnew/
cp -v lib/libicuuc.so.48 libnew/
cp -v lib/libicudata.so.48  libnew/
cp -v lib/libicuio.so.48 libnew/
cp -v lib/libbz2.so libnew/
cp -v lib/libpq.so.5.5 libnew/
cp -v lib/libapreq2.so.3.7.1 libnew/

rm -frv lib
mv libnew lib

cd lib
ln -s libpq.so.5.5 libpq.so.5
ln -s libpq.so.5.5 libpq.so
ln -s libapreq2.so.3.7.1 libapreq2.so.3
ln -s libapreq2.so.3.7.1 libapreq2.so
cd ../

# process var directory.
rm -frv var/perl
rm -frv var/proftpd*
rm -frv var/mysql/cdcol
rm -frv var/mysql/*.err
rm -frv var/mysql/*.pid
rm -frv var/mysql/ib*
rm -frv var/mysql/test
rm -frv var/mysql/phpmyadmin
rm -frv var/mysql/mysql_upgrade_info
chmod -R 777 var/mysql

# process modules directory.
rm -frv modules/httpd.exp
rm -frv modules/mod_perl.so
rm -frv modules/mod_actions.so
rm -frv modules/mod_allowmethods.so
rm -frv modules/mod_asis.so
rm -frv modules/mod_authn_dbm
rm -frv modules/mod_authn_anon
rm -frv modules/mod_authn_dbd
rm -frv modules/mod_authn_default
rm -frv modules/mod_authz_dbm.so
rm -frv modules/mod_authz_default.so
rm -frv modules/mod_authz_groupfile.so
rm -frv modules/mod_authz_owner.so
rm -frv modules/mod_auth_digest.so
rm -frv modules/mod_auth_form.so
rm -frv modules/mod_authn_anon.so
rm -frv modules/mod_authn_dbd.so
rm -frv modules/mod_authn_dbm.so
rm -frv modules/mod_authn_socache.so
rm -frv modules/mod_authnz_ldap.so
rm -frv modules/mod_authz_dbd.so
rm -frv modules/mod_bucketeer.so
rm -frv modules/mod_buffer.so
rm -frv modules/mod_cache*
rm -frv modules/mod_case**
rm -frv modules/mod_cern_meta.so
rm -frv modules/mod_cgi*
rm -frv modules/mod_charset_lite.so
rm -frv modules/mod_echo.so
rm -frv modules/mod_dav*.so
rm -frv modules/mod_dbd.so
rm -frv modules/mod_disk_cache.so
rm -frv modules/mod_dumpio.so
rm -frv modules/mod_ext_filter.so
rm -frv modules/mod_file_cache.so
rm -frv modules/mod_headers.so
rm -frv modules/mod_ident.so
rm -frv modules/mod_imagemap.so
rm -frv modules/mod_include.so
rm -frv modules/mod_info.so
rm -frv modules/mod_ldap.so
rm -frv modules/mod_log_debug.so
rm -frv modules/mod_logio.so
rm -frv modules/mod_lbmethod*
rm -frv modules/mod_mem_cache.so
rm -frv modules/mod_mime_magic.so
rm -frv modules/mod_negotiation.so
rm -frv modules/mod_proxy*
rm -frv modules/mod_reqtimeout.so
rm -frv modules/mod_ratelimit.so
rm -frv modules/mod_remoteip.so
rm -frv modules/mod_request.so
rm -frv modules/mod_sed.so
rm -frv modules/mod_sess*.so
rm -frv modules/mod_slotmem_shm.so
rm -frv modules/mod_socache*.so
rm -frv modules/mod_speling.so
rm -frv modules/mod_ssl.so
rm -frv modules/mod_status.so
rm -frv modules/mod_substitute.so
rm -frv modules/mod_suexec.so
rm -frv modules/mod_unique_id.so
rm -frv modules/mod_userdir.so
rm -frv modules/mod_usertrack.so
rm -frv modules/mod_version.so
rm -frv modules/mod_vhost_alias.so

# copy needed files.
cp -v ../Makefile .
../createControl.php $product
cp -v ../stop .
cp -v ../index.$product.php htdocs/index.php
chmod a+rx start*
chmod a+rx stop*

# make the auth file
mkdir -v auth
touch auth/users
cp ../adduser.sh auth/

# process the phpmyadmin
tar xvf $1/phpmyadmin.tar.gz
mv -v phpmyadmin/locale phpmyadmin/locale.bak
mkdir -v phpmyadmin/locale
mv -v phpmyadmin/locale.bak/en_GB phpmyadmin/locale
mv -v phpmyadmin/locale.bak/zh_* phpmyadmin/locale
rm -frv phpmyadmin/locale.bak
cp -v ../phpmyadmin.php phpmyadmin/config.inc.php
rm -frv phpmyadmin/examples
rm -frv phpmyadmin/js/openlayers
rm -frv phpmyadmin/libraries/tcpdf
rm -frv phpmyadmin/Documentation*
rm -frv phpmyadmin/themes/original
rm -frv phpmyadmin/doc

# copy the ioncube loader.
cp -v ../*.so lib/

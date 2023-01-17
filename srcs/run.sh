#!/bin/bash

service nginx start
service php7.3-fpm start

# wordpress
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
mv ./wp-config.php var/www/html/wordpress/wp-config.php 

# user setting
service mysql start
mysql < setting.sql

# check
echo hi
bash

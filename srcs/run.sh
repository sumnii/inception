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

# phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /var/www/html/
mv ./config.inc.php /var/www/html/phpmyadmin/
service nginx reload

# create phpmyadmin DB table
mysql < var/www/html/phpmyadmin/sql/create_tables.sql

# check
echo hi
bash

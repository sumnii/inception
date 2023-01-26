#!/bin/bash

service php7.3-fpm start

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
mv ./wp-config.php var/www/html/wordpress/wp-config.php 

bash
#!/bin/bash

# nginx 관리자(www-data)에 wp가 담길 디렉토리에 대한 권한 할당
chown -R www-data:www-data /var/www/

# if ! mysqladmin --host=$WORDPRESS_DB_HOST --port=3306 --user=$MYSQL_USER --password=$MYSQL_PASSWORD --wait=30 ping > /dev/null; then
# 	printf "MariaDB Daemon Unreachable\n"
# 	exit 1
# fi

if [ ! -f "/var/www/html/wordpress/index.php" ]; then
	sudo -u www-data sh -c " \
	wp core download --locale=$WORDPRESS_LANG && \

	wp config create --dbname=$MYSQL_DATABASE --dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset="utf8" && \
	
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_DB_ADMIN_EMAIL --skip-email && \

	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD && \
	
	wp plugin update --all

	echo "127.0.0.1 $DOMAIN_NAME" >> /etc/hosts
	"
fi

# foreground로 실행
exec php-fpm7.3 -F
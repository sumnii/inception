#!/bin/bash

# 초기 설정 확인
cat /var/lib/mysql/.setup 2> /dev/null

# db_setting
if [ $? -ne 0 ]; then
	service mysql start

	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

	mysql -uroot -p$MYSQL_ROOT_PASSWORD
	pkill -9 mariadb

	touch /var/lib/mysql/.setup

	ln -s /run/mysqld/mysqld.sock /var/lib/mysql/mysql.sock
fi

# 현재 쉘스크립트를 실행중인 bash(pid 1)를 대체
exec mysqld_safe
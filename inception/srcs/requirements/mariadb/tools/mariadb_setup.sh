#!/bin/bash

# 초기 설정 확인
cat /var/lib/mysql/.setup 2> /dev/null

# db_setting
if [ $? -ne 0 ]; then
	mysqld_safe

	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

	touch /var/lib/mysql/.setup

	mysql $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
fi

# 현재 쉘스크립트를 실행중인 bash(pid 1)를 대체
exec mysqld_safe
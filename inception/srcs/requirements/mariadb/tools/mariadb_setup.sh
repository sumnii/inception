#!/bin/bash

service mysql start

# db_setting
mysql -uroot -p$MYSQL_ROOT_PASSWORD <<eof
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
eof

mysql $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

# 현재 쉘스크립트를 실행중인 bash(pid 1)를 대체
exec mysqld_safe
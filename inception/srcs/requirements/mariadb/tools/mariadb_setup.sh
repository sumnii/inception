#!/bin/bash

service mysql start

# db_setting
mysql <<eof
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWD';
FLUSH PRIVILEGES;
eof

# 그냥 mysql server 실행
mysqld

# 현재 쉘스크립트를 실행중인 bash(pid 1)를 mysqld로 대체
# exec mysqld

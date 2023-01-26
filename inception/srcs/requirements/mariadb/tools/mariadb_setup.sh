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

# bash
mysqld

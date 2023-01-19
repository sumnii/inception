CREATE DATABASE wordpress;
CREATE USER 'daelee'@'localhost' IDENTIFIED BY 'daelee';
GRANT ALL PRIVILEGES ON wordpress.* TO 'daelee'@'localhost' WITH GRANT OPTION;


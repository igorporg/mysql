mysql> CREATE DATABASE example;
mysql> CREATE DATABASE sample;
mysql> USE example;
mysql> CREATE TABLE IF NOT EXISTS users(
	id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name    VARCHAR(50) NOT NULL
);
~$ mysqldump -u root -p example > dump_file.sql
~$ mysql -u root -p sample < dump_file.sql
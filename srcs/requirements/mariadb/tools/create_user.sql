CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'tpauvret'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'tpauvret'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'UwU42';

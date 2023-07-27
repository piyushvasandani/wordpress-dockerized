CREATE USER 'wp_user'@'%' IDENTIFIED BY 'Testpassword@123';
CREATE DATABASE wp;
GRANT ALL PRIVILEGES ON wp.* TO 'wp_user'@'%';

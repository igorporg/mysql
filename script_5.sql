-- Создаем дубликат таблички users
CREATE TABLE users_1 (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  is_banned TINYINT(1),
  is_active TINYINT(1),
  created_at VARCHAR(64) NOT NULL,
  updated_at VARCHAR(64) NOT NULL
);
-- вставляем данные из users
INSERT INTO users_1 SELECT * FROM users;

SELECT first_name, last_name, created_at, updated_at FROM users_1;

-- апдейтим поля created_at и updated_at текущей датой и временем
UPDATE users_1 SET created_at = NOW(), updated_at = NOW();

-- меняем поля на тип  DATETIME
ALTER TABLE users_1 MODIFY COLUMN created_at DATETIME NOT NULL;
ALTER TABLE users_1 MODIFY COLUMN updated_at DATETIME NOT NULL;


-- Сделаю чуть позже....
CREATE DATABASE shop;


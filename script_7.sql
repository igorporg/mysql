-- Просмотрим задействованные в запросе таблицы
SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM orders_products;
SELECT * FROM products;
SELECT * FROM catalogs;

-- Добавим пару юзеров не имеющих ни одного заказа
INSERT INTO users (name, birthday_at) VALUES
  ('Андрей', '1999-10-05'),
  ('Полина', '1988-11-12')

-- вытащим всех пользователей попавших в таблицу orders
SELECT id, name FROM users WHERE id IN (SELECT user_id FROM orders);

-- либо
SELECT DISTINCT users.id , users.name FROM users, orders WHERE users.id = orders.user_id;

-- вытащим количество заказов для каждого пользователя
SELECT id, name, (SELECT COUNT(*) FROM orders WHERE user_id = users.id) AS total_orders FROM users WHERE id IN (SELECT user_id FROM orders);

-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT id, name, (SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalog_name FROM products;

-- либо
SELECT p.id, p.name, c.name FROM products p, catalogs c WHERE p.catalog_id = c.id;
-- или
SELECT p.id, p.name, c.name FROM products p JOIN catalogs c ON p.catalog_id = c.id;


-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from_city VARCHAR(255),
  to_city VARCHAR(255)
);

INSERT INTO flights (from_city, to_city) VALUES
  ('Moscow', 'Omsk'),
  ('Omsk', 'Moscow'),
  ('Novgorod', 'Kazan'),
  ('Irkutsk', 'Novgorod'),
  ('Kazan', 'Moscow'),
  ('Moscow', 'Novgorod');
  
 CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO cities (label, name) VALUES
  ('Moscow', 'Москва'),
  ('Omsk', 'Омск'),
  ('Novgorod', 'Новгород'),
  ('Irkutsk', 'Иркутск'),
  ('Kazan', 'Казань');

 -- получаем список полетов с переводом на русский (упрощенный запрос, думаю есть более правильный вариант но пока не могу сообразить какой)
 SELECT id, (SELECT name FROM cities WHERE label like flights.from_city) AS `from`, (SELECT name FROM cities WHERE label like flights.to_city) AS `to` FROM flights;

 -- SELECT id, c.name as `from`, to_city  FROM flights f, cities c WHERE f.from_city like c.label;
 
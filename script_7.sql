-- ���������� ��������������� � ������� �������
SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM orders_products;
SELECT * FROM products;
SELECT * FROM catalogs;

-- ������� ���� ������ �� ������� �� ������ ������
INSERT INTO users (name, birthday_at) VALUES
  ('������', '1999-10-05'),
  ('������', '1988-11-12')

-- ������� ���� ������������� �������� � ������� orders
SELECT id, name FROM users WHERE id IN (SELECT user_id FROM orders);

-- ����
SELECT DISTINCT users.id , users.name FROM users, orders WHERE users.id = orders.user_id;

-- ������� ���������� ������� ��� ������� ������������
SELECT id, name, (SELECT COUNT(*) FROM orders WHERE user_id = users.id) AS total_orders FROM users WHERE id IN (SELECT user_id FROM orders);

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
SELECT id, name, (SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalog_name FROM products;

-- ����
SELECT p.id, p.name, c.name FROM products p, catalogs c WHERE p.catalog_id = c.id;
-- ���
SELECT p.id, p.name, c.name FROM products p JOIN catalogs c ON p.catalog_id = c.id;


-- ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.

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
  ('Moscow', '������'),
  ('Omsk', '����'),
  ('Novgorod', '��������'),
  ('Irkutsk', '�������'),
  ('Kazan', '������');

 -- �������� ������ ������� � ��������� �� ������� (���������� ������, ����� ���� ����� ���������� ������� �� ���� �� ���� ���������� �����)
 SELECT id, (SELECT name FROM cities WHERE label like flights.from_city) AS `from`, (SELECT name FROM cities WHERE label like flights.to_city) AS `to` FROM flights;

 -- SELECT id, c.name as `from`, to_city  FROM flights f, cities c WHERE f.from_city like c.label;
 
-- ������� �������� �������� users
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
-- ��������� ������ �� users
INSERT INTO users_1 SELECT * FROM users;

SELECT first_name, last_name, created_at, updated_at FROM users_1;

-- �������� ���� created_at � updated_at ������� ����� � ��������
UPDATE users_1 SET created_at = NOW(), updated_at = NOW();

-- ������ ���� �� ���  DATETIME
ALTER TABLE users_1 MODIFY COLUMN created_at DATETIME NOT NULL;
ALTER TABLE users_1 MODIFY COLUMN updated_at DATETIME NOT NULL;


-- ������� ���� shop � �������� �������
CREATE DATABASE shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '�������� �������',
  UNIQUE unique_name(name(10))
) COMMENT = '������� ��������-��������';

INSERT INTO catalogs VALUES
  (NULL, '����������'),
  (NULL, '����������� �����'),
  (NULL, '����������'),
  (NULL, '������� �����'),
  (NULL, '����������� ������');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��������',
  description TEXT COMMENT '��������',
  price DECIMAL (11,2) COMMENT '����',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = '�������� �������';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 7890.00, 1),
  ('Intel Core i5-7400', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 12700.00, 1),
  ('AMD FX-8320E', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� AMD.', 4780.00, 1),
  ('AMD FX-8320', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', '����������� ����� ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', '����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', '����������� ����� MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = '������';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT '���������� ���������� �������� �������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ ������';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT '�������� ������ �� 0.0 �� 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = '������';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT '����� �������� ������� �� ������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';


-- ��������� ������� storehouses � storehouses_products ���������������� �������

INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'sklad_1', '1989-04-08 19:22:21', '1993-07-13 21:28:06');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'sklad_2', '1982-10-25 07:58:47', '1983-07-15 09:13:57');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'sklad_3', '1971-03-09 02:23:35', '1971-11-10 02:13:14');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'sklad_4', '1983-01-17 02:15:39', '2017-08-04 18:42:47');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'sklad_5', '1993-12-16 20:06:14', '1987-10-22 20:17:43');

INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('1', 1, 7, 18, '1994-07-27 00:14:06', '2009-05-06 22:33:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('2', 2, 7, 28, '1990-07-15 04:13:15', '1991-01-10 15:44:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('3', 3, 1, 17, '2016-10-03 03:34:59', '2007-02-17 14:17:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('4', 4, 5, 27, '2010-04-12 19:41:48', '1996-05-16 22:10:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('5', 5, 6, 16, '1995-08-11 00:20:06', '2002-12-07 12:07:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('6', 1, 3, 0, '2019-03-11 09:40:35', '1973-06-01 22:57:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('7', 2, 3, 24, '2002-03-19 16:46:41', '2012-06-26 12:34:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('8', 3, 3, 28, '1982-09-08 18:45:19', '2000-12-05 15:41:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('9', 4, 7, 26, '1995-11-06 00:26:07', '2004-08-29 04:36:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('10', 5, 2, 29, '2006-02-23 09:34:02', '2004-07-13 00:44:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('11', 1, 5, 29, '1989-11-20 12:21:37', '2002-03-27 12:44:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('12', 2, 2, 2, '2014-06-05 15:07:50', '1984-07-31 08:25:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('13', 3, 7, 28, '1972-10-23 15:17:51', '1990-10-11 10:20:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('14', 4, 6, 7, '1980-09-13 15:14:03', '1970-07-10 02:34:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('15', 5, 3, 9, '1985-02-14 21:28:13', '1979-06-12 06:36:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('16', 1, 1, 22, '2014-01-03 23:58:15', '2008-04-13 16:36:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('17', 2, 1, 12, '1994-09-11 10:48:20', '1999-09-06 15:41:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('18', 3, 1, 21, '1996-04-27 15:16:29', '2016-05-26 08:20:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('19', 4, 2, 20, '2003-07-16 15:53:55', '1975-05-02 12:45:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('20', 5, 4, 11, '1986-09-27 09:26:23', '1999-04-16 23:52:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('21', 1, 3, 20, '1987-01-06 23:12:01', '1972-06-22 00:44:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('22', 2, 4, 18, '2003-08-26 10:08:37', '1976-01-19 21:18:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('23', 3, 2, 27, '2007-08-05 22:42:14', '1976-04-23 11:34:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('24', 4, 3, 0, '1985-05-11 04:40:30', '2000-06-07 14:45:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('25', 5, 6, 21, '1987-10-30 18:44:26', '1982-10-10 18:28:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('26', 1, 5, 30, '2019-03-15 16:54:04', '1992-10-08 05:04:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('27', 2, 2, 8, '1974-04-25 02:52:30', '1973-09-02 05:27:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('28', 3, 7, 1, '2018-09-11 23:43:20', '1985-05-06 13:40:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('29', 4, 7, 27, '1973-01-22 23:56:04', '1977-04-09 15:46:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('30', 5, 5, 12, '1973-03-07 16:17:39', '2007-12-15 23:42:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('31', 1, 5, 2, '1992-06-11 11:11:53', '2004-03-26 04:16:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('32', 2, 3, 20, '2010-02-24 21:51:17', '1993-08-02 09:58:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('33', 3, 2, 7, '1989-10-29 18:24:43', '1975-09-05 12:03:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('186', 1, 1, 10, '2003-10-22 05:32:09', '1996-04-23 02:55:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('187', 2, 4, 14, '2016-10-10 06:53:14', '1974-02-14 02:10:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('188', 3, 3, 2, '2003-12-16 15:09:10', '1975-09-07 22:11:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('189', 4, 4, 24, '1973-07-16 22:15:17', '1975-11-24 19:45:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('190', 5, 6, 26, '1985-06-29 07:51:48', '1987-09-26 16:58:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('191', 1, 6, 0, '2012-11-02 07:25:49', '1997-11-29 06:36:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('192', 2, 2, 19, '1988-10-04 15:05:47', '2012-06-16 15:50:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('193', 3, 6, 25, '2016-09-25 20:42:10', '1972-11-06 09:10:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('194', 4, 5, 22, '1971-01-11 13:20:32', '1986-09-24 22:25:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('195', 5, 2, 17, '1981-12-15 14:57:55', '1993-03-23 00:32:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('196', 1, 1, 8, '1984-12-17 13:41:12', '1985-08-26 06:33:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('197', 2, 2, 10, '2014-11-30 14:46:45', '1996-03-29 03:05:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('198', 3, 5, 15, '2007-05-14 12:39:26', '2016-07-17 05:19:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('199', 4, 5, 0, '1981-12-03 14:39:42', '2014-01-05 12:57:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('200', 5, 2, 20, '1989-05-07 21:58:39', '2015-06-24 04:30:17');

-- ����������� �� ������� storehouses_products ������, ��������������� �� ���� value � ����������� � ����� ������ ������� �� ��������� value = 0

-- ������� � ������������� ��������
CREATE TABLE storehouses_products_temp (
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT '����� �������� ������� �� ������'
) COMMENT = '��������������� �������';

INSERT INTO storehouses_products_temp SELECT storehouse_id, product_id, value FROM storehouses_products GROUP BY storehouse_id, product_id, value HAVING value > 0 ORDER BY value;
INSERT INTO storehouses_products_temp SELECT storehouse_id, product_id, value FROM storehouses_products GROUP BY storehouse_id, product_id, value HAVING value = 0;
SELECT * FROM storehouses_products_temp;

-- ������� � UNION
-- ������� �������
(SELECT * FROM storehouses_products WHERE value > 0  ORDER BY value LIMIT 100)
UNION
(SELECT * FROM storehouses_products WHERE value = 0  ORDER BY value LIMIT 10);

-- ������� ��������� (�������� �� ����������� ���������� � ������ ��������, ���� ��� union �� ��� ���������)
SELECT SH.name, P.name, SP.value FROM storehouses_products AS SP, storehouses AS SH, products AS P  WHERE SP.storehouse_id = SH.id AND SP.product_id = P.id AND SP.value > 0  ORDER BY value;

(SELECT SH.name, P.name, SP.value FROM storehouses_products AS SP, storehouses AS SH, products AS P  WHERE SP.storehouse_id = SH.id AND SP.product_id = P.id AND SP.value > 0  ORDER BY value)
UNION
(SELECT SH.name, P.name, SP.value FROM storehouses_products AS SP, storehouses AS SH, products AS P  WHERE SP.storehouse_id = SH.id AND SP.product_id = P.id AND SP.value = 0);



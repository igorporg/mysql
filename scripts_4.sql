-- ������ �������� ���� �� ������� filldb
-- ������ ����� ����������� ��� ��� ��� ���������� �������� ������ �������
-- �������� ������ ������� � ��������� ������ ��� ������� ������������ ��������� ������
-- ����� ����������� ��������� �������� ��� (��������� � ��������), �������� ������ � ���������������
-- ��������� ������� ����� �� �������� �����, � ����� ��������� :)


USE VK;
SHOW TABLES;

-- users
SELECT * FROM users LIMIT 100;
-- ��������� ������

-- profiles
SELECT * FROM profiles LIMIT 100;
-- ��������� ������

-- messages
SELECT * FROM messages LIMIT 100;
UPDATE messages SET
  from_user_id = FLOOR(1 + (RAND() * 100)),
  to_user_id = FLOOR(1 + (RAND() * 100))
;
-- �������� ������� ���� �������� ���������
ALTER TABLE messages ADD sent_at TIMESTAMP;

-- �������� � ������� ���� �������� � ����������� 
-- ���� �������� �� ����� ���� ����� ���� �����������, � ����� �� ����� ���� ��������� ��������
-- ����� �� ������ ��������� ���� �������� ����� - 2000-01-01 00:00:00
UPDATE messages SET 
	created_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,'2000-01-01 00:00:00',NOW())),'2000-01-01 00:00:00'),
	sent_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,`created_at`,NOW())),`created_at`);


-- media_types
SELECT * FROM media_types LIMIT 10;
DELETE FROM media_types;
TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio'),
  ('document'),
  ('script'),
  ('zip')
;

-- media
SELECT * FROM media LIMIT 10;

-- ��������� ����� �������� ���������� ����� ����� � ������� �����
UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 6));

-- ������ ����������� �� ������ ������ (���. 1��, �������� 10��)
UPDATE media SET size = FLOOR(1000 + (RAND() * 10000000));

-- �������� ���������� � ������ ��� �������
UPDATE media SET metadata = CONCAT('{"', filename, '":"', size, '"}');
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- �������� � ������� ���� �������� create � ��������� ������ update
-- ���� �������� �� ����� ���� ����� ���� ������
-- ����� �� ������ ��������� ���� ����� �� ��� � � ��������� - 2000-01-01 00:00:00

UPDATE media SET 
	created_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,'2000-01-01 00:00:00',NOW())),'2000-01-01 00:00:00'),
	updated_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,`created_at`,NOW())),`created_at`);

-- friendship
SELECT * FROM friendship_statuses;

-- ������ ��������� � ������
DROP TABLE IF EXISTS `friendship_statuses`;

CREATE TABLE `friendship_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ��������� ������� ��������������� (������ ����� ������� ������)
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (0, 'not friend');
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (1, 'best friend');
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (2, 'friend');
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (3, 'relative');
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (4, 'colleague');
INSERT INTO `friendship_statuses` (`id`, `name`) VALUES (5, 'classmate');


-- friendship
SELECT * FROM friendship LIMIT 100;

UPDATE friendship SET
  status_id = FLOOR(0 + (RAND() * 5));
 
-- �������� ����
UPDATE friendship SET 
	requested_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,'2000-01-01 00:00:00',NOW())),'2000-01-01 00:00:00'),
	confirmed_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,`requested_at`,NOW())),`requested_at`);

-- ���� ������ ������� �� �������� ���� �� ��������������
UPDATE friendship SET 
	requested_at =  '2000-01-01 00:00:00',
	confirmed_at =  '2000-01-01 00:00:00'
WHERE status_id = 0;


 -- communities
SELECT * FROM communities LIMIT 10;
-- ��������� ������

-- communities_users
SELECT * FROM communities_users LIMIT 100;
-- ��������� ������


-- ��������� ������-������� ��� �������� ������
-- �������� �� ������� ����������� ��������-�������, ��� ��� ����� �� �������� �����
 
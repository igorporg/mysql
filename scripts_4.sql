-- ƒанные получены мной из сервиса filldb
-- правки будут произведены там где это необходимо согласно логике проекта
-- основные правки св€заны с подгонкой данных под заранее определенную структуру таблиц
-- также ограничение некоторых значений дат (начальной и конечной), размеров файлов и идентификаторов
-- некоторые команды вз€ты из примеров урока, а также нагуглены :)


USE VK;
SHOW TABLES;

-- users
SELECT * FROM users LIMIT 100;
-- структура верна€

-- profiles
SELECT * FROM profiles LIMIT 100;
-- структура верна€

-- messages
SELECT * FROM messages LIMIT 100;
UPDATE messages SET
  from_user_id = FLOOR(1 + (RAND() * 100)),
  to_user_id = FLOOR(1 + (RAND() * 100))
;
-- дбавл€ем столбец даты отправки сообщени€
ALTER TABLE messages ADD sent_at TIMESTAMP;

-- приводим в пор€док даты создани€ и отправлени€ 
-- дата создани€ не может быть позже даты отправлени€, а также не может быть столетней давности
-- берем за основу начальную дату например такую - 2000-01-01 00:00:00
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

-- добавл€ем новые значени€ полученных типов медиа в таблицу медиа
UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 6));

-- ставим ограничени€ на размер файлов (мин. 1 б, максимум 10ћб)
UPDATE media SET size = FLOOR(1000 + (RAND() * 10000000));

-- апдейтим метаданные и мен€ем тип столбца
UPDATE media SET metadata = CONCAT('{"', filename, '":"', size, '"}');
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- приводим в пор€док даты создани€ create и последней правки update
-- дата создани€ не может быть позже даты правки
-- берем за основу начальную дату такую же как и в сообени€х - 2000-01-01 00:00:00

UPDATE media SET 
	created_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,'2000-01-01 00:00:00',NOW())),'2000-01-01 00:00:00'),
	updated_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,`created_at`,NOW())),`created_at`);

-- friendship
SELECT * FROM friendship_statuses;

-- мен€ем структуру и данные
DROP TABLE IF EXISTS `friendship_statuses`;

CREATE TABLE `friendship_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- добавл€ем статусы взаимоотношений (вводим также нулевой статус)
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
 
-- апдейтим даты
UPDATE friendship SET 
	requested_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,'2000-01-01 00:00:00',NOW())),'2000-01-01 00:00:00'),
	confirmed_at =  TIMESTAMPADD(SECOND, FLOOR(RAND()* TIMESTAMPDIFF(SECOND,`requested_at`,NOW())),`requested_at`);

-- если статус нулевой то обнул€ем даты до первоначальной
UPDATE friendship SET 
	requested_at =  '2000-01-01 00:00:00',
	confirmed_at =  '2000-01-01 00:00:00'
WHERE status_id = 0;


 -- communities
SELECT * FROM communities LIMIT 10;
-- структура верна€

-- communities_users
SELECT * FROM communities_users LIMIT 100;
-- структура верна€


-- ѕодобрать сервис-образец дл€ курсовой работы
-- ’отелось бы выбрать направление интернет-магазин, мне это ближе по тематике работ
 
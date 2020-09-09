DROP TABLE IF EXISTS `entity_field_entry`;
DROP TABLE IF EXISTS `entity_parent`;
DROP TABLE IF EXISTS `entity_field_entry_audit`;
DROP TABLE IF EXISTS `entity`;
DROP TABLE IF EXISTS `category_field`;
DROP TABLE IF EXISTS `category_parent`;
DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `public_id_format` varchar(50) DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT '1',
  `current_id` int DEFAULT '0',
  `current_max_id` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category` WRITE;
INSERT INTO `category` VALUES (1,'Theme','theme-',1,0,0),(2,'Statement','statement-',1,0,0),(3,'Measure','measure-',1,0,218),(4,'Communication','communication-',1,0,3),(5,'Project','project-',1,0,0),(6,'Milestone','milestone-',1,0,0),(11,'Department','department-',1,0,0);
UNLOCK TABLES;

CREATE TABLE `category_field` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  `type` enum('string','boolean','integer','float','group','date') NOT NULL,
  `config` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_required` tinyint(1) DEFAULT '0',
  `description` text,
  `priority` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `category_field_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category_field` WRITE;
INSERT INTO `category_field` VALUES (1,1,'name','Name','string',NULL,1,1,'Name of Theme',1),(2,1,'description','Description','string',NULL,1,0,'Description of Theme',2),(3,2,'name','Name','string',NULL,1,1,'Name of Statement',1),(4,2,'description','Description','string',NULL,1,0,'Description of Statement',2),(5,3,'name','Name','string',NULL,1,1,'Name of Measure',3),(6,3,'description','Description','string',NULL,1,0,'Description of Measure',4),(7,4,'name','Name','string',NULL,1,1,'Name of Communication',1),(8,4,'description','Description','string',NULL,1,0,'Description of Communication',2),(13,3,'unit','Unit','group','{\"options\": [\"#\"]}',1,1,'A unit to describe the value type',5),(14,3,'value','Value','integer',NULL,1,1,'The value for the measure',6),(15,3,'test','test','string',NULL,0,0,'test',7),(17,3,'date','date','date',NULL,1,0,'date',NULL),(18,4,'theme','Theme','string',NULL,0,1,'Theme',NULL),(19,3,'redThreshold','RedThreshold','integer',NULL,1,1,'RedThreshold',NULL),(20,3,'aYThreshold','AYThreshold','integer',NULL,1,1,'AYThreshold',NULL),(21,3,'greenThreshold','GreenThreshold','integer',NULL,1,1,'GreenThreshold',NULL),(22,3,'groupBy','GroupBy','string',NULL,1,1,'GroupBy',NULL),(23,4,'groupBy','GroupBy','string',NULL,1,0,'GroupBy',NULL),(24,4,'redThreshold','RedThreshold','integer',NULL,1,0,'RedThreshold',NULL),(25,4,'aYThreshold','AYThreshold','integer',NULL,1,0,'AYThreshold',NULL),(26,4,'greenThreshold','GreenThreshold','integer',NULL,1,0,'GreenThreshold',NULL),(27,4,'unit','Unit','group','{\"options\": [\"#\"]}',1,0,'Unit',NULL),(28,4,'value','Value','integer',NULL,1,0,'Value',NULL);
UNLOCK TABLES;

CREATE TABLE `category_parent` (
  `category_id` int DEFAULT NULL,
  `parent_category_id` int DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT '1',
  KEY `category_id` (`category_id`),
  KEY `parent_category_id` (`parent_category_id`),
  CONSTRAINT `category_parent_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `category_parent_ibfk_2` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category_parent` WRITE;
INSERT INTO `category_parent` VALUES (2,1,1),(3,2,1),(4,2,1),(5,2,1),(6,5,1),(2,2,0);
UNLOCK TABLES;

CREATE TABLE `entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `public_id` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `entity_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=884 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `entity` WRITE;
INSERT INTO `entity` VALUES (884,1,'B','2020-09-07 13:44:26'),(887,2,'statement-01','2020-09-07 13:46:03'),(888,2,'statement-02','2020-09-07 13:46:03'),(889,2,'statement-01-01','2020-09-07 13:46:39'),(890,2,'statement-02-01','2020-09-07 13:46:39'),(891,2,'statement-01-01-01','2020-09-07 13:46:59'),(892,2,'statement-01-01-02','2020-09-07 13:46:59'),(893,2,'statement-01-01-03','2020-09-07 13:46:59'),(894,2,'statement-01-01-04','2020-09-07 13:46:59'),(895,2,'statement-02-01-01','2020-09-07 13:46:59'),(896,2,'statement-02-01-02','2020-09-07 13:46:59'),(897,2,'statement-02-01-03','2020-09-07 13:46:59'),(898,2,'statement-02-01-04','2020-09-07 13:46:59'),(899,3,'measure-219','2020-09-07 13:47:12'),(900,3,'measure-220','2020-09-07 13:47:12'),(901,3,'measure-221','2020-09-07 13:47:13'),(902,3,'measure-222','2020-09-07 13:47:13'),(903,3,'measure-223','2020-09-07 13:47:13'),(904,3,'measure-224','2020-09-07 13:47:13'),(905,3,'measure-225','2020-09-07 13:47:13'),(906,3,'measure-226','2020-09-07 13:47:13'),(907,3,'measure-227','2020-09-07 13:47:13'),(908,3,'measure-228','2020-09-07 13:47:13'),(909,3,'measure-229','2020-09-07 13:47:13'),(910,3,'measure-230','2020-09-07 13:47:13'),(911,3,'measure-231','2020-09-07 13:47:13'),(912,3,'measure-232','2020-09-07 13:47:13'),(913,3,'measure-233','2020-09-07 13:47:13'),(914,3,'measure-234','2020-09-07 13:47:13'),(915,4,'communication-04','2020-09-07 13:47:24'),(916,4,'communication-05','2020-09-07 13:47:24'),(917,4,'communication-06','2020-09-07 13:47:24'),(918,4,'communication-07','2020-09-07 13:47:24'),(919,4,'communication-08','2020-09-07 13:47:24'),(920,4,'communication-09','2020-09-07 13:47:24'),(921,4,'communication-10','2020-09-07 13:47:24'),(922,4,'communication-11','2020-09-07 13:47:24'),(923,4,'communication-12','2020-09-07 13:47:24'),(924,4,'communication-13','2020-09-07 13:47:24'),(925,4,'communication-14','2020-09-07 13:47:24'),(926,4,'communication-15','2020-09-07 13:47:25'),(927,4,'communication-16','2020-09-07 13:47:25'),(928,4,'communication-17','2020-09-07 13:47:25'),(929,4,'communication-18','2020-09-07 13:47:25'),(930,4,'communication-19','2020-09-07 13:47:25');
UNLOCK TABLES;

CREATE TABLE `entity_field_entry` (
  `entity_id` int NOT NULL,
  `category_field_id` int NOT NULL,
  `value` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`entity_id`,`category_field_id`),
  KEY `category_field_id` (`category_field_id`),
  CONSTRAINT `entity_field_entry_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entity_field_entry_ibfk_2` FOREIGN KEY (`category_field_id`) REFERENCES `category_field` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `entity_field_entry` WRITE;
INSERT INTO `entity_field_entry` VALUES (884,1,'Borders','2020-09-07 13:44:26','2020-09-07 13:44:26'),(884,2,'Description 1','2020-09-07 13:44:26','2020-09-07 13:44:26'),(887,3,'Statment 1','2020-09-07 13:46:03','2020-09-07 13:46:59'),(887,4,'Some description','2020-09-07 13:46:03','2020-09-07 13:46:59'),(888,3,'Statment 2','2020-09-07 13:46:03','2020-09-07 13:46:59'),(888,4,'Some description','2020-09-07 13:46:03','2020-09-07 13:46:59'),(889,3,'Sub Statement 1','2020-09-07 13:46:39','2020-09-07 13:46:59'),(889,4,'Some description','2020-09-07 13:46:39','2020-09-07 13:46:59'),(890,3,'Sub Statement 1','2020-09-07 13:46:39','2020-09-07 13:46:59'),(890,4,'Some description','2020-09-07 13:46:39','2020-09-07 13:46:59'),(891,3,'Sub Sub Statement 1','2020-09-07 13:46:59','2020-09-07 13:46:59'),(891,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(892,3,'Sub Sub Statement 2','2020-09-07 13:46:59','2020-09-07 13:46:59'),(892,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(893,3,'Sub Sub Statement 3','2020-09-07 13:46:59','2020-09-07 13:46:59'),(893,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(894,3,'Sub Sub Statement 4','2020-09-07 13:46:59','2020-09-07 13:46:59'),(894,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(895,3,'Sub Sub Statement 1','2020-09-07 13:46:59','2020-09-07 13:46:59'),(895,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(896,3,'Sub Sub Statement 2','2020-09-07 13:46:59','2020-09-07 13:46:59'),(896,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(897,3,'Sub Sub Statement 3','2020-09-07 13:46:59','2020-09-07 13:46:59'),(897,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(898,3,'Sub Sub Statement 4','2020-09-07 13:46:59','2020-09-07 13:46:59'),(898,4,'Some description','2020-09-07 13:46:59','2020-09-07 13:46:59'),(899,5,'Measure 1','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,6,'Measure 1','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,13,'#','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,14,'1','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,19,'1','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,20,'2','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,21,'3','2020-09-07 13:47:12','2020-09-07 13:47:12'),(899,22,'statement-01-01-01','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,5,'Measure 2','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,6,'Measure 2','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,13,'#','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,14,'2','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,19,'1','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,20,'2','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,21,'3','2020-09-07 13:47:12','2020-09-07 13:47:12'),(900,22,'statement-01-01-01','2020-09-07 13:47:12','2020-09-07 13:47:12'),(901,5,'Measure 3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,6,'Measure 3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,14,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(901,22,'statement-01-01-02','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,5,'Measure 4','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,6,'Measure 4','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,14,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(902,22,'statement-01-01-02','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,5,'Measure 5','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,6,'Measure 5','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,14,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(903,22,'statement-01-01-03','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,5,'Measure 6','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,6,'Measure 6','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,14,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(904,22,'statement-01-01-03','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,5,'Measure 7','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,6,'Measure 7','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,14,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(905,22,'statement-01-01-04','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,5,'Measure 8','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,6,'Measure 8','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,14,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(906,22,'statement-01-01-04','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,5,'Measure 9','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,6,'Measure 9','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,14,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(907,22,'statement-02-01-01','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,5,'Measure 10','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,6,'Measure 10','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,14,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(908,22,'statement-02-01-01','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,5,'Measure 11','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,6,'Measure 11','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,14,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(909,22,'statement-02-01-02','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,5,'Measure 12','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,6,'Measure 12','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,14,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(910,22,'statement-02-01-02','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,5,'Measure 13','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,6,'Measure 13','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,14,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(911,22,'statement-02-01-03','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,5,'Measure 14','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,6,'Measure 14','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,14,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(912,22,'statement-02-01-03','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,5,'Measure 15','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,6,'Measure 15','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,14,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(913,22,'statement-02-01-04','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,5,'Measure 16','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,6,'Measure 16','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,13,'#','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,14,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,17,'2020-12-31T23:00:00.000Z','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,19,'1','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,20,'2','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,21,'3','2020-09-07 13:47:13','2020-09-07 13:47:13'),(914,22,'statement-02-01-04','2020-09-07 13:47:13','2020-09-07 13:47:13'),(915,7,'Comms 1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,8,'Comms 1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,23,'Comms 1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(915,28,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,7,'Comms 2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,8,'Comms 2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,23,'Comms 2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(916,28,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,7,'Comms 3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,8,'Comms 3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,23,'Comms 3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(917,28,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,7,'Comms 4','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,8,'Comms 4','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,23,'Comms 4','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(918,28,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,7,'Comms 5','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,8,'Comms 5','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,23,'Comms 5','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(919,28,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,7,'Comms 6','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,8,'Comms 6','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,23,'Comms 6','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(920,28,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,7,'Comms 7','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,8,'Comms 7','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,23,'Comms 7','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(921,28,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,7,'Comms 8','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,8,'Comms 8','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,23,'Comms 8','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(922,28,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,7,'Comms 9','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,8,'Comms 9','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,23,'Comms 9','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(923,28,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,7,'Comms 10','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,8,'Comms 10','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,23,'Comms 10','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,26,'3','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,27,'#','2020-09-07 13:47:24','2020-09-07 13:49:03'),(924,28,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(925,7,'Comms 11','2020-09-07 13:47:25','2020-09-07 13:49:03'),(925,8,'Comms 11','2020-09-07 13:47:25','2020-09-07 13:49:03'),(925,23,'Comms 11','2020-09-07 13:47:24','2020-09-07 13:49:03'),(925,24,'1','2020-09-07 13:47:24','2020-09-07 13:49:03'),(925,25,'2','2020-09-07 13:47:24','2020-09-07 13:49:03'),(925,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:03'),(925,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:03'),(925,28,'2','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,7,'Comms 12','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,8,'Comms 12','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,23,'Comms 12','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,24,'1','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,25,'2','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:03'),(926,28,'3','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,7,'Comms 13','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,8,'Comms 13','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,23,'Comms 13','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,24,'1','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,25,'2','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:03'),(927,28,'1','2020-09-07 13:47:25','2020-09-07 13:49:03'),(928,7,'Comms 14','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,8,'Comms 14','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,23,'Comms 14','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,24,'1','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,25,'2','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:04'),(928,28,'2','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,7,'Comms 15','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,8,'Comms 15','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,23,'Comms 15','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,24,'1','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,25,'2','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:04'),(929,28,'3','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,7,'Comms 16','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,8,'Comms 16','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,23,'Comms 16','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,24,'1','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,25,'2','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,26,'3','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,27,'#','2020-09-07 13:47:25','2020-09-07 13:49:04'),(930,28,'1','2020-09-07 13:47:25','2020-09-07 13:49:04');
UNLOCK TABLES;

CREATE TABLE `entity_parent` (
  `entity_id` int NOT NULL,
  `parent_entity_id` int NOT NULL,
  PRIMARY KEY (`entity_id`,`parent_entity_id`),
  KEY `parent_entity_id` (`parent_entity_id`),
  CONSTRAINT `entity_parent_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entity_parent_ibfk_2` FOREIGN KEY (`parent_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `entity_parent` WRITE;
INSERT INTO `entity_parent` VALUES (887,884),(888,884),(889,884),(890,884),(891,884),(892,884),(893,884),(894,884),(895,884),(896,884),(897,884),(898,884),(889,887),(890,888),(891,889),(892,889),(893,889),(894,889),(895,890),(896,890),(897,890),(898,890),(899,891),(900,891),(915,891),(916,891),(901,892),(902,892),(917,892),(918,892),(903,893),(904,893),(919,893),(920,893),(905,894),(906,894),(921,894),(922,894),(907,895),(908,895),(923,895),(924,895),(909,896),(910,896),(925,896),(926,896),(911,897),(912,897),(927,897),(928,897),(913,898),(914,898),(929,898),(930,898);
UNLOCK TABLES;

CREATE TABLE `entity_field_entry_audit` (
  `entity_id` int DEFAULT NULL,
  `category_field_id` int DEFAULT NULL,
  `value` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_at` datetime DEFAULT NULL,
  KEY `entity_id` (`entity_id`),
  KEY `category_field_id` (`category_field_id`),
  CONSTRAINT `entity_field_entry_audit_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entity_field_entry_audit_ibfk_2` FOREIGN KEY (`category_field_id`) REFERENCES `category_field` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


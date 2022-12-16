-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: django
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--


DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Dozent');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,25),(2,1,26),(3,1,27),(4,1,28),(5,1,34),(6,1,35),(7,1,36),(8,1,37),(9,1,38),(10,1,39),(11,1,40),(12,1,41),(13,1,42),(14,1,43),(15,1,44),(16,1,45),(17,1,46),(18,1,47),(19,1,48),(20,1,49),(21,1,50),(22,1,51),(23,1,52),(24,1,53),(25,1,54),(26,1,55),(27,1,56),(28,1,57),(29,1,58),(30,1,59),(31,1,60),(32,1,61),(33,1,62),(34,1,63),(35,1,64),(36,1,65),(37,1,66),(38,1,67),(39,1,68),(40,1,69),(41,1,70),(42,1,71),(43,1,72),(44,1,73);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add project',7,'add_project'),(26,'Can change project',7,'change_project'),(27,'Can delete project',7,'delete_project'),(28,'Can view project',7,'view_project'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Darf Dozentenbereich betreten',8,'can_access_dozentarea'),(34,'Can add role',9,'add_role'),(35,'Can change role',9,'change_role'),(36,'Can delete role',9,'delete_role'),(37,'Can view role',9,'view_role'),(38,'Can add student',10,'add_student'),(39,'Can change student',10,'change_student'),(40,'Can delete student',10,'delete_student'),(41,'Can view student',10,'view_student'),(42,'Can add poll',11,'add_poll'),(43,'Can change poll',11,'change_poll'),(44,'Can delete poll',11,'delete_poll'),(45,'Can view poll',11,'view_poll'),(46,'Can add role question',12,'add_rolequestion'),(47,'Can change role question',12,'change_rolequestion'),(48,'Can delete role question',12,'delete_rolequestion'),(49,'Can view role question',12,'view_rolequestion'),(50,'Can add project question',13,'add_projectquestion'),(51,'Can change project question',13,'change_projectquestion'),(52,'Can delete project question',13,'delete_projectquestion'),(53,'Can view project question',13,'view_projectquestion'),(54,'Can add skill',14,'add_skill'),(55,'Can change skill',14,'change_skill'),(56,'Can delete skill',14,'delete_skill'),(57,'Can view skill',14,'view_skill'),(58,'Can add project answer',13,'add_projectanswer'),(59,'Can change project answer',13,'change_projectanswer'),(60,'Can delete project answer',13,'delete_projectanswer'),(61,'Can view project answer',13,'view_projectanswer'),(62,'Can add role answer',12,'add_roleanswer'),(63,'Can change role answer',12,'change_roleanswer'),(64,'Can delete role answer',12,'delete_roleanswer'),(65,'Can view role answer',12,'view_roleanswer'),(66,'Can add skill answer',15,'add_skillanswer'),(67,'Can change skill answer',15,'change_skillanswer'),(68,'Can delete skill answer',15,'delete_skillanswer'),(69,'Can view skill answer',15,'view_skillanswer'),(70,'Can add assignment',16,'add_assignment'),(71,'Can change assignment',16,'change_assignment'),(72,'Can delete assignment',16,'delete_assignment'),(73,'Can view assignment',16,'view_assignment'),(74,'Can add section control',17,'add_sectioncontrol'),(75,'Can change section control',17,'change_sectioncontrol'),(76,'Can delete section control',17,'delete_sectioncontrol'),(77,'Can view section control',17,'view_sectioncontrol');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (9,'pbkdf2_sha256$320000$6RfeEW6HJqD6DHLVWQuVE2$w9rsNNieHYo9U77SALpCifdDA5Vnr8Akq9R5valJhyA=','2022-06-24 02:49:55.706603',1,'dozent','','','',1,1,'2022-06-24 00:39:01.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (5,9,1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (9,9,1),(10,9,2),(11,9,3),(12,9,4),(13,9,5),(14,9,6),(15,9,7),(16,9,8),(17,9,9),(18,9,10),(19,9,11),(20,9,12),(21,9,13),(22,9,14),(23,9,15),(24,9,16),(25,9,17),(26,9,18),(27,9,19),(28,9,20),(29,9,21),(30,9,22),(31,9,23),(32,9,24),(33,9,25),(34,9,26),(35,9,27),(36,9,28),(37,9,29),(38,9,30),(39,9,31),(40,9,32),(41,9,33),(42,9,34),(43,9,35),(44,9,36),(45,9,37),(46,9,38),(47,9,39),(48,9,40),(49,9,41),(50,9,42),(51,9,43),(52,9,44),(53,9,45),(54,9,46),(55,9,47),(56,9,48),(57,9,49),(58,9,50),(59,9,51),(60,9,52),(61,9,53),(62,9,54),(63,9,55),(64,9,56),(65,9,57),(66,9,58),(67,9,59),(68,9,60),(69,9,61),(70,9,62),(71,9,63),(72,9,64),(73,9,65),(74,9,66),(75,9,67),(76,9,68),(77,9,69),(78,9,70),(79,9,71),(80,9,72),(81,9,73),(82,9,74),(83,9,75),(84,9,76),(85,9,77);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (417,'2022-06-24 00:46:55.429925','1','superdev',3,'',4,9),(418,'2022-06-24 01:38:08.868758','4','poll Donald Hogan - s00004',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(419,'2022-06-24 01:38:15.552631','5','poll Jaeden Lambert - s00005',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(420,'2022-06-24 01:38:26.803254','61','poll Peter Lustig - s21212',3,'',11,9),(421,'2022-06-24 01:38:34.094486','6','poll Vivian Mcguire - s00006',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(422,'2022-06-24 01:38:40.634268','3','poll Ruth Munoz - s00003',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(423,'2022-06-24 01:38:47.302895','2','poll Meg Nicholls - s00002',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(424,'2022-06-24 01:38:53.065455','1','poll Bob Wilkins - s00001',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(425,'2022-06-24 01:40:22.886697','1','poll Bob Wilkins - s00001',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(426,'2022-06-24 01:40:40.434604','29','poll Kimmy Izard - s00029',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(427,'2022-06-24 01:40:56.151732','25','poll Carlota Skilbeck - s00025',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(428,'2022-06-24 01:41:15.723685','21','poll Berkeley Besque - s00021',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(429,'2022-06-24 01:41:28.266670','35','poll Lucius Skeldinge - s00035',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(430,'2022-06-24 01:41:47.335809','17','poll Kali Marris - s00017',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(431,'2022-06-24 01:42:00.294693','7','poll Franklin Hawes - s00007',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(432,'2022-06-24 01:42:18.389471','6','poll Vivian Mcguire - s00006',2,'[{\"changed\": {\"fields\": [\"Is wing\"]}}]',11,9),(433,'2022-06-24 01:43:00.855579','61','Peter Lustig - s21212',3,'',10,9),(434,'2022-06-24 01:47:30.769458','40','Maxim Haschke (s81781) - Konzepte und Tools für Test, z.B. Testfälle, Testabdeckung, Testplanung , JUnit, usw.',3,'',15,9);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(16,'teamverwaltung_main','assignment'),(11,'teamverwaltung_main','poll'),(7,'teamverwaltung_main','project'),(13,'teamverwaltung_main','projectanswer'),(9,'teamverwaltung_main','role'),(12,'teamverwaltung_main','roleanswer'),(17,'teamverwaltung_main','sectioncontrol'),(14,'teamverwaltung_main','skill'),(15,'teamverwaltung_main','skillanswer'),(10,'teamverwaltung_main','student'),(8,'teamverwaltung_main','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-01-17 22:26:19.483994'),(2,'auth','0001_initial','2022-01-17 22:26:21.533984'),(3,'admin','0001_initial','2022-01-17 22:26:22.110993'),(4,'admin','0002_logentry_remove_auto_add','2022-01-17 22:26:22.180598'),(5,'admin','0003_logentry_add_action_flag_choices','2022-01-17 22:26:22.245981'),(6,'contenttypes','0002_remove_content_type_name','2022-01-17 22:26:22.538987'),(7,'auth','0002_alter_permission_name_max_length','2022-01-17 22:26:22.681980'),(8,'auth','0003_alter_user_email_max_length','2022-01-17 22:26:22.790988'),(9,'auth','0004_alter_user_username_opts','2022-01-17 22:26:22.858980'),(10,'auth','0005_alter_user_last_login_null','2022-01-17 22:26:23.023010'),(11,'auth','0006_require_contenttypes_0002','2022-01-17 22:26:23.083981'),(12,'auth','0007_alter_validators_add_error_messages','2022-01-17 22:26:23.148980'),(13,'auth','0008_alter_user_username_max_length','2022-01-17 22:26:23.294993'),(14,'auth','0009_alter_user_last_name_max_length','2022-01-17 22:26:23.447994'),(15,'auth','0010_alter_group_name_max_length','2022-01-17 22:26:23.552980'),(16,'auth','0011_update_proxy_permissions','2022-01-17 22:26:23.702985'),(17,'auth','0012_alter_user_first_name_max_length','2022-01-17 22:26:23.863983'),(18,'sessions','0001_initial','2022-01-17 22:26:24.117976'),(19,'teamverwaltung_main','0001_initial','2022-01-17 22:26:24.385981'),(20,'teamverwaltung_main','0002_user','2022-01-18 10:59:01.388871'),(21,'teamverwaltung_main','0003_project_isactive_delete_user','2022-02-03 13:38:30.320654'),(22,'teamverwaltung_main','0004_role_student_poll','2022-04-13 17:20:29.624281'),(23,'teamverwaltung_main','0004_role_student_poll_rolequestion_projectquestion','2022-04-15 10:39:43.994793'),(24,'teamverwaltung_main','0005_skill_rename_projectquestion_projectanswer_and_more','2022-04-15 22:03:43.617939'),(25,'teamverwaltung_main','0006_rename_name_student_last_name_student_faculty_and_more','2022-05-06 21:38:20.113621'),(29,'teamverwaltung_main','0007_alter_student_faculty','2022-05-08 11:30:04.289674'),(30,'teamverwaltung_main','0007_sectioncontrol','2022-05-19 12:53:10.293974'),(31,'teamverwaltung_main','0008_skill_abbreviation','2022-05-23 20:44:29.937082');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0bh2kp9gdq3lhjvlcvby1eofohakag8r','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nvDwH:HV_27nHFclwv5WKOw6PIJm-1bDV3mBZKn8l4mxZke5M','2022-06-12 08:06:17.286562'),('0ek35hrfv50olk4nvckm8fo9ogjp6xci','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nnjlh:ZDUrl3zUtfqb-bzo4IC8KcxdGnzX4Gtw3IrXdTmfCJQ','2022-05-22 16:28:25.140126'),('1ezigkpyn5jpq91y9qafp2mdodsa34sj','.eJxVjLEOwiAYBt-F2TS1vyC4WR0dfAPyA19tY2mTAjoY311NHHS9u9xDWC65tyVhsUMQO6HE6pc59ldMH5HB8YblzmMu08VGHqYqzgFjqg4l5Tmejvtz-83_Hj2n_j1gyM4BtQZv12DykKSkChoUHBrXkGSjawmQ00ZpZ2oTjPZMG5K-M-L5AglkOis:1nuxed:1N2zXKCnCBbvWnFyMhhb_mtb77QgNTE5pVbluHooYRE','2022-06-11 14:42:59.418654'),('1tr4uwudk5jqsn2p58qhskl9f52bfkpd','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nxsce:2PjNRne3ju_31ok9hODrvTB1bIz-D_kebUEStAwnZKw','2022-06-19 15:57:00.568205'),('2l2h2d9sb9qzkurp41tbt9teo0epx8p2','.eJxVjE0OwiAYRO_C2hApRYpL9z1D8_0hVQNJaVfGu0uTLnQ3mfdm3mqCbU3TVmWZZlZXZdTpt0Ogp-Qd8APyvWgqeV1m1LuiD1r1WFhet8P9O0hQU1uLt73hHuPFSeAh-hAZEAnAkxFg1wI4cWjQSnNs6CyZQB3a4WwB1OcLIKk5RQ:1o1U8W:AYsGodvapHpQgYMCeyksFZA6y3aQ3e31Uq0nQq-NC2g','2022-06-29 14:36:48.966486'),('329abzoqmcu8e3p8mlp69lulztoiprv1','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nlVGC:1PwnRcxzURpWQlgxfa4xtH2XN8jKnxo80SrcpRGY5Ec','2022-05-16 12:34:40.674510'),('3oiynvlv8tjkwh0aujo00bi2u0tn0ko5','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nfqWA:2LavjjguT6zdIAnxybz_6UvXcUIb0lkxQ3Bd1oh3taA','2022-04-30 22:03:46.829952'),('420u7filtvmz57bkogfo6qeqvk9lmi1r','.eJxVjDsKwzAQRO-iOghJ6OeU6XMGsatdR06CBJZdmdw9NrhIqoF5b2YTCdalpLXznCYSVzGIy2-HkF9cD0BPqI8mc6vLPKE8FHnSLu-N-H073b-DAr3sayQgraO12ShAVAYiokVNNox-1MYBDsp5AhPAKATgzDrYGJ3fk1F8vgUiOJ8:1o4YXb:G0DreLv8LUQJKQu2QdY2IapJe24gDJJtC6DFS5Eoa7o','2022-07-08 01:55:23.414664'),('4aplhc3dcl9gtyeae6vftf90iz3zfkgs','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nvLRB:XpzC2Zw9F_7wBqSTGsAj3c2kZOPA1VPlHEdW9D_Aq1A','2022-06-12 16:06:41.176096'),('6cw3ftbsnf0yuzbliat69fqhfptrossm','.eJxVjMEOwiAQRP-FsyEuSAGP3vsNhN0FqRpISnsy_rtt0oPeJvPezFuEuC4lrD3NYWJxFUqcfjuM9Ex1B_yI9d4ktbrME8pdkQftcmycXrfD_TsosZdtjfpsiXlgp43lTJhBwZZpUE6pTNab7CHhxaMDS9mwZvAakwVg75z4fAHuLzft:1nFcoE:GRqknVIHv9BMgfJZNpTAXTXzICDX8__2hKy36xiUbLs','2022-02-17 14:10:02.204397'),('76fgm1mpuwql31ktmxaf1kj26ymnr3av','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nFdFp:2WN37_Cm_SWBtgPe3GhkS7u8O42LNaf4-tUYWYeeEfg','2022-02-17 14:38:33.382103'),('7e1rikj12ghahybkittjx9xg33wcjipr','.eJxVjE0OwiAYRO_C2hApRYpL9z1D8_0hVQNJaVfGu0uTLnQ3mfdm3mqCbU3TVmWZZlZXZdTpt0Ogp-Qd8APyvWgqeV1m1LuiD1r1WFhet8P9O0hQU1uLt73hHuPFSeAh-hAZEAnAkxFg1wI4cWjQSnNs6CyZQB3a4WwB1OcLIKk5RQ:1o4KiJ:8lfXe_nlRzO6F7No9UAHRRuHLNIEvt0XSxz1BS-QLwc','2022-07-07 11:09:31.440144'),('7vepiuwiwbrh0nv8c60ihdxi8zfkehft','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nfVPt:Q3oyEGEDLA7gnBzyvJAvUKmjvus2msg3AkcAzITuyL8','2022-04-29 23:31:53.235683'),('9d5szvqixs5uozz9ujdb7pbgx5qg9a58','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nCIFY:GE_L0hVhvgipzSF_o7FwBW9OiKiLbYfluBipyVMqiRs','2022-02-08 09:36:28.385739'),('9sinfjw01wjw63fi8zscoruvfxxfdl3m','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nupoh:qHBxGcovQB6cfJ9NH30a0TGPRwzmqsqHQXmn9rhmx-g','2022-06-11 06:20:51.793034'),('co2mtvcv7ralo5cfeg2st8dprqq5xhsv','.eJxVjEEOwiAQRe_C2pAKZVpcuu8ZyAzMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJc1IX5dXpdyOMDy47SHcst6pjLesyk94VfdCmp5r4eT3cv4OMLX9rMcQuEfcwkDe2g0gkkLz3YCzImWIHo3NJ0DoUE8eOLWPfe4mjDAOo9wcDJTiD:1o4ZON:oYWA1NEqhdjCFfFK54VHRz61cOCDANX-tc-hDCn1xmE','2022-07-08 02:49:55.790539'),('d3p5zwgyrs8r8c78jgqmib4d9imz4ni2','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nqxWJ:_C725G5aH6mR53q7Lw6CEIXuJ_JL9HSpIHoZd8gZuyA','2022-05-31 13:45:51.024455'),('d8cuyji9bniw9cgeo5pi7k1lc85v2kgl','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nfJha:PI8MIfTaZbkCqhz598F2iYNoJBL1w_Bz8zxb5ak5ywM','2022-04-29 11:01:22.674440'),('dgt37iptipmuyh0prwtcttl2m3kfl2x8','.eJxVjDkOwjAQAP_iGiEnxMfScZQU_MBa27skIk6k2IYC8XdAooB2ZjQP4bCW3tVMixui2AotVr_MY7jS9BGFMN1oueNY6nRxCYdpneZIY14fai5zOh135_03_3v0mPv3wMSgO88WOwmAbMFLG6VmoECSLaM3SK2KjQ7A7SaQaryKlgwrAGOseL4AAMs6Qg:1o400e:-YhU-1JpyVQIHhvHLFYLZRZPwFimO32oJO3sxRysOE8','2022-07-06 13:03:04.556411'),('dw9pem4zi9qt1b8drbcz0ihk603d2vdn','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nprFh:pYVZxZFAq8f_4zxHcu7HqyPEIIOGMLFLm3_4sBwcKAI','2022-05-28 12:52:09.250427'),('ebqqerqbuimrdpig13q796s7br464rl7','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nxBBb:8BPePzdwAXXOyIewcdY_PhVY0u3WgUAHneyBj5ngM7g','2022-06-17 17:34:11.151912'),('efs5vi3j6vfg1u7vmlltpuvqcrlydt7x','.eJxVjDsKwzAQRO-iOghJ6OeU6XMGsatdR06CBJZdmdw9NrhIqoF5b2YTCdalpLXznCYSVzGIy2-HkF9cD0BPqI8mc6vLPKE8FHnSLu-N-H073b-DAr3sayQgraO12ShAVAYiokVNNox-1MYBDsp5AhPAKATgzDrYGJ3fk1F8vgUiOJ8:1o4YbD:LOw879nrNZHpDGqozDCat0gmX5dWr9v2RrPHtFgrJ7s','2022-07-08 01:59:07.905906'),('eiyw52jl15w7ha1jzjfeyqbtpcewcun7','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1ng71c:puTsQeaPbOqMmtMmd5KNPLTWG06FGv5R2Ie0EM_oCyc','2022-05-01 15:41:20.392758'),('gt2ol2y0t9bi9pg2e25atcjewal6vx8s','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nEg85:ouXFTYSDYqyzf2tExCRSz44dd6IsG_Ht28Qgp-xmJkY','2022-02-14 23:30:37.647023'),('hbzqcgbkbwadzdcwlbxbe5gzv83cokva','.eJxVjEEOgjAQRe_StWlop8jg0j1nIDOdqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzMc6cfjem-NC8A7lTvhUbS16Xme2u2INWOxTR5_Vw_w4mqtO3ZiTRBAk4dAgJufN9GyU15IKK8BnBdW0KPbjYRq8eXPLoCQIGbVjM-wMANTgy:1nj1Ap:Gh3t_AHUQ89lBRErDOElDUkASuraWYi13FnCk576FUg','2022-05-09 16:02:51.479107'),('hu2wg4ctd3vdoc60rr1kcs7lp5q6ejyp','.eJxVjEEOwiAQRe_C2pAKZVpcuu8ZyAzMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJc1IX5dXpdyOMDy47SHcst6pjLesyk94VfdCmp5r4eT3cv4OMLX9rMcQuEfcwkDe2g0gkkLz3YCzImWIHo3NJ0DoUE8eOLWPfe4mjDAOo9wcDJTiD:1o4ZEF:1o2j84ydMqBdhykFwDZrdpZ-pD_nrYJUIYNndBTHhi0','2022-07-08 02:39:27.330664'),('iji6b0yaydqq8s49xi1t9ys4jwdq90yd','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nqdK8:tfuoEtxSUVhRl5WlSWXicJbISc-qyUB_a6gvefj8_Sw','2022-05-30 16:11:56.225048'),('inpk7ocistmink7s1609nibmyx5a820z','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nuan3:RITcMMbzQOW-mM5dGxoP-YYnmbmvYO7JX3RO8ohSPVI','2022-06-10 14:18:09.404262'),('iqos345q2m4phk75ab82amkiw9ycyrvv','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nqEMW:WJhH2SwruVhHiofcxQUeI41Y-7Jrh5Jn1bsvigW0hSg','2022-05-29 13:32:44.170325'),('jp8fw0qwgctr9jzg4sdp61tgrremdnnj','.eJxVjEEOgjAQRe_StWlop8jg0j1nIDOdqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzMc6cfjem-NC8A7lTvhUbS16Xme2u2INWOxTR5_Vw_w4mqtO3ZiTRBAk4dAgJufN9GyU15IKK8BnBdW0KPbjYRq8eXPLoCQIGbVjM-wMANTgy:1no4E0:k32ruCvpHoq5roorhGA2ose8l_uJLO4r1rvOmRqF1Uc','2022-05-23 14:19:00.877456'),('jzrp9uhm79hbd5aaisykc1d0mv8io2cg','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nsrid:k4-jMzstqjocbtis8yirW6dfwBeOQ380bQkKrZ6UDmc','2022-06-05 19:58:27.580800'),('k1p3e5q4teaboxwyu4bcjql2emb1rx53','.eJxVjE0OwiAYRO_C2hApRYpL9z1D8_0hVQNJaVfGu0uTLnQ3mfdm3mqCbU3TVmWZZlZXZdTpt0Ogp-Qd8APyvWgqeV1m1LuiD1r1WFhet8P9O0hQU1uLt73hHuPFSeAh-hAZEAnAkxFg1wI4cWjQSnNs6CyZQB3a4WwB1OcLIKk5RQ:1o3ztp:FvTwiqXeMpHetJRl1ey-pifU_13XQsP0pHCly_Tzyog','2022-07-06 12:56:01.842846'),('k4hyv5njl9rybcl6tiwzoofxhewq88g6','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1npqIb:3HHLM5VVkU6hISLexc9Mfc1dXnufFJFoMHMVn5nrGgY','2022-05-28 11:51:05.512770'),('k6rmwh0cryzawgqi1tp06tfc6jlhj7i9','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nvK3x:xDcoNTidkb9aIeukbuDhJTDFkGhCOlsbhogK0A5vdDg','2022-06-12 14:38:37.510539'),('kaycn37oxijj36v2olf961kysvoxui0m','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nWj6T:vOUZqbg1ltE1j1YLedhzC0Zmg384HxVn_i6dvsiGzaQ','2022-04-05 18:19:33.854861'),('llb3gf6oh4kwqmx1yfnff001u52ppwpp','.eJxVjE0OwiAYRO_C2hApRYpL9z1D8_0hVQNJaVfGu0uTLnQ3mfdm3mqCbU3TVmWZZlZXZdTpt0Ogp-Qd8APyvWgqeV1m1LuiD1r1WFhet8P9O0hQU1uLt73hHuPFSeAh-hAZEAnAkxFg1wI4cWjQSnNs6CyZQB3a4WwB1OcLIKk5RQ:1o4JIc:UAI-mgXIEXh-XVTdzcGtuNXDXi3g2IiJpFWJe7pkHks','2022-07-07 09:38:54.691588'),('lwi34utgi8at3wkg3vfpu8pco29j2gvy','.eJxVjDkOwjAQAP_iGiEnxMfScZQU_MBa27skIk6k2IYC8XdAooB2ZjQP4bCW3tVMixui2AotVr_MY7jS9BGFMN1oueNY6nRxCYdpneZIY14fai5zOh135_03_3v0mPv3wMSgO88WOwmAbMFLG6VmoECSLaM3SK2KjQ7A7SaQaryKlgwrAGOseL4AAMs6Qg:1o1uuj:Go8O5NW-MYjfj77P1qPzveeaSnCp1FGJaOTgXTbDn_4','2022-06-30 19:12:21.083350'),('o9ia6nq47wfqy044jdsk9r151ah2yoqj','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1njKL9:TvYCA0ciR3XpOLsrTgx27ifsodiJd1JxVU6KTtKDXxs','2022-05-10 12:30:47.347377'),('ojn05ejm2k4uwotft6rxwkgsurj0tlyf','.eJxVjE0OwiAYRO_C2hApRYpL9z1D8_0hVQNJaVfGu0uTLnQ3mfdm3mqCbU3TVmWZZlZXZdTpt0Ogp-Qd8APyvWgqeV1m1LuiD1r1WFhet8P9O0hQU1uLt73hHuPFSeAh-hAZEAnAkxFg1wI4cWjQSnNs6CyZQB3a4WwB1OcLIKk5RQ:1nyhnp:CRY4WSbHfWzvHcGNcEPqMrW4j6yeLC4P5A00mdvcqGY','2022-06-21 22:35:57.974513'),('p02tf4rftmwqsao1w6n2kt0eqyq2b4p2','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nC5oD:DTJRH4hy_X_bhACnLlbF0RfiMqXHU23SJtqUSEaJ49s','2022-02-07 20:19:25.044819'),('pnuvaxt6eoamyw3bln923q6doz45qx4f','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1njdb6:gG7zzIy4ODMEJ0EMa59iILVa1mNGfGgFyjQ0bPP7ApE','2022-05-11 09:04:32.314681'),('qwhdg0iy2btzi9hsez2ywzgzxvbh2d9d','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1ndtnk:pkln6D2DvIIMEXIQj2CkSNSkbntfUIV5MP2btkvc5Lg','2022-04-25 13:09:52.322319'),('r6fhdxpayy9923ry2ran79h1awsg1tly','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nXTZl:j3ecsF3GYfVGBzQoslb5t5unpQkr5wUgrjcsdIz6J0c','2022-04-07 19:56:53.980162'),('r9ryodvtzmg84wp8w69qzd8lp1036vj1','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1niZd1:CJEd9v5aIg6r7pX-TFlxBDmhgwbML49wAAUkNtVzf3Q','2022-05-08 10:38:07.868958'),('rhfdencwga7386w6tvdais1xxypsy6yd','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nfJPr:uAIS1nusUJmA45DKOOVjIyysgkRE0l6Vu0m4OVRXK38','2022-04-29 10:43:03.034723'),('sxuv0diexwtrsmd6ug1xe9bu54an64so','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nknEA:OnBmGz5hGUemb3XBC7TOJxiD2od_sth7ntm8GC6xnkY','2022-05-14 13:33:38.457119'),('tzzcx10jgjeczdrmtx45ef1kxdekbld0','.eJxVjEEOgjAQRe_StWlop8jg0j1nIDOdqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzMc6cfjem-NC8A7lTvhUbS16Xme2u2INWOxTR5_Vw_w4mqtO3ZiTRBAk4dAgJufN9GyU15IKK8BnBdW0KPbjYRq8eXPLoCQIGbVjM-wMANTgy:1nj17j:ipmpSMRmrdixHAhlYyq9uZ54Ud_atZW5nolngGR1ToA','2022-05-09 15:59:39.333162'),('virriliha2kmz3m6odvx25q3tfi24ait','.eJxVjMEOwiAQRP-FsyEuSAGP3vsNhN0FqRpISnsy_rtt0oPeJvPezFuEuC4lrD3NYWJxFUqcfjuM9Ex1B_yI9d4ktbrME8pdkQftcmycXrfD_TsosZdtjfpsiXlgp43lTJhBwZZpUE6pTNab7CHhxaMDS9mwZvAakwVg75z4fAHuLzft:1nX0bp:Rc2h8fKoMELsDujHiZItoqPn4Shg8MK5_pOzXcy_4Kc','2022-04-06 13:01:05.906466'),('vj0yeebnqqah8roxevk4ghx36ebj1yxi','.eJxVjDkOwjAQAP_iGiEnxMfScZQU_MBa27skIk6k2IYC8XdAooB2ZjQP4bCW3tVMixui2AotVr_MY7jS9BGFMN1oueNY6nRxCYdpneZIY14fai5zOh135_03_3v0mPv3wMSgO88WOwmAbMFLG6VmoECSLaM3SK2KjQ7A7SaQaryKlgwrAGOseL4AAMs6Qg:1o40JS:OjI7ZOXQmCdhpVh64NWCxCweVYtPjsKh47UjbXqdaKo','2022-07-06 13:22:30.780514'),('wgrzl1j1luklx7mr434468qmesribm16','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nonDs:s0oStEoIAnCVAjLB_gG2VpTrIPpDaYK1Bjt7NPQpXaY','2022-05-25 14:21:52.927736'),('x98o3erjxljkoa1l1v4lu9uzjewdb4uv','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1no40u:esoY-UdVQOTmJ91PvgX2k0z-7qKOZlSqO2JXISdr0E8','2022-05-23 14:05:28.319250'),('xql7h79dvlmgbhxwm6clyftpe9bzwu7j','.eJxVjLEOwiAYBt-F2TS1vyC4WR0dfAPyA19tY2mTAjoY311NHHS9u9xDWC65tyVhsUMQO6HE6pc59ldMH5HB8YblzmMu08VGHqYqzgFjqg4l5Tmejvtz-83_Hj2n_j1gyM4BtQZv12DykKSkChoUHBrXkGSjawmQ00ZpZ2oTjPZMG5K-M-L5AglkOis:1ntRYF:lUTwGyvfKGBMlDE2Mjyou0U0aWFmCCPqSiJqdPohOoE','2022-06-07 10:14:07.728995'),('yhw40a3w3amkxr3wxyl8jqv0clwgipgn','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nq0tR:0oQ-c-5TICV7IXRChisln9EqXEWA6lLgWgqPgb0yGuU','2022-05-28 23:09:49.612890'),('yiz2asb4huid4qx8jsd0cq0y9ecz3uhy','.eJxVjDsOwyAQRO9CHSFgFxanTO8zIL7BSYQlY1dR7h5bcpFUI817M2_m_LZWt_W8uCmxK5Ps8tsFH5-5HSA9fLvPPM5tXabAD4WftPNxTvl1O92_g-p73dcRlVBaISXjQdgSNQ5SBan2MBEDFCpEKJURyYLWhEYAINkcaAig2ecLosI19Q:1nq0lO:FLIf-Ww4RaFJb3Cg2V3tel6hBEpZDSYHcjTvpGpZzYY','2022-05-28 23:01:30.109022');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_assignment`
--

DROP TABLE IF EXISTS `teamverwaltung_main_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_assignment` (
  `student_id` bigint NOT NULL,
  `project_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`student_id`),
  KEY `teamverwaltung_main__project_id_dbf10315_fk_teamverwa` (`project_id`),
  KEY `teamverwaltung_main__role_id_cb3658d0_fk_teamverwa` (`role_id`),
  CONSTRAINT `teamverwaltung_main__project_id_dbf10315_fk_teamverwa` FOREIGN KEY (`project_id`) REFERENCES `teamverwaltung_main_project` (`id`),
  CONSTRAINT `teamverwaltung_main__role_id_cb3658d0_fk_teamverwa` FOREIGN KEY (`role_id`) REFERENCES `teamverwaltung_main_role` (`id`),
  CONSTRAINT `teamverwaltung_main__student_id_d1133a67_fk_teamverwa` FOREIGN KEY (`student_id`) REFERENCES `teamverwaltung_main_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_assignment`
--

LOCK TABLES `teamverwaltung_main_assignment` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_assignment` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_assignment` VALUES (1,10,4),(2,17,1),(3,10,4),(4,17,2),(5,17,5),(6,11,5),(7,11,2),(8,17,5),(9,17,4),(10,11,2),(11,11,5),(12,11,4),(13,17,4),(14,10,3),(15,10,4),(16,17,4),(17,17,5),(18,10,2),(19,11,2),(20,17,2),(21,10,5),(22,11,5),(23,10,2),(24,11,1),(25,11,3),(26,10,2),(27,11,3),(28,17,2),(29,17,4),(30,10,3),(31,10,1),(32,17,3),(33,17,3),(34,10,5),(35,10,3),(36,11,4),(37,11,3),(38,10,4),(39,17,3),(40,11,4),(45,10,5);
/*!40000 ALTER TABLE `teamverwaltung_main_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_poll`
--

DROP TABLE IF EXISTS `teamverwaltung_main_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_poll` (
  `student_id` bigint NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `is_wing` tinyint(1) NOT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `teamverwaltung_main__student_id_3f013fb8_fk_teamverwa` FOREIGN KEY (`student_id`) REFERENCES `teamverwaltung_main_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_poll`
--

LOCK TABLES `teamverwaltung_main_poll` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_poll` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_poll` VALUES (1,'2022-04-15 23:15:04.476203',1),(2,'2022-04-17 16:07:00.000000',0),(3,'2022-04-17 16:07:00.000000',0),(4,'2022-04-17 16:07:00.000000',0),(5,'2022-04-17 16:07:00.000000',0),(6,'2022-04-17 16:07:00.000000',1),(7,'2022-04-17 16:07:55.000000',1),(8,'2022-04-17 16:07:55.000000',0),(9,'2022-04-17 16:07:55.000000',0),(10,'2022-04-17 16:07:55.000000',0),(11,'2022-04-17 16:07:55.000000',0),(12,'2022-04-17 16:07:55.000000',0),(13,'2022-04-17 16:07:55.000000',0),(14,'2022-04-17 16:07:56.000000',0),(15,'2022-04-17 16:07:56.000000',0),(16,'2022-04-17 16:07:56.000000',0),(17,'2022-04-17 16:07:56.000000',1),(18,'2022-04-17 16:07:56.000000',0),(19,'2022-04-17 16:07:56.000000',0),(20,'2022-04-17 16:07:56.000000',0),(21,'2022-04-17 16:07:56.000000',1),(22,'2022-04-17 16:07:56.000000',0),(23,'2022-04-17 16:07:56.000000',0),(24,'2022-04-17 16:07:56.000000',0),(25,'2022-04-17 16:07:57.000000',1),(26,'2022-04-17 16:07:57.000000',0),(27,'2022-04-17 16:07:57.000000',0),(28,'2022-04-17 16:07:57.000000',0),(29,'2022-04-17 16:07:57.000000',1),(30,'2022-04-17 16:07:57.000000',0),(31,'2022-04-17 16:07:57.000000',0),(32,'2022-04-17 16:07:57.000000',0),(33,'2022-04-17 16:07:57.000000',0),(34,'2022-04-17 16:07:57.000000',0),(35,'2022-04-17 16:07:57.000000',1),(36,'2022-04-17 16:07:58.000000',0),(37,'2022-04-17 16:07:58.000000',0),(38,'2022-04-17 16:07:58.000000',0),(39,'2022-04-17 16:07:58.000000',0),(40,'2022-04-17 16:07:58.000000',0),(45,'2022-06-22 13:31:22.326419',0);
/*!40000 ALTER TABLE `teamverwaltung_main_poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_project`
--

DROP TABLE IF EXISTS `teamverwaltung_main_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1023) NOT NULL,
  `responsible` varchar(255) NOT NULL,
  `documentfile_url` varchar(255) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_project`
--

LOCK TABLES `teamverwaltung_main_project` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_project` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_project` VALUES (10,'E3_FutureCity Projects','Unsere Software ist eine „Digitale Projektwerkstatt“, mit der Kommunen Bürgerbeteiligungsverfahren aufsetzen können, bei denen Bürger*innen kollaborativ Bürgerprojekte planen.','Norbert Rost','https://bildungsportal.sachsen.de/opal/downloadering?fibercode=l2x9jep6',1),(11,'E1_Ressourcenverwaltung','Für die wöchentliche Ressourcenplanung in der Abteilung ist eine Übersicht von Mitarbeitern im Bereich essenziell. Jedem Mitarbeiter wird dabei die Arbeit in einem oder mehreren Projekt(en) zugeordnet.','Herr Zirkelbach','https://bildungsportal.sachsen.de/opal/downloadering?fibercode=l2x9kdk8',1),(17,'I7_Teamverwaltung','An der HTW werden für die Lehre im Fach „Software Engineering“ realitätsnahe Projekte in\nGruppenarbeit durchgeführt. Die Projekte beginnen im Modul SE I, an dem neben verschiedenen\nInformatikstudiengängen auch Studierende des Wirtschaftsingenieurwesens teilnehmen.','Christoph Zirkelbach','https://bildungsportal.sachsen.de/opal/downloadering?fibercode=l2x9kdk8',1);
/*!40000 ALTER TABLE `teamverwaltung_main_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_projectanswer`
--

DROP TABLE IF EXISTS `teamverwaltung_main_projectanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_projectanswer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` bigint unsigned NOT NULL,
  `project_id` bigint NOT NULL,
  `poll_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teamverwaltung_main__project_id_14885c5e_fk_teamverwa` (`project_id`),
  KEY `teamverwaltung_main__poll_id_98974004_fk_teamverwa` (`poll_id`),
  CONSTRAINT `teamverwaltung_main__poll_id_98974004_fk_teamverwa` FOREIGN KEY (`poll_id`) REFERENCES `teamverwaltung_main_poll` (`student_id`),
  CONSTRAINT `teamverwaltung_main__project_id_14885c5e_fk_teamverwa` FOREIGN KEY (`project_id`) REFERENCES `teamverwaltung_main_project` (`id`),
  CONSTRAINT `teamverwaltung_main_projectanswer_chk_1` CHECK ((`score` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_projectanswer`
--

LOCK TABLES `teamverwaltung_main_projectanswer` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_projectanswer` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_projectanswer` VALUES (2,4,10,1),(3,1,11,1),(4,1,17,1),(6,5,10,2),(7,1,11,2),(8,5,17,2),(10,5,10,3),(11,4,11,3),(12,5,17,3),(14,2,10,4),(15,2,11,4),(16,2,17,4),(18,2,10,5),(19,5,11,5),(20,5,17,5),(22,4,10,6),(23,4,11,6),(24,2,17,6),(26,5,10,7),(27,5,11,7),(28,2,17,7),(30,3,10,8),(31,5,11,8),(32,5,17,8),(34,1,10,9),(35,2,11,9),(36,3,17,9),(38,3,10,10),(39,3,11,10),(40,1,17,10),(42,3,10,11),(43,4,11,11),(44,2,17,11),(46,1,10,12),(47,5,11,12),(48,3,17,12),(50,3,10,13),(51,3,11,13),(52,5,17,13),(54,4,10,14),(55,3,11,14),(56,3,17,14),(58,5,10,15),(59,3,11,15),(60,2,17,15),(62,1,10,16),(63,1,11,16),(64,3,17,16),(66,2,10,17),(67,4,11,17),(68,4,17,17),(70,4,10,18),(71,1,11,18),(72,4,17,18),(74,1,10,19),(75,5,11,19),(76,4,17,19),(78,2,10,20),(79,1,11,20),(80,2,17,20),(82,5,10,21),(83,4,11,21),(84,3,17,21),(86,3,10,22),(87,5,11,22),(88,1,17,22),(90,5,10,23),(91,4,11,23),(92,4,17,23),(94,2,10,24),(95,4,11,24),(96,1,17,24),(98,1,10,25),(99,2,11,25),(100,1,17,25),(102,5,10,26),(103,2,11,26),(104,1,17,26),(106,2,10,27),(107,4,11,27),(108,4,17,27),(110,3,10,28),(111,2,11,28),(112,5,17,28),(114,2,10,29),(115,1,11,29),(116,3,17,29),(118,5,10,30),(119,2,11,30),(120,3,17,30),(122,5,10,31),(123,5,11,31),(124,4,17,31),(126,3,10,32),(127,4,11,32),(128,4,17,32),(130,1,10,33),(131,1,11,33),(132,2,17,33),(134,5,10,34),(135,4,11,34),(136,2,17,34),(138,4,10,35),(139,4,11,35),(140,1,17,35),(142,3,10,36),(143,4,11,36),(144,2,17,36),(146,1,10,37),(147,2,11,37),(148,1,17,37),(150,4,10,38),(151,3,11,38),(152,3,17,38),(154,1,10,39),(155,2,11,39),(156,2,17,39),(158,2,10,40),(159,2,11,40),(160,1,17,40),(227,5,10,45),(228,5,11,45),(229,5,17,45);
/*!40000 ALTER TABLE `teamverwaltung_main_projectanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_role`
--

DROP TABLE IF EXISTS `teamverwaltung_main_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_role`
--

LOCK TABLES `teamverwaltung_main_role` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_role` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_role` VALUES (1,'Teamleiter'),(2,'Analyse'),(3,'Entwurf'),(4,'Implementierung'),(5,'Test');
/*!40000 ALTER TABLE `teamverwaltung_main_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_roleanswer`
--

DROP TABLE IF EXISTS `teamverwaltung_main_roleanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_roleanswer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` bigint unsigned NOT NULL,
  `role_id` bigint NOT NULL,
  `poll_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teamverwaltung_main__role_id_e5422657_fk_teamverwa` (`role_id`),
  KEY `teamverwaltung_main__poll_id_11dc9493_fk_teamverwa` (`poll_id`),
  CONSTRAINT `teamverwaltung_main__poll_id_11dc9493_fk_teamverwa` FOREIGN KEY (`poll_id`) REFERENCES `teamverwaltung_main_poll` (`student_id`),
  CONSTRAINT `teamverwaltung_main__role_id_e5422657_fk_teamverwa` FOREIGN KEY (`role_id`) REFERENCES `teamverwaltung_main_role` (`id`),
  CONSTRAINT `teamverwaltung_main_roleanswer_chk_1` CHECK ((`score` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_roleanswer`
--

LOCK TABLES `teamverwaltung_main_roleanswer` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_roleanswer` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_roleanswer` VALUES (1,5,1,1),(2,3,2,1),(3,1,3,1),(4,5,4,1),(5,1,5,1),(6,5,1,2),(7,1,2,2),(8,2,3,2),(9,4,4,2),(10,2,5,2),(11,2,1,3),(12,3,2,3),(13,3,3,3),(14,4,4,3),(15,1,5,3),(16,4,1,4),(17,5,2,4),(18,4,3,4),(19,1,4,4),(20,4,5,4),(21,3,1,5),(22,2,2,5),(23,1,3,5),(24,4,4,5),(25,4,5,5),(26,2,1,6),(27,5,2,6),(28,1,3,6),(29,4,4,6),(30,5,5,6),(31,5,1,7),(32,5,2,7),(33,3,3,7),(34,3,4,7),(35,3,5,7),(36,4,1,8),(37,1,2,8),(38,3,3,8),(39,5,4,8),(40,5,5,8),(41,1,1,9),(42,4,2,9),(43,1,3,9),(44,4,4,9),(45,1,5,9),(46,5,1,10),(47,5,2,10),(48,2,3,10),(49,3,4,10),(50,2,5,10),(51,5,1,11),(52,4,2,11),(53,1,3,11),(54,3,4,11),(55,5,5,11),(56,4,1,12),(57,2,2,12),(58,3,3,12),(59,4,4,12),(60,4,5,12),(61,1,1,13),(62,1,2,13),(63,1,3,13),(64,3,4,13),(65,2,5,13),(66,3,1,14),(67,4,2,14),(68,5,3,14),(69,1,4,14),(70,2,5,14),(71,1,1,15),(72,5,2,15),(73,4,3,15),(74,5,4,15),(75,2,5,15),(76,2,1,16),(77,1,2,16),(78,2,3,16),(79,3,4,16),(80,3,5,16),(81,2,1,17),(82,4,2,17),(83,1,3,17),(84,3,4,17),(85,4,5,17),(86,3,1,18),(87,5,2,18),(88,4,3,18),(89,4,4,18),(90,2,5,18),(91,5,1,19),(92,5,2,19),(93,3,3,19),(94,1,4,19),(95,4,5,19),(96,2,1,20),(97,5,2,20),(98,5,3,20),(99,1,4,20),(100,5,5,20),(101,2,1,21),(102,3,2,21),(103,4,3,21),(104,4,4,21),(105,4,5,21),(106,4,1,22),(107,3,2,22),(108,5,3,22),(109,4,4,22),(110,5,5,22),(111,1,1,23),(112,4,2,23),(113,3,3,23),(114,1,4,23),(115,1,5,23),(116,5,1,24),(117,1,2,24),(118,2,3,24),(119,3,4,24),(120,3,5,24),(121,2,1,25),(122,1,2,25),(123,4,3,25),(124,4,4,25),(125,3,5,25),(126,3,1,26),(127,5,2,26),(128,3,3,26),(129,4,4,26),(130,4,5,26),(131,3,1,27),(132,1,2,27),(133,4,3,27),(134,2,4,27),(135,2,5,27),(136,5,1,28),(137,5,2,28),(138,4,3,28),(139,1,4,28),(140,4,5,28),(141,1,1,29),(142,2,2,29),(143,2,3,29),(144,5,4,29),(145,2,5,29),(146,2,1,30),(147,4,2,30),(148,5,3,30),(149,5,4,30),(150,2,5,30),(151,5,1,31),(152,2,2,31),(153,3,3,31),(154,3,4,31),(155,3,5,31),(156,3,1,32),(157,1,2,32),(158,5,3,32),(159,1,4,32),(160,2,5,32),(161,2,1,33),(162,4,2,33),(163,5,3,33),(164,2,4,33),(165,3,5,33),(166,4,1,34),(167,3,2,34),(168,5,3,34),(169,2,4,34),(170,5,5,34),(171,5,1,35),(172,1,2,35),(173,4,3,35),(174,2,4,35),(175,2,5,35),(176,4,1,36),(177,2,2,36),(178,3,3,36),(179,3,4,36),(180,3,5,36),(181,3,1,37),(182,4,2,37),(183,5,3,37),(184,5,4,37),(185,2,5,37),(186,3,1,38),(187,2,2,38),(188,3,3,38),(189,5,4,38),(190,4,5,38),(191,1,1,39),(192,3,2,39),(193,3,3,39),(194,1,4,39),(195,2,5,39),(196,2,1,40),(197,5,2,40),(198,5,3,40),(199,5,4,40),(200,2,5,40),(286,5,1,45),(287,5,2,45),(288,5,3,45),(289,5,4,45),(290,5,5,45);
/*!40000 ALTER TABLE `teamverwaltung_main_roleanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_sectioncontrol`
--

DROP TABLE IF EXISTS `teamverwaltung_main_sectioncontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_sectioncontrol` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `section` varchar(100) NOT NULL,
  `activated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_sectioncontrol`
--

LOCK TABLES `teamverwaltung_main_sectioncontrol` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_sectioncontrol` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_sectioncontrol` VALUES (1,'themen',1),(2,'fragebogen',1),(3,'teams',1),(4,'fragebogen_readonly',0);
/*!40000 ALTER TABLE `teamverwaltung_main_sectioncontrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_skill`
--

DROP TABLE IF EXISTS `teamverwaltung_main_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skill` varchar(255) NOT NULL,
  `abbreviation` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_skill`
--

LOCK TABLES `teamverwaltung_main_skill` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_skill` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_skill` VALUES (1,'Objektorientierte Konzepte (Klassen, Vererbung, Polymorphismus)','oop'),(2,'Web-Technologien (HTML, CSS, HTTP, REST)','web'),(3,'Objektorientierte Programmiersprachen, z.B. Java, C#, C++ usw.','ooplang'),(4,'Skriptsprachen, z.B. Python, Ruby, PHP, JavaScript, usw.','script'),(5,'Web-Frameworks, z.B. Spring, ASP.NET, Rails, Django, Node.js, Vaadin, Laravel, usw.','webframeworks'),(6,'Datenbanken, z.B. MySQL, MS SQL Server, MongoDB, usw.','db'),(7,'Modellierungssprachen, z.B. EPK, BPMN, UML, Entity- Relationship-Diagramm, usw.','modelling'),(8,'Gestaltung von Benutzeroberflächen (UI-Design)','ui'),(9,'Projekt-, Risiko-, Qualitätsmanagement, Personalführung','management'),(10,'Softwareentwicklung in Projektarbeit','teamwork'),(11,'Softwareentwicklung in Einzelarbeit','developer'),(12,'Versionsverwaltung mit Git','git'),(13,'Konzepte und Tools für Test, z.B. Testfälle, Testabdeckung, Testplanung , JUnit, usw.','test');
/*!40000 ALTER TABLE `teamverwaltung_main_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_skillanswer`
--

DROP TABLE IF EXISTS `teamverwaltung_main_skillanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_skillanswer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` int unsigned NOT NULL,
  `poll_id` bigint NOT NULL,
  `skill_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teamverwaltung_main__poll_id_ea74e6d0_fk_teamverwa` (`poll_id`),
  KEY `teamverwaltung_main__skill_id_6b3bf26f_fk_teamverwa` (`skill_id`),
  CONSTRAINT `teamverwaltung_main__poll_id_ea74e6d0_fk_teamverwa` FOREIGN KEY (`poll_id`) REFERENCES `teamverwaltung_main_poll` (`student_id`),
  CONSTRAINT `teamverwaltung_main__skill_id_6b3bf26f_fk_teamverwa` FOREIGN KEY (`skill_id`) REFERENCES `teamverwaltung_main_skill` (`id`),
  CONSTRAINT `teamverwaltung_main_skillanswer_chk_1` CHECK ((`score` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_skillanswer`
--

LOCK TABLES `teamverwaltung_main_skillanswer` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_skillanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `teamverwaltung_main_skillanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamverwaltung_main_student`
--

DROP TABLE IF EXISTS `teamverwaltung_main_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamverwaltung_main_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_name` varchar(255) NOT NULL,
  `s_num` varchar(6) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `title` varchar(4) NOT NULL,
  `faculty` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `s_num` (`s_num`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamverwaltung_main_student`
--

LOCK TABLES `teamverwaltung_main_student` WRITE;
/*!40000 ALTER TABLE `teamverwaltung_main_student` DISABLE KEYS */;
INSERT INTO `teamverwaltung_main_student` VALUES (1,'Wilkins','s00001','Bob','h','wi'),(2,'Nicholls','s00002','Meg','h','iw'),(3,'Munoz','s00003','Ruth','f','iw'),(4,'Hogan','s00004','Donald','h','iv'),(5,'Lambert','s00005','Jaeden','h','ia'),(6,'Mcguire','s00006','Vivian','f','wi'),(7,'Hawes','s00007','Franklin','h','wi'),(8,'Rasmussen','s00008','Darrel','h','ia'),(9,'Hendrix','s00009','Bernard','h','iv'),(10,'Carey','s00010','Mila','f','iw'),(11,'Firpi','s00011','Serena','f','iv'),(12,'Ilyas','s00012','Manuel','h','ia'),(13,'Hearfield','s00013','Lydon','h','iw'),(14,'Gorhardt','s00014','Johny','h','ia'),(15,'Lafaye','s00015','Cordi','h','iv'),(16,'Moresby','s00016','Arley','f','iw'),(17,'Marris','s00017','Kali','f','wi'),(18,'Sayre','s00018','Antony','h','iw'),(19,'Doerren','s00019','Mora','f','ia'),(20,'Sherebrooke','s00020','Philly','h','ia'),(21,'Besque','s00021','Berkeley','h','wi'),(22,'Chatel','s00022','Jere','f','ia'),(23,'Jurczik','s00023','Olivette','f','iw'),(24,'Paolicchi','s00024','Kennett','h','ia'),(25,'Skilbeck','s00025','Carlota','f','wi'),(26,'Zavittieri','s00026','Savina','f','iw'),(27,'Molyneaux','s00027','Laetitia','f','ia'),(28,'MacMechan','s00028','Jeannie','f','iv'),(29,'Izard','s00029','Kimmy','f','wi'),(30,'Gawke','s00030','Rafaelia','f','iw'),(31,'Edmonds','s00031','Emmey','f','ia'),(32,'Taggert','s00032','Sonia','f','iv'),(33,'Betun','s00033','Kelila','h','ia'),(34,'Burborough','s00034','Dani','h','ia'),(35,'Skeldinge','s00035','Lucius','h','wi'),(36,'Henriet','s00036','Redd','h','iv'),(37,'Tatters','s00037','Katrine','f','ia'),(38,'Hampton','s00038','Shannen','f','iw'),(39,'Bysaker','s00039','Galen','h','iv'),(40,'Downing','s00040','Loralie','f','iv'),(45,'Haschke','s81781','Maxim','h','ia'),(46,'Bande','s82054','Meggle','h','iw'),(60,'Ho','s82053','Tan Minh','h','ia'),(64,'Kirchner','s81912','David','h','ia');
/*!40000 ALTER TABLE `teamverwaltung_main_student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-24  3:05:01

-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: abs01jo2026
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.4

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned DEFAULT NULL,
  `student_engagement_id` bigint unsigned DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_slug_unique` (`slug`),
  KEY `album_status_index` (`status`),
  KEY `album_deleted_at_index` (`deleted_at`),
  KEY `album_published_at_index` (`published_at`),
  KEY `album_created_by_foreign` (`created_by`),
  KEY `album_updated_by_foreign` (`updated_by`),
  KEY `album_student_engagement_id_foreign` (`student_engagement_id`),
  CONSTRAINT `album_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `album_student_engagement_id_foreign` FOREIGN KEY (`student_engagement_id`) REFERENCES `student_engagement` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `album_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_image`
--

DROP TABLE IF EXISTS `album_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_image` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `album_image_album_id_index` (`album_id`),
  CONSTRAINT `album_image_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_image`
--

LOCK TABLES `album_image` WRITE;
/*!40000 ALTER TABLE `album_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_lang`
--

DROP TABLE IF EXISTS `album_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `album_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `album_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_lang`
--

LOCK TABLES `album_lang` WRITE;
/*!40000 ALTER TABLE `album_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni_stay_connected_webform`
--

DROP TABLE IF EXISTS `alumni_stay_connected_webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni_stay_connected_webform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alumni_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_alumni` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `graduation_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_profession` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `universities_attended` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `degrees_awarded` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `listed_on_linkedin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spouse_is_alumni` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interested_activities` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_news` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `suggestions` text COLLATE utf8mb4_unicode_ci,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni_stay_connected_webform`
--

LOCK TABLES `alumni_stay_connected_webform` WRITE;
/*!40000 ALTER TABLE `alumni_stay_connected_webform` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumni_stay_connected_webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_logs`
--

DROP TABLE IF EXISTS `api_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `auth_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `api_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `api_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `api_logs_chk_1` CHECK (json_valid(`parameters`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_logs`
--

LOCK TABLES `api_logs` WRITE;
/*!40000 ALTER TABLE `api_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` bigint unsigned NOT NULL,
  `old_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `new_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(1023) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audits_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`) USING BTREE,
  KEY `audits_user_id_user_type_index` (`user_id`,`user_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bms`
--

DROP TABLE IF EXISTS `bms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `module_class` varchar(255) DEFAULT NULL,
  `module_id` bigint unsigned DEFAULT NULL,
  `category_slug` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT '1',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  `view` varchar(50) NOT NULL DEFAULT 'page',
  `layout` varchar(50) NOT NULL DEFAULT 'main',
  `category` varchar(100) NOT NULL,
  `color` varchar(7) DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `bms_slug_unique` (`slug`),
  KEY `idx-bms-status` (`status`),
  KEY `idx-bms-created_by` (`created_by`),
  KEY `idx-bms-updated_by` (`updated_by`),
  KEY `idx-bms-deleted_at` (`deleted_at`),
  KEY `idx-bms-published_at` (`published_at`),
  KEY `bms_category_slug_foreign` (`category_slug`),
  CONSTRAINT `bms_category_slug_foreign` FOREIGN KEY (`category_slug`) REFERENCES `dropdown_list` (`slug`) ON DELETE CASCADE,
  CONSTRAINT `fk-bms-created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-bms-updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bms`
--

LOCK TABLES `bms` WRITE;
/*!40000 ALTER TABLE `bms` DISABLE KEYS */;
INSERT INTO `bms` VALUES (1,NULL,'news-ticker-1',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','news-ticker',NULL,1),(2,NULL,'news-ticker-2',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','news-ticker',NULL,2),(3,NULL,'home-hero-3',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','home-hero',NULL,1),(4,NULL,'why-abs-4',1,NULL,NULL,NULL,'/guiding-statement',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','why-abs',NULL,1),(5,NULL,'why-abs-features-5',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','why-abs-features',NULL,1),(6,NULL,'why-abs-features-6',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','why-abs-features',NULL,2),(7,NULL,'why-abs-features-7',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','why-abs-features',NULL,3),(8,NULL,'why-abs-features-8',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','why-abs-features',NULL,4),(9,NULL,'facts-figures-9',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,1),(10,NULL,'facts-figures-10',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,2),(11,NULL,'facts-figures-11',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,3),(12,NULL,'facts-figures-12',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,4),(13,NULL,'facts-figures-13',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,5),(14,NULL,'facts-figures-14',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,6),(15,NULL,'facts-figures-15',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','facts-figures',NULL,7),(16,NULL,'home-schools-16',1,NULL,NULL,NULL,'/schools/primary-school',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','home-schools',NULL,1),(17,NULL,'home-schools-17',1,NULL,NULL,NULL,'/schools/primary-school',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','home-schools',NULL,2),(18,NULL,'home-schools-18',1,NULL,NULL,NULL,'/schools/middle-school',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','home-schools',NULL,3),(19,NULL,'home-schools-19',1,NULL,NULL,NULL,'/schools/ib-college',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','home-schools',NULL,4),(20,NULL,'academic-achievements-20',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,1),(21,NULL,'academic-achievements-21',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,2),(22,NULL,'academic-achievements-22',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,3),(23,NULL,'academic-achievements-23',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,4),(24,NULL,'academic-achievements-24',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,5),(25,NULL,'academic-achievements-25',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','academic-achievements',NULL,6),(26,NULL,'accreditations-26',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,1),(27,NULL,'accreditations-27',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,2),(28,NULL,'accreditations-28',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,3),(29,NULL,'accreditations-29',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,4),(30,NULL,'accreditations-30',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,5),(31,NULL,'accreditations-31',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','accreditations',NULL,6),(32,NULL,'testimonials-32',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','testimonials',NULL,1),(33,NULL,'testimonials-33',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','testimonials',NULL,2),(34,NULL,'testimonials-34',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','testimonials',NULL,3),(35,NULL,'notable-alumni-35',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','notable-alumni',NULL,1),(36,NULL,'notable-alumni-36',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','notable-alumni',NULL,2),(37,NULL,'notable-alumni-37',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','notable-alumni',NULL,3),(38,NULL,'student-engagement-intro-38',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','student-engagement-intro',NULL,1),(39,NULL,'tuition-registration-fees-39',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-registration-fees',NULL,1),(40,NULL,'tuition-registration-fees-40',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-registration-fees',NULL,2),(41,NULL,'tuition-transport-41',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-transport',NULL,1),(42,NULL,'tuition-transport-42',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-transport',NULL,2),(43,NULL,'tuition-policies-43',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-policies',NULL,1),(44,NULL,'tuition-policies-44',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-policies',NULL,2),(45,NULL,'tuition-policies-45',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','tuition-policies',NULL,3),(46,NULL,'admissions-procedure-46',1,NULL,NULL,NULL,'/contact-us',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,1),(47,NULL,'admissions-procedure-47',1,NULL,NULL,NULL,'/contact-us',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,2),(48,NULL,'admissions-procedure-48',1,NULL,NULL,NULL,'/apply-now',1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,3),(49,NULL,'admissions-procedure-49',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,4),(50,NULL,'admissions-procedure-50',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,5),(51,NULL,'admissions-procedure-51',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','admissions-procedure',NULL,6),(52,NULL,'apply-now-52',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','apply-now',NULL,1),(53,NULL,'apply-now-53',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','apply-now',NULL,2),(54,NULL,'guiding-statement-54',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,1),(55,NULL,'guiding-statement-55',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,2),(56,NULL,'guiding-statement-56',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,3),(57,NULL,'guiding-statement-57',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,4),(58,NULL,'guiding-statement-58',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,5),(59,NULL,'guiding-statement-59',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,6),(60,NULL,'guiding-statement-60',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,7),(61,NULL,'guiding-statement-61',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,8),(62,NULL,'guiding-statement-62',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,9),(63,NULL,'guiding-statement-63',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','guiding-statement',NULL,10),(64,NULL,'employment-64',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','employment',NULL,1),(65,NULL,'employment-65',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','employment',NULL,2),(66,NULL,'employment-66',1,NULL,NULL,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,0,0,NULL,'page','main','employment',NULL,3);
/*!40000 ALTER TABLE `bms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bms_lang`
--

DROP TABLE IF EXISTS `bms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bms_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `second_title` varchar(255) DEFAULT NULL,
  `brief` varchar(1000) DEFAULT NULL,
  `content` text,
  `image_id` bigint unsigned DEFAULT NULL,
  `cover_image_id` bigint unsigned DEFAULT NULL,
  `video_id` bigint unsigned DEFAULT NULL,
  `image_responsive_id` bigint unsigned DEFAULT NULL,
  `button_text_1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `url_1` varchar(255) DEFAULT NULL,
  `button_image_1` varchar(255) DEFAULT NULL,
  `button_2_text` varchar(255) DEFAULT NULL,
  `url_2` varchar(255) DEFAULT NULL,
  `button_image_2` varchar(255) DEFAULT NULL,
  `button_text_3` varchar(255) DEFAULT NULL,
  `url_3` varchar(255) DEFAULT NULL,
  `button_image_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bms_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `bms_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `bms_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `bms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bms_lang`
--

LOCK TABLES `bms_lang` WRITE;
/*!40000 ALTER TABLE `bms_lang` DISABLE KEYS */;
INSERT INTO `bms_lang` VALUES (1,1,'en','Amman Baccalaureate School achieves another national first by earning reaccreditation through the IB and NEASC Collaborative Learning Protocol',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,1,'ar','مدرسة البكالوريا - عمان تحقق إنجازاً وطنياً جديداً بحصولها على إعادة الاعتماد من خلال بروتوكول التعلم التعاوني بين IB و NEASC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,2,'en','HRH Prince Hassan and HRH Princess Sarvath inaugurate the new Ahmad Mango sports field at the Amman Baccalaureate School',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,2,'ar','سمو الأمير الحسن وسمو الأميرة ثروت يفتتحان ملعب أحمد منكو الرياضي الجديد في مدرسة البكالوريا - عمان',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,3,'en','A Quality Education & Principled Upbringing Since 1981',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,3,'ar','تعليم نوعي وتنشئة قائمة على المبادئ منذ عام 1981',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,4,'en','Why ABS',NULL,'The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students.','<p>The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students. Deeply rooted and firmly grounded in and proud of the rich and varied Jordanian culture and heritage. This is an ethos that remains today.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,4,'ar','لماذا ABS',NULL,'The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students.','<p>The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students. Deeply rooted and firmly grounded in and proud of the rich and varied Jordanian culture and heritage. This is an ethos that remains today.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,5,'en','Arab Heritage & Culture',NULL,'A deep-rooted connection to Jordanian and Arab heritage.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,5,'ar','التراث والثقافة العربية',NULL,'A deep-rooted connection to Jordanian and Arab heritage.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,6,'en','Bilingual Excellence',NULL,'An exceptional bilingual education and a strong command of Arabic and English.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,6,'ar','التميّز ثنائي اللغة',NULL,'An exceptional bilingual education and a strong command of Arabic and English.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,7,'en','IB Continuum School',NULL,'Offering four IB Programmes (KG1-Gr 12) PYP, MYP, DP, CP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,7,'ar','مدرسة IB متكاملة',NULL,'Offering four IB Programmes (KG1-Gr 12) PYP, MYP, DP, CP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,8,'en','Innovation',NULL,'AI & Digital Technologies',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,8,'ar','الابتكار',NULL,'AI & Digital Technologies',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,9,'en','45+',NULL,'Years of Excellence',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,9,'ar','45+',NULL,'عاماً من التميّز',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,10,'en','4',NULL,'IB Programmes (PYP, MYP, DP, CP)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,10,'ar','4',NULL,'برامج IB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,11,'en','86.000','m²','Campus Size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,11,'ar','86.000','m²','مساحة الحرم المدرسي',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,12,'en','1,165+',NULL,'Students',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,12,'ar','1,165+',NULL,'طالب وطالبة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,13,'en','190+',NULL,'Faculty',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,13,'ar','190+',NULL,'معلم ومعلمة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,14,'en','6:1',NULL,'Student Ratio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,14,'ar','6:1',NULL,'نسبة الطلبة للمعلمين',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,15,'en','4-18','(Years)','Age Range',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,15,'ar','4-18','(Years)','الفئة العمرية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,16,'en','KG1 - KG2','Primary School',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,16,'ar','الروضة الأولى - الروضة الثانية','المدرسة الابتدائية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,17,'en','Grade 1 - Grade 6','Primary School',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,17,'ar','الصف الأول - الصف السادس','المدرسة الابتدائية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,18,'en','Grade 7 - Grade 10','Secondary School – Middle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,18,'ar','الصف السابع - الصف العاشر','المرحلة المتوسطة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,19,'en','Grade 11 - Grade 12','Secondary School – IB College',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,19,'ar','الصف الحادي عشر - الصف الثاني عشر','كلية البكالوريا الدولية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,20,'en','100%',NULL,'IB Diploma pass rate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,20,'ar','100%',NULL,'نسبة النجاح في دبلوم IB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,21,'en','35',NULL,'Achieved 40+ points',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,21,'ar','35',NULL,'حصلوا على 40 نقطة فأكثر',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,22,'en','39',NULL,'Average score',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,22,'ar','39',NULL,'متوسط النقاط',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,23,'en','85%',NULL,'Accepted to Top 100 Universities',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,23,'ar','85%',NULL,'قُبلوا في أفضل 100 جامعة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,24,'en','42',NULL,'Bilingual Diplomas Awarded',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,24,'ar','42',NULL,'دبلوم ثنائي اللغة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,25,'en','40+',NULL,'Years of Academic Excellence',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,25,'ar','40+',NULL,'عاماً من التميّز الأكاديمي',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,26,'en','ECIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,26,'ar','ECIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,27,'en','NEASC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,27,'ar','NEASC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,28,'en','IB Continuum School',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,28,'ar','IB Continuum School',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,29,'en','International Baccalaureate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,29,'ar','International Baccalaureate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,30,'en','Ministry of Education - Jordan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,30,'ar','Ministry of Education - Jordan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,31,'en','Pearson BTEC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,31,'ar','Pearson BTEC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,32,'en','LANA GHANEM','Class of 2016 Alumna & Keynote Speaker','Life is a series of choices that we make to achieve our goals so make sure that your choices are immersed in passion.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,32,'ar','LANA GHANEM','Class of 2016 Alumna & Keynote Speaker','Life is a series of choices that we make to achieve our goals so make sure that your choices are immersed in passion.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,33,'en','ABS PARENT',NULL,'My daughter\'s IB Diploma results opened doors we never imagined — she\'s now at a top UK university.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,33,'ar','ABS PARENT',NULL,'My daughter\'s IB Diploma results opened doors we never imagined — she\'s now at a top UK university.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,34,'en','ABS PARENT',NULL,'The bilingual program is exceptional — my son switches between Arabic and English with absolute confidence.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,34,'ar','ABS PARENT',NULL,'The bilingual program is exceptional — my son switches between Arabic and English with absolute confidence.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,35,'en','Amjad Afanah',NULL,'Tech Entrepreneur, Software Architect, and Founder of cloud startup DCHQ.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,35,'ar','أمجد العفانة',NULL,'Tech Entrepreneur, Software Architect, and Founder of cloud startup DCHQ.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,36,'en','Hamdi Tabbaa',NULL,'Founder and CEO of Abwaab, an innovative and leading regional EdTech platform.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,36,'ar','حمدي طباع',NULL,'Founder and CEO of Abwaab, an innovative and leading regional EdTech platform.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,37,'en','Princess Zeina Rashid',NULL,'Olympic table tennis athlete and sports diplomat representing Jordan at international games.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,37,'ar','الأميرة زينة راشد',NULL,'Olympic table tennis athlete and sports diplomat representing Jordan at international games.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,38,'en','What are Co-curricular Activities?',NULL,'These activities, such as sports, school bands, drama, educational trips and the arts, are not part of the academic curriculum, yet they are recognised as essential elements in the life of our ABS students. They provide opportunities to engage in diverse learning experiences that foster creativity, teamwork and personal growth. Far from being supplementary, co-curricular activities play a vital role in enhancing the learning process, making it both meaningful and enjoyable.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,38,'ar','ما هي الأنشطة المصاحبة للمنهاج؟',NULL,'These activities, such as sports, school bands, drama, educational trips and the arts, are not part of the academic curriculum, yet they are recognised as essential elements in the life of our ABS students. They provide opportunities to engage in diverse learning experiences that foster creativity, teamwork and personal growth. Far from being supplementary, co-curricular activities play a vital role in enhancing the learning process, making it both meaningful and enjoyable.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(77,39,'en','Administration Fee','JD 100','Payable at application; non-refundable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(78,39,'ar','رسوم إدارية','100 دينار','Payable at application; non-refundable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(79,40,'en','Enrolment Fee','JD 1,500','KG1 – Grade 12 upon confirmation; non-refundable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(80,40,'ar','رسوم التسجيل','1,500 دينار','KG1 – Grade 12 upon confirmation; non-refundable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(81,41,'en','Round-trip (Morning & Afternoon):',NULL,'JOD 935 / year  |  JOD 495 / semester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(82,41,'ar','ذهاب وإياب (صباحاً ومساءً):',NULL,'JOD 935 / year  |  JOD 495 / semester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(83,42,'en','One-way trip (Morning or Afternoon):',NULL,'JOD 580 / year  |  JOD 315 / semester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(84,42,'ar','اتجاه واحد (صباحاً أو مساءً):',NULL,'JOD 580 / year  |  JOD 315 / semester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(85,43,'en','Seat Reservation:',NULL,'A seat reservation fee of JOD 1,000 is payable by January 31, by all existing students to secure your child\'s seat for the next academic year (deductible from tuition). If unpaid, the school will not guarantee your child\'s seat.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(86,43,'ar','حجز المقعد:',NULL,'A seat reservation fee of JOD 1,000 is payable by January 31, by all existing students to secure your child\'s seat for the next academic year (deductible from tuition). If unpaid, the school will not guarantee your child\'s seat.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(87,44,'en','Tuition Deadlines & Installments:',NULL,'Total tuition fees are due by April 30. Payment can be made in full in advance by April 30, (or within one week of acceptance), or by three (3) post-dated cheques in equal amounts dated: 30 April, 30 September, and 31 January. Failure to pay by the due date gives the school the right to accept new students from the waiting list.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(88,44,'ar','مواعيد الدفع والأقساط:',NULL,'Total tuition fees are due by April 30. Payment can be made in full in advance by April 30, (or within one week of acceptance), or by three (3) post-dated cheques in equal amounts dated: 30 April, 30 September, and 31 January. Failure to pay by the due date gives the school the right to accept new students from the waiting list.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(89,45,'en','Notification of Withdrawal:',NULL,'If the decision of withdrawing your child is taken after January 31, the seat reservation fee is non-refundable. Should a decision to withdraw your child occur during the academic year after fees have been paid, one month\'s fee (calculated as 1/9 of the tuition fee) will be due for each month or partial month of notice not given, starting from the due date of the first payment.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(90,45,'ar','إشعار الانسحاب:',NULL,'If the decision of withdrawing your child is taken after January 31, the seat reservation fee is non-refundable. Should a decision to withdraw your child occur during the academic year after fees have been paid, one month\'s fee (calculated as 1/9 of the tuition fee) will be due for each month or partial month of notice not given, starting from the due date of the first payment.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(91,46,'en','Enquire','STEP ONE','Contact our Admissions team for any questions about the school and seat availability — email registrar@abs.edu.jo or call 0770 444 303.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(92,46,'ar','استفسر','الخطوة الأولى','Contact our Admissions team for any questions about the school and seat availability — email registrar@abs.edu.jo or call 0770 444 303.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(93,47,'en','Book a Tour','STEP TWO','Discover Excellence: tour our campus and take your first steps into unlocking the ABS experience.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(94,47,'ar','احجز جولة','الخطوة الثانية','Discover Excellence: tour our campus and take your first steps into unlocking the ABS experience.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(95,48,'en','Complete your Application Form','STEP THREE','Begin your ABS Adventure: Complete your application form now!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(96,48,'ar','أكمل نموذج الطلب','الخطوة الثالثة','Begin your ABS Adventure: Complete your application form now!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(97,49,'en','Family Interview','STEP FOUR','Our dedicated ABS team would like to get to know you and your family, share information about our school, community, and programs, and give you a chance to ask any questions.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(98,49,'ar','مقابلة العائلة','الخطوة الرابعة','Our dedicated ABS team would like to get to know you and your family, share information about our school, community, and programs, and give you a chance to ask any questions.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(99,50,'en','Entrance Assessment','STEP FIVE','Once a seat is confirmed available, the applicant is invited to sit a grade- level appropriate entrance assessment.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(100,50,'ar','اختبار القبول','الخطوة الخامسة','Once a seat is confirmed available, the applicant is invited to sit a grade- level appropriate entrance assessment.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(101,51,'en','Your First Steps into Excellence','STEP SIX','Welcome to the Amman Baccalaureate School family. Your exceptional educational journey begins here.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(102,51,'ar','خطواتك الأولى نحو التميّز','الخطوة السادسة','Welcome to the Amman Baccalaureate School family. Your exceptional educational journey begins here.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(103,52,'en','Primary School','Application Guidelines & Waiting Lists',NULL,'<h4>Application Timeline</h4><p>Applications should be submitted within 3 months of your child\'s birth. If a place is not available after the enrollment year, a 12 month waiting period will apply.</p><h4>Postponement Policy</h4><p>If you wish to postpone your child\'s application after a seat becomes available, the postponement is valid for 12 month period.</p><h3>KG2 – Grade 6 Procedures</h3><h4>Existing Waiting List:</h4><p>If your child is currently on our waiting list, you have a 12 month period, to secure a place. If a place is not available within this timeframe, your child will be removed from the list, and you need to renew the application.</p><h4>100 JOD Fee Policy</h4><p>If you pay the new registration fee of 100 JOD, no refund applies.</p><h4>New Registrations:</h4><p>Parents who register their child on the waiting list now will have a 12-month period to wait for an available seat. If a seat does not become available within this period, your child will be removed from the list, and you need to re-register.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(104,52,'ar','المدرسة الابتدائية','إرشادات التقديم وقوائم الانتظار',NULL,'<h4>Application Timeline</h4><p>Applications should be submitted within 3 months of your child\'s birth. If a place is not available after the enrollment year, a 12 month waiting period will apply.</p><h4>Postponement Policy</h4><p>If you wish to postpone your child\'s application after a seat becomes available, the postponement is valid for 12 month period.</p><h3>KG2 – Grade 6 Procedures</h3><h4>Existing Waiting List:</h4><p>If your child is currently on our waiting list, you have a 12 month period, to secure a place. If a place is not available within this timeframe, your child will be removed from the list, and you need to renew the application.</p><h4>100 JOD Fee Policy</h4><p>If you pay the new registration fee of 100 JOD, no refund applies.</p><h4>New Registrations:</h4><p>Parents who register their child on the waiting list now will have a 12-month period to wait for an available seat. If a seat does not become available within this period, your child will be removed from the list, and you need to re-register.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(105,53,'en','Secondary School (Grades 7 – 12)','Waiting List',NULL,'<p>Students on the waiting list have a 12-month period, to secure a place. If a place does not become available within this period, the student will be removed from the list and must reapply.</p><h4>Secondary School Application</h4><p>Applications for the 2025-2026 academic year will open on November 3, 2024, and close on March 3, 2025.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(106,53,'ar','المدرسة الثانوية (الصفوف 7 – 12)','قائمة الانتظار',NULL,'<p>Students on the waiting list have a 12-month period, to secure a place. If a place does not become available within this period, the student will be removed from the list and must reapply.</p><h4>Secondary School Application</h4><p>Applications for the 2025-2026 academic year will open on November 3, 2024, and close on March 3, 2025.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(107,54,'en','Arab Heritage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(108,54,'ar','التراث العربي',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(109,55,'en','Lifelong Learners',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(110,55,'ar','متعلمون مدى الحياة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(111,56,'en','Teamwork',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(112,56,'ar','العمل الجماعي',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(113,57,'en','Achievement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(114,57,'ar','الإنجاز',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(115,58,'en','Responsibility',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(116,58,'ar','المسؤولية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(117,59,'en','Bilingualism to Biliteracy',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(118,59,'ar','من ثنائية اللغة إلى ثنائية الإلمام بالقراءة والكتابة',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(119,60,'en','International Mindedness',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(120,60,'ar','العقلية الدولية',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(121,61,'en','Youth Agency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(122,61,'ar','تمكين الشباب',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(123,62,'en','Excellence',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(124,62,'ar','التميّز',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(125,63,'en','Holistic Education',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(126,63,'ar','التعليم الشامل',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(127,64,'en','Employment',NULL,NULL,'<p>The Amman Baccalaureate School is an IB World School that provides a bilingual education in Arabic and English, which, whilst meeting the highest international standards, remains firmly rooted in the Arab heritage. The School is a Jordanian, non-profit institution that promotes international understanding, communication and awareness through embracing other cultures. The Amman Baccalaureate School works towards developing well rounded responsible world citizens.</p><p>Working at ABS means working at an IB pioneer school in an exciting, enriching locality. It means working side by side with local Jordanians and international staff to maintain ABS’s high educational standards while preparing the next generation of youth for their positions as world changers and innovative creators.</p><h3>Salary and Benefits Package</h3><p>At Amman Baccalaureate School, we value the dedication and expertise of our educators and administrative staff. To support them, we offer a competitive salary and a comprehensive benefits package designed to attract, retain, and reward exceptional talent.</p><h4>International Teachers (hired from outside Jordan)</h4><ul><li>Competitive base salary aligned with qualifications, experience, and international standards</li><li>Gratuity payment in accordance with school policy, subject to successful completion of the academic year</li><li>Responsibility allowance for additional leadership roles or posts of responsibility</li><li>International allowance to support housing, utilities, relocation, and airfare (calculated based on destination and number of dependents)</li><li>Comprehensive health insurance for the employee and eligible dependents</li><li>Life insurance coverage for employees</li><li>Social Security contributions in accordance with Jordanian labor law</li><li>Visa and permits support, including work permits, residence permits for dependents, initial entry visas, and airport departure taxes</li><li>Tuition fee reduction for dependent children, in line with school policy</li><li>Transportation to and from School via bus, as per school policy</li></ul><h4>Local Teachers (hired from inside Jordan)</h4><ul><li>Competitive base salary aligned with qualifications and experience</li><li>Responsibility allowance for posts of additional leadership or responsibility</li><li>Social Security and Provident Fund contributions in accordance with Jordanian labor law and school policy</li><li>Comprehensive health insurance for the employee and eligible dependents</li><li>Life insurance coverage for employees</li><li>Tuition fee reduction for dependent children, according to school policy</li><li>Transportation to and from School via bus, in line with the school policy</li></ul>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(128,64,'ar','التوظيف',NULL,NULL,'<p>The Amman Baccalaureate School is an IB World School that provides a bilingual education in Arabic and English, which, whilst meeting the highest international standards, remains firmly rooted in the Arab heritage. The School is a Jordanian, non-profit institution that promotes international understanding, communication and awareness through embracing other cultures. The Amman Baccalaureate School works towards developing well rounded responsible world citizens.</p><p>Working at ABS means working at an IB pioneer school in an exciting, enriching locality. It means working side by side with local Jordanians and international staff to maintain ABS’s high educational standards while preparing the next generation of youth for their positions as world changers and innovative creators.</p><h3>Salary and Benefits Package</h3><p>At Amman Baccalaureate School, we value the dedication and expertise of our educators and administrative staff. To support them, we offer a competitive salary and a comprehensive benefits package designed to attract, retain, and reward exceptional talent.</p><h4>International Teachers (hired from outside Jordan)</h4><ul><li>Competitive base salary aligned with qualifications, experience, and international standards</li><li>Gratuity payment in accordance with school policy, subject to successful completion of the academic year</li><li>Responsibility allowance for additional leadership roles or posts of responsibility</li><li>International allowance to support housing, utilities, relocation, and airfare (calculated based on destination and number of dependents)</li><li>Comprehensive health insurance for the employee and eligible dependents</li><li>Life insurance coverage for employees</li><li>Social Security contributions in accordance with Jordanian labor law</li><li>Visa and permits support, including work permits, residence permits for dependents, initial entry visas, and airport departure taxes</li><li>Tuition fee reduction for dependent children, in line with school policy</li><li>Transportation to and from School via bus, as per school policy</li></ul><h4>Local Teachers (hired from inside Jordan)</h4><ul><li>Competitive base salary aligned with qualifications and experience</li><li>Responsibility allowance for posts of additional leadership or responsibility</li><li>Social Security and Provident Fund contributions in accordance with Jordanian labor law and school policy</li><li>Comprehensive health insurance for the employee and eligible dependents</li><li>Life insurance coverage for employees</li><li>Tuition fee reduction for dependent children, according to school policy</li><li>Transportation to and from School via bus, in line with the school policy</li></ul>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(129,65,'en','Opportunities',NULL,NULL,'<p>To review current opportunities at ABS, please click below.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(130,65,'ar','الفرص الوظيفية',NULL,NULL,'<p>To review current opportunities at ABS, please click below.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(131,66,'en','Living in Jordan',NULL,NULL,'<p>Jordan is a fascinating, friendly and safe place in which to live and work. Amman offers a rich mix of the old and the new with spectacular Roman ruins, buzzing coffee shops and souqs, modern shopping malls, art galleries and an international-standard museum. The ABS enjoys a privileged position in the leafy, affluent district of Western Amman.</p><p>Culturally, Jordan offers many treasures and the Dead Sea, Baptismal Site, Petra and Jerash are all within easy reach.</p><p>For those interested to venture further afield, Jordan is also well-placed as a hub from which to travel more widely within the region to Beirut, Cairo, the UAE and numerous other interesting destinations.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(132,66,'ar','العيش في الأردن',NULL,NULL,'<p>Jordan is a fascinating, friendly and safe place in which to live and work. Amman offers a rich mix of the old and the new with spectacular Roman ruins, buzzing coffee shops and souqs, modern shopping malls, art galleries and an international-standard museum. The ABS enjoys a privileged position in the leafy, affluent district of Western Amman.</p><p>Culturally, Jordan offers many treasures and the Dead Sea, Baptismal Site, Petra and Jerash are all within easy reach.</p><p>For those interested to venture further afield, Jordan is also well-placed as a hub from which to travel more widely within the region to Beirut, Cairo, the UAE and numerous other interesting destinations.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `bms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `button`
--

DROP TABLE IF EXISTS `button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `button` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `button_status_index` (`status`),
  KEY `idx-button_created_by` (`created_by`),
  KEY `idx-button_updated_by` (`updated_by`),
  KEY `idx-button_deleted_at` (`deleted_at`),
  KEY `idx-button_published_at` (`published_at`),
  CONSTRAINT `fk-button_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-button_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `button`
--

LOCK TABLES `button` WRITE;
/*!40000 ALTER TABLE `button` DISABLE KEYS */;
/*!40000 ALTER TABLE `button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `button_lang`
--

DROP TABLE IF EXISTS `button_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `button_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cbutton_lang_parent_idx` (`language`,`parent_id`),
  KEY `button_lang_parent_id_foreign` (`parent_id`),
  CONSTRAINT `button_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `button` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `button_lang`
--

LOCK TABLES `button_lang` WRITE;
/*!40000 ALTER TABLE `button_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `button_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`),
  KEY `idx-city-status` (`status`),
  KEY `idx-city-created_by` (`created_by`),
  KEY `idx-city-updated_by` (`updated_by`),
  KEY `idx-city-deleted_at` (`deleted_at`),
  KEY `idx-city-published_at` (`published_at`),
  CONSTRAINT `fk-city-created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-city-updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (545,'amman',1,1536652233,1757941928,NULL,1757980800,1,1,10,0,0,NULL),(546,'aqaba',1,1537302661,1629291642,NULL,NULL,1,1,10,0,0,NULL),(547,'irbid',1,1537792980,1537946651,NULL,NULL,1,1,10,0,0,NULL),(548,'ajloun',1,1537302670,1537946644,NULL,NULL,1,1,10,0,0,NULL),(549,'karak',1,1537302678,1757941950,NULL,1758585600,1,1,10,0,0,NULL),(550,'maan',1,1537302684,1537946631,NULL,NULL,1,1,10,0,0,NULL),(551,'mafraq',1,1537302691,1629291615,NULL,NULL,1,1,10,0,0,NULL),(552,'ramtha',1,1537302698,1629291605,NULL,NULL,1,1,10,0,0,NULL),(553,'madaba',1,1537302705,1537946604,NULL,NULL,1,1,10,0,0,NULL),(554,'tafila',1,1537302713,1629291595,NULL,NULL,1,1,10,0,0,NULL),(555,'balqa',1,1537302720,1629291587,NULL,NULL,1,1,10,0,0,NULL),(556,'zarqa',1,1537302728,1629291574,NULL,NULL,1,1,10,0,0,NULL),(557,'jerash',1,1537302734,1631094970,NULL,NULL,1,1,10,0,0,NULL),(560,'a',0,1682952893,1682953616,NULL,NULL,1,1,10,0,0,NULL);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city_lang`
--

DROP TABLE IF EXISTS `city_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `city_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `city_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `city_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_lang`
--

LOCK TABLES `city_lang` WRITE;
/*!40000 ALTER TABLE `city_lang` DISABLE KEYS */;
INSERT INTO `city_lang` VALUES (8,545,'en','Amman'),(9,545,'ar','عمان'),(12,546,'en','Aqaba'),(13,546,'ar','العقبة'),(14,548,'en','Ajloun'),(15,548,'ar','عجلون'),(16,549,'en','Karak'),(17,549,'ar','الكرك'),(18,550,'en','Ma\'an'),(19,550,'ar','معّان'),(20,551,'en','Mafraq'),(21,551,'ar','المفرق'),(22,552,'en','Ramtha'),(23,552,'ar','الرمثا'),(24,553,'en','Madaba'),(25,553,'ar','مادبا'),(26,554,'en','Tafila'),(27,554,'ar','الطفيلة'),(28,555,'en','Balqa'),(29,555,'ar','البلقاء'),(30,556,'en','Zarqa'),(31,556,'ar','الزرقاء'),(32,557,'en','Jerash'),(33,557,'ar','جرش'),(34,547,'en','Irbid'),(35,547,'ar','إربد'),(40,560,'en','a ar'),(41,560,'ar','a ar');
/*!40000 ALTER TABLE `city_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_note_webform`
--

DROP TABLE IF EXISTS `class_note_webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_note_webform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `graduation_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `university` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_of_study` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `social_media_links` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmation_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_permission` tinyint(1) DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_note_webform`
--

LOCK TABLES `class_note_webform` WRITE;
/*!40000 ALTER TABLE `class_note_webform` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_note_webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_us_webform`
--

DROP TABLE IF EXISTS `contact_us_webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_us_webform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `page_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_us_webform`
--

LOCK TABLES `contact_us_webform` WRITE;
/*!40000 ALTER TABLE `contact_us_webform` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_us_webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `num_code` bigint unsigned NOT NULL AUTO_INCREMENT,
  `alpha_2_code` varchar(2) DEFAULT NULL,
  `alpha_3_code` varchar(3) DEFAULT NULL,
  `en_short_name` varchar(52) DEFAULT NULL,
  `ar_short_name` varchar(255) DEFAULT NULL,
  `ar_nationality` varchar(255) DEFAULT NULL,
  `en_nationality` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`num_code`) USING BTREE,
  UNIQUE KEY `alpha_2_code` (`alpha_2_code`) USING BTREE,
  UNIQUE KEY `alpha_3_code` (`alpha_3_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=895 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (4,'AF','AFG','Afghanistan','أفغانستان','أفغانستاني','Afghan'),(8,'AL','ALB','Albania','ألبانيا','ألباني','Albanian'),(10,'AQ','ATA','Antarctica','أنتاركتيكا','أنتاركتيكي','Antarctic'),(12,'DZ','DZA','Algeria','الجزائر','جزائري','Algerian'),(16,'AS','ASM','American Samoa','ساموا-الأمريكي','أمريكي سامواني','American Samoan'),(20,'AD','AND','Andorra','أندورا','أندوري','Andorran'),(24,'AO','AGO','Angola','أنغولا','أنقولي','Angolan'),(28,'AG','ATG','Antigua and Barbuda','أنتيغوا وبربودا','بربودي','Antiguan or Barbudan'),(31,'AZ','AZE','Azerbaijan','أذربيجان','أذربيجاني','Azerbaijani, Azeri'),(32,'AR','ARG','Argentina','الأرجنتين','أرجنتيني','Argentine'),(36,'AU','AUS','Australia','أستراليا','أسترالي','Australian'),(40,'AT','AUT','Austria','النمسا','نمساوي','Austrian'),(44,'BS','BHS','Bahamas','الباهاماس','باهاميسي','Bahamian'),(48,'BH','BHR','Bahrain','البحرين','بحريني','Bahraini'),(50,'BD','BGD','Bangladesh','بنغلاديش','بنغلاديشي','Bangladeshi'),(51,'AM','ARM','Armenia','أرمينيا','أرميني','Armenian'),(52,'BB','BRB','Barbados','بربادوس','بربادوسي','Barbadian'),(56,'BE','BEL','Belgium','بلجيكا','بلجيكي','Belgian'),(60,'BM','BMU','Bermuda','جزر برمودا','برمودي','Bermudian, Bermudan'),(64,'BT','BTN','Bhutan','بوتان','بوتاني','Bhutanese'),(68,'BO','BOL','Bolivia (Plurinational State of)','بوليفيا','بوليفي','Bolivian'),(70,'BA','BIH','Bosnia and Herzegovina','البوسنة و الهرسك','بوسني/هرسكي','Bosnian or Herzegovinian'),(72,'BW','BWA','Botswana','بوتسوانا','بوتسواني','Motswana, Botswanan'),(74,'BV','BVT','Bouvet Island','جزيرة بوفيت','بوفيهي','Bouvet Island'),(76,'BR','BRA','Brazil','البرازيل','برازيلي','Brazilian'),(84,'BZ','BLZ','Belize','بيليز','بيليزي','Belizean'),(86,'IO','IOT','British Indian Ocean Territory','إقليم المحيط البريطاني الهندي','إقليم المحيط الهندي البريطاني','BIOT'),(90,'SB','SLB','Solomon Islands','جزر سليمان','جزر سليمان','Solomon Island'),(92,'VG','VGB','Virgin Islands (British)','جزر فيرجن البريطانية','جزر فيرجن البريطانية','British Virgin Island'),(96,'BN','BRN','Brunei Darussalam','بروناي','بروني','Bruneian'),(100,'BG','BGR','Bulgaria','بلغاريا','بلغاري','Bulgarian'),(104,'MM','MMR','Myanmar','ميانمار','ميانماري','Burmese'),(108,'BI','BDI','Burundi','بوروندي','بورونيدي','Burundian'),(112,'BY','BLR','Belarus','روسيا البيضاء','روسي','Belarusian'),(116,'KH','KHM','Cambodia','كمبوديا','كمبودي','Cambodian'),(120,'CM','CMR','Cameroon','كاميرون','كاميروني','Cameroonian'),(124,'CA','CAN','Canada','كندا','كندي','Canadian'),(132,'CV','CPV','Cabo Verde','الرأس الأخضر','الرأس الأخضر','Cabo Verdean'),(136,'KY','CYM','Cayman Islands','جزر كايمان','كايماني','Caymanian'),(140,'CF','CAF','Central African Republic','جمهورية أفريقيا الوسطى','أفريقي','Central African'),(144,'LK','LKA','Sri Lanka','سريلانكا','سريلانكي','Sri Lankan'),(148,'TD','TCD','Chad','تشاد','تشادي','Chadian'),(152,'CL','CHL','Chile','شيلي','شيلي','Chilean'),(156,'CN','CHN','China','جمهورية الصين الشعبية','صيني','Chinese'),(158,'TW','TWN','Taiwan, Province of China','تايوان','تايواني','Chinese, Taiwanese'),(162,'CX','CXR','Christmas Island','جزيرة الكريسماس','جزيرة عيد الميلاد','Christmas Island'),(166,'CC','CCK','Cocos (Keeling) Islands','جزر كوكوس','جزر كوكوس','Cocos Island'),(170,'CO','COL','Colombia','كولومبيا','كولومبي','Colombian'),(174,'KM','COM','Comoros','جزر القمر','جزر القمر','Comoran, Comorian'),(175,'YT','MYT','Mayotte','مايوت','مايوتي','Mahoran'),(178,'CG','COG','Congo (Republic of the)','جمهورية الكونغو','كونغي','Congolese'),(180,'CD','COD','Congo (Democratic Republic of the)','جمهورية الكونغو الديموقراطية','جمهورية الكونغو الديموقراطية','Congolese'),(184,'CK','COK','Cook Islands','جزر كوك','جزر كوك','Cook Island'),(188,'CR','CRI','Costa Rica','كوستاريكا','كوستاريكي','Costa Rican'),(191,'HR','HRV','Croatia','كرواتيا','كوراتي','Croatian'),(192,'CU','CUB','Cuba','كوبا','كوبي','Cuban'),(196,'CY','CYP','Cyprus','قبرص','قبرصي','Cypriot'),(203,'CZ','CZE','Czech Republic','الجمهورية التشيكية','تشيكي','Czech'),(204,'BJ','BEN','Benin','بنين','بنيني','Beninese, Beninois'),(208,'DK','DNK','Denmark','الدانمارك','دنماركي','Danish'),(212,'DM','DMA','Dominica','دومينيكا','دومينيكي','Dominican'),(214,'DO','DOM','Dominican Republic','الجمهورية الدومينيكية','دومينيكي','Dominican'),(218,'EC','ECU','Ecuador','إكوادور','إكوادوري','Ecuadorian'),(222,'SV','SLV','El Salvador','إلسلفادور','سلفادوري','Salvadoran'),(226,'GQ','GNQ','Equatorial Guinea','غينيا الاستوائي','غيني','Equatorial Guinean, Equatoguinean'),(231,'ET','ETH','Ethiopia','أثيوبيا','أثيوبي','Ethiopian'),(232,'ER','ERI','Eritrea','إريتريا','إريتيري','Eritrean'),(233,'EE','EST','Estonia','استونيا','استوني','Estonian'),(234,'FO','FRO','Faroe Islands','جزر فارو','جزر فارو','Faroese'),(238,'FK','FLK','Falkland Islands (Malvinas)','جزر فوكلاند','فوكلاندي','Falkland Island'),(239,'GS','SGS','South Georgia and the South Sandwich Islands','جورجيا الجنوبية وجزر ساندويتش الجنوبية','لمنطقة القطبية الجنوبية','South Georgia or South Sandwich Islands'),(242,'FJ','FJI','Fiji','فيجي','فيجي','Fijian'),(246,'FI','FIN','Finland','فنلندا','فنلندي','Finnish'),(248,'AX','ALA','Åland Islands',NULL,'آلاندي','Åland Island'),(250,'FR','FRA','France','فرنسا','فرنسي','French'),(254,'GF','GUF','French Guiana','غيانا الفرنسية','غويانا الفرنسية','French Guianese'),(258,'PF','PYF','French Polynesia','بولينيزيا الفرنسية','بولينيزيي','French Polynesian'),(260,'TF','ATF','French Southern Territories','المناطق الجنوبية لفرنسا','أراض فرنسية جنوبية وأنتارتيكية','French Southern Territories'),(262,'DJ','DJI','Djibouti','جيبوتي','جيبوتي','Djiboutian'),(266,'GA','GAB','Gabon','الغابون','غابوني','Gabonese'),(268,'GE','GEO','Georgia','جيورجيا','جيورجي','Georgian'),(270,'GM','GMB','Gambia','غامبيا','غامبي','Gambian'),(275,'PS','PSE','Palestine, State of','فلسطين','فلسطيني','Palestinian'),(276,'DE','DEU','Germany','ألمانيا','ألماني','German'),(288,'GH','GHA','Ghana','غانا','غاني','Ghanaian'),(292,'GI','GIB','Gibraltar','جبل طارق','جبل طارق','Gibraltar'),(296,'KI','KIR','Kiribati','كيريباتي','كيريباتي','I-Kiribati'),(300,'GR','GRC','Greece','اليونان','يوناني','Greek, Hellenic'),(304,'GL','GRL','Greenland','جرينلاند','جرينلاندي','Greenlandic'),(308,'GD','GRD','Grenada','غرينادا','غرينادي','Grenadian'),(312,'GP','GLP','Guadeloupe','جوادلوب','جزر جوادلوب','Guadeloupe'),(316,'GU','GUM','Guam','جوام','جوامي','Guamanian, Guambat'),(320,'GT','GTM','Guatemala','غواتيمال','غواتيمالي','Guatemalan'),(324,'GN','GIN','Guinea','غينيا','غيني','Guinean'),(328,'GY','GUY','Guyana','غيانا','غياني','Guyanese'),(332,'HT','HTI','Haiti','هايتي','هايتي','Haitian'),(334,'HM','HMD','Heard Island and McDonald Islands','جزيرة هيرد وجزر ماكدونالد','جزيرة هيرد وجزر ماكدونالد','Heard Island or McDonald Islands'),(336,'VA','VAT','Vatican City State','الفاتيكان','فاتيكاني','Vatican'),(340,'HN','HND','Honduras','هندوراس','هندوراسي','Honduran'),(344,'HK','HKG','Hong Kong','هونغ كونغ','هونغ كونغي','Hong Kong, Hong Kongese'),(348,'HU','HUN','Hungary','المجر','مجري','Hungarian, Magyar'),(352,'IS','ISL','Iceland','آيسلندا','آيسلندي','Icelandic'),(356,'IN','IND','India','الهند','هندي','Indian'),(360,'ID','IDN','Indonesia','أندونيسيا','أندونيسيي','Indonesian'),(364,'IR','IRN','Iran','إيران','إيراني','Iranian, Persian'),(368,'IQ','IRQ','Iraq','العراق','عراقي','Iraqi'),(372,'IE','IRL','Ireland','إيرلندا','إيرلندي','Irish'),(380,'IT','ITA','Italy','إيطاليا','إيطالي','Italian'),(384,'CI','CIV','Côte d\'Ivoire','ساحل العاج','ساحل العاج','Ivorian'),(388,'JM','JAM','Jamaica','جمايكا','جمايكي','Jamaican'),(392,'JP','JPN','Japan','اليابان','ياباني','Japanese'),(398,'KZ','KAZ','Kazakhstan','كازاخستان','كازاخستاني','Kazakhstani, Kazakh'),(400,'JO','JOR','Jordan','الأردن','أردني','Jordanian'),(404,'KE','KEN','Kenya','كينيا','كيني','Kenyan'),(408,'KP','PRK','Korea (Democratic People\'s Republic of)','كوريا الشمالية','كوري','North Korean'),(410,'KR','KOR','Korea (Republic of)','كوريا الجنوبية','كوري','South Korean'),(414,'KW','KWT','Kuwait','الكويت','كويتي','Kuwaiti'),(417,'KG','KGZ','Kyrgyzstan','قيرغيزستان','قيرغيزستاني','Kyrgyzstani, Kyrgyz, Kirgiz, Kirghiz'),(418,'LA','LAO','Lao People\'s Democratic Republic','لاوس','لاوسي','Lao, Laotian'),(422,'LB','LBN','Lebanon','لبنان','لبناني','Lebanese'),(426,'LS','LSO','Lesotho','ليسوتو','ليوسيتي','Basotho'),(428,'LV','LVA','Latvia','لاتفيا','لاتيفي','Latvian'),(430,'LR','LBR','Liberia','ليبيريا','ليبيري','Liberian'),(434,'LY','LBY','Libya','ليبيا','ليبي','Libyan'),(438,'LI','LIE','Liechtenstein','ليختنشتين','ليختنشتيني','Liechtenstein'),(440,'LT','LTU','Lithuania','لتوانيا','لتوانيي','Lithuanian'),(442,'LU','LUX','Luxembourg','لوكسمبورغ','لوكسمبورغي','Luxembourg, Luxembourgish'),(446,'MO','MAC','Macao','ماكاو','ماكاوي','Macanese, Chinese'),(450,'MG','MDG','Madagascar','مدغشقر','مدغشقري','Malagasy'),(454,'MW','MWI','Malawi','مالاوي','مالاوي','Malawian'),(458,'MY','MYS','Malaysia','ماليزيا','ماليزي','Malaysian'),(462,'MV','MDV','Maldives','المالديف','مالديفي','Maldivian'),(466,'ML','MLI','Mali','مالي','مالي','Malian, Malinese'),(470,'MT','MLT','Malta','مالطا','مالطي','Maltese'),(474,'MQ','MTQ','Martinique','مارتينيك','مارتينيكي','Martiniquais, Martinican'),(478,'MR','MRT','Mauritania','موريتانيا','موريتانيي','Mauritanian'),(480,'MU','MUS','Mauritius','موريشيوس','موريشيوسي','Mauritian'),(484,'MX','MEX','Mexico','المكسيك','مكسيكي','Mexican'),(492,'MC','MCO','Monaco','موناكو','مونيكي','Monégasque, Monacan'),(496,'MN','MNG','Mongolia','منغوليا','منغولي','Mongolian'),(498,'MD','MDA','Moldova (Republic of)','مولدافيا','مولديفي','Moldovan'),(499,'ME','MNE','Montenegro','الجبل الأسو','الجبل الأسود','Montenegrin'),(500,'MS','MSR','Montserrat','مونتسيرات','مونتسيراتي','Montserratian'),(504,'MA','MAR','Morocco','المغرب','مغربي','Moroccan'),(508,'MZ','MOZ','Mozambique','موزمبيق','موزمبيقي','Mozambican'),(512,'OM','OMN','Oman','عُمان','عماني','Omani'),(516,'NA','NAM','Namibia','ناميبيا','ناميبي','Namibian'),(520,'NR','NRU','Nauru','نورو','نوري','Nauruan'),(524,'NP','NPL','Nepal','نيبال','نيبالي','Nepali, Nepalese'),(528,'NL','NLD','Netherlands','هولندا','هولندي','Dutch, Netherlandic'),(531,'CW','CUW','Curaçao','كوراكاو','كوراساوي','Curaçaoan'),(533,'AW','ABW','Aruba','أروبه','أوروبهيني','Aruban'),(534,'SX','SXM','Sint Maarten (Dutch part)','سانت مارتن','ساينت مارتني هولندي','Sint Maarten'),(535,'BQ','BES','Bonaire, Sint Eustatius and Saba','بونير وسانت يوستاتيوس وسابا','بونير وسانت يوستاتيوس وسابا','Bonaire, Sint Eustatius and Saba'),(540,'NC','NCL','New Caledonia','كاليدونيا الجديدة','كاليدوني','New Caledonian'),(548,'VU','VUT','Vanuatu','فانواتو','فانواتي','Ni-Vanuatu, Vanuatuan'),(554,'NZ','NZL','New Zealand','نيوزيلندا','نيوزيلندي','New Zealand, NZ'),(558,'NI','NIC','Nicaragua','نيكاراجوا','نيكاراجوي','Nicaraguan'),(562,'NE','NER','Niger','النيجر','نيجيري','Nigerien'),(566,'NG','NGA','Nigeria','نيجيريا','نيجيري','Nigerian'),(570,'NU','NIU','Niue','ني','ني','Niuean'),(574,'NF','NFK','Norfolk Island','جزيرة نورفولك','نورفوليكي','Norfolk Island'),(578,'NO','NOR','Norway','النرويج','نرويجي','Norwegian'),(580,'MP','MNP','Northern Mariana Islands','جزر ماريانا الشمالية','ماريني','Northern Marianan'),(581,'UM','UMI','United States Minor Outlying Islands','جزر الولايات المتحدة البعيدة الصغرى','جزر الولايات المتحدة البعيدة الصغرى','United States Minor Outlying Islands'),(583,'FM','FSM','Micronesia (Federated States of)','مايكرونيزيا','مايكرونيزيي','Micronesian'),(584,'MH','MHL','Marshall Islands','جزر مارشال','مارشالي','Marshallese'),(585,'PW','PLW','Palau','بالاو','بالاوي','Palauan'),(586,'PK','PAK','Pakistan','باكستان','باكستاني','Pakistani'),(591,'PA','PAN','Panama','بنما','بنمي','Panamanian'),(598,'PG','PNG','Papua New Guinea','بابوا غينيا الجديدة','بابوي','Papua New Guinean, Papuan'),(600,'PY','PRY','Paraguay','باراغواي','بارغاوي','Paraguayan'),(604,'PE','PER','Peru','بيرو','بيري','Peruvian'),(608,'PH','PHL','Philippines','الفليبين','فلبيني','Philippine, Filipino'),(612,'PN','PCN','Pitcairn','بيتكيرن','بيتكيرني','Pitcairn Island'),(616,'PL','POL','Poland','بولونيا','بوليني','Polish'),(620,'PT','PRT','Portugal','البرتغال','برتغالي','Portuguese'),(624,'GW','GNB','Guinea-Bissau','غينيا-بيساو','غيني','Bissau-Guinean'),(626,'TL','TLS','Timor-Leste','تيمور الشرقية','تيموري','Timorese'),(630,'PR','PRI','Puerto Rico','بورتو ريكو','بورتي','Puerto Rican'),(634,'QA','QAT','Qatar','قطر','قطري','Qatari'),(638,'RE','REU','Réunion','جمع شمل','ريونيوني','Réunionese, Réunionnais'),(642,'RO','ROU','Romania','رومانيا','روماني','Romanian'),(643,'RU','RUS','Russian Federation','روسيا','روسي','Russian'),(646,'RW','RWA','Rwanda','رواندا','رواندا','Rwandan'),(652,'BL','BLM','Saint Barthélemy','سانت بارتيليمي','سان بارتيلمي','Barthélemois'),(654,'SH','SHN','Saint Helena, Ascension and Tristan da Cunha','سانت هيلانة','هيلاني','Saint Helenian'),(659,'KN','KNA','Saint Kitts and Nevis','سانت كيتس ونيفس','سانت كيتس ونيفس','Kittitian or Nevisian'),(660,'AI','AIA','Anguilla','أنغويلا','أنغويلي','Anguillan'),(662,'LC','LCA','Saint Lucia','سانت لوسيا','سان بيير وميكلوني','Saint Lucian'),(663,'MF','MAF','Saint Martin (French part)','سانت مارتن','ساينت مارتني فرنسي','Saint-Martinoise'),(666,'PM','SPM','Saint Pierre and Miquelon','سان بيار وميكلون','سان بيار وميكلون','Saint-Pierrais or Miquelonnais'),(670,'VC','VCT','Saint Vincent and the Grenadines','سانت فنسنت وجزر غرينادين','سانت فنسنت وجزر غرينادين','Saint Vincentian, Vincentian'),(674,'SM','SMR','San Marino','سان مارينو','ماريني','Sammarinese'),(678,'ST','STP','Sao Tome and Principe','ساو تومي وبرينسيبي','ساو تومي وبرينسيبي','São Toméan'),(682,'SA','SAU','Saudi Arabia','المملكة العربية السعودية','سعودي','Saudi, Saudi Arabian'),(686,'SN','SEN','Senegal','السنغال','سنغالي','Senegalese'),(688,'RS','SRB','Serbia','جمهورية صربيا','صربي','Serbian'),(690,'SC','SYC','Seychelles','سيشيل','سيشيلي','Seychellois'),(694,'SL','SLE','Sierra Leone','سيراليون','سيراليوني','Sierra Leonean'),(702,'SG','SGP','Singapore','سنغافورة','سنغافوري','Singaporean'),(703,'SK','SVK','Slovakia','سلوفاكيا','سولفاكي','Slovak'),(704,'VN','VNM','Vietnam','فيتنام','فيتنامي','Vietnamese'),(705,'SI','SVN','Slovenia','سلوفينيا','سولفيني','Slovenian, Slovene'),(706,'SO','SOM','Somalia','الصومال','صومالي','Somali, Somalian'),(710,'ZA','ZAF','South Africa','جنوب أفريقيا','أفريقي','South African'),(716,'ZW','ZWE','Zimbabwe','زمبابوي','زمبابوي','Zimbabwean'),(724,'ES','ESP','Spain','إسبانيا','إسباني','Spanish'),(728,'SS','SSD','South Sudan','جنوب السودان','سوادني جنوبي','South Sudanese'),(729,'SD','SDN','Sudan','السودان','سوداني','Sudanese'),(732,'EH','ESH','Western Sahara','الصحراء الغربية','صحراوي','Sahrawi, Sahrawian, Sahraouian'),(740,'SR','SUR','Suriname','سورينام','سورينامي','Surinamese'),(744,'SJ','SJM','Svalbard and Jan Mayen','سفالبارد وجان مايان','سفالبارد ويان ماين','Svalbard'),(748,'SZ','SWZ','Swaziland','سوازيلند','سوازيلندي','Swazi'),(752,'SE','SWE','Sweden','السويد','سويدي','Swedish'),(756,'CH','CHE','Switzerland','سويسرا','سويسري','Swiss'),(760,'SY','SYR','Syrian Arab Republic','سوريا','سوري','Syrian'),(762,'TJ','TJK','Tajikistan','طاجيكستان','طاجيكستاني','Tajikistani'),(764,'TH','THA','Thailand','تايلندا','تايلندي','Thai'),(768,'TG','TGO','Togo','توغو','توغي','Togolese'),(772,'TK','TKL','Tokelau','توكيلاو','توكيلاوي','Tokelauan'),(776,'TO','TON','Tonga','تونغا','تونغي','Tongan'),(780,'TT','TTO','Trinidad and Tobago','ترينيداد وتوباغو','ترينيداد وتوباغو','Trinidadian or Tobagonian'),(784,'AE','ARE','United Arab Emirates','الإمارات العرب','إماراتي','Emirati, Emirian, Emiri'),(788,'TN','TUN','Tunisia','تونس','تونسي','Tunisian'),(792,'TR','TUR','Turkey','تركيا','تركي','Turkish'),(795,'TM','TKM','Turkmenistan','تركمانستان','تركمانستاني','Turkmen'),(796,'TC','TCA','Turks and Caicos Islands','جزر تركس وكايكوس','جزر توركس وكايكوس','Turks and Caicos Island'),(798,'TV','TUV','Tuvalu','توفالو','توفالي','Tuvaluan'),(800,'UG','UGA','Uganda','أوغندا','أوغندي','Ugandan'),(804,'UA','UKR','Ukraine','أوكرانيا','أوكراني','Ukrainian'),(807,'MK','MKD','Macedonia (the former Yugoslav Republic of)','مقدونيا','مقدوني','Macedonian'),(818,'EG','EGY','Egypt','مصر','مصري','Egyptian'),(826,'GB','GBR','United Kingdom of Great Britain and Northern Ireland','المملكة المتحدة','بريطاني','British, UK'),(831,'GG','GGY','Guernsey','غيرنسي','غيرنزي','Channel Island'),(832,'JE','JEY','Jersey','جيرسي','جيرزي','Channel Island'),(833,'IM','IMN','Isle of Man','جزيرة آيل أوف مان','ماني','Manx'),(834,'TZ','TZA','Tanzania, United Republic of','تنزانيا','تنزانيي','Tanzanian'),(840,'US','USA','United States of America','الولايات المتحدة','أمريكي','American'),(850,'VI','VIR','Virgin Islands (U.S.)','جزر العذراء الأمريكية','أمريكي','U.S. Virgin Island'),(854,'BF','BFA','Burkina Faso','بوركينا فاسو','بوركيني','Burkinabé'),(858,'UY','URY','Uruguay','أورغواي','أورغواي','Uruguayan'),(860,'UZ','UZB','Uzbekistan','أوزباكستان','أوزباكستاني','Uzbekistani, Uzbek'),(862,'VE','VEN','Venezuela (Bolivarian Republic of)','فنزويلا','فنزويلي','Venezuelan'),(876,'WF','WLF','Wallis and Futuna','واليس وفوتونا','فوتوني','Wallis and Futuna, Wallisian or Futunan'),(882,'WS','WSM','Samoa','المناطق','ساموي','Samoan'),(887,'YE','YEM','Yemen','اليمن','يمني','Yemeni'),(894,'ZM','ZMB','Zambia','زامبيا','زامبياني','Zambian');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries_tbl`
--

DROP TABLE IF EXISTS `countries_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries_tbl` (
  `id` int NOT NULL AUTO_INCREMENT,
  `region_id` int DEFAULT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `revision` bigint DEFAULT '0',
  `status` int DEFAULT '0',
  `slug` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_by` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `updated_by` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries_tbl`
--

LOCK TABLES `countries_tbl` WRITE;
/*!40000 ALTER TABLE `countries_tbl` DISABLE KEYS */;
INSERT INTO `countries_tbl` VALUES (42,NULL,NULL,1583867655,NULL,NULL,0,1,'DZ',NULL,NULL,NULL,10,0,NULL),(43,NULL,NULL,1583867655,NULL,NULL,0,1,'BH',NULL,NULL,NULL,10,0,NULL),(44,NULL,NULL,1583867655,NULL,NULL,0,1,'EG',NULL,NULL,NULL,10,0,NULL),(45,NULL,NULL,1583867655,NULL,NULL,0,1,'IQ',NULL,NULL,NULL,10,0,NULL),(46,NULL,NULL,1583867655,NULL,NULL,0,1,'JO',NULL,NULL,NULL,10,0,NULL),(47,NULL,NULL,1583867655,NULL,NULL,0,1,'KW',NULL,NULL,NULL,10,0,NULL),(48,NULL,NULL,1583867655,NULL,NULL,0,1,'LB',NULL,NULL,NULL,10,0,NULL),(49,NULL,NULL,1583867655,NULL,NULL,0,1,'LY',NULL,NULL,NULL,10,0,NULL),(50,NULL,NULL,1583867655,NULL,NULL,0,1,'MA',NULL,NULL,NULL,10,0,NULL),(51,NULL,NULL,1583867655,NULL,NULL,0,1,'MR',NULL,NULL,NULL,10,0,NULL),(52,NULL,NULL,1583867655,NULL,NULL,0,1,'OM',NULL,NULL,NULL,10,0,NULL),(53,NULL,NULL,1583867655,NULL,NULL,0,1,'PS',NULL,NULL,NULL,10,0,NULL),(54,NULL,NULL,1583867655,NULL,NULL,0,1,'QA',NULL,NULL,NULL,10,0,NULL),(55,NULL,NULL,1583867655,NULL,NULL,0,1,'SA',NULL,NULL,NULL,10,0,NULL),(56,NULL,NULL,1583867655,NULL,NULL,0,1,'SD',NULL,NULL,NULL,10,0,NULL),(57,NULL,NULL,1583867655,NULL,NULL,0,1,'SY',NULL,NULL,NULL,10,0,NULL),(58,NULL,NULL,1583867655,NULL,NULL,0,1,'TN',NULL,NULL,NULL,10,0,NULL),(59,NULL,NULL,1583867655,NULL,NULL,0,1,'AE',NULL,NULL,NULL,10,0,NULL),(60,NULL,NULL,1583867655,1757943213,NULL,0,1,'YE',NULL,'1',1757980800,10,0,NULL),(61,NULL,NULL,1583867655,NULL,NULL,0,1,'MENA',NULL,NULL,NULL,10,0,NULL),(62,NULL,NULL,1583867655,NULL,NULL,0,1,'OTHER',NULL,NULL,NULL,10,0,NULL),(63,NULL,NULL,1583867655,NULL,NULL,0,1,'GCC',NULL,NULL,NULL,10,0,NULL),(64,NULL,NULL,1583867655,NULL,NULL,0,1,'Levant',NULL,NULL,NULL,10,0,NULL),(65,NULL,NULL,1583867655,NULL,NULL,0,1,'NorthAfrica',NULL,NULL,NULL,10,0,NULL);
/*!40000 ALTER TABLE `countries_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries_tbl_lang`
--

DROP TABLE IF EXISTS `countries_tbl_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries_tbl_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `language` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `countries_tbl_lang_language` (`language`) USING BTREE,
  KEY `countries_tbl_lang_post_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries_tbl_lang`
--

LOCK TABLES `countries_tbl_lang` WRITE;
/*!40000 ALTER TABLE `countries_tbl_lang` DISABLE KEYS */;
INSERT INTO `countries_tbl_lang` VALUES (164,42,'en','Algeria'),(165,43,'en','Bahrain'),(166,44,'en','Egypt'),(167,45,'en','Iraq'),(168,46,'en','Jordan'),(169,47,'en','Kuwait'),(170,48,'en','Lebanon'),(171,49,'en','Libya'),(172,50,'en','Morocco'),(173,51,'en','Mauritania'),(174,52,'en','Oman'),(175,53,'en','Palestinian Territories'),(176,54,'en','Qatar'),(177,55,'en','Saudi Arabia'),(178,56,'en','Sudan'),(179,57,'en','Syria'),(180,58,'en','Tunisia'),(181,59,'en','United Arab Emirates'),(182,60,'en','Yemen'),(183,61,'en','MENA'),(184,62,'en','Other'),(185,63,'en','GCC'),(186,64,'en','Levant'),(187,65,'en','North Africa'),(188,60,'ar','يمن');
/*!40000 ALTER TABLE `countries_tbl_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `city_id` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`),
  KEY `page_status` (`status`) USING BTREE,
  KEY `city_id` (`city_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  KEY `idx-district-deleted_at` (`deleted_at`),
  KEY `idx-district-published_at` (`published_at`),
  CONSTRAINT `district_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `district_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `district_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7849 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (500,'out-of-amman',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(711,'abu-nsair',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(712,'shafa-badran',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(713,'tareq',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(714,'al-jubaiha',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(715,'swaileh',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(716,'tilaa-al-ali,-khalda-&-um-al-summaq',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(717,'al-abdali',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(718,'basman',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(719,'marka',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7110,'uhud',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7111,'al-naseer',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7112,'al-madeeneh',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7113,'zahran',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7114,'wadi-al-seer',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7115,'badr-al-jadeeda',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7116,'marj-al-hamam',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7117,'al-muqablain',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7118,'badr',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7119,'ras-al-ain',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7120,'al-yarmouk',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7121,'al-qwaismeh,-al-juwaideh,-abu-alanda-and-al-raqeem',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7122,'sahab',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7123,'al-mwaqqar',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7124,'khraibet-al-souq',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7125,'naour',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7126,'husban',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7127,'al-jeezeh',1,545,10,0,0,NULL,NULL,1,1,0,0,NULL),(7679,'qasabet-al-zarqa',1,556,10,0,0,NULL,NULL,1,1,0,0,NULL),(7680,'al-hashmieh',1,556,10,0,0,NULL,NULL,1,1,0,0,NULL),(7681,'al-rusaifeh',1,556,10,0,0,NULL,NULL,1,1,0,0,NULL),(7682,'qasabet-al-aqaba',1,546,10,0,0,NULL,NULL,1,1,0,0,NULL),(7683,'al-qweireh',1,546,10,0,0,NULL,NULL,1,1,0,0,NULL),(7684,'ebder',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7685,'abu-ziad-/-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7686,'abu-al-loqs',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7687,'arhaba',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7688,'erkhim',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7689,'al-ashrafieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7690,'al-baqoura',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7691,'al-birz',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7692,'al-bwaydah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7693,'al-jarm/-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7694,'al-himmah/-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7695,'al-khraj',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7696,'al-khreibeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7697,'al-thneibeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7698,'al-rasiah-/-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7699,'al-rafeed',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7700,'al-ramtha',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7701,'al-samt',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7702,'al-shajarah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7703,'al-turrah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7704,'al-tantour',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7705,'al-teebah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7706,'al-adasieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7707,'al-azieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7708,'al-oja-al-janoubieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7709,'al-oja-al-shamalieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7710,'al-qasfah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7711,'al-qeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7712,'al-mkheibeh-al-tahta',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7713,'al-mkheibeh-al-foga',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7714,'al-mazar',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7715,'al-yarmouk-1',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7716,'um-al-abar',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7717,'um-qais',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7718,'barishta',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7719,'bseileh/-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7720,'beit-idees',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7721,'beit-yafa',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7722,'tanbah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7723,'jijeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7724,'jheifeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7725,'jdeita',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7726,'jfein',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7727,'jamha',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7728,'jenin',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7729,'hatem',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7730,'hibras',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7731,'habka',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7732,'hartha',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7733,'hreima',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7734,'hofa-al-mazar',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7735,'hofa-al-wasatieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7736,'khirbet-izreet',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7737,'kharja',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7738,'dokra',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7739,'deir-abi-seed-al-sharqi',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7740,'deir-abi-seed-al-gharbi',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7741,'deir-al-birak',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7742,'deir-al-saaneh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7743,'deir-yousef',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7744,'zibdet-al-wasatieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7745,'zuhar',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7746,'zimal',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7747,'zobia',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7748,'sahem',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7749,'sama',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7750,'samar',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7751,'smou',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7752,'soum',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7753,'skhour-al-ghor',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7754,'samma',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7755,'samad',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7756,'saydour',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7757,'tabaqet-fahel',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7758,'aqraba',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7759,'anraweh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7760,'anbah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7761,'ghor-al-balawneh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7762,'ghor-al-wahadneh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7763,'ghor-farah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7764,'qallaat-ghor-al-arbeen',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7765,'qom',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7766,'qamim',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7767,'qanat-al-malek-abdullah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7768,'kabr',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7769,'kafer-asad',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7770,'kafer-al-maa',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7771,'kafer-rakeb',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7772,'kafer-rahta',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7773,'kafer-aan',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7774,'kafer-awan',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7775,'kafer-kifaya',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7776,'kafer-yoba',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7777,'kafrabeel',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7778,'kafersoum',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7779,'mkharba',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7780,'marhaba',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7781,'mazraet-tamerah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7782,'mazraet-khirbet-suwan',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7783,'muath',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7784,'malka',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7785,'mandah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7786,'al-barha',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7787,'al-huson',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7788,'al-rabieh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7789,'al-rawdah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7790,'al-sareeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7791,'al-mugheer',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7792,'al-manarah',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7793,'al-nuzha',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7794,'al-naseer-2',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7795,'al-neimeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7796,'al-hashmieh-2',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7797,'aydoun',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7798,'bushra',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7799,'beit-ras',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7800,'hikma',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7801,'huwara',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7802,'hour',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7803,'saal',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7804,'elaal',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7805,'foura',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7806,'kitem',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7807,'kafer-jayez',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7808,'mrou',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7809,'natfeh',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7810,'ham',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7811,'yebla',1,547,10,0,0,NULL,NULL,1,1,0,0,NULL),(7812,'qasabet-al-salt',1,555,10,0,0,NULL,NULL,1,1,0,0,NULL),(7813,'deir-alla',1,555,10,0,0,NULL,NULL,1,1,0,0,NULL),(7814,'ein-al-basha',1,555,10,0,0,NULL,NULL,1,1,0,0,NULL),(7815,'al-shouneh-al-janoubieh',1,555,10,0,0,NULL,NULL,1,1,0,0,NULL),(7816,'mahes-&-fuheis',1,555,10,0,0,NULL,NULL,1,1,0,0,NULL),(7817,'qasabet-maan',1,550,10,0,0,NULL,NULL,1,1,0,0,NULL),(7818,'petra',1,550,10,0,0,NULL,NULL,1,1,0,0,NULL),(7819,'al-shobak',1,550,10,0,0,NULL,NULL,1,1,0,0,NULL),(7820,'al-husainieh',1,550,10,0,0,NULL,NULL,1,1,0,0,NULL),(7821,'qasabet-al-mafraq',1,551,10,0,0,NULL,NULL,1,1,0,0,NULL),(7822,'al-badieh-al-shamalieh',1,551,10,0,0,NULL,NULL,1,1,0,0,NULL),(7823,'al-rweished',1,551,10,0,0,NULL,NULL,1,1,0,0,NULL),(7824,'al-badieh-al-shamalieh-al-gharbieh',1,551,10,0,0,NULL,NULL,1,1,0,0,NULL),(7825,'qasabet-madaba',1,553,10,0,0,NULL,NULL,1,1,0,0,NULL),(7826,'thiban',1,553,10,0,0,NULL,NULL,1,1,0,0,NULL),(7827,'qasabet-ajloun',1,548,10,0,0,NULL,NULL,1,1,0,0,NULL),(7828,'kafranja',1,548,10,0,0,NULL,NULL,1,1,0,0,NULL),(7829,'qasabet-al-karak',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7830,'al-mazar-al-janoubi',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7831,'al-qaser',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7832,'faqou',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7833,'al-aghwar-al-janoubieh',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7834,'eei',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7835,'al-qatraneh',1,549,10,0,0,NULL,NULL,1,1,0,0,NULL),(7836,'qasabet-al-tafileh',1,554,10,0,0,NULL,NULL,1,1,0,0,NULL),(7837,'al-hasa',1,554,10,0,0,NULL,NULL,1,1,0,0,NULL),(7838,'bseirah',1,554,10,0,0,NULL,NULL,1,1,0,0,NULL),(7839,'qasabet-jerash',1,557,10,0,0,NULL,1682953841,1,1,0,0,NULL),(7841,'um-uthaina',1,545,10,1724198400,1724229709,1724229709,NULL,1,1,0,0,NULL),(7842,'al-qubeh-circle',1,547,10,1724198400,1724230103,1724230103,NULL,1,1,0,0,NULL),(7843,'third-circle',1,545,10,1728432000,1728458349,1728458349,NULL,1,1,0,0,NULL),(7844,'dabouq',1,545,10,1728432000,1728458409,1728458409,NULL,1,1,0,0,NULL),(7845,'airport-road',1,545,10,1728432000,1728460356,1728460356,NULL,1,1,0,0,NULL),(7846,'dahyet-al-nakhee',1,545,10,1728432000,1728460398,1728460398,NULL,1,1,0,0,NULL),(7847,'al-thahir',1,545,10,1728432000,1728460599,1728460599,NULL,1,1,0,0,NULL),(7848,'queen-rania-st',1,545,10,1728432000,1728465946,1728465946,NULL,1,1,0,0,NULL);
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district_lang`
--

DROP TABLE IF EXISTS `district_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `city_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `district_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `district_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `district` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district_lang`
--

LOCK TABLES `district_lang` WRITE;
/*!40000 ALTER TABLE `district_lang` DISABLE KEYS */;
INSERT INTO `district_lang` VALUES (37,500,'en','Out Of Amman'),(38,711,'en','Abu Nsair'),(39,712,'en','Shafa Badran'),(40,713,'en','Tareq'),(41,714,'en','Al Jubaiha'),(42,715,'en','Swaileh'),(43,716,'en','Tilaa Al Ali, Khalda & Um Al Summaq'),(44,717,'en','Al Abdali'),(45,718,'en','Basman'),(46,719,'en','Marka'),(47,7110,'en','Uhud'),(48,7111,'en','Al Naseer'),(49,7112,'en','Al Madeeneh'),(50,7113,'en','Zahran'),(51,7114,'en','Wadi Al Seer'),(52,7115,'en','Badr Al Jadeeda'),(53,7116,'en','Marj Al Hamam'),(54,7117,'en','Al Muqablain'),(55,7118,'en','Badr'),(56,7119,'en','Ras Al Ain'),(57,7120,'en','Al Yarmouk'),(58,7121,'en','Al Qwaismeh, Al Juwaideh, Abu Alanda And Al Raqeem'),(59,7122,'en','Sahab'),(60,7123,'en','Al Mwaqqar'),(61,7124,'en','Khraibet Al Souq'),(62,7125,'en','Naour'),(63,7126,'en','Husban'),(64,7127,'en','Al Jeezeh'),(65,7679,'en','Qasabet Al Zarqa'),(66,7680,'en','Al Hashmieh'),(67,7681,'en','Al Rusaifeh'),(68,7682,'en','Qasabet Al Aqaba'),(69,7683,'en','Al Qweireh'),(70,7684,'en','Ebder'),(71,7685,'en','Abu Ziad / Ghor Al Arbeen'),(72,7686,'en','Abu Al Loqs'),(73,7687,'en','Arhaba'),(74,7688,'en','Erkhim'),(75,7689,'en','Al Ashrafieh'),(76,7690,'en','Al Baqoura'),(77,7691,'en','Al Birz'),(78,7692,'en','Al Bwaydah'),(79,7693,'en','Al Jarm/ Ghor Al Arbeen'),(80,7694,'en','Al Himmah/ Ghor Al Arbeen'),(81,7695,'en','Al Khraj'),(82,7696,'en','Al Khreibeh'),(83,7697,'en','Al Thneibeh'),(84,7698,'en','Al Rasiah / Ghor Al Arbeen'),(85,7699,'en','Al Rafeed'),(86,7700,'en','Al Ramtha'),(87,7701,'en','Al Samt'),(88,7702,'en','Al Shajarah'),(89,7703,'en','Al Turrah'),(90,7704,'en','Al Tantour'),(91,7705,'en','Al Teebah'),(92,7706,'en','Al Adasieh'),(93,7707,'en','Al Azieh'),(94,7708,'en','Al Oja Al Janoubieh'),(95,7709,'en','Al Oja Al Shamalieh'),(96,7710,'en','Al Qasfah'),(97,7711,'en','Al Qeen'),(98,7712,'en','Al Mkheibeh Al Tahta'),(99,7713,'en','Al Mkheibeh Al Foga'),(100,7714,'en','Al Mazar'),(101,7715,'en','Al Yarmouk'),(102,7716,'en','Um Al Abar'),(103,7717,'en','Um Qais'),(104,7718,'en','Barishta'),(105,7719,'en','Bseileh/ Ghor Al Arbeen'),(106,7720,'en','Beit Idees'),(107,7721,'en','Beit Yafa'),(108,7722,'en','Tanbah'),(109,7723,'en','Jijeen'),(110,7724,'en','Jheifeh'),(111,7725,'en','Jdeita'),(112,7726,'en','Jfein'),(113,7727,'en','Jamha'),(114,7728,'en','Jenin'),(115,7729,'en','Hatem'),(116,7730,'en','Hibras'),(117,7731,'en','Habka'),(118,7732,'en','Hartha'),(119,7733,'en','Hreima'),(120,7734,'en','Hofa Al Mazar'),(121,7735,'en','Hofa Al Wasatieh'),(122,7736,'en','Khirbet Izreet'),(123,7737,'en','Kharja'),(124,7738,'en','Dokra'),(125,7739,'en','Deir Abi Seed Al Sharqi'),(126,7740,'en','Deir Abi Seed Al Gharbi'),(127,7741,'en','Deir Al Birak'),(128,7742,'en','Deir Al Saaneh'),(129,7743,'en','Deir Yousef'),(130,7744,'en','Zibdet Al Wasatieh'),(131,7745,'en','Zuhar'),(132,7746,'en','Zimal'),(133,7747,'en','Zobia'),(134,7748,'en','Sahem'),(135,7749,'en','Sama'),(136,7750,'en','Samar'),(137,7751,'en','Smou'),(138,7752,'en','Soum'),(139,7753,'en','Skhour Al Ghor'),(140,7754,'en','Samma'),(141,7755,'en','Samad'),(142,7756,'en','Saydour'),(143,7757,'en','Tabaqet Fahel'),(144,7758,'en','Aqraba'),(145,7759,'en','Anraweh'),(146,7760,'en','Anbah'),(147,7761,'en','Ghor Al Balawneh'),(148,7762,'en','Ghor Al Wahadneh'),(149,7763,'en','Ghor Farah'),(150,7764,'en','Qallaat Ghor Al Arbeen'),(151,7765,'en','Qom'),(152,7766,'en','Qamim'),(153,7767,'en','Qanat Al Malek Abdullah'),(154,7768,'en','Kabr'),(155,7769,'en','Kafer Asad'),(156,7770,'en','Kafer Al Maa'),(157,7771,'en','Kafer Rakeb'),(158,7772,'en','Kafer Rahta'),(159,7773,'en','Kafer Aan'),(160,7774,'en','Kafer Awan'),(161,7775,'en','Kafer Kifaya'),(162,7776,'en','Kafer Yoba'),(163,7777,'en','Kafrabeel'),(164,7778,'en','Kafersoum'),(165,7779,'en','Mkharba'),(166,7780,'en','Marhaba'),(167,7781,'en','Mazraet Tamerah'),(168,7782,'en','Mazraet Khirbet Suwan'),(169,7783,'en','Muath'),(170,7784,'en','Malka'),(171,7785,'en','Mandah'),(172,7786,'en','Al Barha'),(173,7787,'en','Al Huson'),(174,7788,'en','Al Rabieh'),(175,7789,'en','Al Rawdah'),(176,7790,'en','Al Sareeh'),(177,7791,'en','Al Mugheer'),(178,7792,'en','Al Manarah'),(179,7793,'en','Al Nuzha'),(180,7794,'en','Al Naseer'),(181,7795,'en','Al Neimeh'),(182,7796,'en','Al Hashmieh'),(183,7797,'en','Aydoun'),(184,7798,'en','Bushra'),(185,7799,'en','Beit Ras'),(186,7800,'en','Hikma'),(187,7801,'en','Huwara'),(188,7802,'en','Hour'),(189,7803,'en','Saal'),(190,7804,'en','Elaal'),(191,7805,'en','Foura'),(192,7806,'en','Kitem'),(193,7807,'en','Kafer Jayez'),(194,7808,'en','Mrou'),(195,7809,'en','Natfeh'),(196,7810,'en','Ham'),(197,7811,'en','Yebla'),(198,7812,'en','Qasabet Al Salt'),(199,7813,'en','Deir Alla'),(200,7814,'en','Ein Al Basha'),(201,7815,'en','Al Shouneh Al Janoubieh'),(202,7816,'en','Mahes & Fuheis'),(203,7817,'en','Qasabet Maan'),(204,7818,'en','Petra'),(205,7819,'en','Al Shobak'),(206,7820,'en','Al Husainieh'),(207,7821,'en','Qasabet Al Mafraq'),(208,7822,'en','Al Badieh Al Shamalieh'),(209,7823,'en','Al Rweished'),(210,7824,'en','Al Badieh Al Shamalieh Al Gharbieh'),(211,7825,'en','Qasabet Madaba'),(212,7826,'en','Thiban'),(213,7827,'en','Qasabet Ajloun'),(214,7828,'en','Kafranja'),(215,7829,'en','Qasabet Al Karak'),(216,7830,'en','Al Mazar Al Janoubi'),(217,7831,'en','Al Qaser'),(218,7832,'en','Faqou'),(219,7833,'en','Al Aghwar Al Janoubieh'),(220,7834,'en','Eei'),(221,7835,'en','Al Qatraneh'),(222,7836,'en','Qasabet Al Tafileh'),(223,7837,'en','Al Hasa'),(224,7838,'en','Bseirah'),(225,7839,'en','Qasabet Jerash a'),(226,500,'ar','خارج عمان'),(227,711,'ar','ابو نصير'),(228,712,'ar','شفا بدران'),(229,713,'ar','طارق'),(230,714,'ar','الجبيهة'),(231,715,'ar','صويلح'),(232,716,'ar','تلاع العلي وأم السماق و خلدا'),(233,717,'ar','العبدلي'),(234,718,'ar','بسمان'),(235,719,'ar','ماركا'),(236,7110,'ar','أحد'),(237,7111,'ar','النصر'),(238,7112,'ar','المدينة'),(239,7113,'ar','زهران'),(240,7114,'ar','وادي السير'),(241,7115,'ar','بدر الجديدة'),(242,7116,'ar','مرج الحمام'),(243,7117,'ar','المقابلين'),(244,7118,'ar','بدر'),(245,7119,'ar','رأس العين'),(246,7120,'ar','اليرموك'),(247,7121,'ar','القويسمة والجويدة وأبو علندا والرقيم'),(248,7122,'ar','سحاب'),(249,7123,'ar','الموقر'),(250,7124,'ar','خريبة السوق'),(251,7125,'ar','ناعور'),(252,7126,'ar','حسبان'),(253,7127,'ar','الجيزة'),(254,7679,'ar','قصبة الزرقاء'),(255,7680,'ar','الهاشمية'),(256,7681,'ar','الرصيفة'),(257,7682,'ar','قصبة العقبة'),(258,7683,'ar','القويرة'),(259,7684,'ar','ابدر'),(260,7685,'ar','ابو زياد/غور الاربعين'),(261,7686,'ar','ابو اللوقس'),(262,7687,'ar','ارحابا'),(263,7688,'ar','ارخيم'),(264,7689,'ar','الاشرفية'),(265,7690,'ar','الباقورة'),(266,7691,'ar','البرز'),(267,7692,'ar','البويضة'),(268,7693,'ar','الجرم/غور الاربعين'),(269,7694,'ar','الحمه/غور الاربعين'),(270,7695,'ar','الخراج'),(271,7696,'ar','الخريبة'),(272,7697,'ar','الذنيبة'),(273,7698,'ar','الراسيه/غور الاربعين'),(274,7699,'ar','الرفيد'),(275,7700,'ar','الرمثا'),(276,7701,'ar','السمط'),(277,7702,'ar','الشجرة'),(278,7703,'ar','الطرة'),(279,7704,'ar','الطنطور'),(280,7705,'ar','الطيبة'),(281,7706,'ar','العدسية'),(282,7707,'ar','العزيه'),(283,7708,'ar','العوجا الجنوبيه'),(284,7709,'ar','العوجا الشمالية'),(285,7710,'ar','القصفه'),(286,7711,'ar','القين'),(287,7712,'ar','المخيبه التحتا'),(288,7713,'ar','المخيبه الفوقا'),(289,7714,'ar','المزار'),(290,7715,'ar','اليرموك'),(291,7716,'ar','ام الابار'),(292,7717,'ar','ام قيس'),(293,7718,'ar','بارشتا'),(294,7719,'ar','بصيله/غور الاربعين'),(295,7720,'ar','بيت ايدس'),(296,7721,'ar','بيت يافا'),(297,7722,'ar','تبنه'),(298,7723,'ar','ججين'),(299,7724,'ar','جحفية'),(300,7725,'ar','جديتا'),(301,7726,'ar','جفين'),(302,7727,'ar','جمحه'),(303,7728,'ar','جنين'),(304,7729,'ar','حاتم'),(305,7730,'ar','حبراص'),(306,7731,'ar','حبكا'),(307,7732,'ar','حرثا'),(308,7733,'ar','حريما'),(309,7734,'ar','حوفا المزار'),(310,7735,'ar','حوفا الوسطيه'),(311,7736,'ar','خربة عزريت'),(312,7737,'ar','خرجا'),(313,7738,'ar','دوقره'),(314,7739,'ar','دير ابي سعيد الشرقي'),(315,7740,'ar','دير ابي سعيد الغربي'),(316,7741,'ar','دير البرك'),(317,7742,'ar','دير السعنة'),(318,7743,'ar','دير يوسف'),(319,7744,'ar','زبدة الوسطية'),(320,7745,'ar','زحر'),(321,7746,'ar','زمال'),(322,7747,'ar','زوبيا'),(323,7748,'ar','سحم'),(324,7749,'ar','سما'),(325,7750,'ar','سمر'),(326,7751,'ar','سموع'),(327,7752,'ar','سوم'),(328,7753,'ar','صخور الغور'),(329,7754,'ar','صما'),(330,7755,'ar','صمد'),(331,7756,'ar','صيدور'),(332,7757,'ar','طبقة فحل'),(333,7758,'ar','عقربا'),(334,7759,'ar','عمراوة'),(335,7760,'ar','عنبه'),(336,7761,'ar','غور البلاونه'),(337,7762,'ar','غور الوهادنه'),(338,7763,'ar','غور فاره'),(339,7764,'ar','قلاعات غور الاربعين'),(340,7765,'ar','قم'),(341,7766,'ar','قميم'),(342,7767,'ar','قناة الملك عبدالله'),(343,7768,'ar','كبر'),(344,7769,'ar','كفر اسد'),(345,7770,'ar','كفر الماء'),(346,7771,'ar','كفر راكب'),(347,7772,'ar','كفر رحتا'),(348,7773,'ar','كفر عان'),(349,7774,'ar','كفر عوان'),(350,7775,'ar','كفر كيفيا'),(351,7776,'ar','كفر يوبا'),(352,7777,'ar','كفرابيل'),(353,7778,'ar','كفرسوم'),(354,7779,'ar','مخربا'),(355,7780,'ar','مرحبا'),(356,7781,'ar','مزرعة تميره'),(357,7782,'ar','مزرعة خربة الصوان'),(358,7783,'ar','معاذ'),(359,7784,'ar','ملكا'),(360,7785,'ar','مندح'),(361,7786,'ar','البارحة'),(362,7787,'ar','الحصن'),(363,7788,'ar','الرابية'),(364,7789,'ar','الروضة'),(365,7790,'ar','الصريح'),(366,7791,'ar','المغير'),(367,7792,'ar','المنارة'),(368,7793,'ar','النزهة'),(369,7794,'ar','النصر'),(370,7795,'ar','النعيمة'),(371,7796,'ar','الهاشمية'),(372,7797,'ar','ايدون'),(373,7798,'ar','بشرى'),(374,7799,'ar','بيت راس'),(375,7800,'ar','حكما'),(376,7801,'ar','حوارة'),(377,7802,'ar','حور'),(378,7803,'ar','سال'),(379,7804,'ar','علعال'),(380,7805,'ar','فوعرا'),(381,7806,'ar','كتم'),(382,7807,'ar','كفرجايز'),(383,7808,'ar','مرو'),(384,7809,'ar','ناطفه'),(385,7810,'ar','هام'),(386,7811,'ar','يبلا'),(387,7812,'ar','قصبة السلط'),(388,7813,'ar','دير علا'),(389,7814,'ar','عين الباشا'),(390,7815,'ar','الشونة الجنوبية'),(391,7816,'ar','ماحص والفحيص'),(392,7817,'ar','قصبة معان'),(393,7818,'ar','البتــراء'),(394,7819,'ar','الشوبك'),(395,7820,'ar','الحسينيه'),(396,7821,'ar','قصبة المفرق'),(397,7822,'ar','البادية الشمالية'),(398,7823,'ar','الرويشد'),(399,7824,'ar','البادية الشمالية الغربية'),(400,7825,'ar','قصبة مادبا'),(401,7826,'ar','ذيبان'),(402,7827,'ar','قصبة عجلون'),(403,7828,'ar','كفرنجه'),(404,7829,'ar','قصبة الكرك'),(405,7830,'ar','المزار الجنوبي'),(406,7831,'ar','القصـــــــر'),(407,7832,'ar','فقـــــــوع'),(408,7833,'ar','الأغوار الجنوبية'),(409,7834,'ar','عــي'),(410,7835,'ar','القــطـرانــة'),(411,7836,'ar','قصـبـة الطفيلــة'),(412,7837,'ar','الـحســا'),(413,7838,'ar','بصــيــرا'),(414,7839,'ar','قصبة جرش'),(417,7841,'en','Um Uthaina,'),(418,7841,'ar',' أم أذينة'),(419,7842,'en',' Al Qubeh Circle'),(420,7842,'ar','دوار القبة'),(421,7843,'en','Third circle'),(422,7843,'ar','الدوار الثالث'),(423,7844,'en','Dabouq'),(424,7844,'ar','دابوق'),(425,7845,'en',' Airport road'),(426,7845,'ar','طريق المطار'),(427,7846,'en',' Dahyet Al Nakhee'),(428,7846,'ar','ضاحية النخيل'),(429,7847,'en','Al Thahir '),(430,7847,'ar','الظهير'),(431,7848,'en','Queen Rania St.'),(432,7848,'ar','شارع الملكة رانيا');
/*!40000 ALTER TABLE `district_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dropdown_list`
--

DROP TABLE IF EXISTS `dropdown_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropdown_list` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `category` varchar(255) NOT NULL,
  `self_parent_id` bigint unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`),
  KEY `idx-dropdown_list_status` (`status`),
  KEY `idx-dropdown_list_category` (`category`),
  KEY `dropdown_list_ibfk_1` (`created_by`),
  KEY `dropdown_list_ibfk_2` (`updated_by`),
  KEY `idx-dropdown_list_deleted_at` (`deleted_at`),
  KEY `idx-dropdown_list_published_at` (`published_at`),
  CONSTRAINT `dropdown_list_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `dropdown_list_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dropdown_list`
--

LOCK TABLES `dropdown_list` WRITE;
/*!40000 ALTER TABLE `dropdown_list` DISABLE KEYS */;
INSERT INTO `dropdown_list` VALUES (1,'news-ticker',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,10,0,0,NULL),(2,'home-hero',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,11,0,0,NULL),(3,'why-abs',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,12,0,0,NULL),(4,'why-abs-features',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,13,0,0,NULL),(5,'facts-figures',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,14,0,0,NULL),(6,'home-schools',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,15,0,0,NULL),(7,'academic-achievements',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,16,0,0,NULL),(8,'accreditations',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,17,0,0,NULL),(9,'testimonials',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,18,0,0,NULL),(10,'notable-alumni',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,19,0,0,NULL),(11,'student-engagement-intro',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,20,0,0,NULL),(12,'tuition-registration-fees',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,21,0,0,NULL),(13,'tuition-transport',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,22,0,0,NULL),(14,'tuition-policies',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,23,0,0,NULL),(15,'admissions-procedure',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,24,0,0,NULL),(16,'apply-now',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,25,0,0,NULL),(17,'guiding-statement',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,26,0,0,NULL),(18,'development-department',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,27,0,0,NULL),(19,'employment',1,'Bms Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,28,0,0,NULL),(20,'board-of-trustees',1,'Team Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(21,'senior-leadership-team',1,'Team Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(22,'staff',1,'Team Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(23,'school-news',1,'News Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(24,'alumni-news',1,'News Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(25,'our-campus',1,'Album Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(26,'student-engagement',1,'Album Category',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(27,'general-enquiry',1,'Subjects',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(28,'admissions',1,'Subjects',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(29,'book-a-tour',1,'Subjects',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(30,'alumni-status-alumnus-alumna',1,'Alumni Status',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(31,'alumni-status-former-student',1,'Alumni Status',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(32,'alumni-status-friend-of-abs',1,'Alumni Status',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(33,'alumni-activities-reunions',1,'Alumni Activities',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(34,'alumni-activities-mentoring-students',1,'Alumni Activities',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(35,'alumni-activities-career-talks',1,'Alumni Activities',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(36,'alumni-activities-volunteering',1,'Alumni Activities',NULL,1792518776,1792518776,NULL,1792518776,1,1,4,0,0,NULL),(37,'class-note-type-career-update',1,'Class Note Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(38,'class-note-type-education-update',1,'Class Note Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(39,'class-note-type-family-news',1,'Class Note Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(40,'class-note-type-achievement-award',1,'Class Note Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,4,0,0,NULL),(41,'class-note-type-other',1,'Class Note Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,5,0,0,NULL),(42,'giving-designation-where-most-needed',1,'Giving Designation',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(43,'giving-designation-scholarships-bursaries',1,'Giving Designation',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(44,'giving-designation-campus-development',1,'Giving Designation',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(45,'giving-designation-arts-athletics',1,'Giving Designation',NULL,1792518776,1792518776,NULL,1792518776,1,1,4,0,0,NULL),(46,'giving-tribute-none',1,'Giving Tribute',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(47,'giving-tribute-in-honor-of',1,'Giving Tribute',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(48,'giving-tribute-in-memory-of',1,'Giving Tribute',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(49,'name-title-mr',1,'Name Title',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(50,'name-title-mrs',1,'Name Title',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(51,'name-title-ms',1,'Name Title',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(52,'name-title-dr',1,'Name Title',NULL,1792518776,1792518776,NULL,1792518776,1,1,4,0,0,NULL),(53,'donor-type-alumnus-alumna',1,'Donor Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,0,NULL),(54,'donor-type-parent',1,'Donor Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,2,0,0,NULL),(55,'donor-type-grandparent',1,'Donor Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,3,0,0,NULL),(56,'donor-type-staff',1,'Donor Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,4,0,0,NULL),(57,'donor-type-friend-of-abs',1,'Donor Type',NULL,1792518776,1792518776,NULL,1792518776,1,1,5,0,0,NULL);
/*!40000 ALTER TABLE `dropdown_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dropdown_list_lang`
--

DROP TABLE IF EXISTS `dropdown_list_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropdown_list_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `brief` varchar(1000) DEFAULT NULL,
  `content` text,
  `image_id` bigint unsigned DEFAULT NULL,
  `second_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `dropdown_list_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `dropdown_list_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `dropdown_list_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `dropdown_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dropdown_list_lang`
--

LOCK TABLES `dropdown_list_lang` WRITE;
/*!40000 ALTER TABLE `dropdown_list_lang` DISABLE KEYS */;
INSERT INTO `dropdown_list_lang` VALUES (1,1,'en','Header News Ticker',NULL,NULL,NULL,NULL),(2,1,'ar','شريط الأخبار',NULL,NULL,NULL,NULL),(3,2,'en','Home Hero',NULL,NULL,NULL,NULL),(4,2,'ar','واجهة الصفحة الرئيسية',NULL,NULL,NULL,NULL),(5,3,'en','Home - Why ABS',NULL,NULL,NULL,NULL),(6,3,'ar','الرئيسية - لماذا ABS',NULL,NULL,NULL,NULL),(7,4,'en','Home - Why ABS Features',NULL,NULL,NULL,NULL),(8,4,'ar','الرئيسية - مميزات ABS',NULL,NULL,NULL,NULL),(9,5,'en','Home - Facts & Figures',NULL,NULL,NULL,NULL),(10,5,'ar','الرئيسية - حقائق وأرقام',NULL,NULL,NULL,NULL),(11,6,'en','Home - Schools Cards',NULL,NULL,NULL,NULL),(12,6,'ar','الرئيسية - بطاقات المدارس',NULL,NULL,NULL,NULL),(13,7,'en','Home - Academic Achievements',NULL,NULL,NULL,NULL),(14,7,'ar','الرئيسية - الإنجازات الأكاديمية',NULL,NULL,NULL,NULL),(15,8,'en','Home - Accreditations & Recognitions',NULL,NULL,NULL,NULL),(16,8,'ar','الرئيسية - الاعتمادات',NULL,NULL,NULL,NULL),(17,9,'en','Home - Voices of ABS',NULL,NULL,NULL,NULL),(18,9,'ar','الرئيسية - آراء مجتمع ABS',NULL,NULL,NULL,NULL),(19,10,'en','Home - Notable Alumni',NULL,NULL,NULL,NULL),(20,10,'ar','الرئيسية - خريجون متميزون',NULL,NULL,NULL,NULL),(21,11,'en','Student Engagement Intro',NULL,NULL,NULL,NULL),(22,11,'ar','مقدمة الأنشطة الطلابية',NULL,NULL,NULL,NULL),(23,12,'en','Tuition - Initial Registration Fees',NULL,NULL,NULL,NULL),(24,12,'ar','الرسوم - رسوم التسجيل',NULL,NULL,NULL,NULL),(25,13,'en','Tuition - Transport Fees',NULL,NULL,NULL,NULL),(26,13,'ar','الرسوم - رسوم المواصلات',NULL,NULL,NULL,NULL),(27,14,'en','Tuition - Payment & Withdrawal Policies',NULL,NULL,NULL,NULL),(28,14,'ar','الرسوم - سياسات الدفع والانسحاب',NULL,NULL,NULL,NULL),(29,15,'en','Page - Admissions Procedure Steps',NULL,NULL,NULL,NULL),(30,15,'ar','صفحة - خطوات القبول',NULL,NULL,NULL,NULL),(31,16,'en','Page - Apply Now Tabs',NULL,NULL,NULL,NULL),(32,16,'ar','صفحة - تبويبات التقديم',NULL,NULL,NULL,NULL),(33,17,'en','Page - Guiding Statement Values',NULL,NULL,NULL,NULL),(34,17,'ar','صفحة - القيم',NULL,NULL,NULL,NULL),(35,18,'en','Page - Development Department Cards',NULL,NULL,NULL,NULL),(36,18,'ar','صفحة - بطاقات دائرة التطوير',NULL,NULL,NULL,NULL),(37,19,'en','Page - Employment Tabs',NULL,NULL,NULL,NULL),(38,19,'ar','صفحة - تبويبات التوظيف',NULL,NULL,NULL,NULL),(39,20,'en','Board of Trustees',NULL,'<p>Guiding our vision with expertise, dedication, and a shared commitment to academic excellence since 1981.</p>',NULL,'Leadership'),(40,20,'ar','مجلس الأمناء',NULL,'<p>نوجّه رؤيتنا بالخبرة والتفاني والالتزام المشترك بالتميّز الأكاديمي منذ عام 1981.</p>',NULL,'القيادة'),(41,21,'en','Senior Leadership Team',NULL,'<p>Driving academic excellence, innovation, and holistic student success across the Amman Baccalaureate School community.</p>',NULL,'Executive Leadership'),(42,21,'ar','فريق القيادة العليا',NULL,'<p>نقود التميّز الأكاديمي والابتكار والنجاح الشامل للطلبة في مجتمع مدرسة البكالوريا - عمان.</p>',NULL,'القيادة التنفيذية'),(43,22,'en','Staff',NULL,NULL,NULL,NULL),(44,22,'ar','الكادر',NULL,NULL,NULL,NULL),(45,23,'en','School News',NULL,NULL,NULL,NULL),(46,23,'ar','أخبار المدرسة',NULL,NULL,NULL,NULL),(47,24,'en','Alumni News',NULL,NULL,NULL,NULL),(48,24,'ar','أخبار الخريجين',NULL,NULL,NULL,NULL),(49,25,'en','Our Campus',NULL,NULL,NULL,NULL),(50,25,'ar','حرمنا المدرسي',NULL,NULL,NULL,NULL),(51,26,'en','Student Engagement',NULL,NULL,NULL,NULL),(52,26,'ar','الأنشطة الطلابية',NULL,NULL,NULL,NULL),(53,27,'en','General Enquiry',NULL,NULL,NULL,NULL),(54,27,'ar','استفسار عام',NULL,NULL,NULL,NULL),(55,28,'en','Admissions',NULL,NULL,NULL,NULL),(56,28,'ar','القبول',NULL,NULL,NULL,NULL),(57,29,'en','Book a Tour',NULL,NULL,NULL,NULL),(58,29,'ar','حجز جولة',NULL,NULL,NULL,NULL),(59,30,'en','Alumnus / Alumna',NULL,NULL,NULL,NULL),(60,30,'ar','خريج / خريجة',NULL,NULL,NULL,NULL),(61,31,'en','Former Student',NULL,NULL,NULL,NULL),(62,31,'ar','طالب سابق',NULL,NULL,NULL,NULL),(63,32,'en','Friend of ABS',NULL,NULL,NULL,NULL),(64,32,'ar','صديق المدرسة',NULL,NULL,NULL,NULL),(65,33,'en','Reunions',NULL,NULL,NULL,NULL),(66,33,'ar','لقاءات الخريجين',NULL,NULL,NULL,NULL),(67,34,'en','Mentoring Students',NULL,NULL,NULL,NULL),(68,34,'ar','إرشاد الطلبة',NULL,NULL,NULL,NULL),(69,35,'en','Career Talks',NULL,NULL,NULL,NULL),(70,35,'ar','محاضرات مهنية',NULL,NULL,NULL,NULL),(71,36,'en','Volunteering',NULL,NULL,NULL,NULL),(72,36,'ar','التطوع',NULL,NULL,NULL,NULL),(73,37,'en','Career Update',NULL,NULL,NULL,NULL),(74,37,'ar','تحديث مهني',NULL,NULL,NULL,NULL),(75,38,'en','Education Update',NULL,NULL,NULL,NULL),(76,38,'ar','تحديث تعليمي',NULL,NULL,NULL,NULL),(77,39,'en','Family News',NULL,NULL,NULL,NULL),(78,39,'ar','أخبار عائلية',NULL,NULL,NULL,NULL),(79,40,'en','Achievement / Award',NULL,NULL,NULL,NULL),(80,40,'ar','إنجاز / جائزة',NULL,NULL,NULL,NULL),(81,41,'en','Other',NULL,NULL,NULL,NULL),(82,41,'ar','أخرى',NULL,NULL,NULL,NULL),(83,42,'en','Where Most Needed',NULL,NULL,NULL,NULL),(84,42,'ar','حيث الحاجة الأكبر',NULL,NULL,NULL,NULL),(85,43,'en','Scholarships & Bursaries',NULL,NULL,NULL,NULL),(86,43,'ar','المنح الدراسية',NULL,NULL,NULL,NULL),(87,44,'en','Campus Development',NULL,NULL,NULL,NULL),(88,44,'ar','تطوير الحرم المدرسي',NULL,NULL,NULL,NULL),(89,45,'en','Arts & Athletics',NULL,NULL,NULL,NULL),(90,45,'ar','الفنون والرياضة',NULL,NULL,NULL,NULL),(91,46,'en','None',NULL,NULL,NULL,NULL),(92,46,'ar','لا يوجد',NULL,NULL,NULL,NULL),(93,47,'en','In Honor Of',NULL,NULL,NULL,NULL),(94,47,'ar','تكريماً لـ',NULL,NULL,NULL,NULL),(95,48,'en','In Memory Of',NULL,NULL,NULL,NULL),(96,48,'ar','إحياءً لذكرى',NULL,NULL,NULL,NULL),(97,49,'en','Mr',NULL,NULL,NULL,NULL),(98,49,'ar','السيد',NULL,NULL,NULL,NULL),(99,50,'en','Mrs',NULL,NULL,NULL,NULL),(100,50,'ar','السيدة',NULL,NULL,NULL,NULL),(101,51,'en','Ms',NULL,NULL,NULL,NULL),(102,51,'ar','الآنسة',NULL,NULL,NULL,NULL),(103,52,'en','Dr',NULL,NULL,NULL,NULL),(104,52,'ar','الدكتور',NULL,NULL,NULL,NULL),(105,53,'en','Alumnus / Alumna',NULL,NULL,NULL,NULL),(106,53,'ar','خريج / خريجة',NULL,NULL,NULL,NULL),(107,54,'en','Parent',NULL,NULL,NULL,NULL),(108,54,'ar','ولي أمر',NULL,NULL,NULL,NULL),(109,55,'en','Grandparent',NULL,NULL,NULL,NULL),(110,55,'ar','جد / جدة',NULL,NULL,NULL,NULL),(111,56,'en','Staff',NULL,NULL,NULL,NULL),(112,56,'ar','موظف',NULL,NULL,NULL,NULL),(113,57,'en','Friend of ABS',NULL,NULL,NULL,NULL),(114,57,'ar','صديق المدرسة',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `dropdown_list_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exports`
--

DROP TABLE IF EXISTS `exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exporter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exports_user_id_foreign` (`user_id`),
  CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exports`
--

LOCK TABLES `exports` WRITE;
/*!40000 ALTER TABLE `exports` DISABLE KEYS */;
/*!40000 ALTER TABLE `exports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_import_rows`
--

DROP TABLE IF EXISTS `failed_import_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_import_rows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `import_id` bigint unsigned NOT NULL,
  `validation_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `failed_import_rows_import_id_foreign` (`import_id`),
  CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_import_rows`
--

LOCK TABLES `failed_import_rows` WRITE;
/*!40000 ALTER TABLE `failed_import_rows` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_import_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`),
  KEY `idx-faq_status` (`status`),
  KEY `idx-faq_created_by` (`created_by`),
  KEY `idx-faq_updated_by` (`updated_by`),
  KEY `idx-faq_deleted_at` (`deleted_at`),
  KEY `idx-faq_published_at` (`published_at`),
  CONSTRAINT `fk-faq_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-faq_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_lang`
--

DROP TABLE IF EXISTS `faq_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `brief` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `faq_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `faq_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `faq_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `faq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_lang`
--

LOCK TABLES `faq_lang` WRITE;
/*!40000 ALTER TABLE `faq_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giving_webform`
--

DROP TABLE IF EXISTS `giving_webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giving_webform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tribute` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `on_behalf_of_organization` tinyint(1) DEFAULT NULL,
  `organization_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_zip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT NULL,
  `appear_in_donor_report` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `donor_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `confirmation_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giving_webform`
--

LOCK TABLES `giving_webform` WRITE;
/*!40000 ALTER TABLE `giving_webform` DISABLE KEYS */;
/*!40000 ALTER TABLE `giving_webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `header_image`
--

DROP TABLE IF EXISTS `header_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `header_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `model_id` bigint unsigned DEFAULT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `revision` bigint DEFAULT '0',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `header_image_model_index` (`model_id`,`model_type`) USING BTREE,
  KEY `page_slug` (`path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `header_image`
--

LOCK TABLES `header_image` WRITE;
/*!40000 ALTER TABLE `header_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `header_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `header_image_lang`
--

DROP TABLE IF EXISTS `header_image_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `header_image_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `language` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `header_image_title_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_image_id` bigint unsigned DEFAULT NULL,
  `header_image_brief` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `header_image_lang_language_index` (`language`) USING BTREE,
  KEY `header_image_lang_parent_id_foreign` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `header_image_lang`
--

LOCK TABLES `header_image_lang` WRITE;
/*!40000 ALTER TABLE `header_image_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `header_image_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `importer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `imports_user_id_foreign` (`user_id`),
  CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `directory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'media',
  `visibility` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` int unsigned DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `ext` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `caption` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `exif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `curations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_created_by_foreign` (`created_by`),
  KEY `media_updated_by_foreign` (`updated_by`),
  CONSTRAINT `fk-board_director_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-board_director_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_slug` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `revision` bigint DEFAULT '0',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_menu_created_by` (`created_by`) USING BTREE,
  KEY `fk_menu_updated_by` (`updated_by`) USING BTREE,
  KEY `menu_category_slug_foreign` (`category_slug`) USING BTREE,
  KEY `menu_status_index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (2,'mega-menu',1757543005,1757543005,NULL,1757462400,0,0,NULL,1,1,10,1),(3,'footer-menu',1758395160,1758395160,NULL,1758326400,0,0,NULL,1,1,10,1),(4,'site-map-menu',1759150472,1759150472,NULL,1759104000,0,0,NULL,1,1,10,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_lang`
--

DROP TABLE IF EXISTS `menu_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL,
  `language` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`id`),
  KEY `menu_lang_language` (`language`) USING BTREE,
  KEY `menu_lang_parent_id_foreign` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_lang`
--

LOCK TABLES `menu_lang` WRITE;
/*!40000 ALTER TABLE `menu_lang` DISABLE KEYS */;
INSERT INTO `menu_lang` VALUES (3,2,'en','Mega Menu'),(4,2,'ar','Mega Menu'),(5,3,'en','footer menu'),(6,3,'ar','footer menu'),(7,4,'en','sitemap menu'),(8,4,'ar','sitemap menu');
/*!40000 ALTER TABLE `menu_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_link`
--

DROP TABLE IF EXISTS `menu_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_link` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned DEFAULT NULL,
  `self_parent_id` bigint DEFAULT '-1',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `custom_color_class` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `admin_icon` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `alwaysVisible` int NOT NULL DEFAULT '0',
  `order` int DEFAULT NULL,
  `additional_attributes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `revision` bigint DEFAULT '0',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_menu_link_created_by` (`created_by`) USING BTREE,
  KEY `fk_menu_link_updated_by` (`updated_by`) USING BTREE,
  KEY `menu_link_menu_id_foreign` (`menu_id`) USING BTREE,
  KEY `menu_link_status_index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_link`
--

LOCK TABLES `menu_link` WRITE;
/*!40000 ALTER TABLE `menu_link` DISABLE KEYS */;
INSERT INTO `menu_link` VALUES (1,2,-1,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(2,2,1,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(3,2,1,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(4,2,1,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(5,2,1,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(6,2,1,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(7,2,1,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(8,2,1,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(9,2,1,NULL,'',NULL,0,8,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,8,1),(10,2,1,NULL,'',NULL,0,9,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,9,1),(11,2,1,NULL,'',NULL,0,10,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,10,1),(12,2,-1,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(13,2,12,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(14,2,12,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(15,2,12,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(16,2,-1,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(17,2,16,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(18,2,16,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(19,2,16,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(20,2,16,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(21,2,16,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(22,2,16,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(23,2,16,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(24,2,-1,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(25,2,24,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(26,2,24,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(27,2,24,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(28,2,24,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(29,2,24,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(30,2,24,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(31,2,24,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(32,2,-1,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(33,2,32,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(34,2,32,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(35,2,32,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(36,2,32,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(37,2,32,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(38,2,-1,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(39,4,-1,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(40,4,39,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(41,4,39,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(42,4,39,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(43,4,39,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(44,4,39,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(45,4,39,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(46,4,39,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(47,4,39,NULL,'',NULL,0,8,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,8,1),(48,4,39,NULL,'',NULL,0,9,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,9,1),(49,4,39,NULL,'',NULL,0,10,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,10,1),(50,4,-1,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(51,4,50,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(52,4,50,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(53,4,50,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(54,4,-1,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(55,4,54,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(56,4,54,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(57,4,54,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(58,4,54,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(59,4,54,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(60,4,54,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(61,4,54,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(62,4,-1,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(63,4,62,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(64,4,62,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(65,4,62,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(66,4,62,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(67,4,62,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(68,4,62,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(69,4,62,NULL,'',NULL,0,7,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,7,1),(70,4,-1,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(71,4,70,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(72,4,70,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(73,4,70,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(74,4,70,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(75,4,70,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(76,4,-1,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1),(77,3,-1,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(78,3,77,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(79,3,77,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(80,3,77,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(81,3,-1,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(82,3,81,NULL,'',NULL,0,1,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,1,1),(83,3,81,NULL,'',NULL,0,2,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,2,1),(84,3,81,NULL,'',NULL,0,3,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,3,1),(85,3,81,NULL,'',NULL,0,4,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,4,1),(86,3,81,NULL,'',NULL,0,5,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,5,1),(87,3,81,NULL,'',NULL,0,6,NULL,1792518776,1792518776,NULL,1792518776,0,0,NULL,1,1,6,1);
/*!40000 ALTER TABLE `menu_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_link_lang`
--

DROP TABLE IF EXISTS `menu_link_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_link_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL,
  `language` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `link_2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `brief` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`id`),
  KEY `menu_link_lang_language` (`language`) USING BTREE,
  KEY `menu_link_lang_parent_id_foreign` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_link_lang`
--

LOCK TABLES `menu_link_lang` WRITE;
/*!40000 ALTER TABLE `menu_link_lang` DISABLE KEYS */;
INSERT INTO `menu_link_lang` VALUES (1,1,'en','About Us',NULL,NULL,NULL),(2,1,'ar','من نحن',NULL,NULL,NULL),(3,2,'en','Letter from the Chairman','/letter-from-the-chairman',NULL,NULL),(4,2,'ar','رسالة رئيس مجلس الأمناء','/letter-from-the-chairman',NULL,NULL),(5,3,'en','Letter from the School Principal and CEO','/letter-from-the-principal',NULL,NULL),(6,3,'ar','رسالة مديرة المدرسة','/letter-from-the-principal',NULL,NULL),(7,4,'en','Guiding Statement - Who We Are','/guiding-statement',NULL,NULL),(8,4,'ar','البيان التوجيهي - من نحن','/guiding-statement',NULL,NULL),(9,5,'en','ABS Shared Understanding of High-Quality Learning','/shared-understanding-of-high-quality-learning',NULL,NULL),(10,5,'ar','الفهم المشترك للتعلّم عالي الجودة','/shared-understanding-of-high-quality-learning',NULL,NULL),(11,6,'en','Strategic Priorities','/strategic-priorities',NULL,NULL),(12,6,'ar','الأولويات الاستراتيجية','/strategic-priorities',NULL,NULL),(13,7,'en','Board of Trustees','/team/board-of-trustees',NULL,NULL),(14,7,'ar','مجلس الأمناء','/team/board-of-trustees',NULL,NULL),(15,8,'en','Innovation','/innovation',NULL,NULL),(16,8,'ar','الابتكار','/innovation',NULL,NULL),(17,9,'en','Senior Leadership Team','/team/senior-leadership-team',NULL,NULL),(18,9,'ar','فريق القيادة العليا','/team/senior-leadership-team',NULL,NULL),(19,10,'en','Staff','/team/staff',NULL,NULL),(20,10,'ar','الكادر','/team/staff',NULL,NULL),(21,11,'en','Our Campus','/our-campus',NULL,NULL),(22,11,'ar','حرمنا المدرسي','/our-campus',NULL,NULL),(23,12,'en','Schools',NULL,NULL,NULL),(24,12,'ar','المدارس',NULL,NULL,NULL),(25,13,'en','Primary School – KG1 - Grade 6','/schools/primary-school',NULL,NULL),(26,13,'ar','المدرسة الابتدائية – الروضة الأولى - الصف السادس','/schools/primary-school',NULL,NULL),(27,14,'en','Secondary School – Middle School (Grades 7-10)','/schools/middle-school',NULL,NULL),(28,14,'ar','المدرسة الثانوية – المرحلة المتوسطة (7-10)','/schools/middle-school',NULL,NULL),(29,15,'en','Secondary School – IB College (Grades 11-12)','/schools/ib-college',NULL,NULL),(30,15,'ar','المدرسة الثانوية – كلية البكالوريا الدولية (11-12)','/schools/ib-college',NULL,NULL),(31,16,'en','Admissions',NULL,NULL,NULL),(32,16,'ar','القبول',NULL,NULL,NULL),(33,17,'en','Overview','/admissions',NULL,NULL),(34,17,'ar','نظرة عامة','/admissions',NULL,NULL),(35,18,'en','Admissions Procedure','/admissions-procedure',NULL,NULL),(36,18,'ar','إجراءات القبول','/admissions-procedure',NULL,NULL),(37,19,'en','Tuition Fees','/tuition-fees',NULL,NULL),(38,19,'ar','الرسوم الدراسية','/tuition-fees',NULL,NULL),(39,20,'en','Apply Now','/apply-now',NULL,NULL),(40,20,'ar','قدّم الآن','/apply-now',NULL,NULL),(41,21,'en','Admission Policy','/admission-policy',NULL,NULL),(42,21,'ar','سياسة القبول','/admission-policy',NULL,NULL),(43,22,'en','Examination Entry Policy','/examination-entry-policy',NULL,NULL),(44,22,'ar','سياسة التقدم للامتحانات','/examination-entry-policy',NULL,NULL),(45,23,'en','Scholarships, Bursaries and Awards','/scholarships-bursaries-and-awards',NULL,NULL),(46,23,'ar','المنح الدراسية والجوائز','/scholarships-bursaries-and-awards',NULL,NULL),(47,24,'en','Student Engagement',NULL,NULL,NULL),(48,24,'ar','الأنشطة الطلابية',NULL,NULL,NULL),(49,25,'en','Overview','/student-engagement',NULL,NULL),(50,25,'ar','نظرة عامة','/student-engagement',NULL,NULL),(51,26,'en','Athletic and Recreation','/student-engagement/athletic-and-recreation',NULL,NULL),(52,26,'ar','الرياضة والترفيه','/student-engagement/athletic-and-recreation',NULL,NULL),(53,27,'en','Extra Co-Curricular Activities and CAS','/student-engagement/extra-co-curricular-activities-and-cas',NULL,NULL),(54,27,'ar','الأنشطة اللامنهجية و CAS','/student-engagement/extra-co-curricular-activities-and-cas',NULL,NULL),(55,28,'en','Adventure and Leadership','/student-engagement/adventure-and-leadership',NULL,NULL),(56,28,'ar','المغامرة والقيادة','/student-engagement/adventure-and-leadership',NULL,NULL),(57,29,'en','Arts and Culture','/student-engagement/arts-and-culture',NULL,NULL),(58,29,'ar','الفنون والثقافة','/student-engagement/arts-and-culture',NULL,NULL),(59,30,'en','Academic Enrichment','/student-engagement/academic-enrichment',NULL,NULL),(60,30,'ar','الإثراء الأكاديمي','/student-engagement/academic-enrichment',NULL,NULL),(61,31,'en','Additional Educational Needs (AEN)','/additional-educational-needs',NULL,NULL),(62,31,'ar','الاحتياجات التعليمية الإضافية','/additional-educational-needs',NULL,NULL),(63,32,'en','School Development',NULL,NULL,NULL),(64,32,'ar','تطوير المدرسة',NULL,NULL,NULL),(65,33,'en','Alumni','/alumni',NULL,NULL),(66,33,'ar','الخريجون','/alumni',NULL,NULL),(67,34,'en','Alumni - Stay Connected Form','/alumni-stay-connected',NULL,NULL),(68,34,'ar','نموذج تواصل الخريجين','/alumni-stay-connected',NULL,NULL),(69,35,'en','Development Department','/development-department',NULL,NULL),(70,35,'ar','دائرة التطوير','/development-department',NULL,NULL),(71,36,'en','Giving Page Form','/giving',NULL,NULL),(72,36,'ar','نموذج العطاء','/giving',NULL,NULL),(73,37,'en','Submit a Class Note Form','/submit-a-class-note',NULL,NULL),(74,37,'ar','نموذج ملاحظة الدفعة','/submit-a-class-note',NULL,NULL),(75,38,'en','Employment','/employment',NULL,NULL),(76,38,'ar','التوظيف','/employment',NULL,NULL),(77,39,'en','About Us',NULL,NULL,NULL),(78,39,'ar','من نحن',NULL,NULL,NULL),(79,40,'en','Letter from the Chairman','/letter-from-the-chairman',NULL,NULL),(80,40,'ar','رسالة رئيس مجلس الأمناء','/letter-from-the-chairman',NULL,NULL),(81,41,'en','Letter from the School Principal and CEO','/letter-from-the-principal',NULL,NULL),(82,41,'ar','رسالة مديرة المدرسة','/letter-from-the-principal',NULL,NULL),(83,42,'en','Guiding Statement - Who We Are','/guiding-statement',NULL,NULL),(84,42,'ar','البيان التوجيهي - من نحن','/guiding-statement',NULL,NULL),(85,43,'en','ABS Shared Understanding of High-Quality Learning','/shared-understanding-of-high-quality-learning',NULL,NULL),(86,43,'ar','الفهم المشترك للتعلّم عالي الجودة','/shared-understanding-of-high-quality-learning',NULL,NULL),(87,44,'en','Strategic Priorities','/strategic-priorities',NULL,NULL),(88,44,'ar','الأولويات الاستراتيجية','/strategic-priorities',NULL,NULL),(89,45,'en','Board of Trustees','/team/board-of-trustees',NULL,NULL),(90,45,'ar','مجلس الأمناء','/team/board-of-trustees',NULL,NULL),(91,46,'en','Innovation','/innovation',NULL,NULL),(92,46,'ar','الابتكار','/innovation',NULL,NULL),(93,47,'en','Senior Leadership Team','/team/senior-leadership-team',NULL,NULL),(94,47,'ar','فريق القيادة العليا','/team/senior-leadership-team',NULL,NULL),(95,48,'en','Staff','/team/staff',NULL,NULL),(96,48,'ar','الكادر','/team/staff',NULL,NULL),(97,49,'en','Our Campus','/our-campus',NULL,NULL),(98,49,'ar','حرمنا المدرسي','/our-campus',NULL,NULL),(99,50,'en','Schools',NULL,NULL,NULL),(100,50,'ar','المدارس',NULL,NULL,NULL),(101,51,'en','Primary School – KG1 - Grade 6','/schools/primary-school',NULL,NULL),(102,51,'ar','المدرسة الابتدائية – الروضة الأولى - الصف السادس','/schools/primary-school',NULL,NULL),(103,52,'en','Secondary School – Middle School (Grades 7-10)','/schools/middle-school',NULL,NULL),(104,52,'ar','المدرسة الثانوية – المرحلة المتوسطة (7-10)','/schools/middle-school',NULL,NULL),(105,53,'en','Secondary School – IB College (Grades 11-12)','/schools/ib-college',NULL,NULL),(106,53,'ar','المدرسة الثانوية – كلية البكالوريا الدولية (11-12)','/schools/ib-college',NULL,NULL),(107,54,'en','Admissions',NULL,NULL,NULL),(108,54,'ar','القبول',NULL,NULL,NULL),(109,55,'en','Overview','/admissions',NULL,NULL),(110,55,'ar','نظرة عامة','/admissions',NULL,NULL),(111,56,'en','Admissions Procedure','/admissions-procedure',NULL,NULL),(112,56,'ar','إجراءات القبول','/admissions-procedure',NULL,NULL),(113,57,'en','Tuition Fees','/tuition-fees',NULL,NULL),(114,57,'ar','الرسوم الدراسية','/tuition-fees',NULL,NULL),(115,58,'en','Apply Now','/apply-now',NULL,NULL),(116,58,'ar','قدّم الآن','/apply-now',NULL,NULL),(117,59,'en','Admission Policy','/admission-policy',NULL,NULL),(118,59,'ar','سياسة القبول','/admission-policy',NULL,NULL),(119,60,'en','Examination Entry Policy','/examination-entry-policy',NULL,NULL),(120,60,'ar','سياسة التقدم للامتحانات','/examination-entry-policy',NULL,NULL),(121,61,'en','Scholarships, Bursaries and Awards','/scholarships-bursaries-and-awards',NULL,NULL),(122,61,'ar','المنح الدراسية والجوائز','/scholarships-bursaries-and-awards',NULL,NULL),(123,62,'en','Student Engagement',NULL,NULL,NULL),(124,62,'ar','الأنشطة الطلابية',NULL,NULL,NULL),(125,63,'en','Overview','/student-engagement',NULL,NULL),(126,63,'ar','نظرة عامة','/student-engagement',NULL,NULL),(127,64,'en','Athletic and Recreation','/student-engagement/athletic-and-recreation',NULL,NULL),(128,64,'ar','الرياضة والترفيه','/student-engagement/athletic-and-recreation',NULL,NULL),(129,65,'en','Extra Co-Curricular Activities and CAS','/student-engagement/extra-co-curricular-activities-and-cas',NULL,NULL),(130,65,'ar','الأنشطة اللامنهجية و CAS','/student-engagement/extra-co-curricular-activities-and-cas',NULL,NULL),(131,66,'en','Adventure and Leadership','/student-engagement/adventure-and-leadership',NULL,NULL),(132,66,'ar','المغامرة والقيادة','/student-engagement/adventure-and-leadership',NULL,NULL),(133,67,'en','Arts and Culture','/student-engagement/arts-and-culture',NULL,NULL),(134,67,'ar','الفنون والثقافة','/student-engagement/arts-and-culture',NULL,NULL),(135,68,'en','Academic Enrichment','/student-engagement/academic-enrichment',NULL,NULL),(136,68,'ar','الإثراء الأكاديمي','/student-engagement/academic-enrichment',NULL,NULL),(137,69,'en','Additional Educational Needs (AEN)','/additional-educational-needs',NULL,NULL),(138,69,'ar','الاحتياجات التعليمية الإضافية','/additional-educational-needs',NULL,NULL),(139,70,'en','School Development',NULL,NULL,NULL),(140,70,'ar','تطوير المدرسة',NULL,NULL,NULL),(141,71,'en','Alumni','/alumni',NULL,NULL),(142,71,'ar','الخريجون','/alumni',NULL,NULL),(143,72,'en','Alumni - Stay Connected Form','/alumni-stay-connected',NULL,NULL),(144,72,'ar','نموذج تواصل الخريجين','/alumni-stay-connected',NULL,NULL),(145,73,'en','Development Department','/development-department',NULL,NULL),(146,73,'ar','دائرة التطوير','/development-department',NULL,NULL),(147,74,'en','Giving Page Form','/giving',NULL,NULL),(148,74,'ar','نموذج العطاء','/giving',NULL,NULL),(149,75,'en','Submit a Class Note Form','/submit-a-class-note',NULL,NULL),(150,75,'ar','نموذج ملاحظة الدفعة','/submit-a-class-note',NULL,NULL),(151,76,'en','Employment','/employment',NULL,NULL),(152,76,'ar','التوظيف','/employment',NULL,NULL),(153,77,'en','Schools',NULL,NULL,NULL),(154,77,'ar','المدارس',NULL,NULL,NULL),(155,78,'en','Primary School - KG1 - Grade 6','/schools/primary-school',NULL,NULL),(156,78,'ar','المدرسة الابتدائية','/schools/primary-school',NULL,NULL),(157,79,'en','Secondary School - Middle School (Grades 7-10)','/schools/middle-school',NULL,NULL),(158,79,'ar','المرحلة المتوسطة','/schools/middle-school',NULL,NULL),(159,80,'en','Secondary School - IB College (Grades 11-12)','/schools/ib-college',NULL,NULL),(160,80,'ar','كلية البكالوريا الدولية','/schools/ib-college',NULL,NULL),(161,81,'en','Quick Links',NULL,NULL,NULL),(162,81,'ar','روابط سريعة',NULL,NULL,NULL),(163,82,'en','Why ABS','/guiding-statement',NULL,NULL),(164,82,'ar','لماذا ABS','/guiding-statement',NULL,NULL),(165,83,'en','Letter from the Chairman','/letter-from-the-chairman',NULL,NULL),(166,83,'ar','رسالة رئيس مجلس الأمناء','/letter-from-the-chairman',NULL,NULL),(167,84,'en','Our Campus','/our-campus',NULL,NULL),(168,84,'ar','حرمنا المدرسي','/our-campus',NULL,NULL),(169,85,'en','Book a Tour','/contact-us',NULL,NULL),(170,85,'ar','احجز جولة','/contact-us',NULL,NULL),(171,86,'en','Alumni','/alumni',NULL,NULL),(172,86,'ar','الخريجون','/alumni',NULL,NULL),(173,87,'en','Working at ABS','/employment',NULL,NULL),(174,87,'ar','العمل في ABS','/employment',NULL,NULL);
/*!40000 ALTER TABLE `menu_link_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned NOT NULL,
  `message` varchar(255) NOT NULL,
  `immutable` int DEFAULT '0',
  `created_at` bigint NOT NULL,
  `updated_at` bigint NOT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `deleted_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `category_id` (`category_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `message_category` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (91,3,'required',0,20240810023943,20240810023943,1,1,NULL),(92,3,'attributes.name',0,20240810024036,20240810024112,1,1,NULL),(93,3,'attributes.phone',0,20240810024217,20240810024217,1,1,NULL),(156,3,'attributes.email',0,20240822074519,20240822074519,1,1,NULL),(157,3,'attributes.captcha',0,20240822074643,20240822074643,1,1,NULL),(158,3,'attributes.message',0,20240822074709,20240822074808,1,1,NULL),(159,3,'attributes.subject_id',0,20240822074746,20240822074746,1,1,NULL),(162,7,'ACCESSIBILITY_TOOLS',0,20240901015033,20240901015033,1,1,NULL),(163,7,'INCREASE_TEXT',0,20240901020353,20240901020353,1,1,NULL),(164,7,'NEGATIVE_CONTRAST',0,20240901021003,20240901021003,1,1,NULL),(165,7,'LIGHT_BACKGROUND',0,20240901021133,20240901021133,1,1,NULL),(166,7,'LINKS_UNDERLINE',0,20240901021247,20240901021247,1,1,NULL),(167,7,'DECREASE_TEXT',0,20240901021351,20240901021351,1,1,NULL),(168,7,'HIGH_CONTRAST',0,20240901021437,20240901021437,1,1,NULL),(169,7,'GRAYSCALE',0,20240901021540,20240901021540,1,1,NULL),(170,7,'READABLE_FONT',0,20240901021627,20240901021627,1,1,NULL),(171,7,'RESET',0,20240901021709,20240901021709,1,1,NULL),(178,3,'regex',0,20240904115319,20240904115319,1,1,NULL),(179,3,'numeric',0,20240904115415,20240904115415,1,1,NULL),(180,3,'email',0,20240904115509,20240904115509,1,1,NULL),(181,3,'attributes.role_id',0,20240904115716,20240904115716,1,1,NULL),(182,3,'mimes',0,20240904122946,20240904122946,1,1,NULL),(194,3,'min.numeric',0,20241001094431,20241001094431,1,1,NULL),(195,3,'lte.numeric',0,20241001095756,20241001095756,1,1,NULL),(196,3,'max.numeric',0,20241001095927,20241001095927,1,1,NULL),(197,3,'exists',0,20241001100123,20241001100123,1,1,NULL),(198,3,'required_if',0,20241001100251,20241001100251,1,1,NULL),(199,3,'attributes.transport_total_amount',0,20241001100501,20241001100536,1,1,NULL),(200,3,'attributes.amount',0,20241003114343,20241003114343,1,1,NULL),(201,3,'attributes.period',0,20241003114439,20241031123932,1,1,NULL),(202,3,'attributes.calculator_type',0,20241003114608,20241003114608,1,1,NULL),(205,3,'min_digits',0,20241010104136,20241010104136,1,1,NULL),(206,3,'starts_with',0,20241010105512,20241010105512,1,1,NULL),(207,3,'min.string',0,20241010110122,20241010110122,1,1,NULL),(232,2,'ABS_CAREERS_PAGE',0,1792518776,1792518776,1,1,NULL),(233,2,'ABS_FACTS_FIGURES',0,1792518776,1792518776,1,1,NULL),(234,2,'ABS_LISTED_ON_LINKEDIN',0,1792518776,1792518776,1,1,NULL),(235,2,'ABS_PORTAL',0,1792518776,1792518776,1,1,NULL),(236,2,'ABS_TES_JOBS',0,1792518776,1792518776,1,1,NULL),(237,2,'ACADEMIC_ACHIEVEMENTS',0,1792518776,1792518776,1,1,NULL),(238,2,'ACADEMIC_ACHIEVEMENTS_BRIEF',0,1792518776,1792518776,1,1,NULL),(239,2,'ACCREDITATIONS_RECOGNITIONS',0,1792518776,1792518776,1,1,NULL),(240,2,'ACCREDITATIONS_RECOGNITIONS_BRIEF',0,1792518776,1792518776,1,1,NULL),(241,2,'ADDRESS',0,1792518776,1792518776,1,1,NULL),(242,2,'ALBUMS',0,1792518776,1792518776,1,1,NULL),(243,2,'ALL',0,1792518776,1792518776,1,1,NULL),(244,2,'ALL_RIGHTS_RESERVED',0,1792518776,1792518776,1,1,NULL),(245,2,'ALUMNI',0,1792518776,1792518776,1,1,NULL),(246,2,'ALUMNI_NEWS',0,1792518776,1792518776,1,1,NULL),(247,2,'AMOUNT_JOD',0,1792518776,1792518776,1,1,NULL),(248,2,'ANNUAL_TUITION_FEES',0,1792518776,1792518776,1,1,NULL),(249,2,'ANNUAL_TUITION_FEES_BRIEF',0,1792518776,1792518776,1,1,NULL),(250,2,'ANNUAL_TUITION_JOD',0,1792518776,1792518776,1,1,NULL),(251,2,'APPEAR_IN_DONOR_REPORT',0,1792518776,1792518776,1,1,NULL),(252,2,'APPLY_NOW',0,1792518776,1792518776,1,1,NULL),(253,2,'ARE_YOU_AN_ABS_ALUMNI',0,1792518776,1792518776,1,1,NULL),(254,2,'ARE_YOU_AN_ABS_PARENT',0,1792518776,1792518776,1,1,NULL),(255,2,'BOOK_A_CAMPUS_TOUR',0,1792518776,1792518776,1,1,NULL),(256,2,'CALENDAR',0,1792518776,1792518776,1,1,NULL),(257,2,'CAN_ABS_SHARE_YOUR_EMAIL',0,1792518776,1792518776,1,1,NULL),(258,2,'CITY',0,1792518776,1792518776,1,1,NULL),(259,2,'CLASS_NOTE_BRIEF',0,1792518776,1792518776,1,1,NULL),(260,2,'CLASS_OF_ABS',0,1792518776,1792518776,1,1,NULL),(261,2,'CLICK_HERE_TO_READ_MORE',0,1792518776,1792518776,1,1,NULL),(262,2,'COMPANY',0,1792518776,1792518776,1,1,NULL),(263,2,'CONTACT_US',0,1792518776,1792518776,1,1,NULL),(264,2,'CONTACT_US_BRIEF',0,1792518776,1792518776,1,1,NULL),(265,2,'COUNTRY',0,1792518776,1792518776,1,1,NULL),(266,2,'CURRENT_OCCUPATION',0,1792518776,1792518776,1,1,NULL),(267,2,'CURRENT_PROFESSION',0,1792518776,1792518776,1,1,NULL),(268,2,'DEGREES_AWARDED',0,1792518776,1792518776,1,1,NULL),(269,2,'DESIGNATION',0,1792518776,1792518776,1,1,NULL),(270,2,'DEVELOPED_BY',0,1792518776,1792518776,1,1,NULL),(271,2,'DIVISION',0,1792518776,1792518776,1,1,NULL),(272,2,'EMAIL',0,1792518776,1792518776,1,1,NULL),(273,2,'EMAIL_ADDRESS',0,1792518776,1792518776,1,1,NULL),(274,2,'EMAIL_PLACEHOLDER',0,1792518776,1792518776,1,1,NULL),(275,2,'ENQUIRE_NOW',0,1792518776,1792518776,1,1,NULL),(276,2,'EXPLORE_MORE',0,1792518776,1792518776,1,1,NULL),(277,2,'FIELD_OF_STUDY',0,1792518776,1792518776,1,1,NULL),(278,2,'FILTER',0,1792518776,1792518776,1,1,NULL),(279,2,'FILTER_BY',0,1792518776,1792518776,1,1,NULL),(280,2,'FIRST_NAME',0,1792518776,1792518776,1,1,NULL),(281,2,'FOOTER_SLOGAN',0,1792518776,1792518776,1,1,NULL),(282,2,'GET_DIRECTIONS',0,1792518776,1792518776,1,1,NULL),(283,2,'GIFT_AMOUNT',0,1792518776,1792518776,1,1,NULL),(284,2,'GIFT_ON_BEHALF_OF_ORGANIZATION',0,1792518776,1792518776,1,1,NULL),(285,2,'GIFT_REMAIN_ANONYMOUS',0,1792518776,1792518776,1,1,NULL),(286,2,'GIVING_FORM_BRIEF',0,1792518776,1792518776,1,1,NULL),(287,2,'GIVING_FORM_TITLE',0,1792518776,1792518776,1,1,NULL),(288,2,'Google thinks, you are a bot, please refresh and try again!',0,1792518776,1792518776,1,1,NULL),(289,2,'GRADE',0,1792518776,1792518776,1,1,NULL),(290,2,'HOME',0,1792518776,1792518776,1,1,NULL),(291,2,'HOME_ADDRESS',0,1792518776,1792518776,1,1,NULL),(292,2,'I_AM_A',0,1792518776,1792518776,1,1,NULL),(293,2,'INITIAL_REGISTRATION',0,1792518776,1792518776,1,1,NULL),(294,2,'INTERESTED_ALUMNI_ACTIVITIES',0,1792518776,1792518776,1,1,NULL),(295,2,'IS_YOUR_SPOUSE_AN_ABS_ALUMNUS',0,1792518776,1792518776,1,1,NULL),(296,2,'JOD',0,1792518776,1792518776,1,1,NULL),(297,2,'LAST_NAME',0,1792518776,1792518776,1,1,NULL),(298,2,'LATEST_STORIES',0,1792518776,1792518776,1,1,NULL),(299,2,'LEAVE_A_COMMENT',0,1792518776,1792518776,1,1,NULL),(300,2,'LOAD_MORE',0,1792518776,1792518776,1,1,NULL),(301,2,'LOCATION_CITY_COUNTRY',0,1792518776,1792518776,1,1,NULL),(302,2,'MESSAGE',0,1792518776,1792518776,1,1,NULL),(303,2,'MIDDLE_NAME',0,1792518776,1792518776,1,1,NULL),(304,2,'MOBILE_NUMBER',0,1792518776,1792518776,1,1,NULL),(305,2,'MORE_NEWS',0,1792518776,1792518776,1,1,NULL),(306,2,'MORE_STUDENT_ENGAGEMENT',0,1792518776,1792518776,1,1,NULL),(307,2,'NAME',0,1792518776,1792518776,1,1,NULL),(308,2,'NAME_TITLE',0,1792518776,1792518776,1,1,NULL),(309,2,'NEWS',0,1792518776,1792518776,1,1,NULL),(310,2,'NEWS_BRIEF',0,1792518776,1792518776,1,1,NULL),(311,2,'NO',0,1792518776,1792518776,1,1,NULL),(312,2,'NO_RESULTS_FOUND',0,1792518776,1792518776,1,1,NULL),(313,2,'NOTABLE_ALUMNI_BRIEF',0,1792518776,1792518776,1,1,NULL),(314,2,'NOTE_DETAILS',0,1792518776,1792518776,1,1,NULL),(315,2,'OF',0,1792518776,1792518776,1,1,NULL),(316,2,'OPEN_FLIPBOOK',0,1792518776,1792518776,1,1,NULL),(317,2,'ORGANIZATION_NAME',0,1792518776,1792518776,1,1,NULL),(318,2,'OTHER',0,1792518776,1792518776,1,1,NULL),(319,2,'PAGE',0,1792518776,1792518776,1,1,NULL),(320,2,'PAYMENT_WITHDRAWAL_POLICIES',0,1792518776,1792518776,1,1,NULL),(321,2,'PERMISSION_TO_SHARE_CLASS_NOTE',0,1792518776,1792518776,1,1,NULL),(322,2,'PHONE',0,1792518776,1792518776,1,1,NULL),(323,2,'PLEASE_SELECT',0,1792518776,1792518776,1,1,NULL),(324,2,'PRIVACY',0,1792518776,1792518776,1,1,NULL),(325,2,'PRIVACY_POLICY',0,1792518776,1792518776,1,1,NULL),(326,2,'READ_MORE',0,1792518776,1792518776,1,1,NULL),(327,2,'READY_TO_BEGIN_YOUR_ABS_JOURNEY',0,1792518776,1792518776,1,1,NULL),(328,2,'READY_TO_BEGIN_YOUR_ABS_JOURNEY_BRIEF',0,1792518776,1792518776,1,1,NULL),(329,2,'RECEIVE_ABS_NEWS',0,1792518776,1792518776,1,1,NULL),(330,2,'SCHOOLS',0,1792518776,1792518776,1,1,NULL),(331,2,'SEARCH',0,1792518776,1792518776,1,1,NULL),(332,2,'SEARCH_HINT',0,1792518776,1792518776,1,1,NULL),(333,2,'SEND_CONFIRMATION_EMAIL_TO',0,1792518776,1792518776,1,1,NULL),(334,2,'SHOWING',0,1792518776,1792518776,1,1,NULL),(335,2,'SITE_MAP',0,1792518776,1792518776,1,1,NULL),(336,2,'SOCIAL_MEDIA_LINKS',0,1792518776,1792518776,1,1,NULL),(337,2,'STATE_ZIP',0,1792518776,1792518776,1,1,NULL),(338,2,'STATUS',0,1792518776,1792518776,1,1,NULL),(339,2,'STAY_CONNECTED_BRIEF',0,1792518776,1792518776,1,1,NULL),(340,2,'STAY_CONNECTED_FORM',0,1792518776,1792518776,1,1,NULL),(341,2,'STAY_CONNECTED_TITLE',0,1792518776,1792518776,1,1,NULL),(342,2,'STAY_UPDATED',0,1792518776,1792518776,1,1,NULL),(343,2,'STAY_UPDATED_BRIEF',0,1792518776,1792518776,1,1,NULL),(344,2,'STUDENT_ENGAGEMENT',0,1792518776,1792518776,1,1,NULL),(345,2,'STUDENT_ENGAGEMENT_ALBUMS',0,1792518776,1792518776,1,1,NULL),(346,2,'STUDENT_ENGAGEMENT_TYPES',0,1792518776,1792518776,1,1,NULL),(347,2,'SUBJECT',0,1792518776,1792518776,1,1,NULL),(348,2,'SUBMIT',0,1792518776,1792518776,1,1,NULL),(349,2,'SUBMIT_A_CLASS_NOTE',0,1792518776,1792518776,1,1,NULL),(350,2,'SUBMIT_YOUR_PHOTO',0,1792518776,1792518776,1,1,NULL),(351,2,'SUBMITTED_SUCCESSFULLY',0,1792518776,1792518776,1,1,NULL),(352,2,'SUBSCRIBE',0,1792518776,1792518776,1,1,NULL),(353,2,'SUGGESTIONS_FEEDBACK',0,1792518776,1792518776,1,1,NULL),(354,2,'SUPPORT_YOUR_ALMA_MATER',0,1792518776,1792518776,1,1,NULL),(355,2,'TERMS_AND_CONDITIONS',0,1792518776,1792518776,1,1,NULL),(356,2,'TERMS_CONDITIONS',0,1792518776,1792518776,1,1,NULL),(357,2,'TRANSPORT_BUS_FEES',0,1792518776,1792518776,1,1,NULL),(358,2,'TRIBUTE',0,1792518776,1792518776,1,1,NULL),(359,2,'TUITION_FEES',0,1792518776,1792518776,1,1,NULL),(360,2,'TYPE_HERE',0,1792518776,1792518776,1,1,NULL),(361,2,'UNIVERSITIES_ATTENDED',0,1792518776,1792518776,1,1,NULL),(362,2,'UNIVERSITY_COLLEGE_NAME',0,1792518776,1792518776,1,1,NULL),(363,2,'UNIVERSITY_DESTINATIONS',0,1792518776,1792518776,1,1,NULL),(364,2,'UNIVERSITY_DESTINATIONS_BRIEF',0,1792518776,1792518776,1,1,NULL),(365,2,'UPLOADING',0,1792518776,1792518776,1,1,NULL),(366,2,'VIEW_ALL_UNIVERSITIES',0,1792518776,1792518776,1,1,NULL),(367,2,'VOICES_OF_ABS',0,1792518776,1792518776,1,1,NULL),(368,2,'VOICES_OF_ABS_BRIEF',0,1792518776,1792518776,1,1,NULL),(369,2,'YEAR_OF_GRADUATION',0,1792518776,1792518776,1,1,NULL),(370,2,'YES',0,1792518776,1792518776,1,1,NULL),(371,2,'YOUR_ABS_JOURNEY_STARTS_HERE',0,1792518776,1792518776,1,1,NULL),(372,2,'YOUR_ABS_JOURNEY_STARTS_HERE_BRIEF',0,1792518776,1792518776,1,1,NULL),(373,2,'YOUR_NOTE',0,1792518776,1792518776,1,1,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_category`
--

DROP TABLE IF EXISTS `message_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `message_category_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `message_category_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_category`
--

LOCK TABLES `message_category` WRITE;
/*!40000 ALTER TABLE `message_category` DISABLE KEYS */;
INSERT INTO `message_category` VALUES (2,'site',1,'2024-07-13 12:10:32','2024-07-13 12:18:22',1,1,NULL),(3,'validation',1,'2024-07-13 12:18:00','2024-07-13 12:20:21',1,1,NULL),(4,'admin',1,'2024-07-13 12:21:35','2024-07-13 12:21:35',1,1,NULL),(7,'accessibility',1,'2024-07-13 17:55:00','2024-08-31 22:48:53',1,1,NULL);
/*!40000 ALTER TABLE `message_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_lang`
--

DROP TABLE IF EXISTS `message_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `translation_value` varchar(550) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_index` (`parent_id`,`language`) USING BTREE,
  CONSTRAINT `message_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=761 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_lang`
--

LOCK TABLES `message_lang` WRITE;
/*!40000 ALTER TABLE `message_lang` DISABLE KEYS */;
INSERT INTO `message_lang` VALUES (181,91,'en',':attribute is required'),(182,91,'ar',':attribute لا يمكن ان يكون فارغا'),(183,92,'en','Name'),(184,92,'ar','الاسم'),(185,93,'en','Phone'),(186,93,'ar','الهاتف'),(311,156,'en','Email'),(312,156,'ar','البريد الالكتروني'),(313,157,'en','Captcha'),(314,157,'ar','التحقق من انك لست انسان آلي'),(315,158,'en','Message'),(316,158,'ar','الرسالة'),(317,159,'en','Subject'),(318,159,'ar','الموضوع'),(323,162,'en','Accessibility Tools'),(324,162,'ar','أدوات إمكانية الوصول'),(325,163,'en','Increase Text'),(326,163,'ar','تكبير الخط'),(327,164,'en','Negative Contrast'),(328,164,'ar','تباين عكسي'),(329,165,'en','Light Background'),(330,165,'ar','خلفية مضاءه'),(331,166,'en','Links Underline'),(332,166,'ar','خطوط تحت الروابط'),(333,167,'en','Decrease Text'),(334,167,'ar','تصغير الخط'),(335,168,'en','High Contrast'),(336,168,'ar','تباين عالي'),(337,169,'en','Gray Scale'),(338,169,'ar','ألوان بتدرج رمادي'),(339,170,'en','Readable Font'),(340,170,'ar','استخدم خط عادي'),(341,171,'en','Reset'),(342,171,'ar','إعادة تعيين'),(355,178,'en','The :attribute field format is invalid.'),(356,178,'ar','صيغة :attribute .غير صحيحة.'),(357,179,'en','The :attribute field must be a number.'),(358,179,'ar','يجب على :attribute أن يكون رقمًا.'),(359,180,'en','The :attribute field must be a valid email address.'),(360,180,'ar','يجب أن يكون :attribute عنوان بريد إلكتروني صحيح البُنية.'),(361,181,'en','Role'),(362,181,'ar','الدور'),(363,182,'en','The :attribute field must be a file of type: :values.'),(364,182,'ar','يجب أن يكون ملفًا من نوع : :values.'),(387,194,'en','The :attribute field must be at least :min.'),(388,194,'ar','يجب أن تكون قيمة :attribute مساوية أو أكبر من :min.'),(389,195,'en','\'The :attribute field must be less than or equal to :value.'),(390,195,'ar','يجب أن تكون قيمة :attribute مساوية أو أصغر من :value.'),(391,196,'en','The :attribute field must not be greater than :max.'),(392,196,'ar','يجب أن تكون قيمة :attribute مساوية أو أصغر من :max.'),(393,197,'en','The selected to :attribute is not exists.'),(394,197,'ar','القيمة المحددة ل:attribute غير متاحة.'),(395,198,'en','The :attribute field is required when :other has current value.'),(396,198,'ar',':attribute مطلوب في حال ما إذا كان :other بالقيمة الحالية.'),(397,199,'en','Car price'),(398,199,'ar','سعر السيارة'),(399,200,'en','Required Amount'),(400,200,'ar','المبلغ المطلوب'),(401,201,'en','period'),(402,201,'ar','المدة'),(403,202,'en','calculator type'),(404,202,'ar','نوع الحاسبة'),(409,205,'en','The :attribute field must have at least :min digits.'),(410,205,'ar','يجب أن يحتوي الحقل :attribute على :min أرقامًا على الأقل.'),(411,206,'en','The :attribute field must start with one of the following: :values.'),(412,206,'ar','يجب أن يبدأ :attribute بأحد القيم التالية: :values'),(413,207,'en','The :attribute field must be at least :min characters.'),(414,207,'ar','يجب أن يكون طول النص :attribute على الأقل :min حروفٍ/حرفًا.'),(477,232,'en','Amman Baccalaureate School (ABS) Careers Page'),(478,232,'ar','صفحة الوظائف في مدرسة البكالوريا - عمان'),(479,233,'en','ABS Facts & Figures'),(480,233,'ar','حقائق وأرقام عن ABS'),(481,234,'en','Do you have ABS listed as your school on your LinkedIn profile?'),(482,234,'ar','هل أدرجت ABS كمدرستك في ملفك على LinkedIn؟'),(483,235,'en','ABS Portal'),(484,235,'ar','بوابة ABS'),(485,236,'en','Amman Baccalaureate School - Tes Jobs'),(486,236,'ar','مدرسة البكالوريا - عمان - وظائف Tes'),(487,237,'en','Academic Achievements & Success'),(488,237,'ar','الإنجازات الأكاديمية والنجاح'),(489,238,'en','Outstanding academic results and a culture of principled learning have defined the ABS experience since 1981.'),(490,238,'ar','نتائج أكاديمية متميزة وثقافة تعلّم قائمة على المبادئ ميّزت تجربة ABS منذ عام 1981.'),(491,239,'en','Accreditations & Recognitions'),(492,239,'ar','الاعتمادات والتقديرات'),(493,240,'en','Proudly authorized, licensed, and partnered with leading international educational institutions and global frameworks.'),(494,240,'ar','معتمدون ومرخّصون بفخر وشركاء لمؤسسات تعليمية دولية رائدة وأطر عالمية.'),(495,241,'en','Address'),(496,241,'ar','العنوان'),(497,242,'en','Albums'),(498,242,'ar','الألبومات'),(499,243,'en','All'),(500,243,'ar','الكل'),(501,244,'en','All rights reserved.'),(502,244,'ar','جميع الحقوق محفوظة.'),(503,245,'en','Alumni'),(504,245,'ar','الخريجون'),(505,246,'en','Alumni News'),(506,246,'ar','أخبار الخريجين'),(507,247,'en','Amount JOD'),(508,247,'ar','المبلغ بالدينار'),(509,248,'en','Annual Tuition Fees'),(510,248,'ar','الرسوم الدراسية السنوية'),(511,249,'en','Structured breakdown by school division and grade level'),(512,249,'ar','تفصيل منظم حسب المرحلة الدراسية والصف'),(513,250,'en','Annual Tuition (JOD)'),(514,250,'ar','الرسوم السنوية (دينار)'),(515,251,'en','Would you like your name to appear in our annual donor report and other donor-related publications?'),(516,251,'ar','هل ترغب بظهور اسمك في تقرير المتبرعين السنوي والمنشورات ذات الصلة؟'),(517,252,'en','Apply Now'),(518,252,'ar','قدّم الآن'),(519,253,'en','Are you an ABS Alumni?'),(520,253,'ar','هل أنت من خريجي ABS؟'),(521,254,'en','Are you an ABS Parent?'),(522,254,'ar','هل أنت ولي أمر في ABS؟'),(523,255,'en','Book a Campus Tour'),(524,255,'ar','احجز جولة في الحرم المدرسي'),(525,256,'en','Calendar'),(526,256,'ar','التقويم'),(527,257,'en','Can ABS share your email with fellow alumni?'),(528,257,'ar','هل يمكن لـ ABS مشاركة بريدك الإلكتروني مع زملائك الخريجين؟'),(529,258,'en','City'),(530,258,'ar','المدينة'),(531,259,'en','We\'d love to hear from you and stay connected! Please share your updated contact information and any relevant details about your family, career and achievements.'),(532,259,'ar','يسعدنا أن نسمع منك وأن نبقى على تواصل! يرجى مشاركة معلومات الاتصال المحدثة وأي تفاصيل عن عائلتك ومسيرتك وإنجازاتك.'),(533,260,'en','Class of ABS (Graduation Year)'),(534,260,'ar','دفعة ABS (سنة التخرج)'),(535,261,'en','Click here to read more'),(536,261,'ar','اضغط هنا لقراءة المزيد'),(537,262,'en','Company'),(538,262,'ar','الشركة'),(539,263,'en','Contact Us'),(540,263,'ar','تواصل معنا'),(541,264,'en','Contact our team for any questions about the school and seat availability.'),(542,264,'ar','تواصل مع فريقنا لأي استفسار عن المدرسة وتوفر المقاعد.'),(543,265,'en','Country'),(544,265,'ar','الدولة'),(545,266,'en','Current Occupation/Title'),(546,266,'ar','المهنة / المسمى الوظيفي الحالي'),(547,267,'en','Current Profession (Job Title and Employer)'),(548,267,'ar','المهنة الحالية (المسمى الوظيفي وجهة العمل)'),(549,268,'en','Degree(s) Awarded'),(550,268,'ar','الدرجات العلمية'),(551,269,'en','Designation'),(552,269,'ar','وجهة التبرع'),(553,270,'en','Developed by'),(554,270,'ar','تطوير'),(555,271,'en','Division'),(556,271,'ar','المرحلة'),(557,272,'en','Email'),(558,272,'ar','البريد الإلكتروني'),(559,273,'en','Email Address'),(560,273,'ar','البريد الإلكتروني'),(561,274,'en','info@example.com'),(562,274,'ar','info@example.com'),(563,275,'en','Enquire Now'),(564,275,'ar','استفسر الآن'),(565,276,'en','Explore More'),(566,276,'ar','اكتشف المزيد'),(567,277,'en','Field of Study (Major, Minor, etc.)'),(568,277,'ar','مجال الدراسة (التخصص الرئيسي، الفرعي...)'),(569,278,'en','Filter'),(570,278,'ar','تصفية'),(571,279,'en','Filter By'),(572,279,'ar','تصفية حسب'),(573,280,'en','First Name'),(574,280,'ar','الاسم الأول'),(575,281,'en','45 years of Excellence'),(576,281,'ar','45 عاماً من التميّز'),(577,282,'en','Get Directions'),(578,282,'ar','احصل على الاتجاهات'),(579,283,'en','Gift Amount'),(580,283,'ar','قيمة التبرع'),(581,284,'en','Make this gift on behalf of an organization'),(582,284,'ar','تقديم هذا التبرع باسم مؤسسة'),(583,285,'en','I would like this gift to remain anonymous'),(584,285,'ar','أرغب بأن يبقى هذا التبرع مجهول الاسم'),(585,286,'en','Support your alma mater. Fields marked with * are required.'),(586,286,'ar','ادعم مدرستك. الحقول المميزة بـ * مطلوبة.'),(587,287,'en','Giving Page Form'),(588,287,'ar','نموذج العطاء'),(589,288,'en','Google thinks, you are a bot, please refresh and try again!'),(590,288,'ar','يعتقد Google أنك روبوت، يرجى تحديث الصفحة والمحاولة مرة أخرى!'),(591,289,'en','Grade'),(592,289,'ar','الصف'),(593,290,'en','Home'),(594,290,'ar','الرئيسية'),(595,291,'en','Home Address'),(596,291,'ar','عنوان السكن'),(597,292,'en','I am a'),(598,292,'ar','أنا'),(599,293,'en','Initial Registration'),(600,293,'ar','التسجيل الأولي'),(601,294,'en','Are you interested in participating in any of the following alumni activities?'),(602,294,'ar','هل ترغب بالمشاركة في أي من أنشطة الخريجين التالية؟'),(603,295,'en','Is your spouse an ABS alumnus/alumna?'),(604,295,'ar','هل زوجك / زوجتك من خريجي ABS؟'),(605,296,'en','JOD'),(606,296,'ar','دينار'),(607,297,'en','Last Name'),(608,297,'ar','اسم العائلة'),(609,298,'en','Latest Stories'),(610,298,'ar','آخر الأخبار'),(611,299,'en','Leave a comment'),(612,299,'ar','اترك تعليقاً'),(613,300,'en','Load More'),(614,300,'ar','تحميل المزيد'),(615,301,'en','Location (City, Country)'),(616,301,'ar','الموقع (المدينة، الدولة)'),(617,302,'en','Message'),(618,302,'ar','الرسالة'),(619,303,'en','Middle Name'),(620,303,'ar','الاسم الأوسط'),(621,304,'en','Mobile Number'),(622,304,'ar','رقم الهاتف المحمول'),(623,305,'en','More News'),(624,305,'ar','المزيد من الأخبار'),(625,306,'en','More Student Engagement'),(626,306,'ar','المزيد من الأنشطة الطلابية'),(627,307,'en','Name'),(628,307,'ar','الاسم'),(629,308,'en','Title'),(630,308,'ar','اللقب'),(631,309,'en','News'),(632,309,'ar','الأخبار'),(633,310,'en','The latest news from ABS, including campus events and student achievements.'),(634,310,'ar','آخر أخبار ABS بما في ذلك فعاليات الحرم المدرسي وإنجازات الطلبة.'),(635,311,'en','No'),(636,311,'ar','لا'),(637,312,'en','No results found'),(638,312,'ar','لا توجد نتائج'),(639,313,'en','Our graduates shape the world. Meet a few of the pioneers, athletes, and creators who started their journey at ABS.'),(640,313,'ar','خريجونا يصنعون العالم. تعرّف على بعض الروّاد والرياضيين والمبدعين الذين بدأوا رحلتهم في ABS.'),(641,314,'en','Note Details'),(642,314,'ar','تفاصيل الملاحظة'),(643,315,'en','of'),(644,315,'ar','من'),(645,316,'en','Open Flipbook'),(646,316,'ar','افتح الكتيب'),(647,317,'en','Organization Name'),(648,317,'ar','اسم المؤسسة'),(649,318,'en','Other'),(650,318,'ar','أخرى'),(651,319,'en','Page'),(652,319,'ar','صفحة'),(653,320,'en','Payment of Fees & Withdrawal Policies'),(654,320,'ar','سياسات دفع الرسوم والانسحاب'),(655,321,'en','I agree to have my class note and photo shared in ABS communications.'),(656,321,'ar','أوافق على مشاركة ملاحظتي وصورتي في منشورات ABS.'),(657,322,'en','Phone'),(658,322,'ar','الهاتف'),(659,323,'en','Please Select'),(660,323,'ar','يرجى الاختيار'),(661,324,'en','Privacy Policy'),(662,324,'ar','سياسة الخصوصية'),(663,325,'en','Privacy Policy'),(664,325,'ar','سياسة الخصوصية'),(665,326,'en','Read More'),(666,326,'ar','اقرأ المزيد'),(667,327,'en','Ready to Begin Your ABS Journey?'),(668,327,'ar','هل أنت مستعد لبدء رحلتك في ABS؟'),(669,328,'en','Book a campus tour to experience our community firsthand, or start your application today. Our Admissions team is here to help at every step.'),(670,328,'ar','احجز جولة في الحرم المدرسي لتختبر مجتمعنا عن قرب، أو ابدأ طلبك اليوم. فريق القبول هنا لمساعدتك في كل خطوة.'),(671,329,'en','Would you like to receive the latest news, updates, and announcements from ABS?'),(672,329,'ar','هل ترغب باستلام آخر الأخبار والإعلانات من ABS؟'),(673,330,'en','Schools'),(674,330,'ar','المدارس'),(675,331,'en','Search'),(676,331,'ar','بحث'),(677,332,'en','Type a word to search the website.'),(678,332,'ar','اكتب كلمة للبحث في الموقع.'),(679,333,'en','Please send a confirmation email to the address below'),(680,333,'ar','يرجى إرسال رسالة تأكيد إلى البريد التالي'),(681,334,'en','Showing'),(682,334,'ar','عرض'),(683,335,'en','Site Map'),(684,335,'ar','خريطة الموقع'),(685,336,'en','Social Media Links if available'),(686,336,'ar','روابط مواقع التواصل الاجتماعي إن وجدت'),(687,337,'en','State & zip'),(688,337,'ar','الولاية والرمز البريدي'),(689,338,'en','Status'),(690,338,'ar','الحالة'),(691,339,'en','We\'d love to hear from you and stay connected! Please take a moment to share your updated contact information.'),(692,339,'ar','يسعدنا أن نسمع منك وأن نبقى على تواصل! يرجى مشاركة معلومات الاتصال المحدثة.'),(693,340,'en','Stay Connected Form'),(694,340,'ar','نموذج البقاء على تواصل'),(695,341,'en','Stay Connected – ABS Alumni'),(696,341,'ar','ابقَ على تواصل – خريجو ABS'),(697,342,'en','Stay Updated'),(698,342,'ar','ابقَ على اطلاع'),(699,343,'en','Subscribe to receive the latest news from ABS, including campus events, student achievements, and admissions updates delivered directly to your inbox.'),(700,343,'ar','اشترك لتصلك آخر أخبار ABS بما في ذلك فعاليات الحرم المدرسي وإنجازات الطلبة وتحديثات القبول مباشرة إلى بريدك.'),(701,344,'en','Student Engagement'),(702,344,'ar','الأنشطة الطلابية'),(703,345,'en','Student Engagement Albums'),(704,345,'ar','ألبومات الأنشطة الطلابية'),(705,346,'en','Student Engagement types'),(706,346,'ar','أنواع الأنشطة الطلابية'),(707,347,'en','Subject'),(708,347,'ar','الموضوع'),(709,348,'en','Submit'),(710,348,'ar','إرسال'),(711,349,'en','Submit a Class Note'),(712,349,'ar','أرسل ملاحظة الدفعة'),(713,350,'en','Submit Your Photo'),(714,350,'ar','أرفق صورتك'),(715,351,'en','Thank you, your submission has been received successfully.'),(716,351,'ar','شكراً لك، تم استلام طلبك بنجاح.'),(717,352,'en','Subscribe'),(718,352,'ar','اشترك'),(719,353,'en','Do you have any suggestions or feedback for ABS or the alumni office?'),(720,353,'ar','هل لديك أي اقتراحات أو ملاحظات لـ ABS أو لمكتب الخريجين؟'),(721,354,'en','Support your alma mater'),(722,354,'ar','ادعم مدرستك'),(723,355,'en','Terms and Conditions'),(724,355,'ar','الشروط والأحكام'),(725,356,'en','Terms and Conditions'),(726,356,'ar','الشروط والأحكام'),(727,357,'en','Transport (Bus Fees)'),(728,357,'ar','المواصلات (رسوم الحافلات)'),(729,358,'en','Tribute'),(730,358,'ar','إهداء'),(731,359,'en','Tuition Fees'),(732,359,'ar','الرسوم الدراسية'),(733,360,'en','Type Here'),(734,360,'ar','اكتب هنا'),(735,361,'en','Universities Attended'),(736,361,'ar','الجامعات التي درست فيها'),(737,362,'en','University/College Name'),(738,362,'ar','اسم الجامعة / الكلية'),(739,363,'en','University Destinations'),(740,363,'ar','وجهات الخريجين الجامعية'),(741,364,'en','Joining a global network of scholars at the world\'s most prestigious universities.'),(742,364,'ar','ينضم خريجونا إلى شبكة عالمية من الباحثين في أعرق جامعات العالم.'),(743,365,'en','Uploading...'),(744,365,'ar','جارٍ الرفع...'),(745,366,'en','View all universities'),(746,366,'ar','عرض جميع الجامعات'),(747,367,'en','Voices of ABS'),(748,367,'ar','أصوات من ABS'),(749,368,'en','Stories from our alumni and parents'),(750,368,'ar','قصص من خريجينا وأولياء الأمور'),(751,369,'en','Year of Graduation from ABS'),(752,369,'ar','سنة التخرج من ABS'),(753,370,'en','Yes'),(754,370,'ar','نعم'),(755,371,'en','Your ABS Journey Starts Here'),(756,371,'ar','رحلتك في ABS تبدأ هنا'),(757,372,'en','Your admissions journey, one step at a time — from your first question to your first day as a Stallion.'),(758,372,'ar','رحلة القبول خطوة بخطوة — من سؤالك الأول وحتى يومك الأول معنا.'),(759,373,'en','Your note'),(760,373,'ar','ملاحظتك');
/*!40000 ALTER TABLE `message_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (99,'2019_12_14_000001_create_personal_access_tokens_table',1),(101,'2025_09_15_192034_create_project_features_table',2),(103,'2025_09_15_192034_create_sustainability_links_table',3),(104,'2025_09_18_105458_remove_unique_from_category_slug_in_button_table',4),(105,'2025_09_18_115536_crate_principles_table',5),(106,'2025_09_18_192034_create_sustainability_principles_table ',6),(107,'2025_09_20_220911_add_category_slug_to_bms_table',7),(108,'2025_09_21_200858_create_subscribe_webform_table',8),(109,'2025_09_23_074729_update_brief_length_in_board_director_lang_table',9),(111,'2025_09_23_213423_change_created_at_and_updated_at_columns_in_exports_table',10),(112,'2025_09_25_050105_add_video_id_to_projects_table',11),(113,'2025_09_25_095006_add_icon_id_to_projects_table',12),(119,'2025_09_26_141558_create_sustainability_content_table',13),(120,'2025_10_06_094434_add_icon2_id_to_projects_table',14),(121,'2025_10_08_092724_add_color_to_projects_table',15),(122,'2025_10_08_133443_add_colors_to_projects_table',16),(123,'2025_10_20_144650_update_roles_timestamps_to_datetime',17),(124,'2025_10_20_145524_update_permissions_timestamps_to_datetime',18),(126,'2025_10_22_073620_change_department_id_to_department_in_contact_us_webform_table',19),(127,'2025_10_26_125617_create_short_link_table',20),(128,'2025_12_24_101535_add_image_id_to_bms_table',21),(129,'2025_12_24_103151_add_image_id_to_news_table',21),(130,'2025_12_29_090648_add_company_to_contact_us_webform_table',21),(131,'2025_12_29_140802_alter_translation_value_length_in_message_lang_table',21),(132,'2026_10_20_100000_create_school_tables',21),(133,'2026_10_20_100100_create_school_tab_tables',21),(134,'2026_10_20_100200_create_school_subject_tables',21),(135,'2026_10_20_100300_create_team_member_tables',21),(136,'2026_10_20_100400_create_university_tables',21),(137,'2026_10_20_100500_create_student_engagement_tables',21),(138,'2026_10_20_100600_create_album_tables',21),(139,'2026_10_20_100700_create_tuition_fee_tables',21),(140,'2026_10_20_100800_add_category_id_to_news_table',21),(141,'2026_10_20_100900_create_subscribe_webform_table',21),(142,'2026_10_20_101000_create_alumni_stay_connected_webform_table',21),(143,'2026_10_20_101100_create_class_note_webform_table',21),(144,'2026_10_20_101200_create_giving_webform_table',21),(145,'2026_10_20_101300_insert_abs_initial_data',22),(146,'2026_10_20_101400_insert_abs_design_content',23),(147,'2026_10_20_101500_copy_english_content_to_empty_arabic_fields',24);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (2,'App\\Models\\User',7),(1,'App\\Models\\User',9),(3,'App\\Models\\User',9),(2,'App\\Models\\User',91);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_id` bigint unsigned DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `main_image_id` bigint unsigned DEFAULT NULL,
  `inner_image_id` bigint unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  `is_campaign` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`),
  KEY `status` (`status`),
  KEY `news_ibfk_1` (`created_by`),
  KEY `news_ibfk_2` (`updated_by`),
  KEY `idx-news_deleted_at` (`deleted_at`),
  KEY `idx-news_published_at` (`published_at`),
  KEY `idx-news_category_id` (`category_id`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `news_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,NULL,23,'abs-students-shine-at-annual-science-and-innovation-fair',1,NULL,NULL,1792518995,1792518995,NULL,1792518995,1,1,10,0,0,NULL,NULL),(2,NULL,23,'class-of-2026-achieves-record-ib-diploma-results',1,NULL,NULL,1792518995,1792518995,NULL,1792432595,1,1,10,0,0,NULL,NULL),(3,NULL,23,'primary-students-embark-on-outdoor-education-week',1,NULL,NULL,1792518995,1792518995,NULL,1792346195,1,1,10,0,0,NULL,NULL),(4,NULL,23,'abs-hosts-inter-school-model-united-nations-conference',1,NULL,NULL,1792518995,1792518995,NULL,1792259795,1,1,10,0,0,NULL,NULL);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_lang`
--

DROP TABLE IF EXISTS `news_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `brief` varchar(1000) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `news_lang_lang_parent_idx` (`language`,`parent_id`),
  KEY `news_lang_ibfk_1` (`parent_id`),
  CONSTRAINT `news_lang_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_lang`
--

LOCK TABLES `news_lang` WRITE;
/*!40000 ALTER TABLE `news_lang` DISABLE KEYS */;
INSERT INTO `news_lang` VALUES (1,1,NULL,'en','ABS Students Shine at Annual Science and Innovation Fair',NULL,NULL),(2,1,NULL,'ar','طلبة ABS يتألقون في معرض العلوم والابتكار السنوي',NULL,NULL),(3,2,NULL,'en','Class of 2026 Achieves Record IB Diploma Results',NULL,NULL),(4,2,NULL,'ar','دفعة 2026 تحقق نتائج قياسية في دبلوم IB',NULL,NULL),(5,3,NULL,'en','Primary Students Embark on Outdoor Education Week',NULL,NULL),(6,3,NULL,'ar','طلبة المرحلة الابتدائية ينطلقون في أسبوع التعليم الخارجي',NULL,NULL),(7,4,NULL,'en','ABS Hosts Inter-School Model United Nations Conference',NULL,NULL),(8,4,NULL,'ar','ABS تستضيف مؤتمر نموذج الأمم المتحدة بين المدارس',NULL,NULL);
/*!40000 ALTER TABLE `news_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `status` int NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `image_header_id` bigint unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `revision` int NOT NULL DEFAULT '1',
  `changed` tinyint DEFAULT '0',
  `reject_note` varchar(255) DEFAULT NULL,
  `view` varchar(255) NOT NULL DEFAULT 'page',
  `layout` varchar(255) NOT NULL DEFAULT 'main',
  `image` varchar(255) DEFAULT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `awards_slug_unique` (`slug`),
  KEY `page_status` (`status`) USING BTREE,
  KEY `idx-page_created_by` (`created_by`),
  KEY `idx-page_updated_by` (`updated_by`),
  KEY `idx-page_deleted_at` (`deleted_at`),
  KEY `idx-page_published_at` (`published_at`),
  CONSTRAINT `fk-page_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk-page_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,'letter-from-the-chairman',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'letter','main',NULL,10),(2,'letter-from-the-principal',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'letter','main',NULL,11),(3,'guiding-statement',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'guiding_statement','main',NULL,12),(4,'shared-understanding-of-high-quality-learning',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,13),(5,'strategic-priorities',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,14),(6,'innovation',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,15),(7,'our-campus',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'campus','main',NULL,16),(8,'admissions',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,17),(9,'admissions-procedure',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'admissions_procedure','main',NULL,18),(10,'tuition-fees',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,19),(11,'apply-now',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'apply_now','main',NULL,20),(12,'admission-policy',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,21),(13,'examination-entry-policy',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,22),(14,'scholarships-bursaries-and-awards',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,23),(15,'additional-educational-needs',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,24),(16,'development-department',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'development_department','main',NULL,25),(17,'alumni',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,26),(18,'employment',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'employment','main',NULL,27),(19,'privacy-policy',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,28),(20,'terms-conditions',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,29),(21,'site-map',1,NULL,1792518776,1792518776,NULL,1792518776,1,1,1,0,NULL,'page','main',NULL,30);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_lang`
--

DROP TABLE IF EXISTS `page_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `brief` varchar(255) DEFAULT NULL,
  `content` text,
  `image_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `page_lang_post_id` (`parent_id`) USING BTREE,
  KEY `page_lang_language` (`language`) USING BTREE,
  CONSTRAINT `fk_page_lang` FOREIGN KEY (`parent_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_lang`
--

LOCK TABLES `page_lang` WRITE;
/*!40000 ALTER TABLE `page_lang` DISABLE KEYS */;
INSERT INTO `page_lang` VALUES (1,1,'en','Letter from the Chairman',NULL,NULL,NULL),(2,1,'ar','رسالة رئيس مجلس الأمناء',NULL,NULL,NULL),(3,2,'en','Letter from the School Principal & CEO','Welcome to ABS','<p>As Principal and CEO, it is my pleasure to welcome you to our vibrant and nurturing community where students are at the heart of everything we do. At the Amman Baccalaureate School (ABS), we take pride in offering an exceptional, student- centered educational experience that prepares young minds to thrive in an ever- changing world.</p><p>Our mission is to develop well-rounded, lifelong learners who are confident, compassionate, and equipped with the skills and values needed to make a positive impact on the global stage. Guided by our vision of academic excellence and personal growth, we create an environment where students feel empowered to pursue their passions, explore their potential, and contribute to society.</p><p>ABS is committed to innovation and excellence, combining rigorous academic programs with opportunities for holistic development. From the internationally recognised IB curriculum to our rich array of extracurricular activities, our school prioritizes the intellectual, emotional, and social growth of each individual.</p><p><strong>\"We invite you to join us on this journey of discovery, creativity, and achievement as we continue to shape the leaders and innovators of tomorrow. At ABS, students are not just part of the school, they are the essence of it.\"</strong></p><p>Principal &amp; CEO</p>',NULL),(4,2,'ar','رسالة مديرة المدرسة والرئيسة التنفيذية','Welcome to ABS','<p>As Principal and CEO, it is my pleasure to welcome you to our vibrant and nurturing community where students are at the heart of everything we do. At the Amman Baccalaureate School (ABS), we take pride in offering an exceptional, student- centered educational experience that prepares young minds to thrive in an ever- changing world.</p><p>Our mission is to develop well-rounded, lifelong learners who are confident, compassionate, and equipped with the skills and values needed to make a positive impact on the global stage. Guided by our vision of academic excellence and personal growth, we create an environment where students feel empowered to pursue their passions, explore their potential, and contribute to society.</p><p>ABS is committed to innovation and excellence, combining rigorous academic programs with opportunities for holistic development. From the internationally recognised IB curriculum to our rich array of extracurricular activities, our school prioritizes the intellectual, emotional, and social growth of each individual.</p><p><strong>\"We invite you to join us on this journey of discovery, creativity, and achievement as we continue to shape the leaders and innovators of tomorrow. At ABS, students are not just part of the school, they are the essence of it.\"</strong></p><p>Principal &amp; CEO</p>',NULL),(5,3,'en','Guiding Statement - Who We Are',NULL,'<h2>Our Vision</h2><p>To provide a holistic, challenging, and enriching education to prepare rooted, connected respectful and impactful new generations who will make a positive difference in a changing and complex world.</p><h2>Our Mission</h2><h3>Al Tarbiyeh</h3><p>The Amman Baccalaureate School was formed in 1981, upon a foundation of academic excellence. Deeply rooted in our proud Jordanian heritage, this is an ethos that remains today.</p><p>Students are encouraged to be intellectually curious and spiritually conscious, respecting difference without prejudice to one\'s own principles; to give the very best of themselves in all things; to be kind and compassionate to others; and to contribute to the community at school, at home and beyond.</p><p>The school nurtures and encourages students to be resilient, adaptable, and passionate global citizens, ready to go out into the world as grounded, confident, upstanding men and women.</p><p>These values are at the very core of our shared life, shaping a community of ethical learners with agency, who are an influence for good in a challenging and changing world.</p><h3>A quality education and principled upbringing</h3>',NULL),(6,3,'ar','البيان التوجيهي - من نحن',NULL,'<h2>Our Vision</h2><p>To provide a holistic, challenging, and enriching education to prepare rooted, connected respectful and impactful new generations who will make a positive difference in a changing and complex world.</p><h2>Our Mission</h2><h3>Al Tarbiyeh</h3><p>The Amman Baccalaureate School was formed in 1981, upon a foundation of academic excellence. Deeply rooted in our proud Jordanian heritage, this is an ethos that remains today.</p><p>Students are encouraged to be intellectually curious and spiritually conscious, respecting difference without prejudice to one\'s own principles; to give the very best of themselves in all things; to be kind and compassionate to others; and to contribute to the community at school, at home and beyond.</p><p>The school nurtures and encourages students to be resilient, adaptable, and passionate global citizens, ready to go out into the world as grounded, confident, upstanding men and women.</p><p>These values are at the very core of our shared life, shaping a community of ethical learners with agency, who are an influence for good in a challenging and changing world.</p><h3>A quality education and principled upbringing</h3>',NULL),(7,4,'en','ABS Shared Understanding of High-Quality Learning',NULL,'<p>High-Quality Learning at ABS combines inquiry-based, conceptual, experiential, and collaborative learning. It cultivates critical thinking, creativity and problem solving thereby enhancing personal growth and fostering agency. It engages learners in local and global issues so that they will be rooted, compassionate citizens who will have a positive impact on the world.</p>',NULL),(8,4,'ar','الفهم المشترك للتعلّم عالي الجودة',NULL,'<p>High-Quality Learning at ABS combines inquiry-based, conceptual, experiential, and collaborative learning. It cultivates critical thinking, creativity and problem solving thereby enhancing personal growth and fostering agency. It engages learners in local and global issues so that they will be rooted, compassionate citizens who will have a positive impact on the world.</p>',NULL),(9,5,'en','Strategic Priorities',NULL,NULL,NULL),(10,5,'ar','الأولويات الاستراتيجية',NULL,NULL,NULL),(11,6,'en','Innovation',NULL,NULL,NULL),(12,6,'ar','الابتكار',NULL,NULL,NULL),(13,7,'en','Our Campus',NULL,NULL,NULL),(14,7,'ar','حرمنا المدرسي',NULL,NULL,NULL),(15,8,'en','Admissions',NULL,NULL,NULL),(16,8,'ar','القبول',NULL,NULL,NULL),(17,9,'en','Admissions Procedure','Prospective Parents','<p>We are pleased you are considering our school for your family. We hope you will discover the warmth, friendliness and excitement that is at the heart of our bilingual and international learning community.</p>',NULL),(18,9,'ar','إجراءات القبول','Prospective Parents','<p>We are pleased you are considering our school for your family. We hope you will discover the warmth, friendliness and excitement that is at the heart of our bilingual and international learning community.</p>',NULL),(19,10,'en','Tuition Fees','Financial Information','<p>Transparent tuition structures, administrative fees, transport, and comprehensive policy guidelines.</p><p><small>*Ministry textbooks and stationery are supplied by the School. Costs of other textbooks, field trips, special courses, co-curricular activities, and Summer School are payable separately.</small></p>',NULL),(20,10,'ar','الرسوم الدراسية','Financial Information','<p>Transparent tuition structures, administrative fees, transport, and comprehensive policy guidelines.</p><p><small>*Ministry textbooks and stationery are supplied by the School. Costs of other textbooks, field trips, special courses, co-curricular activities, and Summer School are payable separately.</small></p>',NULL),(21,11,'en','Admission Applications',NULL,'<p>Applications are now submitted through our online portal. Payments can be made at our HRH Princess Sarvath El Hassan Welcome Center, Sunday – Thursday, 8:00 AM – 4:00 PM during the school year.</p>',NULL),(22,11,'ar','طلبات القبول',NULL,'<p>Applications are now submitted through our online portal. Payments can be made at our HRH Princess Sarvath El Hassan Welcome Center, Sunday – Thursday, 8:00 AM – 4:00 PM during the school year.</p>',NULL),(23,12,'en','Admission Policy',NULL,NULL,NULL),(24,12,'ar','سياسة القبول',NULL,NULL,NULL),(25,13,'en','Examination Entry Policy',NULL,NULL,NULL),(26,13,'ar','سياسة التقدم للامتحانات',NULL,NULL,NULL),(27,14,'en','Scholarships, Bursaries and Awards',NULL,NULL,NULL),(28,14,'ar','المنح الدراسية والجوائز',NULL,NULL,NULL),(29,15,'en','Additional Educational Needs (AEN)','Access and Inclusion at ABS','<h2>Our philosophy</h2><p>At ABS, we believe that all children have the right to learn, regardless of their educational needs, within the regular educational system. We therefore work to create a school environment where every student feels valued, empowered, supported, and capable of thriving. As an IB Continuum school, ABS prioritises the learner through all stages of their academic and social-emotional development and works to ensure that its learners are supported in all aspects of their school journey, striving to create equitable opportunities so all learners are included.</p><p>At ABS, an inclusive education is defined as one in which the teaching, learning, and wellbeing of every learner matters equally. We value and celebrate the uniqueness of each learner, fostering an environment where differences, interests, and talents are embraced within and beyond the classroom. This commitment ensures that learners have equitable access to suitable instruction and curricula, enabling them to progress and realise their potential both academically and as valued members of the school community.</p><p>Our approach is proactive, recognising that early identification, intervention, and barrier removal are ethical imperatives that guide our efforts.</p><h2>Our purpose</h2><ul><li>To support the overall well-being of all learners by addressing their educational, social- emotional, and physical needs.</li><li>To foster strong collaboration with families and the school community to create an environment where all learners are valued and feel they fully belong.</li><li>To address learners’ additional needs through personalised learning and to empower them to realise their fullest potential, ultimately enhancing student outcomes and promoting inclusive education.</li><li>To empower all teachers to identify students’ needs and provide support within regular lessons.</li><li>To provide the requisite provision through a team of professionals specialising in inclusion and student support.</li></ul>',NULL),(30,15,'ar','الاحتياجات التعليمية الإضافية','Access and Inclusion at ABS','<h2>Our philosophy</h2><p>At ABS, we believe that all children have the right to learn, regardless of their educational needs, within the regular educational system. We therefore work to create a school environment where every student feels valued, empowered, supported, and capable of thriving. As an IB Continuum school, ABS prioritises the learner through all stages of their academic and social-emotional development and works to ensure that its learners are supported in all aspects of their school journey, striving to create equitable opportunities so all learners are included.</p><p>At ABS, an inclusive education is defined as one in which the teaching, learning, and wellbeing of every learner matters equally. We value and celebrate the uniqueness of each learner, fostering an environment where differences, interests, and talents are embraced within and beyond the classroom. This commitment ensures that learners have equitable access to suitable instruction and curricula, enabling them to progress and realise their potential both academically and as valued members of the school community.</p><p>Our approach is proactive, recognising that early identification, intervention, and barrier removal are ethical imperatives that guide our efforts.</p><h2>Our purpose</h2><ul><li>To support the overall well-being of all learners by addressing their educational, social- emotional, and physical needs.</li><li>To foster strong collaboration with families and the school community to create an environment where all learners are valued and feel they fully belong.</li><li>To address learners’ additional needs through personalised learning and to empower them to realise their fullest potential, ultimately enhancing student outcomes and promoting inclusive education.</li><li>To empower all teachers to identify students’ needs and provide support within regular lessons.</li><li>To provide the requisite provision through a team of professionals specialising in inclusion and student support.</li></ul>',NULL),(31,16,'en','Development Department','Welcome to the Office of Development!','<p>Our mission is to inspire and support individuals and organizations in making meaningful financial contributions that empower ABS to achieve its vision and further its mission of serving the people of Jordan and beyond.</p><p>At ABS, the Office of Development works in close partnership with the Board of Trustees, the Principal, faculty, and staff to secure vital funding for the school’s strategic priorities. Together, we aim to ensure a lasting impact and sustain ABS\'s commitment to excellence in education and community service.</p>',NULL),(32,16,'ar','دائرة التطوير','Welcome to the Office of Development!','<p>Our mission is to inspire and support individuals and organizations in making meaningful financial contributions that empower ABS to achieve its vision and further its mission of serving the people of Jordan and beyond.</p><p>At ABS, the Office of Development works in close partnership with the Board of Trustees, the Principal, faculty, and staff to secure vital funding for the school’s strategic priorities. Together, we aim to ensure a lasting impact and sustain ABS\'s commitment to excellence in education and community service.</p>',NULL),(33,17,'en','Alumni',NULL,'<p>Welcome to the Alumni Relations Office at ABS! Our mission is to foster meaningful connections within the vibrant ABS community—bringing together alumni, faculty, and staff—while championing ABS’s founding vision of creating a better and more impactful society.</p><p>The Office of Alumni Relations at ABS, proudly based in Amman, works hand-in-hand with ABS leadership, faculties, programs, and the OBS Alumni Association to cultivate a thriving and connected alumni community. Together, we collaborate on meaningful events, impactful programs, and philanthropic initiatives that advance the mission and legacy of our institution.</p><p>Our commitment to staying connected with you drives us to organize initiatives that keep you actively engaged with your alma mater. Your accomplishments are a testament to ABS\'s excellence, and we take immense pride in celebrating your successes.</p><p>We are eager to hear from you! Reach out to us anytime at development@abs.edu.jo. Let’s continue building the future of ABS—together.</p>',NULL),(34,17,'ar','الخريجون',NULL,'<p>Welcome to the Alumni Relations Office at ABS! Our mission is to foster meaningful connections within the vibrant ABS community—bringing together alumni, faculty, and staff—while championing ABS’s founding vision of creating a better and more impactful society.</p><p>The Office of Alumni Relations at ABS, proudly based in Amman, works hand-in-hand with ABS leadership, faculties, programs, and the OBS Alumni Association to cultivate a thriving and connected alumni community. Together, we collaborate on meaningful events, impactful programs, and philanthropic initiatives that advance the mission and legacy of our institution.</p><p>Our commitment to staying connected with you drives us to organize initiatives that keep you actively engaged with your alma mater. Your accomplishments are a testament to ABS\'s excellence, and we take immense pride in celebrating your successes.</p><p>We are eager to hear from you! Reach out to us anytime at development@abs.edu.jo. Let’s continue building the future of ABS—together.</p>',NULL),(35,18,'en','Employment',NULL,NULL,NULL),(36,18,'ar','التوظيف',NULL,NULL,NULL),(37,19,'en','Privacy Policy',NULL,NULL,NULL),(38,19,'ar','سياسة الخصوصية',NULL,NULL,NULL),(39,20,'en','Terms and Conditions',NULL,NULL,NULL),(40,20,'ar','الشروط والأحكام',NULL,NULL,NULL),(41,21,'en','Site Map',NULL,NULL,NULL),(42,21,'ar','خريطة الموقع',NULL,NULL,NULL);
/*!40000 ALTER TABLE `page_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'view_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(2,'view_any_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(3,'create_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(4,'update_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(5,'reorder_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(6,'delete_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(7,'delete_any_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(8,'import_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(9,'export_bms','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(10,'view_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(11,'view_any_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(12,'create_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(13,'update_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(14,'reorder_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(15,'delete_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(16,'delete_any_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(17,'import_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(18,'export_branch','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(19,'view_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(20,'view_any_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(21,'create_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(22,'update_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(23,'reorder_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(24,'delete_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(25,'delete_any_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(26,'import_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(27,'export_city','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(28,'view_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(29,'view_any_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(30,'create_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(31,'update_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(32,'reorder_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(33,'delete_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(34,'delete_any_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(35,'import_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(36,'export_complaints::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(37,'view_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(38,'view_any_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(39,'create_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(40,'update_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(41,'reorder_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(42,'delete_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(43,'delete_any_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(44,'import_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(45,'export_contact::us::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(46,'view_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(47,'view_any_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(48,'create_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(49,'update_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(50,'reorder_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(51,'delete_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(52,'delete_any_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(53,'import_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(54,'export_district','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(55,'view_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(56,'view_any_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(57,'create_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(58,'update_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(59,'reorder_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(60,'delete_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(61,'delete_any_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(62,'import_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(63,'export_dropdown::list','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(64,'view_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(65,'view_any_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(66,'create_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(67,'update_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(68,'reorder_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(69,'delete_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(70,'delete_any_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(71,'import_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(72,'export_faq','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(73,'view_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(74,'view_any_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(75,'create_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(76,'update_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(77,'reorder_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(78,'delete_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(79,'delete_any_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(80,'import_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(81,'export_feedback::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(82,'view_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(83,'view_any_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(84,'create_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(85,'update_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(86,'reorder_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(87,'delete_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(88,'delete_any_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(89,'import_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(90,'export_header::image','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(91,'view_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(92,'view_any_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(93,'create_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(94,'update_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(95,'reorder_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(96,'delete_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(97,'delete_any_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(98,'import_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(99,'export_inquiry::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(100,'view_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(101,'view_any_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(102,'create_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(103,'update_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(104,'reorder_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(105,'delete_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(106,'delete_any_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(107,'import_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(108,'export_language::line','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(109,'view_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(110,'view_any_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(111,'create_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(112,'update_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(113,'reorder_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(114,'delete_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(115,'delete_any_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(116,'import_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(117,'export_leasing::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(118,'view_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(119,'view_any_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(120,'create_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(121,'update_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(122,'reorder_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(123,'delete_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(124,'delete_any_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(125,'import_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(126,'export_media','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(127,'view_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(128,'view_any_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(129,'create_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(130,'update_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(131,'reorder_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(132,'delete_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(133,'delete_any_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(134,'import_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(135,'export_menu','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(136,'view_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(137,'view_any_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(138,'create_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(139,'update_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(140,'reorder_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(141,'delete_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(142,'delete_any_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(143,'import_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(144,'export_menu::link','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(145,'view_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(146,'view_any_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(147,'create_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(148,'update_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(149,'reorder_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(150,'delete_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(151,'delete_any_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(152,'import_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(153,'export_message::category','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(154,'view_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(155,'view_any_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(156,'create_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(157,'update_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(158,'reorder_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(159,'delete_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(160,'delete_any_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(161,'import_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(162,'export_message::translation','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(163,'view_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(164,'view_any_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(165,'create_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(166,'update_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(167,'reorder_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(168,'delete_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(169,'delete_any_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(170,'import_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(171,'export_news','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(172,'view_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(173,'view_any_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(174,'create_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(175,'update_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(176,'reorder_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(177,'delete_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(178,'delete_any_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(179,'import_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(180,'export_our::partner','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(181,'view_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(182,'view_any_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(183,'create_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(184,'update_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(185,'reorder_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(186,'delete_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(187,'delete_any_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(188,'import_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(189,'export_our::team','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(190,'view_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(191,'view_any_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(192,'create_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(193,'update_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(194,'reorder_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(195,'delete_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(196,'delete_any_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(197,'import_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(198,'export_our::team::webform','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(199,'view_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(200,'view_any_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(201,'create_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(202,'update_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(203,'reorder_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(204,'delete_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(205,'delete_any_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(206,'import_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(207,'export_page','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(208,'view_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(209,'view_any_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(210,'create_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(211,'update_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(212,'reorder_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(213,'delete_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(214,'delete_any_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(215,'import_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(216,'export_required::document','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(217,'view_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(218,'view_any_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(219,'create_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(220,'update_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(221,'delete_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(222,'delete_any_role','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(232,'view_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(233,'view_any_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(234,'create_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(235,'update_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(236,'reorder_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(237,'delete_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(238,'delete_any_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(239,'import_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(240,'export_testimonial','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(241,'view_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(242,'view_any_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(243,'create_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(244,'update_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(245,'reorder_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(246,'delete_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(247,'delete_any_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(248,'import_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(249,'export_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(250,'page_AllSetting','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(251,'page_QuickTranslate','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(252,'view_audit::audit','web','2025-10-20 14:56:12','2025-10-20 14:56:12'),(253,'restore_audit::audit','web','2025-10-20 14:56:12','2025-10-20 14:56:12'),(254,'view_any_audit::audit','web','2025-10-20 14:56:12','2025-10-20 14:56:12'),(255,'restore_any_audit::audit','web','2025-10-20 14:56:12','2025-10-20 14:56:12'),(269,'view_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(270,'view_any_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(271,'create_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(272,'update_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(273,'restore_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(274,'restore_any_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(275,'replicate_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(276,'reorder_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(277,'delete_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(278,'delete_any_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(279,'force_delete_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(280,'force_delete_any_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(281,'import_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(282,'export_school::school','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(283,'view_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(284,'view_any_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(285,'create_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(286,'update_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(287,'restore_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(288,'restore_any_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(289,'replicate_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(290,'reorder_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(291,'delete_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(292,'delete_any_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(293,'force_delete_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(294,'force_delete_any_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(295,'import_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(296,'export_school::tab::school::tab','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(297,'view_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(298,'view_any_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(299,'create_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(300,'update_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(301,'restore_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(302,'restore_any_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(303,'replicate_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(304,'reorder_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(305,'delete_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(306,'delete_any_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(307,'force_delete_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(308,'force_delete_any_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(309,'import_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(310,'export_school::subject::school::subject','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(311,'view_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(312,'view_any_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(313,'create_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(314,'update_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(315,'restore_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(316,'restore_any_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(317,'replicate_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(318,'reorder_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(319,'delete_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(320,'delete_any_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(321,'force_delete_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(322,'force_delete_any_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(323,'import_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(324,'export_tuition::fee::tuition::fee','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(325,'view_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(326,'view_any_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(327,'create_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(328,'update_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(329,'restore_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(330,'restore_any_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(331,'replicate_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(332,'reorder_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(333,'delete_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(334,'delete_any_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(335,'force_delete_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(336,'force_delete_any_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(337,'import_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(338,'export_team::member::team::member','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(339,'view_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(340,'view_any_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(341,'create_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(342,'update_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(343,'restore_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(344,'restore_any_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(345,'replicate_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(346,'reorder_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(347,'delete_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(348,'delete_any_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(349,'force_delete_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(350,'force_delete_any_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(351,'import_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(352,'export_university::university','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(353,'view_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(354,'view_any_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(355,'create_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(356,'update_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(357,'restore_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(358,'restore_any_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(359,'replicate_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(360,'reorder_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(361,'delete_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(362,'delete_any_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(363,'force_delete_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(364,'force_delete_any_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(365,'import_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(366,'export_student::engagement::student::engagement','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(367,'view_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(368,'view_any_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(369,'create_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(370,'update_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(371,'restore_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(372,'restore_any_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(373,'replicate_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(374,'reorder_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(375,'delete_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(376,'delete_any_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(377,'force_delete_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(378,'force_delete_any_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(379,'import_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(380,'export_album::album','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(381,'view_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(382,'view_any_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(383,'create_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(384,'update_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(385,'restore_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(386,'restore_any_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(387,'replicate_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(388,'reorder_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(389,'delete_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(390,'delete_any_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(391,'force_delete_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(392,'force_delete_any_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(393,'import_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(394,'export_subscribe::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(395,'view_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(396,'view_any_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(397,'create_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(398,'update_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(399,'restore_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(400,'restore_any_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(401,'replicate_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(402,'reorder_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(403,'delete_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(404,'delete_any_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(405,'force_delete_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(406,'force_delete_any_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(407,'import_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(408,'export_alumni::stay::connected::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(409,'view_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(410,'view_any_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(411,'create_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(412,'update_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(413,'restore_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(414,'restore_any_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(415,'replicate_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(416,'reorder_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(417,'delete_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(418,'delete_any_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(419,'force_delete_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(420,'force_delete_any_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(421,'import_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(422,'export_class::note::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(423,'view_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(424,'view_any_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(425,'create_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(426,'update_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(427,'restore_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(428,'restore_any_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(429,'replicate_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(430,'reorder_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(431,'delete_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(432,'delete_any_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(433,'force_delete_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(434,'force_delete_any_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(435,'import_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56'),(436,'export_giving::webform','web','2026-10-20 17:52:56','2026-10-20 17:52:56');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (269,1),(270,1),(271,1),(272,1),(273,1),(274,1),(275,1),(276,1),(277,1),(278,1),(279,1),(280,1),(281,1),(282,1),(283,1),(284,1),(285,1),(286,1),(287,1),(288,1),(289,1),(290,1),(291,1),(292,1),(293,1),(294,1),(295,1),(296,1),(297,1),(298,1),(299,1),(300,1),(301,1),(302,1),(303,1),(304,1),(305,1),(306,1),(307,1),(308,1),(309,1),(310,1),(311,1),(312,1),(313,1),(314,1),(315,1),(316,1),(317,1),(318,1),(319,1),(320,1),(321,1),(322,1),(323,1),(324,1),(325,1),(326,1),(327,1),(328,1),(329,1),(330,1),(331,1),(332,1),(333,1),(334,1),(335,1),(336,1),(337,1),(338,1),(339,1),(340,1),(341,1),(342,1),(343,1),(344,1),(345,1),(346,1),(347,1),(348,1),(349,1),(350,1),(351,1),(352,1),(353,1),(354,1),(355,1),(356,1),(357,1),(358,1),(359,1),(360,1),(361,1),(362,1),(363,1),(364,1),(365,1),(366,1),(367,1),(368,1),(369,1),(370,1),(371,1),(372,1),(373,1),(374,1),(375,1),(376,1),(377,1),(378,1),(379,1),(380,1),(381,1),(382,1),(383,1),(384,1),(385,1),(386,1),(387,1),(388,1),(389,1),(390,1),(391,1),(392,1),(393,1),(394,1),(395,1),(396,1),(397,1),(398,1),(399,1),(400,1),(401,1),(402,1),(403,1),(404,1),(405,1),(406,1),(407,1),(408,1),(409,1),(410,1),(411,1),(412,1),(413,1),(414,1),(415,1),(416,1),(417,1),(418,1),(419,1),(420,1),(421,1),(422,1),(423,1),(424,1),(425,1),(426,1),(427,1),(428,1),(429,1),(430,1),(431,1),(432,1),(433,1),(434,1),(435,1),(436,1),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,3),(16,3),(17,3),(18,3),(19,3),(20,3),(21,3),(22,3),(23,3),(24,3),(25,3),(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),(34,3),(35,3),(36,3),(37,3),(38,3),(39,3),(40,3),(41,3),(42,3),(43,3),(44,3),(45,3),(46,3),(47,3),(48,3),(49,3),(50,3),(51,3),(52,3),(53,3),(54,3),(55,3),(56,3),(57,3),(58,3),(59,3),(60,3),(61,3),(62,3),(63,3),(64,3),(65,3),(66,3),(67,3),(68,3),(69,3),(70,3),(71,3),(72,3),(73,3),(74,3),(75,3),(76,3),(77,3),(78,3),(79,3),(80,3),(81,3),(82,3),(83,3),(84,3),(85,3),(86,3),(87,3),(88,3),(89,3),(90,3),(91,3),(92,3),(93,3),(94,3),(95,3),(96,3),(97,3),(98,3),(99,3),(100,3),(101,3),(102,3),(103,3),(104,3),(105,3),(106,3),(107,3),(108,3),(109,3),(110,3),(111,3),(112,3),(113,3),(114,3),(115,3),(116,3),(117,3),(118,3),(119,3),(120,3),(121,3),(122,3),(123,3),(124,3),(125,3),(126,3),(127,3),(128,3),(129,3),(130,3),(131,3),(132,3),(133,3),(134,3),(135,3),(136,3),(137,3),(138,3),(139,3),(140,3),(141,3),(142,3),(143,3),(144,3),(145,3),(146,3),(147,3),(148,3),(149,3),(150,3),(151,3),(152,3),(153,3),(154,3),(155,3),(156,3),(157,3),(158,3),(159,3),(160,3),(161,3),(162,3),(163,3),(164,3),(165,3),(166,3),(167,3),(168,3),(169,3),(170,3),(171,3),(172,3),(173,3),(174,3),(175,3),(176,3),(177,3),(178,3),(179,3),(180,3),(181,3),(182,3),(183,3),(184,3),(185,3),(186,3),(187,3),(188,3),(189,3),(190,3),(191,3),(192,3),(193,3),(194,3),(195,3),(196,3),(197,3),(198,3),(199,3),(200,3),(201,3),(202,3),(203,3),(204,3),(205,3),(206,3),(207,3),(208,3),(209,3),(210,3),(211,3),(212,3),(213,3),(214,3),(215,3),(216,3),(217,3),(218,3),(219,3),(220,3),(221,3),(222,3),(232,3),(233,3),(234,3),(235,3),(236,3),(237,3),(238,3),(239,3),(240,3),(241,3),(242,3),(243,3),(244,3),(245,3),(246,3),(247,3),(248,3),(249,3),(250,3),(251,3);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'super_admin','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(2,'panel_user','web','1970-01-01 02:33:44','1970-01-01 02:33:44'),(3,'all','web','1970-01-01 02:33:44','1970-01-01 02:33:44');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_id` bigint unsigned DEFAULT NULL,
  `head_image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_slug_unique` (`slug`),
  KEY `school_status_index` (`status`),
  KEY `school_deleted_at_index` (`deleted_at`),
  KEY `school_published_at_index` (`published_at`),
  KEY `school_created_by_foreign` (`created_by`),
  KEY `school_updated_by_foreign` (`updated_by`),
  CONSTRAINT `school_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `school_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES (1,NULL,NULL,'primary-school',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,NULL,NULL,'middle-school',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,NULL,NULL,'ib-college',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL);
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_lang`
--

DROP TABLE IF EXISTS `school_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grades_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_content` text COLLATE utf8mb4_unicode_ci,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `school_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `school_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `school_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_lang`
--

LOCK TABLES `school_lang` WRITE;
/*!40000 ALTER TABLE `school_lang` DISABLE KEYS */;
INSERT INTO `school_lang` VALUES (1,1,'en','Primary School – KG1 - Grade 6','KG1 - Grade 6','A rigorous bilingual curriculum (Arabic and English) based on the IB Primary Years Programme.','Welcome from Head of Early Years','Amira Al Shawa',NULL,'<p>The Early Years are a wonderful beginning to a child’s experience of school, filled with curiosity, discovery, and new possibilities. At the Amman Baccalaureate School, we provide a warm and stimulating environment where children develop a sense of belonging and are encouraged to explore the world around them.</p><p>As an integral part of the Primary School, our Kindergarten programme is guided by the IB Primary Years Programme (PYP). ABS was authorised to offer the PYP in 2015, becoming the first school in Jordan to offer a fully bilingual (Arabic and English) PYP programme. Through play, inquiry, and purposeful learning experiences, our children are encouraged to ask questions, investigate, share ideas, and develop a genuine love of learning.</p><p>With warm wishes,</p>',NULL),(2,1,'ar','المدرسة الابتدائية – الروضة الأولى - الصف السادس','الروضة الأولى - الصف السادس','A rigorous bilingual curriculum (Arabic and English) based on the IB Primary Years Programme.','كلمة رئيسة مرحلة الطفولة المبكرة','أميرة الشوا',NULL,'<p>The Early Years are a wonderful beginning to a child’s experience of school, filled with curiosity, discovery, and new possibilities. At the Amman Baccalaureate School, we provide a warm and stimulating environment where children develop a sense of belonging and are encouraged to explore the world around them.</p><p>As an integral part of the Primary School, our Kindergarten programme is guided by the IB Primary Years Programme (PYP). ABS was authorised to offer the PYP in 2015, becoming the first school in Jordan to offer a fully bilingual (Arabic and English) PYP programme. Through play, inquiry, and purposeful learning experiences, our children are encouraged to ask questions, investigate, share ideas, and develop a genuine love of learning.</p><p>With warm wishes,</p>',NULL),(3,2,'en','Secondary School – Middle School (Grades 7-10)','Grades 7 - Grades 10','The first school in the Middle East to be authorised to implement the IB Middle Years Programme.','Welcome From Head of Middle School','Miss Dima Qubain','Head of Middle School','<p>The Middle School is a nurturing and vibrant environment committed to nurturing curious, confident, compassionate, and independent young people.</p><p>The Middle School at Amman Baccalaureate school was the first school in the Middle East to be authorised to implement the IB Middle Years Programme in 2002.</p><p>The Middle School encompassing Grades 7–10, are a formative stage in every student’s journey. Our holistic programme combines academic challenge with opportunities for personal growth, wellbeing, leadership, creativity, and service.</p><p>Through a broad and balanced curriculum, students are encouraged to think critically, explore their interests, make meaningful connections, and take increasing ownership of their learning. They are supported to become reflective, resilient, and globally minded individuals who value diverse perspectives and contribute positively to their communities.</p>',NULL),(4,2,'ar','المدرسة الثانوية – المرحلة المتوسطة (الصفوف 7-10)','الصف السابع - الصف العاشر','The first school in the Middle East to be authorised to implement the IB Middle Years Programme.','كلمة رئيسة المرحلة المتوسطة','الآنسة ديما قبعين','Head of Middle School','<p>The Middle School is a nurturing and vibrant environment committed to nurturing curious, confident, compassionate, and independent young people.</p><p>The Middle School at Amman Baccalaureate school was the first school in the Middle East to be authorised to implement the IB Middle Years Programme in 2002.</p><p>The Middle School encompassing Grades 7–10, are a formative stage in every student’s journey. Our holistic programme combines academic challenge with opportunities for personal growth, wellbeing, leadership, creativity, and service.</p><p>Through a broad and balanced curriculum, students are encouraged to think critically, explore their interests, make meaningful connections, and take increasing ownership of their learning. They are supported to become reflective, resilient, and globally minded individuals who value diverse perspectives and contribute positively to their communities.</p>',NULL),(5,3,'en','Secondary School – IB College (Grades 11-12)','Grades 11 - Grades 12','The full IB Diploma Programme and the IB Career-related Programme in the purpose-built Randa Kawar building.','Welcome from Head of IB College','Cathy Souob','Vice Principal for Professional Development and Student Progress/Head of IB College','<p>The IB College, located in the purpose-built Randa Kawar building, enjoys purposely designed learning and recreational spaces catering to the needs of our grades 11 and 12 students. This stimulating location and the experiences it offers provide students with the opportunity to develop a mature and age-appropriate independence within a structured and supportive environment. Within this environment, students are encouraged to develop their identity as world citizens and reach their academic potential.</p><p>On entering the IB College, students enroll on either the full IB Diploma Programme or, if deemed more appropriate, individual Diploma Courses. ABS was also the first school in Jordan to offer the Career-related programme, which offers a career-related pathway to university for those students whose future plans lend themselves to it.</p>',NULL),(6,3,'ar','المدرسة الثانوية – كلية البكالوريا الدولية (الصفوف 11-12)','الصف الحادي عشر - الصف الثاني عشر','The full IB Diploma Programme and the IB Career-related Programme in the purpose-built Randa Kawar building.','كلمة رئيسة كلية البكالوريا الدولية','كاثي صعوب','Vice Principal for Professional Development and Student Progress/Head of IB College','<p>The IB College, located in the purpose-built Randa Kawar building, enjoys purposely designed learning and recreational spaces catering to the needs of our grades 11 and 12 students. This stimulating location and the experiences it offers provide students with the opportunity to develop a mature and age-appropriate independence within a structured and supportive environment. Within this environment, students are encouraged to develop their identity as world citizens and reach their academic potential.</p><p>On entering the IB College, students enroll on either the full IB Diploma Programme or, if deemed more appropriate, individual Diploma Courses. ABS was also the first school in Jordan to offer the Career-related programme, which offers a career-related pathway to university for those students whose future plans lend themselves to it.</p>',NULL);
/*!40000 ALTER TABLE `school_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_subject`
--

DROP TABLE IF EXISTS `school_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_subject` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `school_tab_id` bigint unsigned NOT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_subject_slug_unique` (`slug`),
  KEY `school_subject_status_index` (`status`),
  KEY `school_subject_deleted_at_index` (`deleted_at`),
  KEY `school_subject_published_at_index` (`published_at`),
  KEY `school_subject_created_by_foreign` (`created_by`),
  KEY `school_subject_updated_by_foreign` (`updated_by`),
  KEY `school_subject_school_tab_id_foreign` (`school_tab_id`),
  CONSTRAINT `school_subject_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `school_subject_school_tab_id_foreign` FOREIGN KEY (`school_tab_id`) REFERENCES `school_tab` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `school_subject_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subject`
--

LOCK TABLES `school_subject` WRITE;
/*!40000 ALTER TABLE `school_subject` DISABLE KEYS */;
INSERT INTO `school_subject` VALUES (1,4,NULL,'primary-language',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,4,NULL,'primary-mathematics',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,4,NULL,'primary-science',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,4,NULL,'primary-social-studies',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,4,NULL,'primary-information-literacy',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL),(6,4,NULL,'primary-pspe',1,1792518995,1792518995,NULL,1792518995,1,1,6,0,0,NULL),(7,4,NULL,'primary-transdisciplinary-themes',1,1792518995,1792518995,NULL,1792518995,1,1,7,0,0,NULL),(8,6,NULL,'middle-mathematics',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(9,6,NULL,'middle-sciences',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(10,6,NULL,'middle-individuals-and-societies',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(11,6,NULL,'middle-language-and-literature',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(12,6,NULL,'middle-language-acquisition',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL),(13,6,NULL,'middle-arts',1,1792518995,1792518995,NULL,1792518995,1,1,6,0,0,NULL),(14,6,NULL,'middle-design',1,1792518995,1792518995,NULL,1792518995,1,1,7,0,0,NULL),(15,6,NULL,'middle-interdisciplinary',1,1792518995,1792518995,NULL,1792518995,1,1,8,0,0,NULL),(16,9,NULL,'ib-diploma-programme',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(17,9,NULL,'ib-career-related-programme',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL);
/*!40000 ALTER TABLE `school_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_subject_lang`
--

DROP TABLE IF EXISTS `school_subject_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_subject_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` text COLLATE utf8mb4_unicode_ci,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `school_subject_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `school_subject_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `school_subject_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `school_subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subject_lang`
--

LOCK TABLES `school_subject_lang` WRITE;
/*!40000 ALTER TABLE `school_subject_lang` DISABLE KEYS */;
INSERT INTO `school_subject_lang` VALUES (1,1,'en','Language','<ul><li>Oral language</li><li>Written language</li><li>Visual language</li></ul>',NULL),(2,1,'ar','اللغة','<ul><li>Oral language</li><li>Written language</li><li>Visual language</li></ul>',NULL),(3,2,'en','Mathematics',NULL,NULL),(4,2,'ar','الرياضيات',NULL,NULL),(5,3,'en','Science',NULL,NULL),(6,3,'ar','العلوم',NULL,NULL),(7,4,'en','Social Studies',NULL,NULL),(8,4,'ar','الدراسات الاجتماعية',NULL,NULL),(9,5,'en','Information Literacy and Technology Integration',NULL,NULL),(10,5,'ar','الثقافة المعلوماتية ودمج التكنولوجيا',NULL,NULL),(11,6,'en','Personal, Social and Physical Education (PSPE)',NULL,NULL),(12,6,'ar','التربية الشخصية والاجتماعية والبدنية',NULL,NULL),(13,7,'en','Transdisciplinary Themes','<p>Throughout the year, learners inquire into globally significant issues through Units of Inquiry, which are organised within the Programme of Inquiry. Each unit addresses a central idea connected to one of the six transdisciplinary themes. During the school year, Kindergarten learners explore five Units of Inquiry, while learners in Grades 1–6 explore six.</p>',NULL),(14,7,'ar','المحاور العابرة للتخصصات','<p>Throughout the year, learners inquire into globally significant issues through Units of Inquiry, which are organised within the Programme of Inquiry. Each unit addresses a central idea connected to one of the six transdisciplinary themes. During the school year, Kindergarten learners explore five Units of Inquiry, while learners in Grades 1–6 explore six.</p>',NULL),(15,8,'en','Mathematics','<h4>Course description and aims</h4><p>The framework for MYP mathematics outlines four branches of mathematical study.</p><ul><li>Numerical and abstract reasoning</li><li>Thinking with models</li><li>Spatial reasoning</li><li>Reasoning with data</li></ul><p>The study of mathematics is a fundamental part of a balanced education. It promotes a powerful universal language, analytical reasoning and problem-solving skills that contribute to the development of logical, abstract and critical thinking. The MYP mathematics and extended mathematics courses promote both inquiry and application, helping students to develop problem-solving techniques that transcend the discipline and are useful in the world outside school.</p><p>Mathematics in the MYP is tailored to the needs of students, seeking to intrigue and motivate them to want to learn its principles. Students should see authentic examples of how mathematics is useful and relevant to their lives and be encouraged to apply it to new situations.</p>','<h4>Course description and aims</h4><p>The framework for MYP mathematics outlines four branches of mathematical study.</p><ul><li>Numerical and abstract reasoning</li><li>Thinking with models</li><li>Spatial reasoning</li><li>Reasoning with data</li></ul><p>The study of mathematics is a fundamental part of a balanced education. It promotes a powerful universal language, analytical reasoning and problem-solving skills that contribute to the development of logical, abstract and critical thinking. The MYP mathematics and extended mathematics courses promote both inquiry and application, helping students to develop problem-solving techniques that transcend the discipline and are useful in the world outside school.</p><p>Mathematics in the MYP is tailored to the needs of students, seeking to intrigue and motivate them to want to learn its principles. Students should see authentic examples of how mathematics is useful and relevant to their lives and be encouraged to apply it to new situations.</p><p>The aims of MYP mathematics courses are to encourage and enable students to:</p><ul><li>enjoy mathematics, develop curiosity and begin to appreciate its elegance and power</li><li>develop an understanding of the principles and nature of mathematics</li><li>communicate clearly and confidently in a variety of contexts</li><li>develop logical, critical and creative thinking</li><li>develop confidence, perseverance and independence in mathematical thinking and problem-solving</li><li>develop powers of generalization and abstraction</li><li>apply and transfer skills to a wide range of real-life situations, other areas of knowledge and future developments</li><li>appreciate how developments in technology and mathematics have influenced each other</li><li>develop the knowledge, skills and attitudes necessary to pursue further studies in mathematics</li><li>develop the ability to reflect critically upon their own work and the work of others.</li></ul><h4>Curriculum model overview</h4><ul><li>For MYP mathematics, schools can develop courses at two level of challenge: standard and extended.</li><li>Standard mathematics aims to provide a sound knowledge of basic mathematical principles.</li><li>Extended mathematics supplements the standard curriculum with additional topics and skills, providing greater breadth and depth of study.</li><li>The MYP promotes sustained inquiry in mathematics by developing conceptual understanding within global contexts.</li><li>Key concepts such as form, logic and relationships broadly frame the MYP curriculum.</li><li>The MYP requires at least 50 hours of teaching time for each subject area in each year of the programme.</li></ul>'),(16,8,'ar','الرياضيات','<h4>Course description and aims</h4><p>The framework for MYP mathematics outlines four branches of mathematical study.</p><ul><li>Numerical and abstract reasoning</li><li>Thinking with models</li><li>Spatial reasoning</li><li>Reasoning with data</li></ul><p>The study of mathematics is a fundamental part of a balanced education. It promotes a powerful universal language, analytical reasoning and problem-solving skills that contribute to the development of logical, abstract and critical thinking. The MYP mathematics and extended mathematics courses promote both inquiry and application, helping students to develop problem-solving techniques that transcend the discipline and are useful in the world outside school.</p><p>Mathematics in the MYP is tailored to the needs of students, seeking to intrigue and motivate them to want to learn its principles. Students should see authentic examples of how mathematics is useful and relevant to their lives and be encouraged to apply it to new situations.</p>','<h4>Course description and aims</h4><p>The framework for MYP mathematics outlines four branches of mathematical study.</p><ul><li>Numerical and abstract reasoning</li><li>Thinking with models</li><li>Spatial reasoning</li><li>Reasoning with data</li></ul><p>The study of mathematics is a fundamental part of a balanced education. It promotes a powerful universal language, analytical reasoning and problem-solving skills that contribute to the development of logical, abstract and critical thinking. The MYP mathematics and extended mathematics courses promote both inquiry and application, helping students to develop problem-solving techniques that transcend the discipline and are useful in the world outside school.</p><p>Mathematics in the MYP is tailored to the needs of students, seeking to intrigue and motivate them to want to learn its principles. Students should see authentic examples of how mathematics is useful and relevant to their lives and be encouraged to apply it to new situations.</p><p>The aims of MYP mathematics courses are to encourage and enable students to:</p><ul><li>enjoy mathematics, develop curiosity and begin to appreciate its elegance and power</li><li>develop an understanding of the principles and nature of mathematics</li><li>communicate clearly and confidently in a variety of contexts</li><li>develop logical, critical and creative thinking</li><li>develop confidence, perseverance and independence in mathematical thinking and problem-solving</li><li>develop powers of generalization and abstraction</li><li>apply and transfer skills to a wide range of real-life situations, other areas of knowledge and future developments</li><li>appreciate how developments in technology and mathematics have influenced each other</li><li>develop the knowledge, skills and attitudes necessary to pursue further studies in mathematics</li><li>develop the ability to reflect critically upon their own work and the work of others.</li></ul><h4>Curriculum model overview</h4><ul><li>For MYP mathematics, schools can develop courses at two level of challenge: standard and extended.</li><li>Standard mathematics aims to provide a sound knowledge of basic mathematical principles.</li><li>Extended mathematics supplements the standard curriculum with additional topics and skills, providing greater breadth and depth of study.</li><li>The MYP promotes sustained inquiry in mathematics by developing conceptual understanding within global contexts.</li><li>Key concepts such as form, logic and relationships broadly frame the MYP curriculum.</li><li>The MYP requires at least 50 hours of teaching time for each subject area in each year of the programme.</li></ul>'),(17,9,'en','Sciences',NULL,NULL),(18,9,'ar','العلوم',NULL,NULL),(19,10,'en','Individuals and Societies',NULL,NULL),(20,10,'ar','الفرد والمجتمع',NULL,NULL),(21,11,'en','Language and Literature (Arabic and English)',NULL,NULL),(22,11,'ar','اللغة والأدب (العربية والإنجليزية)',NULL,NULL),(23,12,'en','Language Acquisition (Arabic, Spanish and French)',NULL,NULL),(24,12,'ar','اكتساب اللغة (العربية والإسبانية والفرنسية)',NULL,NULL),(25,13,'en','Arts',NULL,NULL),(26,13,'ar','الفنون',NULL,NULL),(27,14,'en','Design',NULL,NULL),(28,14,'ar','التصميم',NULL,NULL),(29,15,'en','Interdisciplinary',NULL,NULL),(30,15,'ar','متعدد التخصصات',NULL,NULL),(31,16,'en','The IB Diploma Programme: A Gateway to Top Universities',NULL,NULL),(32,16,'ar','برنامج دبلوم IB: بوابة إلى أفضل الجامعات',NULL,NULL),(33,17,'en','The IB Career-related Programme (CP): Pathway to Professional Success',NULL,NULL),(34,17,'ar','برنامج IB المهني (CP): طريقك إلى النجاح المهني',NULL,NULL);
/*!40000 ALTER TABLE `school_subject_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_tab`
--

DROP TABLE IF EXISTS `school_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_tab` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `school_id` bigint unsigned NOT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_tab_slug_unique` (`slug`),
  KEY `school_tab_status_index` (`status`),
  KEY `school_tab_deleted_at_index` (`deleted_at`),
  KEY `school_tab_published_at_index` (`published_at`),
  KEY `school_tab_created_by_foreign` (`created_by`),
  KEY `school_tab_updated_by_foreign` (`updated_by`),
  KEY `school_tab_school_id_foreign` (`school_id`),
  CONSTRAINT `school_tab_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `school_tab_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `school_tab_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_tab`
--

LOCK TABLES `school_tab` WRITE;
/*!40000 ALTER TABLE `school_tab` DISABLE KEYS */;
INSERT INTO `school_tab` VALUES (1,1,NULL,'primary-overview',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,1,NULL,'primary-the-learner',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,1,NULL,'primary-learner-profile-attributes',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,1,NULL,'primary-subject-briefs',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,2,NULL,'middle-overview',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(6,2,NULL,'middle-subject-briefs',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(7,2,NULL,'middle-personal-project',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(8,2,NULL,'middle-service-as-action',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(9,3,NULL,'ib-overview',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(10,3,NULL,'ib-diploma-programme-results',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(11,3,NULL,'ib-college-curriculum',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL);
/*!40000 ALTER TABLE `school_tab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_tab_lang`
--

DROP TABLE IF EXISTS `school_tab_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_tab_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `school_tab_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `school_tab_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `school_tab_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `school_tab` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_tab_lang`
--

LOCK TABLES `school_tab_lang` WRITE;
/*!40000 ALTER TABLE `school_tab_lang` DISABLE KEYS */;
INSERT INTO `school_tab_lang` VALUES (1,1,'en','Overview','<h3>IB PYP Overview</h3><p>Agency is at the heart of the Primary Years Programme (PYP) framework, which is threaded throughout the three pillars of the PYP curriculum framework: the learner, learning and teaching, and the learning community. These interconnected components form a holistic, coherent programme that is trusted, timeless, and transformational.</p><ul><li><strong>The learner:</strong> describes the outcomes for individual learners and what they seek for themselves (What is learning?)</li><li><strong>Learning and teaching:</strong> outlines the distinctive features of learning and teaching (How best to support learners?)</li><li><strong>The learning community:</strong> highlights the importance of the social outcomes of learning and the role IB communities play in achieving these outcomes (Who facilitates learning and teaching?)</li></ul>'),(2,1,'ar','نظرة عامة','<h3>IB PYP Overview</h3><p>Agency is at the heart of the Primary Years Programme (PYP) framework, which is threaded throughout the three pillars of the PYP curriculum framework: the learner, learning and teaching, and the learning community. These interconnected components form a holistic, coherent programme that is trusted, timeless, and transformational.</p><ul><li><strong>The learner:</strong> describes the outcomes for individual learners and what they seek for themselves (What is learning?)</li><li><strong>Learning and teaching:</strong> outlines the distinctive features of learning and teaching (How best to support learners?)</li><li><strong>The learning community:</strong> highlights the importance of the social outcomes of learning and the role IB communities play in achieving these outcomes (Who facilitates learning and teaching?)</li></ul>'),(3,2,'en','The Learner',NULL),(4,2,'ar','المتعلّم',NULL),(5,3,'en','Learner Profile Attributes',NULL),(6,3,'ar','سمات ملف المتعلّم',NULL),(7,4,'en','Learning and Teaching','<p>At the Amman Baccalaureate Primary School, we deliver a rigorous bilingual curriculum (Arabic and English) based on the International Baccalaureate Organisation Primary Years Programme (IB PYP). Teachers challenge learners to think critically and to develop an international mindset.</p><p>The PYP curriculum framework is uniquely adaptable to local and national standards. Guided by six transdisciplinary themes of global significance, learners deepen their understanding by developing conceptual awareness, strengthening knowledge and skills across and beyond subject areas, and being supported by rigorous approaches to learning and teaching.</p>'),(8,4,'ar','التعلّم والتعليم','<p>At the Amman Baccalaureate Primary School, we deliver a rigorous bilingual curriculum (Arabic and English) based on the International Baccalaureate Organisation Primary Years Programme (IB PYP). Teachers challenge learners to think critically and to develop an international mindset.</p><p>The PYP curriculum framework is uniquely adaptable to local and national standards. Guided by six transdisciplinary themes of global significance, learners deepen their understanding by developing conceptual awareness, strengthening knowledge and skills across and beyond subject areas, and being supported by rigorous approaches to learning and teaching.</p>'),(9,5,'en','Overview','<h3>Middle School Overview</h3><p>The Middle School includes grades 7-10. They learn within the Middle Years Programme framework (MYP)</p><p>In the programme model for the MYP, the first ring around the student at the centre describes the features of the programme that help students develop disciplinary (and interdisciplinary) understanding.</p><p>IB philosophy in the MYP This philosophy, framed in What is an IB education? (2019), is expressed through all aspects of the MYP.</p><p>The programme has been developed with developmentally appropriate attention to:</p><ul><li>Conceptual understanding</li><li>Learning and teaching in context</li><li>Approaches to learning (ATL)</li><li>Service as action (community service)</li><li>Language and identity</li><li>Learning diversity and inclusion.</li></ul><p>All MYP students are encouraged to participate in a wide variety of cultural, sporting and service activities. All students are also able to take part in Community Service as a co-curricular activity. The compulsory Service as Action component of the MYP will be part of the academic programme.</p>'),(10,5,'ar','نظرة عامة','<h3>Middle School Overview</h3><p>The Middle School includes grades 7-10. They learn within the Middle Years Programme framework (MYP)</p><p>In the programme model for the MYP, the first ring around the student at the centre describes the features of the programme that help students develop disciplinary (and interdisciplinary) understanding.</p><p>IB philosophy in the MYP This philosophy, framed in What is an IB education? (2019), is expressed through all aspects of the MYP.</p><p>The programme has been developed with developmentally appropriate attention to:</p><ul><li>Conceptual understanding</li><li>Learning and teaching in context</li><li>Approaches to learning (ATL)</li><li>Service as action (community service)</li><li>Language and identity</li><li>Learning diversity and inclusion.</li></ul><p>All MYP students are encouraged to participate in a wide variety of cultural, sporting and service activities. All students are also able to take part in Community Service as a co-curricular activity. The compulsory Service as Action component of the MYP will be part of the academic programme.</p>'),(11,6,'en','Subject Briefs',NULL),(12,6,'ar','ملخص المواد',NULL),(13,7,'en','The Personal Project',NULL),(14,7,'ar','المشروع الشخصي',NULL),(15,8,'en','Service as Action',NULL),(16,8,'ar','الخدمة كعمل',NULL),(17,9,'en','Overview','<h3>Overview of the International Baccalaureate at Amman Baccalaureate School</h3><p>The International Baccalaureate is the world’s foremost international qualification, opening doors to top universities and careers worldwide. With over 30 years of IB experience, Amman Baccalaureate School provides students with a world-class IB education, expert university guidance, and a strong support network. As a result, our graduates have gained admission to elite institutions in Jordan, the UK, the US, Canada, Australia, and Europe building on their IB qualifications to gain scholarships, internships, and leadership opportunities.</p><p>At Amman Baccalaureate School (ABS), we are proud to offer two world-renowned International Baccalaureate (IB) pathways—both academically rigorous and internationally recognised—designed to enable students develop their abilities, pursue their ambitions and achieve their future aspirations.</p>'),(18,9,'ar','نظرة عامة','<h3>Overview of the International Baccalaureate at Amman Baccalaureate School</h3><p>The International Baccalaureate is the world’s foremost international qualification, opening doors to top universities and careers worldwide. With over 30 years of IB experience, Amman Baccalaureate School provides students with a world-class IB education, expert university guidance, and a strong support network. As a result, our graduates have gained admission to elite institutions in Jordan, the UK, the US, Canada, Australia, and Europe building on their IB qualifications to gain scholarships, internships, and leadership opportunities.</p><p>At Amman Baccalaureate School (ABS), we are proud to offer two world-renowned International Baccalaureate (IB) pathways—both academically rigorous and internationally recognised—designed to enable students develop their abilities, pursue their ambitions and achieve their future aspirations.</p>'),(19,10,'en','Diploma Programme Results',NULL),(20,10,'ar','نتائج برنامج الدبلوم',NULL),(21,11,'en','IB College Curriculum',NULL),(22,11,'ar','منهاج كلية البكالوريا الدولية',NULL);
/*!40000 ALTER TABLE `school_tab_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seo`
--

DROP TABLE IF EXISTS `seo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seo` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=active, 0=inactive',
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` bigint unsigned DEFAULT NULL,
  `robots` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published_at` int unsigned DEFAULT NULL,
  `created_at` int unsigned DEFAULT NULL,
  `updated_at` int unsigned DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL DEFAULT '1',
  `updated_by` bigint unsigned NOT NULL DEFAULT '1',
  `deleted_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seo_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `seo_status_index` (`status`),
  KEY `seo_updated_by_foreign` (`updated_by`),
  KEY `seo_created_by_foreign` (`created_by`),
  CONSTRAINT `seo_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `seo_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seo`
--

LOCK TABLES `seo` WRITE;
/*!40000 ALTER TABLE `seo` DISABLE KEYS */;
/*!40000 ALTER TABLE `seo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seo_lang`
--

DROP TABLE IF EXISTS `seo_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seo_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seo_lang_parent_id_language_unique` (`parent_id`,`language`),
  KEY `seo_lang_language_index` (`language`),
  CONSTRAINT `seo_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `seo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seo_lang`
--

LOCK TABLES `seo_lang` WRITE;
/*!40000 ALTER TABLE `seo_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `seo_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `id` char(40) NOT NULL,
  `expire` int DEFAULT NULL,
  `data` longblob,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` json DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'en.general.title','\"Amman Baccalaureate School\"',2025,1765794847),(2,'en.general.description','\"A quality education & principled upbringing since 1981.\"',2025,1765794848),(3,'en.general.keywords','\"Amman Baccalaureate School\"',2025,1765794848),(4,'en.general.seo_image','null',2025,1765794848),(5,'general.activate_otp','false',2025,2025),(6,'general.date_format','\"F d, Y\"',2025,2025),(7,'general.time_format','\"g:i a\"',2025,2025),(8,'general.time_zone','\"Asia/Amman\"',2025,2025),(9,'general.google_site_verification',NULL,2025,2025),(10,'general.filament_id','\"admin\"',2025,2025),(11,'general.filament_path','\"admin\"',2025,2025),(12,'general.google_recaptcha_site_key',NULL,2025,2025),(13,'general.google_recaptcha_secret',NULL,2025,2025),(14,'general.smtp_host',NULL,2025,2025),(15,'general.smtp_port',NULL,2025,2025),(16,'general.smtp_encryption',NULL,2025,2025),(17,'general.smtp_username',NULL,2025,2025),(18,'general.smtp_password','null',2025,2025),(19,'general.google_analytics_code',NULL,2025,2025),(20,'general.google_tag_code',NULL,2025,2025),(21,'general.meta_pixel_code',NULL,2025,2025),(22,'general.clarity_code',NULL,2025,2025),(23,'general.hotjar_code',NULL,2025,2025),(24,'en.site.logo','null',2025,1765794848),(25,'en.site.footer_logo','null',2025,2025),(26,'en.site.icon','null',2025,1765794848),(27,'en.site.alternative_article','null',2025,2025),(28,'en.site.alternative_avatar','null',2025,2025),(29,'en.site.alternative_header_image','null',2025,1765794848),(30,'site.admin_panel_color',NULL,2025,2025),(31,'pagination.default_page_size','\"10\"',2025,1760970133),(32,'pagination.category_page_size',NULL,2025,2025),(33,'pagination.article_page_size',NULL,2025,2025),(34,'pagination.gallery_page_size',NULL,2025,2025),(35,'pagination.search_page_size',NULL,2025,2025),(36,'site.contact_us_email_list',NULL,2025,2025),(39,'en.site.location','\"Amman Baccalaureate School, Abdoun, Al-Sad Street, Amman 11191, Jordan\"',2025,1757534362),(40,'site.location_url','null',2025,1757534411),(41,'en.site.default_header_image','null',2025,1765794848),(42,'en.site.default_header_image_title','\"Amman Baccalaureate School\"',2025,1765794848),(43,'en.site.default_header_image_title_color',NULL,2025,2025),(44,'ar.general.title','\"مدرسة البكالوريا - عمان\"',2025,1765794848),(45,'ar.general.description','\"تعليم نوعي وتنشئة قائمة على المبادئ منذ عام 1981.\"',2025,1765794848),(46,'ar.general.keywords','\"مدرسة البكالوريا - عمان\"',2025,1765794848),(47,'ar.general.seo_image','null',2025,1765794848),(48,'ar.site.logo','null',2025,1765794848),(49,'ar.site.footer_logo','null',2025,2025),(50,'ar.site.icon','null',2025,1765794848),(51,'ar.site.alternative_article','null',2025,2025),(52,'ar.site.alternative_avatar','null',2025,2025),(53,'ar.site.alternative_header_image','null',2025,1765794849),(54,'ar.site.location','\"مدرسة البكالوريا - عمان، عبدون، شارع السد، عمان 11191، الأردن\"',2025,1757534362),(55,'ar.site.default_header_image','null',2025,1765794849),(56,'ar.site.default_header_image_title','\"مدرسة البكالوريا - عمان\"',2025,1765794849),(57,'ar.site.default_header_image_title_color',NULL,2025,2025),(74,'en.site.alternative_news_blog','null',2025,1765794848),(75,'ar.site.alternative_news_blog','null',2025,1765794849),(81,'en.site.footer_background','null',2025,1765794848),(83,'en.site.alternative_news_header_image','null',2025,1765794848),(85,'ar.site.footer_background','null',2025,1765794848),(87,'ar.site.alternative_news_header_image','null',2025,1765794849),(109,'site.main_phone','\"+962 6 592 2961\"',1757534362,1757534362),(110,'site.second_phone','\"+962 6 541 1191\"',1757534362,1757534362),(111,'site.main_email','\"info@abs.edu.jo\"',1757534362,1757534362),(112,'site.second_email','\"registrar@abs.edu.jo\"',1757534362,1757534362),(113,'en.site.mailbox','null',1757534362,1757534362),(114,'en.site.business_hours_from','\"Sun - Thu: 7:30 AM\"',1757534362,1757534362),(115,'en.site.business_hours_to','\"3:30 PM\"',1757534362,1757534362),(116,'ar.site.mailbox','null',1757534362,1757534362),(117,'ar.site.business_hours_from','\"الأحد - الخميس: 7:30 صباحاً\"',1757534362,1757534362),(118,'ar.site.business_hours_to','\"3:30 مساءً\"',1757534362,1757534362),(119,'site.whatsApp',NULL,1766011362,1766011362),(120,'site.youtube','null',1766011362,1766011362),(121,'site.linkedin',NULL,1766011362,1766011362),(122,'site.instagram',NULL,1766011362,1766011362),(123,'site.facebook','null',1766011362,1766011362),(124,'site.twitter',NULL,1766011362,1766011362);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_engagement`
--

DROP TABLE IF EXISTS `student_engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_engagement` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_id` bigint unsigned DEFAULT NULL,
  `second_image_id` bigint unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_engagement_slug_unique` (`slug`),
  KEY `student_engagement_status_index` (`status`),
  KEY `student_engagement_deleted_at_index` (`deleted_at`),
  KEY `student_engagement_published_at_index` (`published_at`),
  KEY `student_engagement_created_by_foreign` (`created_by`),
  KEY `student_engagement_updated_by_foreign` (`updated_by`),
  CONSTRAINT `student_engagement_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `student_engagement_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_engagement`
--

LOCK TABLES `student_engagement` WRITE;
/*!40000 ALTER TABLE `student_engagement` DISABLE KEYS */;
INSERT INTO `student_engagement` VALUES (1,NULL,NULL,'athletic-and-recreation',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,NULL,NULL,'extra-co-curricular-activities-and-cas',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,NULL,NULL,'adventure-and-leadership',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,NULL,NULL,'arts-and-culture',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,NULL,NULL,'academic-enrichment',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL);
/*!40000 ALTER TABLE `student_engagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_engagement_lang`
--

DROP TABLE IF EXISTS `student_engagement_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_engagement_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `list_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `list_content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `student_engagement_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `student_engagement_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `student_engagement_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `student_engagement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_engagement_lang`
--

LOCK TABLES `student_engagement_lang` WRITE;
/*!40000 ALTER TABLE `student_engagement_lang` DISABLE KEYS */;
INSERT INTO `student_engagement_lang` VALUES (1,1,'en','Athletic and Recreation','Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity.','<p>Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity. Athletics play a key role in shaping character, teaching teamwork, and building resilience. We provide an environment where students are encouraged to push their limits, embrace challenges, and grow as athletes and individuals.</p><p>Our programme offers a wide range of sports, allowing students to discover and pursue their passions. From team sports like football, basketball, and volleyball to individual pursuits such as track and field, tennis, and gymnastics, we cater to diverse interests and abilities. Every student has the opportunity to explore their athletic potential and find the sport that resonates with them.</p><p>Whether students aim to compete at the highest level, stay active, or enjoy the camaraderie of being part of a team, our athletics programme has something for everyone. We are dedicated to nurturing the talents and passions of our students, fostering a love for sports, and preparing them for success in both athletic and academic pursuits.</p>','Athletics and Recreation','<ul><li>Basketball</li><li>Basketball Little League</li><li>Chess</li><li>Cycling Club by Bike Rush</li><li>Flag American Football</li><li>Football</li><li>Football Little League</li><li>Get Fit</li><li>Gymnastics</li><li>Kick Boxing - Jujutsu</li><li>Padel Tennis</li><li>Tennis</li><li>Track & Field</li><li>Volleyball</li><li>Zumba</li></ul>'),(2,1,'ar','الرياضة والترفيه','Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity.','<p>Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity. Athletics play a key role in shaping character, teaching teamwork, and building resilience. We provide an environment where students are encouraged to push their limits, embrace challenges, and grow as athletes and individuals.</p><p>Our programme offers a wide range of sports, allowing students to discover and pursue their passions. From team sports like football, basketball, and volleyball to individual pursuits such as track and field, tennis, and gymnastics, we cater to diverse interests and abilities. Every student has the opportunity to explore their athletic potential and find the sport that resonates with them.</p><p>Whether students aim to compete at the highest level, stay active, or enjoy the camaraderie of being part of a team, our athletics programme has something for everyone. We are dedicated to nurturing the talents and passions of our students, fostering a love for sports, and preparing them for success in both athletic and academic pursuits.</p>','Athletics and Recreation','<ul><li>Basketball</li><li>Basketball Little League</li><li>Chess</li><li>Cycling Club by Bike Rush</li><li>Flag American Football</li><li>Football</li><li>Football Little League</li><li>Get Fit</li><li>Gymnastics</li><li>Kick Boxing - Jujutsu</li><li>Padel Tennis</li><li>Tennis</li><li>Track & Field</li><li>Volleyball</li><li>Zumba</li></ul>'),(3,2,'en','Extra Co-Curricular Activities and CAS',NULL,NULL,NULL,NULL),(4,2,'ar','الأنشطة اللامنهجية و CAS',NULL,NULL,NULL,NULL),(5,3,'en','Adventure and Leadership',NULL,NULL,NULL,NULL),(6,3,'ar','المغامرة والقيادة',NULL,NULL,NULL,NULL),(7,4,'en','Arts and Culture',NULL,NULL,NULL,NULL),(8,4,'ar','الفنون والثقافة',NULL,NULL,NULL,NULL),(9,5,'en','Academic Enrichment',NULL,NULL,NULL,NULL),(10,5,'ar','الإثراء الأكاديمي',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `student_engagement_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribe_webform`
--

DROP TABLE IF EXISTS `subscribe_webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe_webform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribe_webform`
--

LOCK TABLES `subscribe_webform` WRITE;
/*!40000 ALTER TABLE `subscribe_webform` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribe_webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_member`
--

DROP TABLE IF EXISTS `team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_member` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_member_slug_unique` (`slug`),
  KEY `team_member_status_index` (`status`),
  KEY `team_member_deleted_at_index` (`deleted_at`),
  KEY `team_member_published_at_index` (`published_at`),
  KEY `team_member_created_by_foreign` (`created_by`),
  KEY `team_member_updated_by_foreign` (`updated_by`),
  CONSTRAINT `team_member_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `team_member_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_member`
--

LOCK TABLES `team_member` WRITE;
/*!40000 ALTER TABLE `team_member` DISABLE KEYS */;
INSERT INTO `team_member` VALUES (1,20,NULL,NULL,NULL,1,'hrh-princess-sumaya-bint-el-hassan',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,20,NULL,NULL,NULL,0,'mr-shahm-al-wir',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,20,NULL,NULL,NULL,0,'mrs-zeena-majali',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,20,NULL,NULL,NULL,0,'he-mrs-majd-shweikeh',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,20,NULL,NULL,NULL,0,'mrs-mary-tadros',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL),(6,20,NULL,NULL,NULL,0,'mr-maher-kaddoura',1,1792518995,1792518995,NULL,1792518995,1,1,6,0,0,NULL),(7,20,NULL,NULL,NULL,0,'mrs-tamara-al-qadi',1,1792518995,1792518995,NULL,1792518995,1,1,7,0,0,NULL),(8,20,NULL,NULL,NULL,0,'mrs-nour-masri',1,1792518995,1792518995,NULL,1792518995,1,1,8,0,0,NULL),(9,20,NULL,NULL,NULL,0,'mr-zeid-bdeir',1,1792518995,1792518995,NULL,1792518995,1,1,9,0,0,NULL),(10,21,NULL,NULL,NULL,0,'mr-fiyaz-ahmed',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(11,21,NULL,NULL,NULL,0,'ms-cathy-souob',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(12,21,NULL,NULL,NULL,0,'ms-dima-qubain',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL);
/*!40000 ALTER TABLE `team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_member_lang`
--

DROP TABLE IF EXISTS `team_member_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_member_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `team_member_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `team_member_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `team_member_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `team_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_member_lang`
--

LOCK TABLES `team_member_lang` WRITE;
/*!40000 ALTER TABLE `team_member_lang` DISABLE KEYS */;
INSERT INTO `team_member_lang` VALUES (1,1,'en','HRH Princess Sumaya bint El Hassan','Chair of the Board of Trustees','HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change.','<p>HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change. She is a dedicated science enabler in the Arab World where so many challenges urgently require science-based solutions. The Princess has worked for almost two decades to help foster an environment for home- grown solutions to be found for pressing issues facing the region.</p><p>HRH was appointed Chair of the Board of the Amman Baccalaureate School in August 2021 on the retirement of Chair and Co-founder, HRH Princess Sarvath El Hassan. Princess Sumaya had joined the Board in 2005 and has been consistently active in the school\'s daily and strategic management.</p><p>HRH is President of the Royal Scientific Society (RSS), Chair of the Princess Sumaya University for Technology (PSUT), and Vice-Chair of the Jordan Museum. In August 2020, the Director General of UNESCO appointed HRH as UNESCO Goodwill Ambassador for Science for Peace.</p>'),(2,1,'ar','سمو الأميرة سمية بنت الحسن','رئيسة مجلس الأمناء','HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change.','<p>HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change. She is a dedicated science enabler in the Arab World where so many challenges urgently require science-based solutions. The Princess has worked for almost two decades to help foster an environment for home- grown solutions to be found for pressing issues facing the region.</p><p>HRH was appointed Chair of the Board of the Amman Baccalaureate School in August 2021 on the retirement of Chair and Co-founder, HRH Princess Sarvath El Hassan. Princess Sumaya had joined the Board in 2005 and has been consistently active in the school\'s daily and strategic management.</p><p>HRH is President of the Royal Scientific Society (RSS), Chair of the Princess Sumaya University for Technology (PSUT), and Vice-Chair of the Jordan Museum. In August 2020, the Director General of UNESCO appointed HRH as UNESCO Goodwill Ambassador for Science for Peace.</p>'),(3,2,'en','Mr Shahm M. Al-Wir','Board Member','Shahm is a Partner of Foursan Group, a leading Middle Eastern private equity firm. Prior to joining Foursan in 2007, Shahm was a Senior Associate with Debevoise & Plimpton in New York, a global law firm.','<p>Shahm is a Partner of Foursan Group, a leading Middle Eastern private equity firm. Prior to joining Foursan in 2007, Shahm was a Senior Associate with Debevoise & Plimpton in New York, a global law firm.</p>'),(4,2,'ar','السيد شهم الوير','عضو مجلس الأمناء','Shahm is a Partner of Foursan Group, a leading Middle Eastern private equity firm. Prior to joining Foursan in 2007, Shahm was a Senior Associate with Debevoise & Plimpton in New York, a global law firm.','<p>Shahm is a Partner of Foursan Group, a leading Middle Eastern private equity firm. Prior to joining Foursan in 2007, Shahm was a Senior Associate with Debevoise & Plimpton in New York, a global law firm.</p>'),(5,3,'en','Mrs Zeena Majali','Board Member','Zeena Majali co-founded Crystel in 2007. The first outsourcing contact center in Jordan, Crystel employs 2,000 Jordanians, providing superior global customer service. Following Crystel’s success, Zeena cofounded “Xina AI,” a company specializing in A...','<p>Zeena Majali co-founded Crystel in 2007. The first outsourcing contact center in Jordan, Crystel employs 2,000 Jordanians, providing superior global customer service. Following Crystel’s success, Zeena cofounded “Xina AI,” a company specializing in Arabic speech synthesis and natural language understanding.</p>'),(6,3,'ar','السيدة زينة المجالي','عضو مجلس الأمناء','Zeena Majali co-founded Crystel in 2007. The first outsourcing contact center in Jordan, Crystel employs 2,000 Jordanians, providing superior global customer service. Following Crystel’s success, Zeena cofounded “Xina AI,” a company specializing in A...','<p>Zeena Majali co-founded Crystel in 2007. The first outsourcing contact center in Jordan, Crystel employs 2,000 Jordanians, providing superior global customer service. Following Crystel’s success, Zeena cofounded “Xina AI,” a company specializing in Arabic speech synthesis and natural language understanding.</p>'),(7,4,'en','HE Mrs Majd Shweikeh','Board Member','As a goal focused strategist with a talent for persuasive communication and a passion for inspiring others to accomplish visionary business goals, Excellency Shweikeh combines creativity with a data-driven approach to ensuring organizations are struc...','<p>As a goal focused strategist with a talent for persuasive communication and a passion for inspiring others to accomplish visionary business goals, Excellency Shweikeh combines creativity with a data-driven approach to ensuring organizations are structured and equipped with the strategies; structures; technologies and high potential leaders.</p>'),(8,4,'ar','معالي السيدة مجد شويكة','عضو مجلس الأمناء','As a goal focused strategist with a talent for persuasive communication and a passion for inspiring others to accomplish visionary business goals, Excellency Shweikeh combines creativity with a data-driven approach to ensuring organizations are struc...','<p>As a goal focused strategist with a talent for persuasive communication and a passion for inspiring others to accomplish visionary business goals, Excellency Shweikeh combines creativity with a data-driven approach to ensuring organizations are structured and equipped with the strategies; structures; technologies and high potential leaders.</p>'),(9,5,'en','Mrs Mary Tadros','Board Member','Mary is a Senior Manager, Development, Recognition and eAssessment with the IB. She is a lead IB educator with extensive experience as a workshop leader, consultant, team leader, visiting team chair and programme and evaluation leader for school eval...','<p>Mary is a Senior Manager, Development, Recognition and eAssessment with the IB. She is a lead IB educator with extensive experience as a workshop leader, consultant, team leader, visiting team chair and programme and evaluation leader for school evaluation visits. She also chairs New England Association of schools and colleges (NEASC).</p>'),(10,5,'ar','السيدة ماري تادرس','عضو مجلس الأمناء','Mary is a Senior Manager, Development, Recognition and eAssessment with the IB. She is a lead IB educator with extensive experience as a workshop leader, consultant, team leader, visiting team chair and programme and evaluation leader for school eval...','<p>Mary is a Senior Manager, Development, Recognition and eAssessment with the IB. She is a lead IB educator with extensive experience as a workshop leader, consultant, team leader, visiting team chair and programme and evaluation leader for school evaluation visits. She also chairs New England Association of schools and colleges (NEASC).</p>'),(11,6,'en','Mr Maher Kaddoura','Board Member','Maher Kaddoura is a management consultant, serial entrepreneur, angel investor, social change maker, public speaker and adventurer. Upon retirement as Accenture-Middle East managing partner, he established a number of professional services firms whic...','<p>Maher Kaddoura is a management consultant, serial entrepreneur, angel investor, social change maker, public speaker and adventurer. Upon retirement as Accenture-Middle East managing partner, he established a number of professional services firms which became regional leaders in their relative sectors. Maher established Al-Jude NGO in 1999.</p>'),(12,6,'ar','السيد ماهر قدورة','عضو مجلس الأمناء','Maher Kaddoura is a management consultant, serial entrepreneur, angel investor, social change maker, public speaker and adventurer. Upon retirement as Accenture-Middle East managing partner, he established a number of professional services firms whic...','<p>Maher Kaddoura is a management consultant, serial entrepreneur, angel investor, social change maker, public speaker and adventurer. Upon retirement as Accenture-Middle East managing partner, he established a number of professional services firms which became regional leaders in their relative sectors. Maher established Al-Jude NGO in 1999.</p>'),(13,7,'en','Mrs Tamara Al Qadi','Board Member','Tamara Marei Al-Qadi is a wife and mother of four who was born and raised in Amman, Jordan and completed her Civil Engineering degree from The University of Jordan. She is a strong believer in giving back to the community, be it socially or otherwise...','<p>Tamara Marei Al-Qadi is a wife and mother of four who was born and raised in Amman, Jordan and completed her Civil Engineering degree from The University of Jordan. She is a strong believer in giving back to the community, be it socially or otherwise. Tamara takes active roles in non-governmental organizations.</p>'),(14,7,'ar','السيدة تمارا القاضي','عضو مجلس الأمناء','Tamara Marei Al-Qadi is a wife and mother of four who was born and raised in Amman, Jordan and completed her Civil Engineering degree from The University of Jordan. She is a strong believer in giving back to the community, be it socially or otherwise...','<p>Tamara Marei Al-Qadi is a wife and mother of four who was born and raised in Amman, Jordan and completed her Civil Engineering degree from The University of Jordan. She is a strong believer in giving back to the community, be it socially or otherwise. Tamara takes active roles in non-governmental organizations.</p>'),(15,8,'en','Mrs. Nour Masri','Board Member',NULL,NULL),(16,8,'ar','السيدة نور المصري','عضو مجلس الأمناء',NULL,NULL),(17,9,'en','Mr Zeid Bdeir','Board Member','Zeid Bdeir is an ABS graduate, year 1996. He was the recipient of ECIS award, and was the first ABS student to receive the prestigious Gold Award of the then pioneering Crown Prince Award, which is today known as the El Hassan Youth Award, akin to th...','<p>Zeid Bdeir is an ABS graduate, year 1996. He was the recipient of ECIS award, and was the first ABS student to receive the prestigious Gold Award of the then pioneering Crown Prince Award, which is today known as the El Hassan Youth Award, akin to the Duke of Edinburgh International Award. He went on to receive his bachelor\'s degree in Civil Engineering.</p>'),(18,9,'ar','السيد زيد بدير','عضو مجلس الأمناء','Zeid Bdeir is an ABS graduate, year 1996. He was the recipient of ECIS award, and was the first ABS student to receive the prestigious Gold Award of the then pioneering Crown Prince Award, which is today known as the El Hassan Youth Award, akin to th...','<p>Zeid Bdeir is an ABS graduate, year 1996. He was the recipient of ECIS award, and was the first ABS student to receive the prestigious Gold Award of the then pioneering Crown Prince Award, which is today known as the El Hassan Youth Award, akin to the Duke of Edinburgh International Award. He went on to receive his bachelor\'s degree in Civil Engineering.</p>'),(19,10,'en','Mr Fiyaz Ahmed',NULL,NULL,NULL),(20,10,'ar','السيد فياض أحمد',NULL,NULL,NULL),(21,11,'en','Ms Cathy Souob','Vice Principal for Professional Development and Student Progress/Head of IB College',NULL,NULL),(22,11,'ar','السيدة كاثي صعوب','نائبة المدير للتطوير المهني وتقدم الطلبة / رئيسة كلية البكالوريا الدولية',NULL,NULL),(23,12,'en','Ms Dima Qubain','Head of Middle School',NULL,NULL),(24,12,'ar','الآنسة ديما قبعين','رئيسة المرحلة المتوسطة',NULL,NULL);
/*!40000 ALTER TABLE `team_member_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tuition_fee`
--

DROP TABLE IF EXISTS `tuition_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tuition_fee` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `school_id` bigint unsigned NOT NULL,
  `academic_year` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tuition_fee_slug_unique` (`slug`),
  KEY `tuition_fee_status_index` (`status`),
  KEY `tuition_fee_deleted_at_index` (`deleted_at`),
  KEY `tuition_fee_published_at_index` (`published_at`),
  KEY `tuition_fee_created_by_foreign` (`created_by`),
  KEY `tuition_fee_updated_by_foreign` (`updated_by`),
  KEY `tuition_fee_school_id_foreign` (`school_id`),
  CONSTRAINT `tuition_fee_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tuition_fee_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tuition_fee_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tuition_fee`
--

LOCK TABLES `tuition_fee` WRITE;
/*!40000 ALTER TABLE `tuition_fee` DISABLE KEYS */;
INSERT INTO `tuition_fee` VALUES (1,1,'2026-2027',7385.00,'tuition-2026-2027-kg1',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,1,'2026-2027',7385.00,'tuition-2026-2027-kg2',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,1,'2026-2027',7936.00,'tuition-2026-2027-grade-1',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,1,'2026-2027',7936.00,'tuition-2026-2027-grade-2',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,1,'2026-2027',7936.00,'tuition-2026-2027-grade-3',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL),(6,1,'2026-2027',9060.00,'tuition-2026-2027-grade-4',1,1792518995,1792518995,NULL,1792518995,1,1,6,0,0,NULL),(7,1,'2026-2027',9060.00,'tuition-2026-2027-grade-5',1,1792518995,1792518995,NULL,1792518995,1,1,7,0,0,NULL),(8,1,'2026-2027',10223.00,'tuition-2026-2027-grade-6',1,1792518995,1792518995,NULL,1792518995,1,1,8,0,0,NULL),(9,2,'2026-2027',10715.00,'tuition-2026-2027-grade-7',1,1792518995,1792518995,NULL,1792518995,1,1,9,0,0,NULL),(10,2,'2026-2027',11522.00,'tuition-2026-2027-grade-8',1,1792518995,1792518995,NULL,1792518995,1,1,10,0,0,NULL),(11,2,'2026-2027',12333.00,'tuition-2026-2027-grade-9',1,1792518995,1792518995,NULL,1792518995,1,1,11,0,0,NULL),(12,2,'2026-2027',13473.00,'tuition-2026-2027-grade-10',1,1792518995,1792518995,NULL,1792518995,1,1,12,0,0,NULL),(13,3,'2026-2027',16425.00,'tuition-2026-2027-grade-11',1,1792518995,1792518995,NULL,1792518995,1,1,13,0,0,NULL),(14,3,'2026-2027',17284.00,'tuition-2026-2027-grade-12',1,1792518995,1792518995,NULL,1792518995,1,1,14,0,0,NULL);
/*!40000 ALTER TABLE `tuition_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tuition_fee_lang`
--

DROP TABLE IF EXISTS `tuition_fee_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tuition_fee_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tuition_fee_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `tuition_fee_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `tuition_fee_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `tuition_fee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tuition_fee_lang`
--

LOCK TABLES `tuition_fee_lang` WRITE;
/*!40000 ALTER TABLE `tuition_fee_lang` DISABLE KEYS */;
INSERT INTO `tuition_fee_lang` VALUES (1,1,'en','KG1'),(2,1,'ar','الروضة الأولى'),(3,2,'en','KG2'),(4,2,'ar','الروضة الثانية'),(5,3,'en','Grade 1'),(6,3,'ar','الصف الأول'),(7,4,'en','Grade 2'),(8,4,'ar','الصف الثاني'),(9,5,'en','Grade 3'),(10,5,'ar','الصف الثالث'),(11,6,'en','Grade 4'),(12,6,'ar','الصف الرابع'),(13,7,'en','Grade 5'),(14,7,'ar','الصف الخامس'),(15,8,'en','Grade 6'),(16,8,'ar','الصف السادس'),(17,9,'en','Grade 7'),(18,9,'ar','الصف السابع'),(19,10,'en','Grade 8'),(20,10,'ar','الصف الثامن'),(21,11,'en','Grade 9'),(22,11,'ar','الصف التاسع'),(23,12,'en','Grade 10'),(24,12,'ar','الصف العاشر'),(25,13,'en','Grade 11'),(26,13,'ar','الصف الحادي عشر'),(27,14,'en','Grade 12'),(28,14,'ar','الصف الثاني عشر');
/*!40000 ALTER TABLE `tuition_fee_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_id` bigint unsigned DEFAULT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1-published',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `published_at` int DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned NOT NULL,
  `weight_order` tinyint NOT NULL DEFAULT '10',
  `revision` bigint unsigned NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `reject_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `university_slug_unique` (`slug`),
  KEY `university_status_index` (`status`),
  KEY `university_deleted_at_index` (`deleted_at`),
  KEY `university_published_at_index` (`published_at`),
  KEY `university_created_by_foreign` (`created_by`),
  KEY `university_updated_by_foreign` (`updated_by`),
  CONSTRAINT `university_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `university_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (1,NULL,'https://www.columbia.edu',1,'columbia-university',1,1792518995,1792518995,NULL,1792518995,1,1,1,0,0,NULL),(2,NULL,'https://www.ucl.ac.uk',1,'ucl',1,1792518995,1792518995,NULL,1792518995,1,1,2,0,0,NULL),(3,NULL,'https://www.harvard.edu',1,'harvard-university',1,1792518995,1792518995,NULL,1792518995,1,1,3,0,0,NULL),(4,NULL,'https://www.yale.edu',1,'yale-university',1,1792518995,1792518995,NULL,1792518995,1,1,4,0,0,NULL),(5,NULL,'https://www.cam.ac.uk',1,'university-of-cambridge',1,1792518995,1792518995,NULL,1792518995,1,1,5,0,0,NULL),(6,NULL,'https://www.kcl.ac.uk',1,'kings-college-london',1,1792518995,1792518995,NULL,1792518995,1,1,6,0,0,NULL),(7,NULL,'https://www.stanford.edu',1,'stanford-university',1,1792518995,1792518995,NULL,1792518995,1,1,7,0,0,NULL);
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university_lang`
--

DROP TABLE IF EXISTS `university_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university_lang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brief` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `university_lang_language_parent_id_index` (`language`,`parent_id`),
  KEY `university_lang_parent_id_index` (`parent_id`),
  CONSTRAINT `university_lang_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_lang`
--

LOCK TABLES `university_lang` WRITE;
/*!40000 ALTER TABLE `university_lang` DISABLE KEYS */;
INSERT INTO `university_lang` VALUES (1,1,'en','Columbia University',NULL),(2,1,'ar','جامعة كولومبيا',NULL),(3,2,'en','University College London (UCL)',NULL),(4,2,'ar','كلية لندن الجامعية',NULL),(5,3,'en','Harvard University',NULL),(6,3,'ar','جامعة هارفارد',NULL),(7,4,'en','Yale University',NULL),(8,4,'ar','جامعة ييل',NULL),(9,5,'en','University of Cambridge',NULL),(10,5,'ar','جامعة كامبريدج',NULL),(11,6,'en','King\'s College London',NULL),(12,6,'ar','كينغز كوليدج لندن',NULL),(13,7,'en','Stanford University',NULL),(14,7,'ar','جامعة ستانفورد',NULL);
/*!40000 ALTER TABLE `university_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `auth_key` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `without_otp` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` int DEFAULT NULL,
  `password_reset_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '10',
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `superadmin` int DEFAULT '0',
  `registration_ip` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `bind_to_ip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_confirmed` int DEFAULT '0',
  `confirmation_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `avatar` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `first_name` varchar(124) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(124) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `birth_day` int DEFAULT NULL,
  `birth_month` int DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `phone` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `skype` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `device_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `device_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `device_os` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `code` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tmp_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `user_id` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `password_reset_token` (`password_reset_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Syatem Admin','admin','','$2y$12$fLM2mggBRd4eASxlcWTq.uV0VrsdZWcYVpu6Jb92wAXuIidyjdLvy',NULL,0,NULL,NULL,'admin@dot.jo',10,0,1753681205,1,NULL,'',0,NULL,NULL,'Syatem','Admin',NULL,1,NULL,0,'797986466','','',NULL,NULL,NULL,NULL,'2123','1213',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_setting` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_setting_user_key` (`user_id`,`key`) USING BTREE,
  CONSTRAINT `fk_user_id_user_setting_table` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_visit_log`
--

DROP TABLE IF EXISTS `user_visit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_visit_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `language` varchar(5) NOT NULL,
  `user_agent` text NOT NULL,
  `browser` varchar(30) NOT NULL,
  `os` varchar(20) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `visit_time` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `visit_log_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_user_id_user_visit_log_table` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_visit_log`
--

LOCK TABLES `user_visit_log` WRITE;
/*!40000 ALTER TABLE `user_visit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_visit_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed

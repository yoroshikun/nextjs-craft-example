-- MySQL dump 10.17  Distrib 10.3.20-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: craft_nextjs--test
-- ------------------------------------------------------
-- Server version	10.3.20-MariaDB-1:10.3.20+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_subtitle` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-01-08 03:03:41','2020-01-08 03:03:41','218c5eea-46fb-4149-9421-68a27914c614',NULL),(3,3,1,'Home','2020-01-08 03:13:39','2020-01-08 03:22:31','8986a919-bb5f-4c81-8ac5-1a6e1c27b115','This is a custom subtitle! Congrats if you see this it means you can query the content. Try Live previewing this!'),(4,4,1,'This is a test title!','2020-01-08 03:13:39','2020-01-08 03:13:39','166c91a3-75a4-4dd7-a6f9-1391bb8cd302',NULL),(5,5,1,'Home','2020-01-08 03:13:51','2020-01-08 03:13:51','9ac41932-d696-4602-acda-a8d861baf218',NULL),(6,6,1,'Home','2020-01-08 03:15:04','2020-01-08 03:15:04','c71e5f10-1fbc-43ce-bc44-15de657eedca','This is a custom subtitle! Congrats if you see this it means you can query the content. Try Live previewing this!'),(7,7,1,'Home','2020-01-08 03:22:31','2020-01-08 03:22:31','dd3645b6-8941-429f-98a6-d3517627d085','This is a custom subtitle! Congrats if you see this it means you can query the content. Try Live previewing this!'),(8,8,1,'Home','2020-01-08 03:28:37','2020-01-08 03:40:53','8d717f73-8d8a-422d-87d7-e2cb38b87b4a','This is a custom subtitle! Congrats if you see this it means you can query the content. Try Live previewing this live preview :E works!');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
INSERT INTO `drafts` VALUES (2,3,1,'Draft 1','');
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-01-08 03:03:41','2020-01-08 03:03:41',NULL,'e214910a-6f34-4d3b-8e44-252a25fadfa4'),(3,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-01-08 03:13:39','2020-01-08 03:22:31',NULL,'99badf34-771b-4a15-a0b5-4ce825d381ea'),(4,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2020-01-08 03:13:39','2020-01-08 03:13:39',NULL,'74a334f3-1927-4e38-8bfe-81e8bf2c94a3'),(5,NULL,2,NULL,'craft\\elements\\Entry',1,0,'2020-01-08 03:13:51','2020-01-08 03:13:51',NULL,'905edb78-3ad0-4bb0-955b-256b7fd371a7'),(6,NULL,3,1,'craft\\elements\\Entry',1,0,'2020-01-08 03:15:04','2020-01-08 03:15:04',NULL,'188f8a2c-a2cb-4a23-a427-e6a405c3085f'),(7,NULL,4,1,'craft\\elements\\Entry',1,0,'2020-01-08 03:22:31','2020-01-08 03:22:31',NULL,'8ca1d660-77f2-4d45-b4e0-016e140194ea'),(8,2,NULL,1,'craft\\elements\\Entry',1,0,'2020-01-08 03:28:37','2020-01-08 03:40:53',NULL,'8be39fda-32bf-48c5-9f41-f43da2f47f2b');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-01-08 03:03:41','2020-01-08 03:03:41','92e91652-2092-4bf2-9ae6-a6e5ee1d9c35'),(3,3,1,'home','pages/home',1,'2020-01-08 03:13:39','2020-01-08 03:22:31','57e3fcc7-c9f5-4942-9abf-f812776c5d53'),(4,4,1,'this-is-a-test-title','pages/this-is-a-test-title',1,'2020-01-08 03:13:39','2020-01-08 03:13:39','561800af-d0a6-46cb-86d3-3384bbe6a729'),(5,5,1,'this-is-a-test-title','pages/this-is-a-test-title',1,'2020-01-08 03:13:51','2020-01-08 03:13:51','a0e9d157-ca4d-46fb-83d2-4db5032a97e2'),(6,6,1,'this-is-a-test-title','pages/this-is-a-test-title',1,'2020-01-08 03:15:04','2020-01-08 03:15:04','8ccff84e-c6e4-4f66-ae29-f8bb5953e663'),(7,7,1,'home','pages/home',1,'2020-01-08 03:22:31','2020-01-08 03:22:31','61d033d0-687b-48cf-93f7-4a8ef21085c1'),(8,8,1,'home','pages/home',1,'2020-01-08 03:28:37','2020-01-08 03:28:37','a88aea52-f7f3-450f-861c-c478e654aea1');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (3,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:13:39','2020-01-08 03:13:39','a7314012-9a42-44cb-8963-0a2ce0be62da'),(4,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:13:39','2020-01-08 03:13:39','0ffcf65c-3cc3-4455-9320-7b34c51f3633'),(5,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:13:51','2020-01-08 03:13:51','dda26e75-ba28-43c6-920d-bb3cd809a85a'),(6,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:15:04','2020-01-08 03:15:04','3e738512-c68c-42b3-972a-13a60cdef814'),(7,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:22:31','2020-01-08 03:22:31','7e75e985-1e40-4c4e-a73a-dfae60f8fd18'),(8,1,NULL,1,1,'2020-01-08 03:13:00',NULL,NULL,'2020-01-08 03:28:37','2020-01-08 03:28:37','a20d5ff3-6dd4-483a-b508-eb90cdc0fb38');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,1,'Pages','pages',1,'Title','',1,'2020-01-08 03:08:11','2020-01-08 03:14:20',NULL,'bcbec748-c849-4755-92d9-3ae0275c04c1');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-01-08 03:03:41','2020-01-08 03:03:41','665eb6c7-1dc5-446a-996f-cbe9f204dfe7');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (1,1,1,1,0,1,'2020-01-08 03:14:20','2020-01-08 03:14:20','5c275c3e-56bd-421a-bc12-fb7f3835c031');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2020-01-08 03:14:20','2020-01-08 03:14:20',NULL,'57b808fb-72e7-4466-9afd-2799c2d1597c');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (1,1,'Common',1,'2020-01-08 03:14:20','2020-01-08 03:14:20','dbd95738-224e-44a4-925a-4a1cd1c42abf');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'Subtitle','subtitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2020-01-08 03:09:49','2020-01-08 03:09:49','55b263a9-033d-4db2-97b2-747f7c3b811b');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','__PUBLIC__',1,NULL,NULL,'[]','2020-01-08 03:18:16','2020-01-08 03:18:16','91eb3b94-9927-4c0d-94e7-64992ead3c9c'),(2,'NextJs Schema','wvyqH1eaFbCyIw--_0-TsWAbcqoaRGaD',1,NULL,'2020-01-08 03:40:53','[\"sections.6b00ad17-1c99-43c2-8eca-7bb4b25b469f:read\",\"entrytypes.bcbec748-c849-4755-92d9-3ae0275c04c1:read\",\"usergroups.everyone:read\"]','2020-01-08 03:25:48','2020-01-08 03:40:53','ca8278d5-3202-40a7-8173-92af0852a0b5');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `config` mediumtext DEFAULT NULL,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.3.19','3.3.3',0,'{\"fieldGroups\":{\"665eb6c7-1dc5-446a-996f-cbe9f204dfe7\":{\"name\":\"Common\"}},\"siteGroups\":{\"6772a44a-b45b-4434-b9c5-c7a2587f01ce\":{\"name\":\"NextJs + CraftQL Test\"}},\"sites\":{\"158eea7d-ccf1-4161-b3f8-34a2450fbb4e\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"en-US\",\"name\":\"NextJs + CraftQL Test\",\"primary\":true,\"siteGroup\":\"6772a44a-b45b-4434-b9c5-c7a2587f01ce\",\"sortOrder\":1}},\"email\":{\"fromEmail\":\"test@admin.com\",\"fromName\":\"NextJs + CraftQL Test\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"system\":{\"edition\":\"pro\",\"name\":\"NextJs + CraftQL Test\",\"live\":true,\"schemaVersion\":\"3.3.3\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":null,\"photoSubpath\":\"\"},\"dateModified\":1578454100,\"sections\":{\"6b00ad17-1c99-43c2-8eca-7bb4b25b469f\":{\"name\":\"Pages\",\"handle\":\"pages\",\"type\":\"channel\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"158eea7d-ccf1-4161-b3f8-34a2450fbb4e\":{\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"pages/{slug}\",\"template\":\"\"}},\"previewTargets\":[{\"label\":\"NextJs Localhost\",\"urlFormat\":\"http://localhost:3000/{slug}\"}],\"entryTypes\":{\"bcbec748-c849-4755-92d9-3ae0275c04c1\":{\"name\":\"Pages\",\"handle\":\"pages\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"57b808fb-72e7-4466-9afd-2799c2d1597c\":{\"tabs\":[{\"name\":\"Common\",\"sortOrder\":1,\"fields\":{\"55b263a9-033d-4db2-97b2-747f7c3b811b\":{\"required\":false,\"sortOrder\":1}}}]}}}}}},\"fields\":{\"55b263a9-033d-4db2-97b2-747f7c3b811b\":{\"name\":\"Subtitle\",\"handle\":\"subtitle\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"665eb6c7-1dc5-446a-996f-cbe9f204dfe7\"}}}','[]','1ad0RIFGj9B8','2020-01-08 03:03:41','2020-01-08 03:03:41','ecc8176d-adb5-4d1e-8f74-1baf4db4c8d9');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6a1a50c1-2ed7-40ce-bed5-890337ef2d96'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','898464b7-9fa4-4511-b832-eb137cf8c4d7'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','708265f7-cd7b-4f07-bcf7-a45f1b4bbd56'),(4,NULL,'app','m150403_184533_field_version','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','7f79b7ba-050a-4844-b5d4-da53b22216b9'),(5,NULL,'app','m150403_184729_type_columns','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b780b26d-4b88-43e4-9a79-3861bcedf8f0'),(6,NULL,'app','m150403_185142_volumes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','599c8b9a-8aad-4e09-a128-8396f6054d3e'),(7,NULL,'app','m150428_231346_userpreferences','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','38581b96-8781-4dd7-98a1-df45256e534f'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','1719be3d-9585-465d-8bba-20b83085b951'),(9,NULL,'app','m150617_213829_update_email_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','35076f56-3cee-447f-b904-cf9720e94a0e'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','49b370ae-061d-4ccb-aad4-b8136e330f5f'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','dfd9abef-c98a-491b-9173-b7f55159533e'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','50d2b8cc-33e3-4b1f-a4b4-ba40399c85a7'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d32be338-a127-449d-8bb1-653ab55f044c'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f721c41c-2970-4f8f-b039-82b1b85a3534'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','fffea7e1-92b3-4e1c-bec6-3016f56c1fc7'),(16,NULL,'app','m151209_000000_move_logo','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d7476759-4551-4fb4-9906-ccf97492ff45'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d986bb05-3af3-4a3b-9cc5-b55717611980'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6b03207a-370c-4bef-aa3f-27f2dec6f369'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','9dc956d4-1687-472b-a1ca-3692a382fba8'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','349a211c-eedf-428f-97c4-dfe530c1978f'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','1ae54a05-2f70-456c-8fb8-511f14e6b5d5'),(22,NULL,'app','m160727_194637_column_cleanup','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','bf5d717c-c610-4eb3-8abc-eedf7bb4a861'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','803e55a8-e764-4aa3-beb2-ca5ded792335'),(24,NULL,'app','m160807_144858_sites','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b5edc222-1eb5-4345-b6de-48843fe9278b'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','11c9442d-aa7a-45d2-b30d-b997ebada322'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','53807c71-4ed5-448f-a877-6d86fa39e3d3'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','cfd6c181-70dc-4e4b-885b-fc8ecca0bf58'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','972161c5-b74f-4f71-9c4f-0b93d061ae57'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d530ac85-71f4-4524-8363-bd8ef37a436c'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','881f97d9-3742-46f8-b7ec-5be3dea1318c'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','43d4d68e-d36f-4b8e-a19a-66e0de7b6d85'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','13909ca2-952f-417b-9b80-c30c7f75ba20'),(33,NULL,'app','m161007_130653_update_email_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','9fca5f3e-377d-4e49-9615-d05050687712'),(34,NULL,'app','m161013_175052_newParentId','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f7ba9755-dbe3-4644-a42f-e93a834a60a1'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8675482c-9880-4e4d-8ba7-fcc5b5f70c51'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','0c1406e8-2ae6-4f02-86ea-704d48448751'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','675403ba-a00b-47ba-b8cd-8e206cbb61dc'),(38,NULL,'app','m161029_124145_email_message_languages','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','81c2d9f1-69b5-49c4-affc-b9f2f713af31'),(39,NULL,'app','m161108_000000_new_version_format','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6e5c2b4e-322e-49fd-80fa-39a096d5941b'),(40,NULL,'app','m161109_000000_index_shuffle','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','64117891-3f89-4819-aacb-c7199478b9c5'),(41,NULL,'app','m161122_185500_no_craft_app','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5467e2a2-1ca3-4ec8-b892-0b0448706c78'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6d16e499-59fc-4f21-8f5e-abba2791d143'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a1700f1b-ee3b-4a46-9a72-cf4564fc38f4'),(44,NULL,'app','m170114_161144_udates_permission','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','ac39bb06-20c5-48a6-b291-952338846a97'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8cfeda0c-9cfe-44a7-ad13-2d58c9319b30'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f06b4baa-2dc8-4a3e-a2bf-c235e3323161'),(47,NULL,'app','m170206_142126_system_name','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c41dee0c-8491-4b50-9f1b-307c8fc0741f'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','adc4f5e3-0e3e-41a7-8907-7f9086adc83b'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','2f3d688a-d9bb-4606-95ad-751b34804f2c'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','080e5f6c-cc1a-48c2-afcf-0d1eb658bfd2'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','35c7ee54-2a5b-4ca4-8560-b18b85246854'),(52,NULL,'app','m170228_171113_system_messages','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','108b1a5a-69ab-421b-8c49-243dadc0da05'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','eb6457b0-6ffe-476a-a3da-725e38fd5e40'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','54d52273-6eba-453d-aa01-533030369fbc'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','71e066d8-b296-4ab0-a6d5-60bfef71036b'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','544b012e-5199-4b40-b1f2-e62535d162c3'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f4a65ac6-d481-4c56-bdc3-fe6dc2ac1f0d'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','712c0b98-103a-4bbd-a1ac-94544f260cb6'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','05487786-1979-4f49-9b70-2aa06b3a3754'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','64e38280-e0c9-493e-9cda-96dd5467f2e5'),(61,NULL,'app','m170704_134916_sites_tables','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','97ae6ed3-0ef2-4eb5-b09f-2ee6e52625f8'),(62,NULL,'app','m170706_183216_rename_sequences','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','68b1a6ee-5938-46b7-a12d-1d30d077746c'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','10cca91c-9f58-4696-ae70-3ee17514beff'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','188ab54c-f3b8-4306-9a35-9a6d9d3889ca'),(65,NULL,'app','m170810_201318_create_queue_table','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6c93c294-b1e7-490c-bdca-680d3e41b6b0'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6f77dfea-5bc5-4b7f-a736-72f42d8b69ea'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','7e78c0a2-bdee-4781-8ba7-e2cd02cddc20'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','457633ef-d244-4071-bd3d-1e33df170bc4'),(69,NULL,'app','m171011_214115_site_groups','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8ed98a77-604b-455d-8116-a0b045163027'),(70,NULL,'app','m171012_151440_primary_site','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','288dfc8f-a35e-4460-8900-f0ecbc61750f'),(71,NULL,'app','m171013_142500_transform_interlace','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','823c646e-d9df-465a-8e7e-a818f3ef421a'),(72,NULL,'app','m171016_092553_drop_position_select','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c3498162-22de-467b-a212-7423a7976b75'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b9f85e9c-7bd8-436e-baac-6c65c0ea9486'),(74,NULL,'app','m171107_000000_assign_group_permissions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a03a1763-054f-466d-bbac-e84fdd691733'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b578a6db-a083-4131-856b-5f510f971cd3'),(76,NULL,'app','m171126_105927_disabled_plugins','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','143b443a-0569-4791-a45e-1c1ca9df19c0'),(77,NULL,'app','m171130_214407_craftidtokens_table','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','cfb55b4b-6443-4a25-9c2d-e1de018440be'),(78,NULL,'app','m171202_004225_update_email_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c6129bf0-afa7-4a7c-a1e1-593cb519a206'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','97717474-291c-4cd4-8cdb-8b92aa19dfc3'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','34497b5f-db65-42d6-a0c6-422f76be0414'),(81,NULL,'app','m171218_143135_longtext_query_column','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','84a7ba60-b5a6-463e-929f-44e6873386d8'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8bd4df10-6ed7-43b2-81dd-bb7c6ec012b3'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b33eb3b7-6a20-4b36-a661-c162a6d92e2c'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5c96be5e-eb7f-4e73-8a40-045c1ed9a86a'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5a603713-5953-4965-b91e-d0a7eaf77482'),(86,NULL,'app','m180128_235202_set_tag_slugs','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','55ae4f2d-5025-45e1-8b6e-36995c7812d0'),(87,NULL,'app','m180202_185551_fix_focal_points','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','0d4c29c6-5116-4b1f-ad21-2473ea8e8ded'),(88,NULL,'app','m180217_172123_tiny_ints','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','7f1b0bce-a09f-4af0-9095-08d2d9b27605'),(89,NULL,'app','m180321_233505_small_ints','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','fe63d7d0-480f-43ba-b411-3a1df4afb80c'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','9bf825fe-072f-4990-8c82-3a6cb33ff25a'),(91,NULL,'app','m180404_182320_edition_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','60e06466-c679-43fa-81ec-5ac704b1be7b'),(92,NULL,'app','m180411_102218_fix_db_routes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d79790dd-7ee3-44f0-9105-42c7ca2f1253'),(93,NULL,'app','m180416_205628_resourcepaths_table','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','524900e8-f863-49d8-a271-2ef67f6b6c7d'),(94,NULL,'app','m180418_205713_widget_cleanup','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','7d0b2ea3-5048-4343-b069-34088a729819'),(95,NULL,'app','m180425_203349_searchable_fields','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6bfcd96e-1fdc-457c-9782-cce762e7fffe'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8212cdd7-8696-419c-bed0-49ff07419617'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','59a32fca-1e6f-40d9-8c9e-9eca87375647'),(98,NULL,'app','m180518_173000_permissions_to_uid','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f1a97a5f-f97d-44c1-86d7-d2229d3f8000'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','696f3193-7b7a-44ea-aae2-3b927cc84d52'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','56d2d779-5c00-4add-80fe-ae9249a73fd3'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b3d21ae5-8172-410a-a867-c4af65512d3f'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','cf2f4f42-b476-440a-8198-16e6e7b1a116'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','6bc685c7-8938-4337-975d-3c31e466b3e9'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f0230543-8c24-4c77-9da6-07e69a6ed0c9'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8899b02b-1a90-4a0d-8695-78505ed0fbe7'),(106,NULL,'app','m180904_112109_permission_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','08ef10fb-5a22-494b-b928-ef4848f709be'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','ea9e6195-1f50-4dc3-83e3-4baadb439ce4'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','19cc7dc3-4a6b-4ccc-9590-f79b7ae4dd76'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','4b7f3ad2-9a63-4163-94ca-2e6dff597dcc'),(110,NULL,'app','m181017_225222_system_config_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a48be6e1-bdf7-4430-9afe-56826bf0f486'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','3ad9b6fe-79f2-411e-8b3f-0b522824b265'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5fc8f76b-9251-46d0-adec-6ae5258d1c2f'),(113,NULL,'app','m181112_203955_sequences_table','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a16c04e9-fe2d-4a63-9d08-0f50fb5f23af'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','24a51adc-e114-4481-87b6-37e49583ef3c'),(115,NULL,'app','m181128_193942_fix_project_config','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','018bbd30-a9e0-4471-97d2-82baeef5855b'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','72d3e61d-0a61-494b-ae67-fd34ce14b92a'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','76e6d292-2fa5-4717-b063-8d532dc3bc12'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','0d4a2946-450c-4301-aeaf-40841aa3bd6f'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','282abe6b-7ef1-4c93-a223-cf48cc026c37'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5568c86e-e7e0-4136-a93a-07487033c227'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8634a681-43bc-4d4f-8af5-ca1ce0d3020c'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','0c0332dd-fdbf-4e00-85f9-f1b42f028bb6'),(123,NULL,'app','m190109_172845_fix_colspan','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d200551e-afaf-4770-b613-abccc5868b85'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','7e3713ee-2426-4a1a-bd7c-4f913a31dcb3'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c54d9d14-f5a0-44b8-b158-376bce27850c'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','18028fa6-0afb-4234-8e23-f433154af058'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','5e434503-65c4-44c1-959c-ebb3df9624eb'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','35a4b7ea-43f9-49fa-ab25-82900efa9764'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','84d8a0ca-d9aa-4478-a030-6b7021ad89d4'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','65c7be08-a179-47cb-bbe4-c303701c5aa3'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c629e187-63ed-4eb3-972d-a7b853fa67a8'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b3fced38-2b07-4aa2-841f-6a47a36498e2'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','657789a4-8d38-46d1-8fa0-1fb3b436f214'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f52d7dd1-7e41-4b92-b672-a570379525fb'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d76323ef-7eeb-4d01-b2ba-3e6ead3d2557'),(136,NULL,'app','m190312_152740_element_revisions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','769de6fc-4e23-4fe9-9216-0035a35996b5'),(137,NULL,'app','m190327_235137_propagation_method','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a6c4771a-0652-44ce-8acf-4fa4be6f87f4'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','a5ecd9e8-2396-4703-bc97-6a6c1037c044'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b34360b6-b306-425b-b85b-e2842078f36d'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f0be734e-7778-417e-8f9b-38dfd6055b18'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','b7946cac-c3f7-4a17-8234-6be6872e0b65'),(142,NULL,'app','m190504_150349_preview_targets','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','d6f56b39-2004-4b44-b513-4379f4c1271b'),(143,NULL,'app','m190516_184711_job_progress_label','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','c3bfea9f-9ee1-439a-ae7b-b01e5215ea0b'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','46769b05-5ecf-40fd-a6aa-1fcebfd445b1'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f9075752-7375-480a-b4fc-f7b292430e88'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','613a2db7-596b-4484-9c1c-55e7fa411313'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','38cb5498-3f82-4240-9a3a-075340c846a3'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8f36289e-2d15-4cfa-8333-4b70c75701a4'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','f298b02a-6e47-434f-88c1-8023bc0328ed'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','cfca8637-d9dc-4e5a-9759-0c737dc02a7f'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','2b56f848-02b2-4bed-860f-f5d5d772305a'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','bc418c5a-2114-4f76-9818-a8825bc903c2'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','8a265eb2-de0b-433b-9801-a1e017b31f95'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','edb4fab6-9f69-4d44-ba0e-c7656edca419'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:42','0653fb17-ab77-4b83-ba98-4feb82e01835');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('168d2483','@app/web/assets/cp/dist'),('21de2d71','@app/web/assets/generalsettings/dist'),('2378050e','@app/web/assets/installer/dist'),('2764eed7','@app/web/assets/graphiql/dist'),('27f7c2f5','@lib/axios'),('2d2082bc','@lib/jquery-ui'),('357a4160','@app/web/assets/updateswidget/dist'),('3be8eda1','@app/web/assets/craftsupport/dist'),('4023d6fd','@app/web/assets/routes/dist'),('5d964591','@lib/element-resize-detector'),('5e5c3b52','@app/web/assets/matrixsettings/dist'),('63891919','@lib/velocity'),('6a124e3b','@app/web/assets/userpermissions/dist'),('6f966f3d','@app/web/assets/feed/dist'),('7206ee64','@bower/jquery/dist'),('74f66612','@app/web/assets/utilities/dist'),('7ddc084d','@app/web/assets/tablesettings/dist'),('7faeb6f1','@lib/jquery.payment'),('9d74ece4','@app/web/assets/editsection/dist'),('9f41e398','@lib/timepicker'),('a0bebbed','@lib/xregexp'),('a1c6180','@lib/vue'),('aad2ff67','@lib/selectize'),('bc0030e','@app/web/assets/recententries/dist'),('c3b4e534','@lib/garnishjs'),('d2e74481','@app/web/assets/fields/dist'),('d5806acf','@app/web/assets/dashboard/dist'),('d6f2310a','@lib/fabric'),('db569a8','@app/web/assets/pluginstore/dist'),('e644d31d','@lib/fileupload'),('f009f2b2','@lib/d3'),('f526a8cf','@app/web/assets/editentry/dist'),('f908ee21','@lib/jquery-touch-events'),('feacd2e3','@lib/picturefill');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,3,1,1,NULL),(2,3,1,2,NULL),(3,3,1,3,NULL),(4,3,1,4,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' test admin com '),(1,'slug',0,1,''),(3,'slug',0,1,' home '),(3,'title',0,1,' home '),(3,'field',1,1,' this is a custom subtitle congrats if you see this it means you can query the content try live previewing this ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,NULL,'Pages','pages','channel',1,'all','[{\"label\":\"NextJs Localhost\",\"urlFormat\":\"http://localhost:3000/{slug}\"}]','2020-01-08 03:08:11','2020-01-08 03:28:20',NULL,'6b00ad17-1c99-43c2-8eca-7bb4b25b469f');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'pages/{slug}','',1,'2020-01-08 03:08:11','2020-01-08 03:28:20','0019142b-8eb8-481d-abd8-10dbd38d9156');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,1,'yNhRwRcsOSDe3pTz4nmcxhhwzn0PfgdZAUQ0oRIk9FNNp4DhOT0jzNk5KC2wM5PEgNC5a7sqa8S7fU-6HYfd3NKy-a_dmBNQk291','2020-01-08 03:03:42','2020-01-08 03:40:53','235e0570-47d9-4dc5-adc7-c9a22114213d');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'NextJs + CraftQL Test','2020-01-08 03:03:41','2020-01-08 03:03:41',NULL,'6772a44a-b45b-4434-b9c5-c7a2587f01ce');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,1,'NextJs + CraftQL Test','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-01-08 03:03:41','2020-01-08 03:03:41',NULL,'158eea7d-ccf1-4161-b3f8-34a2450fbb4e');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'T3RgfIlHiH6MV3RdhRCIeqDYzNZ5BXv8','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":3,\"siteId\":1,\"draftId\":2,\"revisionId\":null}]',NULL,NULL,'2020-01-09 03:28:37','2020-01-08 03:28:37','2020-01-08 03:28:37','b104121e-88b8-4748-b949-271b64ed1068');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'test@admin.com','$2y$13$gVORt18m//jIw30N6j4D3uMV.qWMSjRufHg3mL7ndNIBzS4GeD6yS',1,0,0,0,'2020-01-08 03:03:42',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-01-08 03:03:42','2020-01-08 03:03:42','2020-01-08 03:03:44','62c614b0-08ec-4f29-a977-bb9f4998ec5b');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-01-08 03:03:44','2020-01-08 03:03:44','99e849b8-f332-4af5-8b59-cc51a9ca0125'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-01-08 03:03:44','2020-01-08 03:03:44','b14d74fe-1b85-4126-ac74-cbe9dceb2f5b'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-01-08 03:03:44','2020-01-08 03:03:44','46be5572-8b18-42bf-868a-70296992c251'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-01-08 03:03:44','2020-01-08 03:03:44','0b3d5849-9ea9-418d-aeed-9688caf7ce99');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-08  3:47:27

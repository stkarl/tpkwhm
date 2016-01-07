-- MySQL dump 10.13  Distrib 5.6.12, for Win64 (x86_64)
--
-- Host: 192.168.2.10    Database: FCVAuditData
-- ------------------------------------------------------
-- Server version	5.5.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `AccountID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`AccountID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES (1,'BigC'),(2,'Coop Mart'),(3,'Metro');
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActionPlan`
--

DROP TABLE IF EXISTS `ActionPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActionPlan` (
  `ActionPlanID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Year` int(11) DEFAULT NULL,
  `Month` int(11) DEFAULT NULL,
  `DistributorID` bigint(20) DEFAULT NULL,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedBy` bigint(20) NOT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ModifiedBy` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ActionPlanID`),
  KEY `FK_ActionPlan_Distributor` (`DistributorID`),
  KEY `FK_ActionPlan_AssCap` (`AssessmentCapacityID`),
  KEY `FK_ActionPlan_CreatedBy` (`CreatedBy`),
  KEY `FK_ActionPlan_ModifiedBy` (`ModifiedBy`),
  CONSTRAINT `FK_ActionPlan_AssCap` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_ModifiedBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActionPlan`
--

LOCK TABLES `ActionPlan` WRITE;
/*!40000 ALTER TABLE `ActionPlan` DISABLE KEYS */;
INSERT INTO `ActionPlan` VALUES (19,2013,9,3612,15,0,'2013-09-05 03:48:39',3038,'2013-09-05 03:48:41',NULL),(20,2013,9,3611,16,0,'2013-09-06 05:49:02',3038,'2013-09-06 05:49:05',NULL),(21,2013,8,3747,17,0,'2013-09-06 08:02:29',3998,'2013-09-06 08:02:43',NULL),(22,2013,9,3747,18,0,'2013-09-06 08:12:50',3998,'2013-09-06 08:13:05',NULL),(23,2013,10,3612,19,0,'2013-09-06 11:29:39',3038,'2013-09-06 11:29:42',NULL),(24,2013,11,3612,20,0,'2013-09-06 11:35:45',3038,'2013-09-06 11:35:47',NULL),(25,2013,12,3612,23,0,'2013-09-10 10:37:48',3038,'2013-09-10 10:37:55',NULL),(26,2014,1,3612,24,0,'2013-09-10 11:03:37',3038,'2013-09-10 11:03:44',NULL),(27,2013,2,3612,25,0,'2013-09-12 04:50:49',3038,'2013-09-12 04:50:59',NULL);
/*!40000 ALTER TABLE `ActionPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActionPlanDetail`
--

DROP TABLE IF EXISTS `ActionPlanDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActionPlanDetail` (
  `ActionPlanDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ActionPlanID` bigint(20) NOT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  `Plan` text,
  `Actors` varchar(512) NOT NULL,
  `EvaluationCriteria` text,
  `ResultNote` text,
  `DueDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ActualDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ActionPlanDetailID`),
  KEY `FK_ActionPlanDetail_ActionPlan` (`ActionPlanID`),
  KEY `FK_ActionPlanDetail_KPI` (`AssessmentKPIID`),
  CONSTRAINT `FK_ActionPlanDetail_ActionPlan` FOREIGN KEY (`ActionPlanID`) REFERENCES `ActionPlan` (`ActionPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlanDetail_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActionPlanDetail`
--

LOCK TABLES `ActionPlanDetail` WRITE;
/*!40000 ALTER TABLE `ActionPlanDetail` DISABLE KEYS */;
INSERT INTO `ActionPlanDetail` VALUES (32,19,2,'ACT1','OIA','EF',NULL,'2013-09-09 17:00:00','2013-09-04 17:00:00',1),(33,19,11,'KEQ12','OFE','FA',NULL,'2013-08-26 17:00:00','2013-09-04 17:00:00',2),(34,20,11,'FSEF','FASEF','FASEF',NULL,'2013-08-26 17:00:00','2013-09-06 05:49:05',0),(35,22,2,'dcssxtytv,','sx','fdjh',NULL,'2013-09-29 17:00:00','2013-09-06 08:13:05',0),(36,22,8,'dsxtg','bszxtv','xzdftrj',NULL,'2013-09-29 17:00:00','2013-09-06 08:13:05',0),(37,22,10,'sdaszrtdmj','sdfdu','sfghfgbjh',NULL,'2013-09-28 17:00:00','2013-09-06 08:13:05',0),(38,23,6,'eeeeeee','eeeeeeee','eeeee',NULL,'2013-08-26 17:00:00','2013-09-05 17:00:00',2),(39,23,8,'feee','eeeeee','eee',NULL,'2013-09-01 17:00:00','2013-09-05 17:00:00',3),(40,24,11,'eeeeeee','aaaaa','aaa',NULL,'2013-08-25 17:00:00','2013-09-05 17:00:00',2),(41,25,3,'FEOF','FESFA','FSEF',NULL,'2013-09-09 17:00:00','2013-09-09 17:00:00',1),(42,25,3,'FEFEF','EEEEEE','eeee',NULL,'2013-08-26 17:00:00','2013-09-09 17:00:00',4),(43,25,11,'OEO','FSEF','EEEa',NULL,'2013-09-08 17:00:00','2013-09-09 17:00:00',2),(44,25,11,'FOE','EE','FA',NULL,'2013-09-08 17:00:00','2013-09-09 17:00:00',4),(45,26,3,'FSEF','fSEF','eee',NULL,'2013-08-25 17:00:00','2013-09-10 11:03:44',NULL),(46,26,3,'FEOF','FESFA','FSEF',NULL,'2013-08-27 17:00:00','2013-09-10 11:03:44',NULL),(47,26,8,'FESFE','FSEF','fSEF',NULL,'2013-09-02 17:00:00','2013-09-10 11:03:44',NULL),(48,26,11,'FESF','FSEF','FSEF',NULL,'2013-09-09 17:00:00','2013-09-10 11:03:44',NULL),(49,26,11,'OEO','FSEF','EEEa',NULL,'2013-09-16 17:00:00','2013-09-10 11:03:44',NULL),(50,27,2,'aaa','eee','aa',NULL,'2013-08-25 17:00:00','2013-09-12 04:50:59',NULL),(51,27,2,'eee','aa','aaa',NULL,'2013-09-01 17:00:00','2013-09-12 04:50:59',NULL),(52,27,10,'eaae','ee','aa',NULL,'2013-08-26 17:00:00','2013-09-12 04:50:59',NULL),(53,27,11,'eafe','eaa','e',NULL,'2013-09-01 17:00:00','2013-09-12 04:50:59',NULL);
/*!40000 ALTER TABLE `ActionPlanDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Agent`
--

DROP TABLE IF EXISTS `Agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Agent` (
  `AgentID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AgentID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agent`
--

LOCK TABLES `Agent` WRITE;
/*!40000 ALTER TABLE `Agent` DISABLE KEYS */;
INSERT INTO `Agent` VALUES (3,'Focus'),(4,'IMA');
/*!40000 ALTER TABLE `Agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AgentRegion`
--

DROP TABLE IF EXISTS `AgentRegion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AgentRegion` (
  `AgentRegionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AgentID` int(20) DEFAULT NULL,
  `RegionID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AgentRegionID`),
  KEY `FK_AgentRegion_Region` (`RegionID`),
  KEY `FK_AgentRegion_Agent` (`AgentID`),
  CONSTRAINT `FK_AgentRegion_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AgentRegion_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AgentRegion`
--

LOCK TABLES `AgentRegion` WRITE;
/*!40000 ALTER TABLE `AgentRegion` DISABLE KEYS */;
INSERT INTO `AgentRegion` VALUES (28,3,1),(29,3,5),(30,3,6),(31,4,3),(32,4,4),(33,4,7);
/*!40000 ALTER TABLE `AgentRegion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentCapacity`
--

DROP TABLE IF EXISTS `AssessmentCapacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentCapacity` (
  `AssessmentCapacityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `DistributorID` bigint(20) NOT NULL,
  `DistributorUserID` bigint(20) NOT NULL,
  `DistributorLevelID` bigint(20) NOT NULL,
  `AssignmentCapacityID` bigint(20) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Month` int(11) DEFAULT NULL,
  PRIMARY KEY (`AssessmentCapacityID`),
  UNIQUE KEY `UQ_AssessmentCapacity` (`DistributorID`,`Year`,`Month`),
  KEY `FK_AssessmentCapacity_User` (`DistributorUserID`),
  KEY `FK_AssessmentCapacity_DL` (`DistributorLevelID`),
  KEY `FK_AssessmentCapacity_Assignment` (`AssignmentCapacityID`),
  CONSTRAINT `FK_AssessmentCapacity_Assignment` FOREIGN KEY (`AssignmentCapacityID`) REFERENCES `AssignmentCapacity` (`AssignmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacity_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacity_DL` FOREIGN KEY (`DistributorLevelID`) REFERENCES `DistributorLevel` (`DistributorLevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacity_User` FOREIGN KEY (`DistributorUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentCapacity`
--

LOCK TABLES `AssessmentCapacity` WRITE;
/*!40000 ALTER TABLE `AssessmentCapacity` DISABLE KEYS */;
INSERT INTO `AssessmentCapacity` VALUES (15,'Danh gia thang 8',NULL,'2013-09-05 03:48:39',NULL,3612,3046,2,NULL,2013,8),(16,'Đánh giá năng lực kỳ 8',NULL,'2013-09-06 05:49:02',NULL,3611,3040,1,NULL,2013,8),(17,'Đánh giá năng lực kỳ 7',NULL,'2013-09-06 08:02:29',NULL,3747,4000,2,NULL,2013,7),(18,'Đánh giá năng lực kỳ 8',NULL,'2013-09-06 08:12:50',NULL,3747,4000,2,NULL,2013,8),(19,'Đánh giá năng lực kỳ 9 - HƯNG THỊNH',NULL,'2013-09-06 11:29:39',NULL,3612,3046,2,NULL,2013,9),(20,'Đánh giá năng lực kỳ 10 - HƯNG THỊNH',NULL,'2013-09-06 11:35:45',NULL,3612,3046,2,NULL,2013,10),(23,'Đánh giá năng lực kỳ 11 - HƯNG THỊNH',NULL,'2013-09-10 10:37:48',NULL,3612,3046,2,NULL,2013,11),(24,'Đánh giá năng lực kỳ 12 - HƯNG THỊNH',NULL,'2013-09-10 11:03:37',NULL,3612,3046,2,NULL,2013,12),(25,'Đánh giá năng lực kỳ 1 - HƯNG THỊNH',NULL,'2013-09-12 04:50:49',NULL,3612,3046,2,NULL,2013,1);
/*!40000 ALTER TABLE `AssessmentCapacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentCapacityKPI`
--

DROP TABLE IF EXISTS `AssessmentCapacityKPI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentCapacityKPI` (
  `AssessmentCapacityKPIID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  `AssessmentKPIScoreID` bigint(20) NOT NULL,
  `Score` float DEFAULT NULL,
  `Weight` float DEFAULT NULL,
  `LogisticCommitmentScore` float DEFAULT NULL,
  `ValueAddedCommitmentScore` float DEFAULT NULL,
  `StrategicCommitmentScore` float DEFAULT NULL,
  `Note` text,
  PRIMARY KEY (`AssessmentCapacityKPIID`),
  UNIQUE KEY `AssessmentKPIID` (`AssessmentKPIID`,`AssessmentCapacityID`),
  KEY `FK_AssessmentCapacityKPI_KPIScore` (`AssessmentKPIScoreID`),
  KEY `FK_AssessmentCapacityKPI_Ass` (`AssessmentCapacityID`),
  CONSTRAINT `FK_AssessmentCapacityKPI_Ass` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityKPI_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityKPI_KPIScore` FOREIGN KEY (`AssessmentKPIScoreID`) REFERENCES `AssessmentKPIScore` (`AssessmentKPIScoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentCapacityKPI`
--

LOCK TABLES `AssessmentCapacityKPI` WRITE;
/*!40000 ALTER TABLE `AssessmentCapacityKPI` DISABLE KEYS */;
INSERT INTO `AssessmentCapacityKPI` VALUES (120,15,2,34,4,7.5,0,2,4,NULL),(121,15,3,22,1,10,3,3,4,NULL),(122,15,4,39,3,7.5,1,2,3,NULL),(123,15,5,44,2,10,3,3,3,NULL),(124,15,6,50,2,10,3,3,3,NULL),(125,15,7,57,3,20,3,3,3,NULL),(126,15,8,63,3,7.5,2,3,4,NULL),(127,15,9,67,1,10,1,2,3,NULL),(128,15,10,75,3,7.5,1,1,3,NULL),(129,15,11,80,2,10,2,3,4,NULL),(130,16,2,32,2,7.5,0,2,4,NULL),(131,16,3,22,1,10,3,3,4,NULL),(132,16,5,43,1,10,3,3,3,NULL),(133,16,8,63,3,7.5,2,3,4,NULL),(134,16,11,80,2,10,2,3,4,NULL),(135,17,2,31,1,7.5,0,2,4,NULL),(136,17,3,26,2,10,3,3,4,NULL),(137,17,4,38,2,7.5,1,2,3,NULL),(138,17,5,44,2,10,3,3,3,NULL),(139,17,6,50,2,10,3,3,3,NULL),(140,17,7,56,2,20,3,3,3,NULL),(141,17,8,62,2,7.5,2,3,4,NULL),(142,17,9,68,2,10,1,2,3,NULL),(143,17,10,73,1,7.5,1,1,3,NULL),(144,17,11,80,2,10,2,3,4,NULL),(145,18,2,31,1,7.5,0,2,4,NULL),(146,18,3,26,2,10,3,3,4,NULL),(147,18,4,38,2,7.5,1,2,3,NULL),(148,18,5,44,2,10,3,3,3,NULL),(149,18,6,50,2,10,3,3,3,NULL),(150,18,7,56,2,20,3,3,3,NULL),(151,18,8,62,2,7.5,2,3,4,NULL),(152,18,9,68,2,10,1,2,3,NULL),(153,18,10,73,1,7.5,1,1,3,NULL),(154,18,11,81,3,10,2,3,4,NULL),(155,19,2,33,3,7.5,0,2,4,NULL),(156,19,3,26,2,10,3,3,4,NULL),(157,19,4,38,2,7.5,1,2,3,NULL),(158,19,5,46,4,10,3,3,3,NULL),(159,19,6,50,2,10,3,3,3,NULL),(160,19,7,57,3,20,3,3,3,NULL),(161,19,8,62,2,7.5,2,3,4,NULL),(162,19,9,68,2,10,1,2,3,NULL),(163,19,10,74,2,7.5,1,1,3,NULL),(164,19,11,81,3,10,2,3,4,NULL),(165,20,2,32,2,7.5,0,2,4,NULL),(166,20,3,26,2,10,3,3,4,NULL),(167,20,5,43,1,10,3,3,3,NULL),(168,20,8,65,5,7.5,2,3,4,NULL),(169,20,11,80,2,10,2,3,4,NULL),(170,23,2,32,2,7.5,0,2,4,NULL),(171,23,3,27,3,10,3,3,4,NULL),(172,23,4,39,3,7.5,1,2,3,NULL),(173,23,5,45,3,10,3,3,3,NULL),(174,23,6,51,3,10,3,3,3,NULL),(175,23,7,58,4,20,3,3,3,NULL),(176,23,8,63,3,7.5,2,3,4,NULL),(177,23,9,69,3,10,1,2,3,NULL),(178,23,10,76,4,7.5,1,1,3,NULL),(179,23,11,82,4,10,2,3,4,NULL),(180,24,2,34,4,7.5,0,2,4,NULL),(181,24,3,28,4,10,3,3,4,NULL),(182,24,4,41,5,7.5,1,2,3,NULL),(183,24,5,45,3,10,3,3,3,NULL),(184,24,6,51,3,10,3,3,3,NULL),(185,24,7,58,4,20,3,3,3,NULL),(186,24,8,64,4,7.5,2,3,4,NULL),(187,24,9,70,4,10,1,2,3,NULL),(188,24,10,76,4,7.5,1,1,3,NULL),(189,24,11,82,4,10,2,3,4,NULL),(190,25,2,32,2,7.5,0,2,4,NULL),(191,25,3,28,4,10,3,3,4,NULL),(192,25,4,38,2,7.5,1,2,3,NULL),(193,25,5,45,3,10,3,3,3,NULL),(194,25,6,52,4,10,3,3,3,NULL),(195,25,7,57,3,20,3,3,3,NULL),(196,25,8,62,2,7.5,2,3,4,NULL),(197,25,9,69,3,10,1,2,3,NULL),(198,25,10,75,3,7.5,1,1,3,NULL),(199,25,11,80,2,10,2,3,4,NULL);
/*!40000 ALTER TABLE `AssessmentCapacityKPI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentCapacityUser`
--

DROP TABLE IF EXISTS `AssessmentCapacityUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentCapacityUser` (
  `AssessmentCapacityUserID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `FCVUserID` bigint(20) NOT NULL,
  PRIMARY KEY (`AssessmentCapacityUserID`),
  UNIQUE KEY `FCVUserID` (`FCVUserID`,`AssessmentCapacityID`),
  KEY `FK_AssessmentCapacityUser_Ass` (`AssessmentCapacityID`),
  CONSTRAINT `FK_AssessmentCapacityUser_Ass` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityUser_User` FOREIGN KEY (`FCVUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentCapacityUser`
--

LOCK TABLES `AssessmentCapacityUser` WRITE;
/*!40000 ALTER TABLE `AssessmentCapacityUser` DISABLE KEYS */;
INSERT INTO `AssessmentCapacityUser` VALUES (45,15,1),(49,16,1),(47,15,3036),(46,15,3038),(50,16,3038),(56,19,3038),(58,20,3038),(60,23,3038),(62,24,3038),(64,25,3038),(51,16,3040),(48,15,3046),(57,19,3046),(59,20,3046),(61,23,3046),(63,24,3046),(65,25,3046),(53,17,3998),(55,18,3998),(52,17,4000),(54,18,4000);
/*!40000 ALTER TABLE `AssessmentCapacityUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentKPI`
--

DROP TABLE IF EXISTS `AssessmentKPI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentKPI` (
  `AssessmentKPIID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `Weight` float DEFAULT NULL,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `AssessmentKPICategoryID` bigint(20) NOT NULL,
  `LogisticCommitmentScore` float DEFAULT NULL,
  `ValueAddedCommitmentScore` float DEFAULT NULL,
  `StrategicCommitmentScore` float DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DisplayOrder` int(11) DEFAULT NULL,
  `MaxPlan` int(11) DEFAULT '3',
  `Code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AssessmentKPIID`),
  UNIQUE KEY `UQ_AssessmentKPI` (`AssessmentKPICategoryID`,`Name`),
  CONSTRAINT `FK_AssessmentKPI_Category` FOREIGN KEY (`AssessmentKPICategoryID`) REFERENCES `AssessmentKPICategory` (`AssessmentKPICategoryID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentKPI`
--

LOCK TABLES `AssessmentKPI` WRITE;
/*!40000 ALTER TABLE `AssessmentKPI` DISABLE KEYS */;
INSERT INTO `AssessmentKPI` VALUES (2,'Thống nhất Tầm Nhìn, Mục tiêu, Chiến lược kinh doanh dài hạn','Thống nhất Tầm Nhìn, Mục tiêu, Chiến lược kinh doanh dài hạn',7.5,'2013-08-17 06:08:01',1,0,2,4,'2013-08-30 09:02:20',1,3,'TNTN'),(3,'Cơ sở vật chất','Cơ sở vật chất',10,'2013-08-15 00:13:46',2,3,3,4,'2013-08-30 09:02:26',4,3,'CSVC'),(4,'Khả năng hợp tác, phối hợp','Khả năng hợp tác, phối hợp',7.5,'2013-08-15 00:16:47',3,1,2,3,'2013-08-30 09:02:30',8,3,'KNHT'),(5,'Xây dựng tổ chức chiến thắng','Xây dựng tổ chức chiến thắng',10,NULL,2,3,3,3,'2013-08-30 09:02:42',5,3,'XDTC'),(6,'Khả năng tài chính','Khả năng tài chính',10,NULL,2,3,3,3,'2013-08-30 09:02:48',6,3,'KNTC'),(7,'Quy trình & Hệ thống','Quy trình & Hệ thống',20,'2013-08-15 00:15:21',2,3,3,3,'2013-08-30 09:02:57',7,3,'QT&HT'),(8,'Chia xẻ thông tin minh bạch, kịp thời','Chia xẻ thông tin minh bạch, kịp thời',7.5,NULL,1,2,3,4,'2013-08-30 09:03:12',3,3,'CSTT'),(9,'Đội ngũ kế thừa','Đội ngũ kế thừa',10,NULL,3,1,2,3,'2013-08-30 09:03:17',9,3,'DNKT'),(10,'Xây dựng mối quan hệ với khách hàng','Xây dựng mối quan hệ với khách hàng',7.5,NULL,3,1,1,3,'2013-08-30 09:03:23',10,3,'XDMQH'),(11,'Thống nhất bảng tiêu chí đánh giá và định kỳ họp thống nhất và rà soát','Thống nhất bảng tiêu chí đánh giá và định kỳ họp thống nhất và rà soát',10,NULL,1,2,3,4,'2013-08-30 09:03:34',2,3,'TNBTC');
/*!40000 ALTER TABLE `AssessmentKPI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentKPICategory`
--

DROP TABLE IF EXISTS `AssessmentKPICategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentKPICategory` (
  `AssessmentKPICategoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`AssessmentKPICategoryID`),
  UNIQUE KEY `UQ_AssessmentKPICategory` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentKPICategory`
--

LOCK TABLES `AssessmentKPICategory` WRITE;
/*!40000 ALTER TABLE `AssessmentKPICategory` DISABLE KEYS */;
INSERT INTO `AssessmentKPICategory` VALUES (1,'Thống nhất mục tiêu và kế hoạch kinh doanh chung','Thống nhất mục tiêu và kế hoạch kinh doanh chung','2013-08-17 05:58:57','2013-08-22 04:18:29',1),(2,'Năng lực phân phối','Năng lực phân phối','2013-08-17 05:58:57','2013-08-15 00:12:28',2),(3,'Năng lực quản lý, kế thừa và phát triển kinh doanh khách hàng','Năng lực quản lý, kế thừa và phát triển kinh doanh khách hàng','2013-08-17 05:58:57','2013-08-15 00:12:40',3);
/*!40000 ALTER TABLE `AssessmentKPICategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentKPIScore`
--

DROP TABLE IF EXISTS `AssessmentKPIScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentKPIScore` (
  `AssessmentKPIScoreID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Score` int(11) DEFAULT NULL,
  `Description` text,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  PRIMARY KEY (`AssessmentKPIScoreID`),
  UNIQUE KEY `UQ_AssessmentKPIScore` (`AssessmentKPIID`,`Name`),
  CONSTRAINT `FK_AssessmentKPIScore_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentKPIScore`
--

LOCK TABLES `AssessmentKPIScore` WRITE;
/*!40000 ALTER TABLE `AssessmentKPIScore` DISABLE KEYS */;
INSERT INTO `AssessmentKPIScore` VALUES (21,'Không đạt yêu cầu tiêu chuẩn cơ bản của FCV cho hoạt động kinh doanh',0,'Không đạt yêu cầu tiêu chuẩn cơ bản của FCV cho hoạt động kinh doanh','2013-08-15 00:44:18',NULL,3),(22,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh hằng tháng',1,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh hằng tháng','2013-08-15 00:44:48',NULL,3),(26,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh hằng tháng. Có kế hoạch cải thiện cụ thể trong 2 tháng tới',2,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh hằng tháng. Có kế hoạch cải thiện cụ thể trong 2 tháng tới','2013-08-15 00:46:42',NULL,3),(27,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh cả năm',3,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh cả năm','2013-08-15 00:47:07',NULL,3),(28,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh cả năm. Có kế hoạch cụ thể cho năm tiếp theo',4,'Đạt yêu cầu cơ bản cho hoạt động kinh doanh cả năm. Có kế hoạch cụ thể cho năm tiếp theo','2013-08-15 00:47:35',NULL,3),(29,'Đạt yêu cầu cho hoạt động kinh doanh trong 2 năm tới',5,'Đạt yêu cầu cho hoạt động kinh doanh trong 2 năm tới','2013-08-15 00:48:47',NULL,3),(30,'Không có văn bản định hướng',0,'Không có văn bản định hướng','2013-08-15 00:49:44',NULL,2),(31,'Có văn bản định hướng kinh doanh nhưng ít hơn 50% nhân viên biết được định hướng mục tiêu này',1,'Có văn bản định hướng kinh doanh nhưng ít hơn 50% nhân viên biết được định hướng mục tiêu này','2013-08-15 00:49:57',NULL,2),(32,'Có văn bản định hướng kinh doanh và có khoảng 50% nhân viên biết được định hướng mục tiêu này',2,'Có văn bản định hướng kinh doanh và có khoảng 50% nhân viên biết được định hướng mục tiêu này','2013-08-15 00:50:12','2013-08-17 06:09:29',2),(33,'Có văn bản định hướng kinh doanh và có khoảng 70% nhân viên biết được định hướng mục tiêu này',3,'Có văn bản định hướng kinh doanh và có khoảng 70% nhân viên biết được định hướng mục tiêu này','2013-08-15 00:51:08',NULL,2),(34,'Có văn bản định hướng kinh doanh và có khoảng 90% nhân viên biết được định hướng mục tiêu này',4,'Có văn bản định hướng kinh doanh và có khoảng 90% nhân viên biết được định hướng mục tiêu này','2013-08-15 00:51:22',NULL,2),(35,'Có văn bản định hướng kinh doanh và 100% toàn bộ nhân viên biết được định hướng mục tiêu này',5,'Có văn bản định hướng kinh doanh và 100% toàn bộ nhân viên biết được định hướng mục tiêu này','2013-08-15 00:51:34',NULL,2),(36,'Không chủ động hợp tác với FCV. Không tham gia họp hàng tháng  với NVBH và ĐHKD',0,'Không chủ động hợp tác với FCV. Không tham gia họp hàng tháng  với NVBH và ĐHKD','2013-08-15 00:52:22',NULL,4),(37,'Hỗ trợ các chính sách của FCV một cách thụ động. Có tham gia họp tháng',1,'Hỗ trợ các chính sách của FCV một cách thụ động. Có tham gia họp tháng','2013-08-15 00:52:37',NULL,4),(38,'Tích cực ủng hộ các chính sách của FCV. Tham gia họp tuần với với NVBH',2,'Tích cực ủng hộ các chính sách của FCV. Tham gia họp tuần với với NVBH','2013-08-15 00:52:52',NULL,4),(39,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của NPP',3,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của NPP','2013-08-15 00:53:08',NULL,4),(40,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của khu vực',4,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của khu vực','2013-08-15 00:53:24',NULL,4),(41,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của khu vực và đội ngũ-khen thưởng hàng quý',5,'Tích cực ủng hộ các chính sách của FCV . Tham gia họp tuần với NVBH. Có kế hoạch hành động và đầu tư để phát triển địa bàn của khu vực và đội ngũ-khen thưởng hàng quý ','2013-08-15 00:53:41',NULL,4),(42,'Không có đủ nhân lực cho hoạt động kinh doanhhiện tại. Thiếu nhân viên bộ phận bán hàng & hỗ trợ bán hàng',0,'Không có đủ nhân lực cho hoạt động kinh doanhhiện tại. Thiếu nhân viên bộ phận bán hàng & hỗ trợ bán hàng ','2013-08-15 00:54:09',NULL,5),(43,'Có đủ nhân viên bán hàng  >= 80% số nhân viên hỗ trợ bán hàng theo yêu cầu hoạt động kinh doanh',1,'Có đủ nhân viên bán hàng  >= 80% số nhân viên hỗ trợ bán hàng theo yêu cầu hoạt động kinh doanh','2013-08-15 00:54:25',NULL,5),(44,'Có đủ NVBH >= 80% số nhân viên hỗ trợ bán hàng theo yêu cầu hoạt động kinh doanh.Có kế hoạch tuyển dụng và đào tạo để phát triển chất lượng nhân sự',2,'Có đủ NVBH >= 80% số nhân viên hỗ trợ bán hàng theo yêu cầu hoạt động kinh doanh.Có kế hoạch tuyển dụng và đào tạo để phát triển chất lượng nhân sự','2013-08-15 00:54:50',NULL,5),(45,'Có 100% số lượng nhân viên theo yêu cầu.  70% số nhân viên đạt yêu cầu tiêu chuẩn',3,'Có 100% số lượng nhân viên theo yêu cầu.  70% số nhân viên đạt yêu cầu tiêu chuẩn','2013-08-15 00:55:24',NULL,5),(46,'Có 100% số lượng nhân viên theo yêu cầu.  80% số nhân viên đạt yêu cầu tiêu chuẩn',4,'Có 100% số lượng nhân viên theo yêu cầu.  80% số nhân viên đạt yêu cầu tiêu chuẩn','2013-08-15 00:59:27',NULL,5),(47,'Có 100% số lượng nhân viên theo yêu cầu.  90% số nhân viên đạt yêu cầu tiêu chuẩn',5,'Có 100% số lượng nhân viên theo yêu cầu.  90% số nhân viên đạt yêu cầu tiêu chuẩn','2013-08-15 00:59:41',NULL,5),(48,'Nợ quá hạn trung bình hơn 4 lần/tháng và tỉ lệ OOS > 15%',0,'Nợ quá hạn trung bình hơn 4 lần/tháng và tỉ lệ OOS > 15%','2013-08-15 01:00:07',NULL,6),(49,'Nợ quá hạn trung bình ít khoảng 2 lần/tháng và tỉ lệ OOS >10%',1,'Nợ quá hạn trung bình ít khoảng 2 lần/tháng và tỉ lệ OOS >10%','2013-08-15 01:00:28',NULL,6),(50,'Nợ quá hạn trung bình 1 lần/tháng hoặc không có nợ quá hạn và tỉ lệ OOS < =10%',2,'Nợ quá hạn trung bình 1 lần/tháng hoặc không có nợ quá hạn và tỉ lệ OOS < =10%','2013-08-15 01:00:41','2013-08-15 01:00:56',6),(51,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của cả năm',3,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của cả năm','2013-08-15 01:01:06',NULL,6),(52,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của  năm kế tiếp',4,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của  năm kế tiếp','2013-08-15 01:01:22',NULL,6),(53,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của  2 năm kế tiếp',5,'Không có Nợ quá hạn trung bình ít hơn 1 lần/tháng, tỷ lệ hụt hàng <=10%. Doanh nghiệp có khả năng đầu tư cho hoạt động kinh doanh của  2 năm kế tiếp','2013-08-15 01:01:37',NULL,6),(54,'Không có quy trình và hệ thống hỗ trợ quản lý',0,'Không có quy trình và hệ thống hỗ trợ quản lý','2013-08-15 01:03:24',NULL,7),(55,'Có các quy trình cơ bản: đặt hàng, bán hàng và thanh toán với FCV nhưng chưa có hệ thống hỗ trợ quản lý',1,'Có các quy trình cơ bản: đặt hàng, bán hàng và thanh toán với FCV nhưng chưa có hệ thống hỗ trợ quản lý','2013-08-15 01:03:39',NULL,7),(56,'Có các quy trình cơ bản (đặt hàng, bán hàng và thanh toán)  và hệ thống cơ bản (kế toán, bán hàng)',2,'Có các quy trình cơ bản (đặt hàng, bán hàng và thanh toán)  và hệ thống cơ bản (kế toán, bán hàng)','2013-08-15 01:03:54',NULL,7),(57,'Ngoài các quy trình cơ bản, có thêm một số quy trình tiêu chuẩn  khác và hệ thống hỗ trợ cơ bản (kế toán, bán hàng)',3,'Ngoài các quy trình cơ bản, có thêm một số quy trình tiêu chuẩn  khác và hệ thống hỗ trợ cơ bản (kế toán, bán hàng)','2013-08-15 01:04:08',NULL,7),(58,'Có đầy đủ các quy trình tiêu chuẩn và hệ thống cơ bản (kế toán, bán hàng)',4,'Có đầy đủ các quy trình tiêu chuẩn và hệ thống cơ bản (kế toán, bán hàng)','2013-08-15 01:04:22',NULL,7),(59,'Có đủ các quy trình tiêu chuẩn và đầy đủ hệ thống hỗ trợ quản lý',5,'Có đủ các quy trình tiêu chuẩn và đầy đủ hệ thống hỗ trợ quản lý','2013-08-15 01:04:40',NULL,7),(60,'Không có chia sẻ thông tin hoạt động kinh doanh nào',0,'Không có chia sẻ thông tin hoạt động kinh doanh nào','2013-08-15 01:05:16',NULL,8),(61,'Chỉ chia sẻ thông tin bán hàng',1,'Chỉ chia sẻ thông tin bán hàng','2013-08-15 01:05:29',NULL,8),(62,'Chia sẻ thông tin bán hàng, khuyến mãi và tồn kho',2,'Chia sẻ thông tin bán hàng, khuyến mãi và tồn kho','2013-08-19 03:00:35',NULL,8),(63,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI',3,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI','2013-08-15 01:05:58',NULL,8),(64,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI. Có kế hoạch hành động thống nhất với FCV để cải thiện và phát triển',4,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI. Có kế hoạch hành động thống nhất với FCV để cải thiện và phát triển','2013-08-15 01:06:14',NULL,8),(65,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI. Có kế hoạch hành động thống nhất với FCV để cải thiện và phát triển. Đạt được 90% tổng số KPIs',5,'Chia sẻ toàn bộ thông tin bán hàng, khuyến mãi, tồn kho, tài chính ROI. Có kế hoạch hành động thống nhất với FCV để cải thiện và phát triển. Đạt được 90% tổng số KPIs','2013-08-15 01:06:29',NULL,8),(66,'Không có tổ chức cơ cấu doanh nghiệp rõ ràng và không có kế hoạch đào tạo người kế nhiệm',0,'Không có tổ chức cơ cấu doanh nghiệp rõ ràng và không có kế hoạch đào tạo người kế nhiệm','2013-08-15 01:07:00',NULL,9),(67,'Có cơ cấu tổ chức doanh nghiệp nhưng không có kế hoạch đào tạo người kế nhiệm',1,'Có cơ cấu tổ chức doanh nghiệp nhưng không có kế hoạch đào tạo người kế nhiệm','2013-08-15 01:07:14',NULL,9),(68,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 100% ủy quyền phù hợp',2,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 100% ủy quyền phù hợp','2013-08-15 01:07:39',NULL,9),(69,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 70% ủy quyền phù hợp. 70% bản tiêu chí đánh giá hoạt động hoàn thành',3,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 70% ủy quyền phù hợp. 70% bản tiêu chí đánh giá hoạt động hoàn thành','2013-08-15 01:08:25',NULL,9),(70,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 80% ủy quyền phù hợp. 80% bản tiêu chí đánh giá hoạt động hoàn thành',4,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 80% ủy quyền phù hợp. 80% bản tiêu chí đánh giá hoạt động hoàn thành','2013-08-15 01:08:43',NULL,9),(71,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 90% ủy quyền phù hợp. 90% bản tiêu chí đánh giá hoạt động hoàn thành',5,'Có cơ cấu tổ chức doanh nghiệp rõ ràng, 100% có bản miêu tả công việc với từng vị trí, 100% có định hướng phát triển nghề nghiệp và 90% ủy quyền phù hợp. 90% bản tiêu chí đánh giá hoạt động hoàn thành','2013-08-15 01:08:57',NULL,9),(72,'Không quan tâm đến mối quan hệ với khách hàng',0,'Không quan tâm đến mối quan hệ với khách hàng','2013-08-15 01:09:18',NULL,10),(73,'Chỉ quan tâm hoàn thành việc giao hàng đủ và đúng thời gian. >= 95% giao hàng đúng, đủ',1,'Chỉ quan tâm hoàn thành việc giao hàng đủ và đúng thời gian. >= 95% giao hàng đúng, đủ','2013-08-15 01:09:35',NULL,10),(74,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 95 % khách hàng được thanh toán đúng hạn và >95% giao hàng đúng hạn',2,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 95 % khách hàng được thanh toán đúng hạn và >95% giao hàng đúng hạn','2013-08-15 01:09:52',NULL,10),(75,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và > 96% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 3 tại địa phương trong số tất cả những nhà cung cấp',3,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và > 96% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 3 tại địa phương trong số tất cả những nhà cung cấp','2013-08-15 01:10:06',NULL,10),(76,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và 98% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 2 tại địa phương trong số tất cả những nhà cung cấp',4,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và 98% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 2 tại địa phương trong số tất cả những nhà cung cấp','2013-08-15 01:10:20',NULL,10),(77,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và 98% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 1 tại địa phương trong số tất cả những nhà cung cấp',5,'Hằng tháng đi thăm các khách hàng chủ lực; tặng quà sinh nhật; 100% thanh toán và 98% giao hàng đúng hạn.  Chủ cửa hàng đánh giá doanh nghiệp đứng hạng 1 tại địa phương trong số tất cả những nhà cung cấp','2013-08-15 01:10:34',NULL,10),(78,'Không có bản tiêu chí đánh giá hoạt động kinh doanh',0,'Không có bản tiêu chí đánh giá hoạt động kinh doanh','2013-08-15 01:11:44',NULL,11),(79,'Chỉ có bản tiêu chí đánh giá hoạt động kinh doanh cho phòng bán hàng nhưng không được theo dõi thường xuyên',1,'Chỉ có bản tiêu chí đánh giá hoạt động kinh doanh cho phòng bán hàng nhưng không được theo dõi thường xuyên','2013-08-15 01:11:59',NULL,11),(80,'Chỉ có bản tiêu chí đánh giá hoạt động kinh doanh cho phòng bán hàng và được theo dõi hằng ngày /hằng tuần',2,'Chỉ có bản tiêu chí đánh giá hoạt động kinh doanh cho phòng bán hàng và được theo dõi hằng ngày /hằng tuần','2013-08-15 01:12:14',NULL,11),(81,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 70% tổng số KPIs',3,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 70% tổng số KPIs ','2013-08-15 01:12:29',NULL,11),(82,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 80% tổng số KPIs',4,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 80% tổng số KPIs ','2013-08-15 01:12:41',NULL,11),(83,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 90% tổng số KPIs',5,'Có bản tiêu chí đánh giá hoạt động áp dụng cho nhiều phòng ban, được theo dõi định kỳ hằng tuần, hằng tháng  Có kế hoạch hành động và có biên bản cuộc họp đánh giá  Đạt được 90% tổng số KPIs ','2013-08-15 01:12:55',NULL,11);
/*!40000 ALTER TABLE `AssessmentKPIScore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Assignment`
--

DROP TABLE IF EXISTS `Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assignment` (
  `AssignmentID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `StartTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ClassID` bigint(20) NOT NULL,
  `InstructorID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ModifiedBy` bigint(20) DEFAULT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`AssignmentID`),
  KEY `FK_Assignment_Class` (`ClassID`),
  KEY `FK_Assignment_CreatedBy` (`CreatedBy`),
  KEY `FK_Assignment_ModifiedBy` (`ModifiedBy`),
  KEY `FK_Assignment_Instructor` (`InstructorID`),
  CONSTRAINT `FK_Assignment_Class` FOREIGN KEY (`ClassID`) REFERENCES `Class` (`ClassID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Assignment_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Assignment_ModifiedBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Assignment_Instructor` FOREIGN KEY (`InstructorID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignment`
--

LOCK TABLES `Assignment` WRITE;
/*!40000 ALTER TABLE `Assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssignmentCapacity`
--

DROP TABLE IF EXISTS `AssignmentCapacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssignmentCapacity` (
  `AssignmentCapacityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorID` bigint(20) NOT NULL,
  `DistributorUserID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DueDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Year` int(11) DEFAULT NULL,
  `Month` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`AssignmentCapacityID`),
  UNIQUE KEY `UQ_AssignmentCapacity` (`DistributorID`,`Year`,`Month`),
  KEY `FK_AssignmentCapacity_User` (`DistributorUserID`),
  CONSTRAINT `FK_AssignmentCapacity_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssignmentCapacity_User` FOREIGN KEY (`DistributorUserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssignmentCapacity`
--

LOCK TABLES `AssignmentCapacity` WRITE;
/*!40000 ALTER TABLE `AssignmentCapacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `AssignmentCapacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssignmentCapacityUser`
--

DROP TABLE IF EXISTS `AssignmentCapacityUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssignmentCapacityUser` (
  `AssignmentCapacityUserID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssignmentCapacityID` bigint(20) NOT NULL,
  `AssigneeID` bigint(20) NOT NULL,
  PRIMARY KEY (`AssignmentCapacityUserID`),
  UNIQUE KEY `UQ_AssignmentCapacityUser` (`AssignmentCapacityID`,`AssigneeID`),
  KEY `FK_AssignmentCapacityUser_User` (`AssigneeID`),
  CONSTRAINT `FK_AssignmentCapacityUser_ACU` FOREIGN KEY (`AssignmentCapacityID`) REFERENCES `AssignmentCapacity` (`AssignmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssignmentCapacityUser_User` FOREIGN KEY (`AssigneeID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssignmentCapacityUser`
--

LOCK TABLES `AssignmentCapacityUser` WRITE;
/*!40000 ALTER TABLE `AssignmentCapacityUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `AssignmentCapacityUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditSchedule`
--

DROP TABLE IF EXISTS `AuditSchedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditSchedule` (
  `AuditScheduleID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `FromDate` datetime DEFAULT NULL,
  `ToDate` datetime DEFAULT NULL,
  `ReAuditScheduleID` bigint(20) DEFAULT NULL,
  `CreatedBy` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AuditScheduleID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  KEY `FK_AuditSchedule_AuditSchedule` (`ReAuditScheduleID`),
  KEY `FK_AuditSchedule_User` (`CreatedBy`),
  CONSTRAINT `FK_AuditSchedule_AuditSchedule` FOREIGN KEY (`ReAuditScheduleID`) REFERENCES `AuditSchedule` (`AuditScheduleID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AuditSchedule_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditSchedule`
--

LOCK TABLES `AuditSchedule` WRITE;
/*!40000 ALTER TABLE `AuditSchedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `AuditSchedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Auditor`
--

DROP TABLE IF EXISTS `Auditor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Auditor` (
  `AuditorID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `CreatedBy` bigint(20) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `auditortypeID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`AuditorID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  KEY `FK_Auditor_User` (`CreatedBy`),
  KEY `FK_Auditor_AuditorType` (`auditortypeID`),
  CONSTRAINT `FK_Auditor_AuditorType` FOREIGN KEY (`auditortypeID`) REFERENCES `AuditorType` (`AuditorTypeID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_Auditor_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auditor`
--

LOCK TABLES `Auditor` WRITE;
/*!40000 ALTER TABLE `Auditor` DISABLE KEYS */;
INSERT INTO `Auditor` VALUES (269,'THCM04','THCM04',1,NULL,'','',2),(270,'THCM05','THCM05',1,NULL,'','',2),(271,'THCM06','THCM06',1,NULL,'','',2),(272,'TDN0001','TDN0001',1,NULL,'','',3),(273,'TDN0002','TDN0002',1,NULL,'','',2),(274,'TDN0003','TDN0003',1,NULL,'','',2),(275,'TDN0004','TDN0004',1,NULL,'','',1),(276,'TDN0005','TDN0005',1,NULL,'','',2),(277,'TDN0006','TDN0006',1,NULL,'','',2),(278,'TDN0007','TDN0007',1,NULL,'','',2),(279,'TDN0008','TDN0008',1,NULL,'','',2),(280,'THN01','THN01',1,NULL,'','',3),(281,'THN02','THN02',1,NULL,'','',1),(282,'THN03','THN03',1,NULL,'','',2),(283,'THN04','THN04',1,NULL,'','',2),(284,'THN05','THN05',1,NULL,'','',2),(285,'THN06','THN06',1,NULL,'','',2),(286,'THN07','THN07',1,NULL,'','',2),(287,'THN08','THN08',1,NULL,'','',2),(288,'TN0001','TN0001',1,NULL,'','',3),(289,'TN0002','TN0002',1,NULL,'','',2),(290,'TN0003','TN0003',1,NULL,'','',1),(291,'TN0004','TN0004',1,NULL,'','',2),(292,'TN0005','TN0005',1,NULL,'','',2),(293,'TN0006','TN0006',1,NULL,'','',2),(294,'TN0007','TN0007',1,NULL,'','',2),(295,'TN0008','TN0008',1,NULL,'','',2),(296,'TCT0001','TCT0001',1,NULL,'','',3),(297,'TCT0002','TCT0002',1,NULL,'','',2),(298,'TCT0003','TCT0003',1,NULL,'','',2),(299,'TCT0004','TCT0004',1,NULL,'','',2),(300,'TCT0005','TCT0005',1,NULL,'','',2),(301,'TCT0006','TCT0006',1,NULL,'','',2),(302,'TCT0007','TCT0007',1,NULL,'','',2),(303,'TCT0008','TCT0008',1,NULL,'','',2),(304,'TE0001','TE0001',1,NULL,'','',3),(305,'TE0002','TE0002',1,NULL,'','',2),(306,'TE0003','TE0003',1,NULL,'','',2),(307,'TE0004','TE0004',1,NULL,'','',2),(308,'TE0005','TE0005',1,NULL,'','',2),(309,'TE0006','TE0006',1,NULL,'','',2),(310,'TE0007','TE0007',1,NULL,'','',2),(311,'TE0008','TE0008',1,NULL,'','',2),(312,'TMK001','TMK001',1,NULL,'','',3),(313,'TMK002','TMK002',1,NULL,'','',2),(314,'TMK003','TMK003',1,NULL,'','',2),(315,'TMK004','TMK004',1,NULL,'','',2),(316,'TMK005','TMK005',1,NULL,'','',2),(317,'TMK006','TMK006',1,NULL,'','',2),(318,'TMK007','TMK007',1,NULL,'','',2),(319,'TMK008','TMK008',1,NULL,'','',2);
/*!40000 ALTER TABLE `Auditor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditorBackup`
--

DROP TABLE IF EXISTS `AuditorBackup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditorBackup` (
  `AuditorBackupID` bigint(11) NOT NULL AUTO_INCREMENT,
  `AuditorID` bigint(20) DEFAULT NULL,
  `Code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CreatedBy` bigint(20) DEFAULT NULL,
  `Path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Telephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AuditorTypeID` bigint(11) DEFAULT NULL,
  `BackupDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AuditorBackupID`),
  KEY `AuditorTypeID` (`AuditorTypeID`),
  CONSTRAINT `auditorbackup_ibfk_1` FOREIGN KEY (`AuditorTypeID`) REFERENCES `AuditorType` (`AuditorTypeID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditorBackup`
--

LOCK TABLES `AuditorBackup` WRITE;
/*!40000 ALTER TABLE `AuditorBackup` DISABLE KEYS */;
INSERT INTO `AuditorBackup` VALUES (1,266,'THCM01','THCM01',414,'files/auditor/Desert(3).jpg','09894564456','asdf@gagsd.com',2,'2013-08-06 10:05:44'),(2,272,'TDN0001','TDN0001',1,NULL,'','',2,'2013-08-06 10:05:50'),(3,276,'TDN0005','TDN0005',1,NULL,'','',3,'2013-08-06 10:05:57');
/*!40000 ALTER TABLE `AuditorBackup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditorOutletTask`
--

DROP TABLE IF EXISTS `AuditorOutletTask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditorOutletTask` (
  `AuditorOutletTaskID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AuditorScheduleID` bigint(20) NOT NULL,
  `AuditorID` bigint(20) NOT NULL,
  `OutletID` bigint(20) NOT NULL,
  `Status` int(11) NOT NULL,
  PRIMARY KEY (`AuditorOutletTaskID`),
  UNIQUE KEY `UQ_AuditorOutletTask` (`AuditorScheduleID`,`AuditorID`,`OutletID`),
  KEY `FK_OutletTask_AuditorSchedule` (`AuditorScheduleID`),
  KEY `FK_OutletTask_Auditor` (`AuditorID`),
  KEY `FK_OutletTask_Outlet` (`OutletID`),
  CONSTRAINT `FK_OutletTask_Auditor` FOREIGN KEY (`AuditorID`) REFERENCES `Auditor` (`AuditorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletTask_AuditorSchedule` FOREIGN KEY (`AuditorScheduleID`) REFERENCES `AuditSchedule` (`AuditScheduleID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletTask_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditorOutletTask`
--

LOCK TABLES `AuditorOutletTask` WRITE;
/*!40000 ALTER TABLE `AuditorOutletTask` DISABLE KEYS */;
/*!40000 ALTER TABLE `AuditorOutletTask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditorStoreTask`
--

DROP TABLE IF EXISTS `AuditorStoreTask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditorStoreTask` (
  `AuditorStoreTaskID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AuditorID` bigint(20) NOT NULL,
  `AuditorScheduleID` bigint(20) NOT NULL,
  `StoreID` bigint(20) NOT NULL,
  `Status` int(11) NOT NULL,
  PRIMARY KEY (`AuditorStoreTaskID`),
  UNIQUE KEY `UQ_AuditorStoreTask` (`AuditorID`,`AuditorScheduleID`,`StoreID`),
  KEY `FK_StoreTask_AuditSchedule` (`AuditorScheduleID`),
  KEY `FK_StoreTask_Auditor` (`AuditorID`),
  KEY `FK_StoreTask_Store` (`StoreID`),
  CONSTRAINT `FK_StoreTask_Auditor` FOREIGN KEY (`AuditorID`) REFERENCES `Auditor` (`AuditorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StoreTask_AuditSchedule` FOREIGN KEY (`AuditorScheduleID`) REFERENCES `AuditSchedule` (`AuditScheduleID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StoreTask_Store` FOREIGN KEY (`StoreID`) REFERENCES `Store` (`StoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditorStoreTask`
--

LOCK TABLES `AuditorStoreTask` WRITE;
/*!40000 ALTER TABLE `AuditorStoreTask` DISABLE KEYS */;
/*!40000 ALTER TABLE `AuditorStoreTask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditorType`
--

DROP TABLE IF EXISTS `AuditorType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditorType` (
  `AuditorTypeID` bigint(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AuditorTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditorType`
--

LOCK TABLES `AuditorType` WRITE;
/*!40000 ALTER TABLE `AuditorType` DISABLE KEYS */;
INSERT INTO `AuditorType` VALUES (1,'QC'),(2,'Auditor'),(3,'TL'),(4,'SE');
/*!40000 ALTER TABLE `AuditorType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Brand`
--

DROP TABLE IF EXISTS `Brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Brand` (
  `BrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `BrandGroupID` bigint(20) NOT NULL,
  `RightLocation` text,
  `Products` text,
  PRIMARY KEY (`BrandID`),
  KEY `FK_Brand_BrandGroup` (`BrandGroupID`),
  CONSTRAINT `FK_Brand_BrandGroup` FOREIGN KEY (`BrandGroupID`) REFERENCES `BrandGroup` (`BrandGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Brand`
--

LOCK TABLES `Brand` WRITE;
/*!40000 ALTER TABLE `Brand` DISABLE KEYS */;
INSERT INTO `Brand` VALUES (1,'DL IFT Regular',1,'Đặt cạnh Dielac','DL Mum/DL step 1/DL step 2/ DL 123 /DL  456/ IMP DL'),(2,'DL IFT Gold',1,'Đặt cạnh DL IFT Regular/Dielac','DL Gold step 1/DL Gold step 2/ DL Gold 123 /DL Gold 456'),(3,'Friso gold',1,'Đặt cạnh Abbott/Enfa/Friso Regular','FG Mum/FG 1/FG 2/FG 3/FG 4'),(4,'Friso regular',1,'Đặt cạnh Abbott/Enfa/Friso gold','Fr 1/FR 2/FR 3/FR 4'),(5,'DL UHT',2,'Đặt cạnh Vinamilk/TH True milk','Plain/Sweet/ straw/ Chocolate'),(6,'Yomost',2,'Đặt cạnh Vinamilk','Pomegranate/ seabuckthorn/ Orange/ Straw/ Peach/Plain');
/*!40000 ALTER TABLE `Brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BrandGroup`
--

DROP TABLE IF EXISTS `BrandGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BrandGroup` (
  `BrandGroupID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`BrandGroupID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BrandGroup`
--

LOCK TABLES `BrandGroup` WRITE;
/*!40000 ALTER TABLE `BrandGroup` DISABLE KEYS */;
INSERT INTO `BrandGroup` VALUES (1,'IFT','Ngành hàng sữa bột'),(2,'DBB','Ngành hàng sữa nước');
/*!40000 ALTER TABLE `BrandGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Class` (
  `ClassID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `OpeningTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `InstructorID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ModifiedBy` bigint(20) DEFAULT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ClassID`),
  KEY `FK_Class_CreatedBy` (`CreatedBy`),
  KEY `FK_Class_ModifiedBy` (`ModifiedBy`),
  KEY `FK_Class_Instructor` (`InstructorID`),
  CONSTRAINT `FK_Class_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Class_ModifiedBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Class_Instructor` FOREIGN KEY (`InstructorID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClassRoster`
--

DROP TABLE IF EXISTS `ClassRoster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClassRoster` (
  `ClassRosterID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClassID` bigint(20) NOT NULL,
  `StudentID` bigint(20) NOT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedBy` bigint(20) DEFAULT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ClassRosterID`),
  UNIQUE KEY `UQ_ClassRoster` (`ClassID`,`ClassRosterID`),
  KEY `FK_ClassRoster_CreatedBy` (`CreatedBy`),
  KEY `FK_ClassRoster_ModifiedBy` (`ModifiedBy`),
  KEY `FK_ClassRoster_Student` (`StudentID`),
  CONSTRAINT `FK_ClassRoster_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ClassRoster_ModifiedBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ClassRoster_Class` FOREIGN KEY (`ClassID`) REFERENCES `Class` (`ClassID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ClassRoster_Student` FOREIGN KEY (`StudentID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClassRoster`
--

LOCK TABLES `ClassRoster` WRITE;
/*!40000 ALTER TABLE `ClassRoster` DISABLE KEYS */;
/*!40000 ALTER TABLE `ClassRoster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DBBPosmRegistered`
--

DROP TABLE IF EXISTS `DBBPosmRegistered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DBBPosmRegistered` (
  `DBBPosmRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBBPosmRegisteredID`),
  UNIQUE KEY `UQ_OutletID_PosmID_OutletPosmID_DBBRegistered` (`OutletID`,`OutletBrandID`,`PosmID`),
  KEY `FK_DBBRegister_OutletBrand` (`OutletBrandID`),
  KEY `FK_DBBRegister_OutletPosm` (`PosmID`),
  CONSTRAINT `FK_DBBRegister_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DBBRegister_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DBBRegister_OutletPosm` FOREIGN KEY (`PosmID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DBBPosmRegistered`
--

LOCK TABLES `DBBPosmRegistered` WRITE;
/*!40000 ALTER TABLE `DBBPosmRegistered` DISABLE KEYS */;
/*!40000 ALTER TABLE `DBBPosmRegistered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Distributor`
--

DROP TABLE IF EXISTS `Distributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Distributor` (
  `DistributorID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `SapCode` varchar(45) NOT NULL,
  `CreatedBy` bigint(20) DEFAULT NULL,
  `RegionID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`DistributorID`),
  UNIQUE KEY `UQ_Distributor` (`SapCode`,`Name`),
  KEY `FK_Distributor_User` (`CreatedBy`),
  KEY `FK_Distributor_Region` (`RegionID`),
  CONSTRAINT `FK_Distributor_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_Distributor_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3793 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Distributor`
--

LOCK TABLES `Distributor` WRITE;
/*!40000 ALTER TABLE `Distributor` DISABLE KEYS */;
INSERT INTO `Distributor` VALUES (3611,'BẢO KHÁNH','100153',1,7),(3612,'HƯNG THỊNH','100149',3038,7),(3613,'LIÊN HƯƠNG','100152',3038,7),(3614,'PHƯƠNG LAN','100156',3038,7),(3615,'TÂN HOÀNG PHÁT','100151',3038,7),(3616,'THÁI NHẬT HOA','100154',3038,7),(3617,'TOÀN DƯƠNG','100148',3038,7),(3618,'VÂN TRANG','100150',3038,7),(3619,'HẢI YẾN','100119',3038,7),(3620,'HƯNG PHÁT','100116',3038,7),(3621,'Nam Thái','102612',3038,7),(3622,'NGỌC SƠN','100110',3038,7),(3623,'THÀNH ĐẠT','100105',3038,7),(3624,'TÙNG HOA','100230',3038,7),(3625,'CHÂU HIỆP','100117',3038,7),(3626,'ĐOÀN THỊ NGHI','100101',3038,7),(3627,'HẢI PHƯỢNG','100124',3038,7),(3628,'HỒNG TƯ','100103',3038,7),(3629,'HƯƠNG TOÀN','100120',3038,7),(3630,'HỮU NGUYÊN','100121',3038,7),(3631,'MAI LINH','100159',3038,7),(3632,'MINH LIÊN','100627',3038,7),(3633,'NAM HẢI','101819',3038,7),(3634,'NGÔ THANH CHI','100157',3038,7),(3635,'NGUYỄN TIẾN LÂM','100115',3038,7),(3636,'PHẠM THỊ MAI PHƯƠNG','100104',3038,7),(3637,'PHƯỢNG SÁNG','100155',3038,7),(3638,'DŨNG TIẾN','100100',3038,7),(3639,'HOA VIỆT','100158',3038,7),(3640,'NGHĨA HƯNG','100114',3038,7),(3641,'SINH PHƯỢNG','100112',3038,7),(3642,'TOÀN THẮNG','100102',3038,7),(3643,'Tuấn Linh Phúc Hải','102723',3038,7),(3644,'XNB THĂNG LONG','100111',3038,7),(3645,'AN THUẬN PHÁT','102698',3038,7),(3646,'ĐÔNG TIẾN','102699',3038,7),(3647,'HÙNG HOÀNG','100109',3038,7),(3648,'NAM LONG','100107',3038,7),(3649,'QUANG CƯỜNG','100118',3038,7),(3650,'THỦY CHÂU','100085',3038,7),(3651,'VÂN HÙNG','100108',3038,7),(3652,'BINH VINH','100122',3038,NULL),(3653,'HO GUOM','101994',3038,NULL),(3654,'HOANG LAM','100142',3038,NULL),(3655,'HUY PHUONG','100139',3038,NULL),(3656,'PT FOOD','100138',3038,NULL),(3657,'TIN NGHIA 1','100144',3038,NULL),(3658,'TIN NGHIA 2','101528',3038,NULL),(3659,'CUONG THINH','100137',3038,NULL),(3660,'HA PHUONG','101767',3038,NULL),(3661,'LAN CHI 1','100147',3038,NULL),(3662,'LAN CHI 2','100147',3038,NULL),(3663,'THIEN AN','101663',3038,NULL),(3664,'XNK','100140',3038,NULL),(3665,'CN Trần Trương','101297',3038,4),(3666,'Đức Lợi','100099',3038,4),(3667,'Thành Lợi','100097',3038,4),(3668,'Tuấn Việt','100092',3038,4),(3669,'CN Quốc Phong ','101649',3038,4),(3670,'Hoàng B́nh','100078',3038,4),(3671,'Nam Tiến','100088',3038,4),(3672,'Quốc Phong 1','100086',3038,4),(3673,'Quốc Phong 2','100086',3038,4),(3674,'Thành Hưng','101721',3038,4),(3675,'Thien Phuc','102673',3038,4),(3676,'Trung Tín','100079',3038,4),(3677,'Vạn Phúc','100091',3038,4),(3678,'Hạnh Đức 1','100018',3038,4),(3679,'Hạnh Đức 2','100018',3038,4),(3680,'Hoàng Yên','102704',3038,4),(3681,'Hùng Nhân','100084',3038,4),(3682,'Kim Tấn Tài','101750',3038,4),(3683,'Nguyên Thành','100083',3038,4),(3684,'Ninh Uyên','102727',3038,4),(3685,'Pacific','100090',3038,4),(3686,'Hoàng Hà','100015',3038,5),(3687,'Hữu Toàn','100014',3038,5),(3688,'Phương Ánh','100003',3038,5),(3689,'Phương Ánh 3','102714',3038,5),(3690,'Thành Nghĩa Thịnh','102434',3038,5),(3691,'Trung Yến Hưng','100013',3038,5),(3692,'Hiệp Thành','100029',3038,5),(3693,'Phượng Định','100027',3038,5),(3694,'Quăng Thái 1','100025',3038,5),(3695,'Quăng Thái 2','100025',3038,5),(3696,'Tâm Đan','100026',3038,5),(3697,'Tân Bảo An','100028',3038,5),(3698,'Anh Quân','102715',3038,5),(3699,'Hữu Lâm','100008',3038,5),(3700,'Huỳnh Thanh Sơn','100009',3038,5),(3701,'NGỌC OANH','101752',3038,5),(3702,'Nguyễn Hùng ','102688',3038,5),(3703,'Phương Ánh 2','101871',3038,5),(3704,'Thành Bước BL','101503',3038,5),(3705,'Thành Bước ĐX','101503',3038,5),(3706,'Vĩnh Phước 1','101728',3038,5),(3707,'Bắc Hà','100790',3038,5),(3708,'Bắc Hà 2','100790',3038,5),(3709,'Hạnh Huyền','100022',3038,5),(3710,'Hạnh Huyền 2','100022',3038,5),(3711,'KHÔI KHUYÊN','100024',3038,5),(3712,'Lâm Thuận 1','100019',3038,5),(3713,'Lâm Thuận 2','100019',3038,5),(3714,'Lâm Thuận 3','102614',3038,5),(3715,'Hoàng Phong 01','100073',3038,1),(3716,'Hoàng Phong 02','100073',3038,1),(3717,'Hồng Lĩnh 01','100070',3038,1),(3718,'Hồng Lĩnh 02','100070',3038,1),(3719,'Hùng Quyên','100075',3038,1),(3720,'NGỌC NHI','100063',3038,1),(3721,'Chín Nguyện','100062',3038,1),(3722,'Duyệt Hỷ','100057',3038,1),(3723,'Nhất Trí Khang ','100242',3038,1),(3724,'Thảo Vy ','100059',3038,1),(3725,'Trí Tín 01','100072',3038,1),(3726,'Trí Tín 02','100072',3038,1),(3727,'Lâm Kim Loan 01','100523',3038,1),(3728,'Nam Trung ','100058',3038,1),(3729,'Ngọc Duy ','100064',3038,1),(3730,'Toàn Đức PH 1','102716',3038,1),(3731,'Toàn Đức PH 2','102716',3038,1),(3732,'Vương Hà Phát','102368',3038,1),(3733,'Hồng Trinh','100071',3038,1),(3746,'Minh Nguyệt 02','100061',3038,1),(3747,'Tấn Phúc ','100069',3038,1),(3748,'Thanh Nga ','100060',3038,1),(3749,'Á Châu','102464',1,NULL),(3750,'ĐẠI THÀNH PHÁT','100049',3038,6),(3751,'Hoàng Bửu','102694',3038,6),(3752,'NAM SƯƠNG','100036',3038,6),(3753,'Ngọc Thu','102603',3038,6),(3754,'Phát Đạt','100271',3038,6),(3755,'TDK','101201',3038,6),(3756,'Trần Phong','100033',3038,6),(3757,'Hiệp Phong','100031',3038,6),(3758,'Hồng Hải Ngân','102601',3038,6),(3759,'HƯNG HÒA','100040',3038,6),(3760,'MAI HƯNG','100030',3038,6),(3761,'PHUOC HIEP','102534',3038,6),(3762,'Tân Thế Phát','101769',3038,6),(3763,'THÁI PHONG','101779',3038,6),(3764,'Đức Hòa','100054',3038,6),(3765,'Khoa Nam','100042',3038,6),(3766,'Lương Thái Cường','100035',3038,6),(3767,'Nam Hồng','102683',3038,6),(3768,'Ngọc Phượng','100055',3038,6),(3769,'Ngọc Thư Quân','102603',3038,6),(3770,'Quang Minh','100034',3038,6),(3771,'Tân Bảo Phương','102064',3038,6),(3772,'Thanh Thanh Tân','102543',3038,6),(3773,'CH KIM CHUNG','100048',3038,6),(3774,'CH Số 3','100046',3038,6),(3775,'LAN QUÍ','100052',3038,6),(3776,'My Loan ','100050',3038,6),(3777,'Ngọc Giàu','100051',3038,6),(3778,'Nguyễn Phước Chung','102602',3038,6),(3792,'Minh Nguyệt 01','100061',1,1);
/*!40000 ALTER TABLE `Distributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorAssessmentKeyOpportunity`
--

DROP TABLE IF EXISTS `DistributorAssessmentKeyOpportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorAssessmentKeyOpportunity` (
  `DistributorAssessmentKeyOpportunityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`DistributorAssessmentKeyOpportunityID`),
  KEY `FK_DistributorKeyOpp_Assessment` (`AssessmentCapacityID`),
  CONSTRAINT `FK_DistributorKeyOpp_Assessment` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorAssessmentKeyOpportunity`
--

LOCK TABLES `DistributorAssessmentKeyOpportunity` WRITE;
/*!40000 ALTER TABLE `DistributorAssessmentKeyOpportunity` DISABLE KEYS */;
INSERT INTO `DistributorAssessmentKeyOpportunity` VALUES (13,15,0,'Cai thien1'),(14,16,0,'fsef'),(15,17,0,'dfg'),(16,17,1,'hyjv'),(17,17,2,'rwy5drivp'),(18,18,0,'gfsrtdcfkuyku'),(19,18,1,'deqztytvbl'),(20,18,2,'kh,fsdt'),(21,19,0,'eeeeeeeeeeee'),(22,20,0,'eeeeeeee'),(23,23,0,'cải thiện 1'),(24,23,1,'cải thiện 2'),(25,23,2,'cải thiện 3'),(26,24,0,'aa'),(27,24,1,'eee'),(28,25,0,'fsea'),(29,25,1,'fase'),(30,25,2,'eafs');
/*!40000 ALTER TABLE `DistributorAssessmentKeyOpportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorAssessmentKeyStrength`
--

DROP TABLE IF EXISTS `DistributorAssessmentKeyStrength`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorAssessmentKeyStrength` (
  `DistributorAssessmentKeyStrengthID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`DistributorAssessmentKeyStrengthID`),
  KEY `FK_DistributorKeyStrength_Assessment` (`AssessmentCapacityID`),
  CONSTRAINT `FK_DistributorKeyStrength_Assessment` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorAssessmentKeyStrength`
--

LOCK TABLES `DistributorAssessmentKeyStrength` WRITE;
/*!40000 ALTER TABLE `DistributorAssessmentKeyStrength` DISABLE KEYS */;
INSERT INTO `DistributorAssessmentKeyStrength` VALUES (13,15,0,'Diem manh 1'),(14,15,1,'Diem manh 3'),(15,15,2,'Diem manh 3'),(16,16,0,'fsfse'),(17,17,0,'sdjd'),(18,17,1,'fdhfk.u'),(19,17,2,'fdtfikyv'),(20,18,0,'xccy'),(21,18,1,'fdygjkf'),(22,18,2,'dfjl'),(23,19,0,'fsefefe'),(24,19,1,'fesfa'),(25,19,2,'fsefesfe'),(26,20,0,'fefef'),(27,20,1,'aaaaa'),(28,23,0,'điểm mạnh 1'),(29,23,1,'điểm mạnh 2'),(30,23,2,'điểm mạnh 3'),(31,24,0,'eee'),(32,24,1,'ee'),(33,24,2,'aaa'),(34,25,0,'fsf'),(35,25,1,'afse'),(36,25,2,'fase');
/*!40000 ALTER TABLE `DistributorAssessmentKeyStrength` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityPlan`
--

DROP TABLE IF EXISTS `DistributorCapacityPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityPlan` (
  `DistributorCapacityPlanID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DistributorID` bigint(20) DEFAULT NULL,
  `OwnerUserID` bigint(20) NOT NULL,
  `PlanYear` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `ApprovedBy` bigint(20) DEFAULT NULL,
  `ApprovedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DistributorLevelRegisterID` bigint(20) NOT NULL,
  `DistributorUserID` bigint(20) NOT NULL,
  `Reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DistributorCapacityPlanID`),
  UNIQUE KEY `UQ_DistributorCapacityPlan` (`OwnerUserID`,`DistributorID`,`PlanYear`),
  KEY `FK_DistributorCapacityPlan_Distributor` (`DistributorID`),
  KEY `FK_DistributorCapacityPlan_Approve` (`ApprovedBy`),
  KEY `FK_DistributorCapacityPlan_DL` (`DistributorLevelRegisterID`),
  CONSTRAINT `FK_DistributorCapacityPlan_Approve` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_DL` FOREIGN KEY (`DistributorLevelRegisterID`) REFERENCES `DistributorLevel` (`DistributorLevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_Owner` FOREIGN KEY (`OwnerUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityPlan`
--

LOCK TABLES `DistributorCapacityPlan` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityPlan` DISABLE KEYS */;
INSERT INTO `DistributorCapacityPlan` VALUES (22,'Kế Hoạch Năm 2013',3612,3038,2013,3,'2013-09-16 09:10:59',NULL,3036,'2013-08-29 08:21:17',2,0,NULL),(25,'Kế Hoạch 2013 Liên Hương',3613,3038,2013,3,'2013-09-16 09:11:00',NULL,3037,'2013-08-30 02:02:23',1,0,NULL),(31,'SE',3614,3038,2013,3,'2013-09-16 09:11:00',NULL,3036,'2013-09-05 07:04:34',1,3058,NULL),(41,'Kế Hoạch Phát Triển Năng Lực NPP Năm 2013 - Tấn Phúc ',3747,3998,2013,3,'2013-09-16 12:38:25',NULL,3790,'2013-09-16 12:43:02',2,4000,NULL),(42,'Kế Hoạch Phát Triển Năng Lực NPP Năm 2013 - Tấn Phúc ',3747,3943,2013,3,'2013-09-16 12:38:25',NULL,3790,'2013-09-16 12:42:53',2,4000,NULL),(43,'Kế Hoạch Phát Triển Năng Lực NPP Năm 2013 - Tấn Phúc ',3747,3790,2013,3,'2013-09-16 12:38:25',NULL,3790,'2013-09-16 12:42:53',2,4000,NULL);
/*!40000 ALTER TABLE `DistributorCapacityPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityPlanAttendance`
--

DROP TABLE IF EXISTS `DistributorCapacityPlanAttendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityPlanAttendance` (
  `DistributorCapacityPlanAttendanceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorCapacityPlanID` bigint(20) NOT NULL,
  `AttendanceID` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`DistributorCapacityPlanAttendanceID`),
  UNIQUE KEY `UQ_DistributorCapacityPlanAttendance` (`DistributorCapacityPlanID`,`AttendanceID`),
  KEY `FK_DistributorCapacityPlanAttendance_User` (`AttendanceID`),
  CONSTRAINT `FK_DistributorCapacityPlanAttendance_DCP` FOREIGN KEY (`DistributorCapacityPlanID`) REFERENCES `DistributorCapacityPlan` (`DistributorCapacityPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlanAttendance_User` FOREIGN KEY (`AttendanceID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityPlanAttendance`
--

LOCK TABLES `DistributorCapacityPlanAttendance` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityPlanAttendance` DISABLE KEYS */;
INSERT INTO `DistributorCapacityPlanAttendance` VALUES (18,22,3038,'2013-08-29 09:40:27','2013-08-29 09:40:27'),(29,25,3037,'2013-08-30 02:05:15','2013-08-30 02:05:15'),(30,25,3038,'2013-08-30 02:05:15','2013-08-30 02:05:15'),(51,31,3037,'2013-09-05 07:03:34','2013-09-05 07:03:34'),(90,41,3998,'2013-09-16 12:38:45','2013-09-16 12:38:45');
/*!40000 ALTER TABLE `DistributorCapacityPlanAttendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityPlanDetail`
--

DROP TABLE IF EXISTS `DistributorCapacityPlanDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityPlanDetail` (
  `DistributorCapacityPlanDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorCapacityPlanID` bigint(20) NOT NULL,
  `Month` int(11) NOT NULL,
  PRIMARY KEY (`DistributorCapacityPlanDetailID`),
  UNIQUE KEY `UQ_DistributorCapacityPlanDetail` (`DistributorCapacityPlanID`,`Month`),
  CONSTRAINT `FK_DistributorCapacityPlanDetail_Plan` FOREIGN KEY (`DistributorCapacityPlanID`) REFERENCES `DistributorCapacityPlan` (`DistributorCapacityPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1682 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityPlanDetail`
--

LOCK TABLES `DistributorCapacityPlanDetail` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityPlanDetail` DISABLE KEYS */;
INSERT INTO `DistributorCapacityPlanDetail` VALUES (311,22,1),(312,22,2),(313,22,3),(314,22,4),(315,22,5),(316,22,6),(317,22,7),(318,22,8),(319,22,9),(320,22,10),(321,22,11),(322,22,12),(395,25,1),(396,25,2),(397,25,3),(398,25,4),(399,25,5),(400,25,6),(401,25,7),(402,25,8),(403,25,9),(404,25,10),(405,25,11),(406,25,12),(551,31,1),(552,31,2),(553,31,3),(554,31,4),(555,31,5),(556,31,6),(557,31,7),(558,31,8),(559,31,9),(560,31,10),(561,31,11),(562,31,12),(1646,41,1),(1647,41,2),(1648,41,3),(1649,41,4),(1650,41,5),(1651,41,6),(1652,41,7),(1653,41,8),(1654,41,9),(1655,41,10),(1656,41,11),(1657,41,12),(1658,42,1),(1659,42,2),(1660,42,3),(1661,42,4),(1662,42,5),(1663,42,6),(1664,42,7),(1665,42,8),(1666,42,9),(1667,42,10),(1668,42,11),(1669,42,12),(1670,43,1),(1671,43,2),(1672,43,3),(1673,43,4),(1674,43,5),(1675,43,6),(1676,43,7),(1677,43,8),(1678,43,9),(1679,43,10),(1680,43,11),(1681,43,12);
/*!40000 ALTER TABLE `DistributorCapacityPlanDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityPlanDetailKPI`
--

DROP TABLE IF EXISTS `DistributorCapacityPlanDetailKPI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityPlanDetailKPI` (
  `DistributorCapacityPlanDetailKPIID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorCapacityPlanDetailID` bigint(20) NOT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  `Score` float DEFAULT NULL,
  `Weight` float DEFAULT NULL,
  `LogisticCommitmentScore` float DEFAULT NULL,
  `ValueAddedCommitmentScore` float DEFAULT NULL,
  `StrategicCommitmentScore` float DEFAULT NULL,
  PRIMARY KEY (`DistributorCapacityPlanDetailKPIID`),
  UNIQUE KEY `UQ_DistributorCapacityPlanDetail` (`DistributorCapacityPlanDetailID`,`AssessmentKPIID`),
  KEY `FK_DistributorCapacityPlanDetailKPI_KPI` (`AssessmentKPIID`),
  CONSTRAINT `FK_DistributorCapacityPlanDetailKPI_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlanDetailKPI_Plan` FOREIGN KEY (`DistributorCapacityPlanDetailID`) REFERENCES `DistributorCapacityPlanDetail` (`DistributorCapacityPlanDetailID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13983 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityPlanDetailKPI`
--

LOCK TABLES `DistributorCapacityPlanDetailKPI` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityPlanDetailKPI` DISABLE KEYS */;
INSERT INTO `DistributorCapacityPlanDetailKPI` VALUES (1623,311,3,1,10,3,3,4),(1624,311,6,1,10,3,3,3),(1625,311,7,1,20,3,3,3),(1626,311,5,1,10,3,3,3),(1627,311,4,1,7.5,1,2,3),(1628,311,10,1,7.5,1,1,3),(1629,311,9,1,10,1,2,3),(1630,311,8,1,7.5,2,3,4),(1631,311,11,1,10,2,3,4),(1632,311,2,1,7.5,0,2,4),(1633,312,3,1,10,3,3,4),(1634,312,6,1,10,3,3,3),(1635,312,7,1,20,3,3,3),(1636,312,5,1,10,3,3,3),(1637,312,4,1,7.5,1,2,3),(1638,312,10,1,7.5,1,1,3),(1639,312,9,1,10,1,2,3),(1640,312,8,1,7.5,2,3,4),(1641,312,11,1,10,2,3,4),(1642,312,2,1,7.5,0,2,4),(1643,313,3,1,10,3,3,4),(1644,313,6,1,10,3,3,3),(1645,313,7,1,20,3,3,3),(1646,313,5,1,10,3,3,3),(1647,313,4,1,7.5,1,2,3),(1648,313,10,1,7.5,1,1,3),(1649,313,9,1,10,1,2,3),(1650,313,8,1,7.5,2,3,4),(1651,313,11,1,10,2,3,4),(1652,313,2,1,7.5,0,2,4),(1653,314,3,1,10,3,3,4),(1654,314,6,1,10,3,3,3),(1655,314,7,1,20,3,3,3),(1656,314,5,1,10,3,3,3),(1657,314,4,1,7.5,1,2,3),(1658,314,10,1,7.5,1,1,3),(1659,314,9,1,10,1,2,3),(1660,314,8,1,7.5,2,3,4),(1661,314,11,1,10,2,3,4),(1662,314,2,1,7.5,0,2,4),(1663,315,3,1,10,3,3,4),(1664,315,6,1,10,3,3,3),(1665,315,7,1,20,3,3,3),(1666,315,5,1,10,3,3,3),(1667,315,4,1,7.5,1,2,3),(1668,315,10,1,7.5,1,1,3),(1669,315,9,1,10,1,2,3),(1670,315,8,1,7.5,2,3,4),(1671,315,11,1,10,2,3,4),(1672,315,2,1,7.5,0,2,4),(1673,316,3,1,10,3,3,4),(1674,316,6,1,10,3,3,3),(1675,316,7,1,20,3,3,3),(1676,316,5,1,10,3,3,3),(1677,316,4,1,7.5,1,2,3),(1678,316,10,1,7.5,1,1,3),(1679,316,9,1,10,1,2,3),(1680,316,8,1,7.5,2,3,4),(1681,316,11,1,10,2,3,4),(1682,316,2,1,7.5,0,2,4),(1683,317,3,1,10,3,3,4),(1684,317,6,1,10,3,3,3),(1685,317,7,1,20,3,3,3),(1686,317,5,1,10,3,3,3),(1687,317,4,1,7.5,1,2,3),(1688,317,10,1,7.5,1,1,3),(1689,317,9,1,10,1,2,3),(1690,317,8,1,7.5,2,3,4),(1691,317,11,1,10,2,3,4),(1692,317,2,1,7.5,0,2,4),(1693,318,3,1,10,3,3,4),(1694,318,6,1,10,3,3,3),(1695,318,7,1,20,3,3,3),(1696,318,5,1,10,3,3,3),(1697,318,4,1,7.5,1,2,3),(1698,318,10,1,7.5,1,1,3),(1699,318,9,1,10,1,2,3),(1700,318,8,1,7.5,2,3,4),(1701,318,11,1,10,2,3,4),(1702,318,2,1,7.5,0,2,4),(1703,319,3,1,10,3,3,4),(1704,319,6,1,10,3,3,3),(1705,319,7,1,20,3,3,3),(1706,319,5,1,10,3,3,3),(1707,319,4,1,7.5,1,2,3),(1708,319,10,1,7.5,1,1,3),(1709,319,9,1,10,1,2,3),(1710,319,8,1,7.5,2,3,4),(1711,319,11,1,10,2,3,4),(1712,319,2,1,7.5,0,2,4),(1713,320,3,1,10,3,3,4),(1714,320,6,1,10,3,3,3),(1715,320,7,1,20,3,3,3),(1716,320,5,1,10,3,3,3),(1717,320,4,1,7.5,1,2,3),(1718,320,10,1,7.5,1,1,3),(1719,320,9,1,10,1,2,3),(1720,320,8,1,7.5,2,3,4),(1721,320,11,1,10,2,3,4),(1722,320,2,1,7.5,0,2,4),(1723,321,3,1,10,3,3,4),(1724,321,6,1,10,3,3,3),(1725,321,7,1,20,3,3,3),(1726,321,5,1,10,3,3,3),(1727,321,4,2,7.5,1,2,3),(1728,321,10,1,7.5,1,1,3),(1729,321,9,1,10,1,2,3),(1730,321,8,1,7.5,2,3,4),(1731,321,11,1,10,2,3,4),(1732,321,2,1,7.5,0,2,4),(1733,322,3,3,10,3,3,4),(1734,322,6,3,10,3,3,3),(1735,322,7,4,20,3,3,3),(1736,322,5,3,10,3,3,3),(1737,322,4,5,7.5,1,2,3),(1738,322,10,5,7.5,1,1,3),(1739,322,9,4,10,1,2,3),(1740,322,8,5,7.5,2,3,4),(1741,322,11,5,10,2,3,4),(1742,322,2,5,7.5,0,2,4),(1983,395,3,3,10,3,3,4),(1984,395,6,3,10,3,3,3),(1985,395,7,3,20,3,3,3),(1986,395,5,3,10,3,3,3),(1987,395,4,3,7.5,1,2,3),(1988,395,10,3,7.5,1,1,3),(1989,395,9,4,10,1,2,3),(1990,395,8,4,7.5,2,3,4),(1991,395,11,4,10,2,3,4),(1992,395,2,4,7.5,0,2,4),(1993,396,3,3,10,3,3,4),(1994,396,6,3,10,3,3,3),(1995,396,7,3,20,3,3,3),(1996,396,5,3,10,3,3,3),(1997,396,4,3,7.5,1,2,3),(1998,396,10,3,7.5,1,1,3),(1999,396,9,4,10,1,2,3),(2000,396,8,4,7.5,2,3,4),(2001,396,11,4,10,2,3,4),(2002,396,2,4,7.5,0,2,4),(2003,397,3,3,10,3,3,4),(2004,397,6,3,10,3,3,3),(2005,397,7,3,20,3,3,3),(2006,397,5,3,10,3,3,3),(2007,397,4,3,7.5,1,2,3),(2008,397,10,3,7.5,1,1,3),(2009,397,9,4,10,1,2,3),(2010,397,8,4,7.5,2,3,4),(2011,397,11,4,10,2,3,4),(2012,397,2,4,7.5,0,2,4),(2013,398,3,3,10,3,3,4),(2014,398,6,3,10,3,3,3),(2015,398,7,3,20,3,3,3),(2016,398,5,3,10,3,3,3),(2017,398,4,3,7.5,1,2,3),(2018,398,10,3,7.5,1,1,3),(2019,398,9,4,10,1,2,3),(2020,398,8,4,7.5,2,3,4),(2021,398,11,4,10,2,3,4),(2022,398,2,4,7.5,0,2,4),(2023,399,3,3,10,3,3,4),(2024,399,6,3,10,3,3,3),(2025,399,7,3,20,3,3,3),(2026,399,5,3,10,3,3,3),(2027,399,4,3,7.5,1,2,3),(2028,399,10,3,7.5,1,1,3),(2029,399,9,4,10,1,2,3),(2030,399,8,4,7.5,2,3,4),(2031,399,11,4,10,2,3,4),(2032,399,2,4,7.5,0,2,4),(2033,400,3,3,10,3,3,4),(2034,400,6,3,10,3,3,3),(2035,400,7,3,20,3,3,3),(2036,400,5,3,10,3,3,3),(2037,400,4,3,7.5,1,2,3),(2038,400,10,3,7.5,1,1,3),(2039,400,9,4,10,1,2,3),(2040,400,8,4,7.5,2,3,4),(2041,400,11,4,10,2,3,4),(2042,400,2,4,7.5,0,2,4),(2043,401,3,3,10,3,3,4),(2044,401,6,3,10,3,3,3),(2045,401,7,3,20,3,3,3),(2046,401,5,3,10,3,3,3),(2047,401,4,3,7.5,1,2,3),(2048,401,10,3,7.5,1,1,3),(2049,401,9,4,10,1,2,3),(2050,401,8,4,7.5,2,3,4),(2051,401,11,4,10,2,3,4),(2052,401,2,4,7.5,0,2,4),(2053,402,3,3,10,3,3,4),(2054,402,6,3,10,3,3,3),(2055,402,7,3,20,3,3,3),(2056,402,5,3,10,3,3,3),(2057,402,4,3,7.5,1,2,3),(2058,402,10,3,7.5,1,1,3),(2059,402,9,4,10,1,2,3),(2060,402,8,4,7.5,2,3,4),(2061,402,11,4,10,2,3,4),(2062,402,2,4,7.5,0,2,4),(2063,403,3,3,10,3,3,4),(2064,403,6,3,10,3,3,3),(2065,403,7,3,20,3,3,3),(2066,403,5,3,10,3,3,3),(2067,403,4,3,7.5,1,2,3),(2068,403,10,3,7.5,1,1,3),(2069,403,9,4,10,1,2,3),(2070,403,8,4,7.5,2,3,4),(2071,403,11,4,10,2,3,4),(2072,403,2,4,7.5,0,2,4),(2073,404,3,3,10,3,3,4),(2074,404,6,3,10,3,3,3),(2075,404,7,3,20,3,3,3),(2076,404,5,3,10,3,3,3),(2077,404,4,3,7.5,1,2,3),(2078,404,10,3,7.5,1,1,3),(2079,404,9,4,10,1,2,3),(2080,404,8,4,7.5,2,3,4),(2081,404,11,4,10,2,3,4),(2082,404,2,4,7.5,0,2,4),(2083,405,3,3,10,3,3,4),(2084,405,6,3,10,3,3,3),(2085,405,7,3,20,3,3,3),(2086,405,5,3,10,3,3,3),(2087,405,4,3,7.5,1,2,3),(2088,405,10,3,7.5,1,1,3),(2089,405,9,4,10,1,2,3),(2090,405,8,4,7.5,2,3,4),(2091,405,11,4,10,2,3,4),(2092,405,2,4,7.5,0,2,4),(2093,406,3,3,10,3,3,4),(2094,406,6,3,10,3,3,3),(2095,406,7,3,20,3,3,3),(2096,406,5,3,10,3,3,3),(2097,406,4,3,7.5,1,2,3),(2098,406,10,3,7.5,1,1,3),(2099,406,9,4,10,1,2,3),(2100,406,8,4,7.5,2,3,4),(2101,406,11,4,10,2,3,4),(2102,406,2,4,7.5,0,2,4),(3423,551,2,3,7.5,0,2,4),(3424,551,11,4,10,2,3,4),(3425,551,8,4,7.5,2,3,4),(3426,551,3,5,10,3,3,4),(3427,551,5,3,10,3,3,3),(3428,551,6,5,10,3,3,3),(3429,551,7,3,20,3,3,3),(3430,551,4,4,7.5,1,2,3),(3431,551,9,2,10,1,2,3),(3432,551,10,3,7.5,1,1,3),(3433,552,2,3,7.5,0,2,4),(3434,552,11,4,10,2,3,4),(3435,552,8,4,7.5,2,3,4),(3436,552,3,5,10,3,3,4),(3437,552,5,3,10,3,3,3),(3438,552,6,5,10,3,3,3),(3439,552,7,3,20,3,3,3),(3440,552,4,4,7.5,1,2,3),(3441,552,9,2,10,1,2,3),(3442,552,10,3,7.5,1,1,3),(3443,553,2,3,7.5,0,2,4),(3444,553,11,4,10,2,3,4),(3445,553,8,4,7.5,2,3,4),(3446,553,3,5,10,3,3,4),(3447,553,5,3,10,3,3,3),(3448,553,6,5,10,3,3,3),(3449,553,7,3,20,3,3,3),(3450,553,4,4,7.5,1,2,3),(3451,553,9,2,10,1,2,3),(3452,553,10,3,7.5,1,1,3),(3453,554,2,3,7.5,0,2,4),(3454,554,11,4,10,2,3,4),(3455,554,8,4,7.5,2,3,4),(3456,554,3,5,10,3,3,4),(3457,554,5,3,10,3,3,3),(3458,554,6,5,10,3,3,3),(3459,554,7,3,20,3,3,3),(3460,554,4,4,7.5,1,2,3),(3461,554,9,2,10,1,2,3),(3462,554,10,3,7.5,1,1,3),(3463,555,2,3,7.5,0,2,4),(3464,555,11,4,10,2,3,4),(3465,555,8,4,7.5,2,3,4),(3466,555,3,5,10,3,3,4),(3467,555,5,3,10,3,3,3),(3468,555,6,5,10,3,3,3),(3469,555,7,3,20,3,3,3),(3470,555,4,4,7.5,1,2,3),(3471,555,9,2,10,1,2,3),(3472,555,10,3,7.5,1,1,3),(3473,556,2,3,7.5,0,2,4),(3474,556,11,4,10,2,3,4),(3475,556,8,4,7.5,2,3,4),(3476,556,3,5,10,3,3,4),(3477,556,5,3,10,3,3,3),(3478,556,6,5,10,3,3,3),(3479,556,7,3,20,3,3,3),(3480,556,4,4,7.5,1,2,3),(3481,556,9,2,10,1,2,3),(3482,556,10,3,7.5,1,1,3),(3483,557,2,3,7.5,0,2,4),(3484,557,11,4,10,2,3,4),(3485,557,8,4,7.5,2,3,4),(3486,557,3,5,10,3,3,4),(3487,557,5,3,10,3,3,3),(3488,557,6,5,10,3,3,3),(3489,557,7,3,20,3,3,3),(3490,557,4,4,7.5,1,2,3),(3491,557,9,2,10,1,2,3),(3492,557,10,3,7.5,1,1,3),(3493,558,2,3,7.5,0,2,4),(3494,558,11,4,10,2,3,4),(3495,558,8,4,7.5,2,3,4),(3496,558,3,5,10,3,3,4),(3497,558,5,3,10,3,3,3),(3498,558,6,5,10,3,3,3),(3499,558,7,3,20,3,3,3),(3500,558,4,4,7.5,1,2,3),(3501,558,9,2,10,1,2,3),(3502,558,10,3,7.5,1,1,3),(3503,559,2,3,7.5,0,2,4),(3504,559,11,4,10,2,3,4),(3505,559,8,4,7.5,2,3,4),(3506,559,3,5,10,3,3,4),(3507,559,5,3,10,3,3,3),(3508,559,6,5,10,3,3,3),(3509,559,7,3,20,3,3,3),(3510,559,4,4,7.5,1,2,3),(3511,559,9,2,10,1,2,3),(3512,559,10,3,7.5,1,1,3),(3513,560,2,3,7.5,0,2,4),(3514,560,11,4,10,2,3,4),(3515,560,8,4,7.5,2,3,4),(3516,560,3,5,10,3,3,4),(3517,560,5,3,10,3,3,3),(3518,560,6,5,10,3,3,3),(3519,560,7,3,20,3,3,3),(3520,560,4,4,7.5,1,2,3),(3521,560,9,2,10,1,2,3),(3522,560,10,3,7.5,1,1,3),(3523,561,2,3,7.5,0,2,4),(3524,561,11,4,10,2,3,4),(3525,561,8,4,7.5,2,3,4),(3526,561,3,5,10,3,3,4),(3527,561,5,3,10,3,3,3),(3528,561,6,5,10,3,3,3),(3529,561,7,3,20,3,3,3),(3530,561,4,4,7.5,1,2,3),(3531,561,9,2,10,1,2,3),(3532,561,10,3,7.5,1,1,3),(3533,562,2,3,7.5,0,2,4),(3534,562,11,4,10,2,3,4),(3535,562,8,4,7.5,2,3,4),(3536,562,3,5,10,3,3,4),(3537,562,5,3,10,3,3,3),(3538,562,6,5,10,3,3,3),(3539,562,7,3,20,3,3,3),(3540,562,4,4,7.5,1,2,3),(3541,562,9,2,10,1,2,3),(3542,562,10,3,7.5,1,1,3),(13623,1646,2,1,7.5,0,2,4),(13624,1646,11,1,10,2,3,4),(13625,1646,8,3,7.5,2,3,4),(13626,1646,3,1,10,3,3,4),(13627,1646,5,2,10,3,3,3),(13628,1646,6,2,10,3,3,3),(13629,1646,7,1,20,3,3,3),(13630,1646,4,2,7.5,1,2,3),(13631,1646,9,1,10,1,2,3),(13632,1646,10,1,7.5,1,1,3),(13633,1647,2,1,7.5,0,2,4),(13634,1647,11,1,10,2,3,4),(13635,1647,8,3,7.5,2,3,4),(13636,1647,3,1,10,3,3,4),(13637,1647,5,2,10,3,3,3),(13638,1647,6,2,10,3,3,3),(13639,1647,7,1,20,3,3,3),(13640,1647,4,2,7.5,1,2,3),(13641,1647,9,1,10,1,2,3),(13642,1647,10,1,7.5,1,1,3),(13643,1648,2,1,7.5,0,2,4),(13644,1648,11,1,10,2,3,4),(13645,1648,8,3,7.5,2,3,4),(13646,1648,3,1,10,3,3,4),(13647,1648,5,2,10,3,3,3),(13648,1648,6,2,10,3,3,3),(13649,1648,7,1,20,3,3,3),(13650,1648,4,2,7.5,1,2,3),(13651,1648,9,1,10,1,2,3),(13652,1648,10,1,7.5,1,1,3),(13653,1649,2,2,7.5,0,2,4),(13654,1649,11,1,10,2,3,4),(13655,1649,8,3,7.5,2,3,4),(13656,1649,3,1,10,3,3,4),(13657,1649,5,2,10,3,3,3),(13658,1649,6,2,10,3,3,3),(13659,1649,7,1,20,3,3,3),(13660,1649,4,2,7.5,1,2,3),(13661,1649,9,2,10,1,2,3),(13662,1649,10,1,7.5,1,1,3),(13663,1650,2,2,7.5,0,2,4),(13664,1650,11,2,10,2,3,4),(13665,1650,8,3,7.5,2,3,4),(13666,1650,3,3,10,3,3,4),(13667,1650,5,3,10,3,3,3),(13668,1650,6,3,10,3,3,3),(13669,1650,7,1,20,3,3,3),(13670,1650,4,2,7.5,1,2,3),(13671,1650,9,2,10,1,2,3),(13672,1650,10,1,7.5,1,1,3),(13673,1651,2,2,7.5,0,2,4),(13674,1651,11,2,10,2,3,4),(13675,1651,8,3,7.5,2,3,4),(13676,1651,3,3,10,3,3,4),(13677,1651,5,3,10,3,3,3),(13678,1651,6,3,10,3,3,3),(13679,1651,7,3,20,3,3,3),(13680,1651,4,2,7.5,1,2,3),(13681,1651,9,2,10,1,2,3),(13682,1651,10,1,7.5,1,1,3),(13683,1652,2,2,7.5,0,2,4),(13684,1652,11,2,10,2,3,4),(13685,1652,8,3,7.5,2,3,4),(13686,1652,3,3,10,3,3,4),(13687,1652,5,3,10,3,3,3),(13688,1652,6,3,10,3,3,3),(13689,1652,7,3,20,3,3,3),(13690,1652,4,2,7.5,1,2,3),(13691,1652,9,2,10,1,2,3),(13692,1652,10,1,7.5,1,1,3),(13693,1653,2,2,7.5,0,2,4),(13694,1653,11,2,10,2,3,4),(13695,1653,8,3,7.5,2,3,4),(13696,1653,3,3,10,3,3,4),(13697,1653,5,3,10,3,3,3),(13698,1653,6,3,10,3,3,3),(13699,1653,7,3,20,3,3,3),(13700,1653,4,2,7.5,1,2,3),(13701,1653,9,2,10,1,2,3),(13702,1653,10,1,7.5,1,1,3),(13703,1654,2,2,7.5,0,2,4),(13704,1654,11,2,10,2,3,4),(13705,1654,8,3,7.5,2,3,4),(13706,1654,3,3,10,3,3,4),(13707,1654,5,3,10,3,3,3),(13708,1654,6,3,10,3,3,3),(13709,1654,7,3,20,3,3,3),(13710,1654,4,2,7.5,1,2,3),(13711,1654,9,2,10,1,2,3),(13712,1654,10,1,7.5,1,1,3),(13713,1655,2,2,7.5,0,2,4),(13714,1655,11,3,10,2,3,4),(13715,1655,8,3,7.5,2,3,4),(13716,1655,3,3,10,3,3,4),(13717,1655,5,3,10,3,3,3),(13718,1655,6,3,10,3,3,3),(13719,1655,7,3,20,3,3,3),(13720,1655,4,2,7.5,1,2,3),(13721,1655,9,2,10,1,2,3),(13722,1655,10,1,7.5,1,1,3),(13723,1656,2,2,7.5,0,2,4),(13724,1656,11,3,10,2,3,4),(13725,1656,8,3,7.5,2,3,4),(13726,1656,3,3,10,3,3,4),(13727,1656,5,3,10,3,3,3),(13728,1656,6,3,10,3,3,3),(13729,1656,7,3,20,3,3,3),(13730,1656,4,2,7.5,1,2,3),(13731,1656,9,2,10,1,2,3),(13732,1656,10,1,7.5,1,1,3),(13733,1657,2,2,7.5,0,2,4),(13734,1657,11,3,10,2,3,4),(13735,1657,8,3,7.5,2,3,4),(13736,1657,3,3,10,3,3,4),(13737,1657,5,3,10,3,3,3),(13738,1657,6,3,10,3,3,3),(13739,1657,7,3,20,3,3,3),(13740,1657,4,2,7.5,1,2,3),(13741,1657,9,2,10,1,2,3),(13742,1657,10,1,7.5,1,1,3),(13743,1658,2,1,7.5,0,2,4),(13744,1658,3,1,10,3,3,4),(13745,1658,4,2,7.5,1,2,3),(13746,1658,5,2,10,3,3,3),(13747,1658,6,2,10,3,3,3),(13748,1658,7,1,20,3,3,3),(13749,1658,8,3,7.5,2,3,4),(13750,1658,9,1,10,1,2,3),(13751,1658,10,1,7.5,1,1,3),(13752,1658,11,1,10,2,3,4),(13753,1659,2,1,7.5,0,2,4),(13754,1659,3,1,10,3,3,4),(13755,1659,4,2,7.5,1,2,3),(13756,1659,5,2,10,3,3,3),(13757,1659,6,2,10,3,3,3),(13758,1659,7,1,20,3,3,3),(13759,1659,8,3,7.5,2,3,4),(13760,1659,9,1,10,1,2,3),(13761,1659,10,1,7.5,1,1,3),(13762,1659,11,1,10,2,3,4),(13763,1660,2,1,7.5,0,2,4),(13764,1660,3,1,10,3,3,4),(13765,1660,4,2,7.5,1,2,3),(13766,1660,5,2,10,3,3,3),(13767,1660,6,2,10,3,3,3),(13768,1660,7,1,20,3,3,3),(13769,1660,8,3,7.5,2,3,4),(13770,1660,9,1,10,1,2,3),(13771,1660,10,1,7.5,1,1,3),(13772,1660,11,1,10,2,3,4),(13773,1661,2,2,7.5,0,2,4),(13774,1661,3,1,10,3,3,4),(13775,1661,4,2,7.5,1,2,3),(13776,1661,5,2,10,3,3,3),(13777,1661,6,2,10,3,3,3),(13778,1661,7,1,20,3,3,3),(13779,1661,8,3,7.5,2,3,4),(13780,1661,9,2,10,1,2,3),(13781,1661,10,1,7.5,1,1,3),(13782,1661,11,1,10,2,3,4),(13783,1662,2,2,7.5,0,2,4),(13784,1662,3,3,10,3,3,4),(13785,1662,4,2,7.5,1,2,3),(13786,1662,5,3,10,3,3,3),(13787,1662,6,3,10,3,3,3),(13788,1662,7,1,20,3,3,3),(13789,1662,8,3,7.5,2,3,4),(13790,1662,9,2,10,1,2,3),(13791,1662,10,1,7.5,1,1,3),(13792,1662,11,2,10,2,3,4),(13793,1663,2,2,7.5,0,2,4),(13794,1663,3,3,10,3,3,4),(13795,1663,4,2,7.5,1,2,3),(13796,1663,5,3,10,3,3,3),(13797,1663,6,3,10,3,3,3),(13798,1663,7,3,20,3,3,3),(13799,1663,8,3,7.5,2,3,4),(13800,1663,9,2,10,1,2,3),(13801,1663,10,1,7.5,1,1,3),(13802,1663,11,2,10,2,3,4),(13803,1664,2,2,7.5,0,2,4),(13804,1664,3,3,10,3,3,4),(13805,1664,4,2,7.5,1,2,3),(13806,1664,5,3,10,3,3,3),(13807,1664,6,3,10,3,3,3),(13808,1664,7,3,20,3,3,3),(13809,1664,8,3,7.5,2,3,4),(13810,1664,9,2,10,1,2,3),(13811,1664,10,1,7.5,1,1,3),(13812,1664,11,2,10,2,3,4),(13813,1665,2,2,7.5,0,2,4),(13814,1665,3,3,10,3,3,4),(13815,1665,4,2,7.5,1,2,3),(13816,1665,5,3,10,3,3,3),(13817,1665,6,3,10,3,3,3),(13818,1665,7,3,20,3,3,3),(13819,1665,8,3,7.5,2,3,4),(13820,1665,9,2,10,1,2,3),(13821,1665,10,1,7.5,1,1,3),(13822,1665,11,2,10,2,3,4),(13823,1666,2,2,7.5,0,2,4),(13824,1666,3,3,10,3,3,4),(13825,1666,4,2,7.5,1,2,3),(13826,1666,5,3,10,3,3,3),(13827,1666,6,3,10,3,3,3),(13828,1666,7,3,20,3,3,3),(13829,1666,8,3,7.5,2,3,4),(13830,1666,9,2,10,1,2,3),(13831,1666,10,1,7.5,1,1,3),(13832,1666,11,2,10,2,3,4),(13833,1667,2,2,7.5,0,2,4),(13834,1667,3,3,10,3,3,4),(13835,1667,4,2,7.5,1,2,3),(13836,1667,5,3,10,3,3,3),(13837,1667,6,3,10,3,3,3),(13838,1667,7,3,20,3,3,3),(13839,1667,8,3,7.5,2,3,4),(13840,1667,9,2,10,1,2,3),(13841,1667,10,1,7.5,1,1,3),(13842,1667,11,3,10,2,3,4),(13843,1668,2,2,7.5,0,2,4),(13844,1668,3,3,10,3,3,4),(13845,1668,4,2,7.5,1,2,3),(13846,1668,5,3,10,3,3,3),(13847,1668,6,3,10,3,3,3),(13848,1668,7,3,20,3,3,3),(13849,1668,8,3,7.5,2,3,4),(13850,1668,9,2,10,1,2,3),(13851,1668,10,1,7.5,1,1,3),(13852,1668,11,3,10,2,3,4),(13853,1669,2,2,7.5,0,2,4),(13854,1669,3,3,10,3,3,4),(13855,1669,4,2,7.5,1,2,3),(13856,1669,5,3,10,3,3,3),(13857,1669,6,3,10,3,3,3),(13858,1669,7,3,20,3,3,3),(13859,1669,8,3,7.5,2,3,4),(13860,1669,9,2,10,1,2,3),(13861,1669,10,1,7.5,1,1,3),(13862,1669,11,3,10,2,3,4),(13863,1670,2,1,7.5,0,2,4),(13864,1670,3,1,10,3,3,4),(13865,1670,4,2,7.5,1,2,3),(13866,1670,5,2,10,3,3,3),(13867,1670,6,2,10,3,3,3),(13868,1670,7,1,20,3,3,3),(13869,1670,8,3,7.5,2,3,4),(13870,1670,9,1,10,1,2,3),(13871,1670,10,1,7.5,1,1,3),(13872,1670,11,1,10,2,3,4),(13873,1671,2,1,7.5,0,2,4),(13874,1671,3,1,10,3,3,4),(13875,1671,4,2,7.5,1,2,3),(13876,1671,5,2,10,3,3,3),(13877,1671,6,2,10,3,3,3),(13878,1671,7,1,20,3,3,3),(13879,1671,8,3,7.5,2,3,4),(13880,1671,9,1,10,1,2,3),(13881,1671,10,1,7.5,1,1,3),(13882,1671,11,1,10,2,3,4),(13883,1672,2,1,7.5,0,2,4),(13884,1672,3,1,10,3,3,4),(13885,1672,4,2,7.5,1,2,3),(13886,1672,5,2,10,3,3,3),(13887,1672,6,2,10,3,3,3),(13888,1672,7,1,20,3,3,3),(13889,1672,8,3,7.5,2,3,4),(13890,1672,9,1,10,1,2,3),(13891,1672,10,1,7.5,1,1,3),(13892,1672,11,1,10,2,3,4),(13893,1673,2,2,7.5,0,2,4),(13894,1673,3,1,10,3,3,4),(13895,1673,4,2,7.5,1,2,3),(13896,1673,5,2,10,3,3,3),(13897,1673,6,2,10,3,3,3),(13898,1673,7,1,20,3,3,3),(13899,1673,8,3,7.5,2,3,4),(13900,1673,9,2,10,1,2,3),(13901,1673,10,1,7.5,1,1,3),(13902,1673,11,1,10,2,3,4),(13903,1674,2,2,7.5,0,2,4),(13904,1674,3,3,10,3,3,4),(13905,1674,4,2,7.5,1,2,3),(13906,1674,5,3,10,3,3,3),(13907,1674,6,3,10,3,3,3),(13908,1674,7,1,20,3,3,3),(13909,1674,8,3,7.5,2,3,4),(13910,1674,9,2,10,1,2,3),(13911,1674,10,1,7.5,1,1,3),(13912,1674,11,2,10,2,3,4),(13913,1675,2,2,7.5,0,2,4),(13914,1675,3,3,10,3,3,4),(13915,1675,4,2,7.5,1,2,3),(13916,1675,5,3,10,3,3,3),(13917,1675,6,3,10,3,3,3),(13918,1675,7,3,20,3,3,3),(13919,1675,8,3,7.5,2,3,4),(13920,1675,9,2,10,1,2,3),(13921,1675,10,1,7.5,1,1,3),(13922,1675,11,2,10,2,3,4),(13923,1676,2,2,7.5,0,2,4),(13924,1676,3,3,10,3,3,4),(13925,1676,4,2,7.5,1,2,3),(13926,1676,5,3,10,3,3,3),(13927,1676,6,3,10,3,3,3),(13928,1676,7,3,20,3,3,3),(13929,1676,8,3,7.5,2,3,4),(13930,1676,9,2,10,1,2,3),(13931,1676,10,1,7.5,1,1,3),(13932,1676,11,2,10,2,3,4),(13933,1677,2,2,7.5,0,2,4),(13934,1677,3,3,10,3,3,4),(13935,1677,4,2,7.5,1,2,3),(13936,1677,5,3,10,3,3,3),(13937,1677,6,3,10,3,3,3),(13938,1677,7,3,20,3,3,3),(13939,1677,8,3,7.5,2,3,4),(13940,1677,9,2,10,1,2,3),(13941,1677,10,1,7.5,1,1,3),(13942,1677,11,2,10,2,3,4),(13943,1678,2,2,7.5,0,2,4),(13944,1678,3,3,10,3,3,4),(13945,1678,4,2,7.5,1,2,3),(13946,1678,5,3,10,3,3,3),(13947,1678,6,3,10,3,3,3),(13948,1678,7,3,20,3,3,3),(13949,1678,8,3,7.5,2,3,4),(13950,1678,9,2,10,1,2,3),(13951,1678,10,1,7.5,1,1,3),(13952,1678,11,2,10,2,3,4),(13953,1679,2,2,7.5,0,2,4),(13954,1679,3,3,10,3,3,4),(13955,1679,4,2,7.5,1,2,3),(13956,1679,5,3,10,3,3,3),(13957,1679,6,3,10,3,3,3),(13958,1679,7,3,20,3,3,3),(13959,1679,8,3,7.5,2,3,4),(13960,1679,9,2,10,1,2,3),(13961,1679,10,1,7.5,1,1,3),(13962,1679,11,3,10,2,3,4),(13963,1680,2,2,7.5,0,2,4),(13964,1680,3,3,10,3,3,4),(13965,1680,4,2,7.5,1,2,3),(13966,1680,5,3,10,3,3,3),(13967,1680,6,3,10,3,3,3),(13968,1680,7,3,20,3,3,3),(13969,1680,8,3,7.5,2,3,4),(13970,1680,9,2,10,1,2,3),(13971,1680,10,1,7.5,1,1,3),(13972,1680,11,3,10,2,3,4),(13973,1681,2,2,7.5,0,2,4),(13974,1681,3,3,10,3,3,4),(13975,1681,4,2,7.5,1,2,3),(13976,1681,5,3,10,3,3,3),(13977,1681,6,3,10,3,3,3),(13978,1681,7,3,20,3,3,3),(13979,1681,8,3,7.5,2,3,4),(13980,1681,9,2,10,1,2,3),(13981,1681,10,1,7.5,1,1,3),(13982,1681,11,3,10,2,3,4);
/*!40000 ALTER TABLE `DistributorCapacityPlanDetailKPI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityTarget`
--

DROP TABLE IF EXISTS `DistributorCapacityTarget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityTarget` (
  `DistributorCapacityTargetID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Year` int(11) NOT NULL,
  `Month` int(11) NOT NULL,
  `DistributorID` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`DistributorCapacityTargetID`),
  UNIQUE KEY `UQ_DistributorCapacityTarget` (`DistributorID`,`Year`,`Month`),
  CONSTRAINT `FK_DistributorCapacityTarget_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityTarget`
--

LOCK TABLES `DistributorCapacityTarget` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityTarget` DISABLE KEYS */;
INSERT INTO `DistributorCapacityTarget` VALUES (15,'Chi tieu thang 9',2013,9,3612,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(16,'Lập chỉ tiêu cho kỳ $8',2013,9,3611,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(17,'Lập chỉ tiêu cho kỳ $7',2013,8,3747,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(18,'Lập chỉ tiêu cho kỳ $8',2013,9,3747,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(19,'Lập chỉ tiêu cho kỳ $9 - HƯNG THỊNH',2013,10,3612,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(20,'Lập chỉ tiêu cho kỳ $10 - HƯNG THỊNH',2013,11,3612,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(21,'Lập chỉ tiêu cho kỳ $11 - HƯNG THỊNH',2013,12,3612,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(22,'Lập chỉ tiêu cho kỳ $12 - HƯNG THỊNH',2014,1,3612,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(23,'Lập chỉ tiêu cho kỳ 1 - HƯNG THỊNH',2013,2,3612,'2013-09-12 04:50:49','2013-09-12 04:50:58');
/*!40000 ALTER TABLE `DistributorCapacityTarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorCapacityTargetDetail`
--

DROP TABLE IF EXISTS `DistributorCapacityTargetDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorCapacityTargetDetail` (
  `DistributorCapacityTargetDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorCapacityTargetID` bigint(20) NOT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  `Score` float DEFAULT NULL,
  `Weight` float DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`DistributorCapacityTargetDetailID`),
  UNIQUE KEY `UQ_DistributorCapacityTargetDetail` (`DistributorCapacityTargetID`,`AssessmentKPIID`),
  KEY `FK_TargetDetail_KPI` (`AssessmentKPIID`),
  CONSTRAINT `FK_TargetDetail_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TargetDetail_Target` FOREIGN KEY (`DistributorCapacityTargetID`) REFERENCES `DistributorCapacityTarget` (`DistributorCapacityTargetID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorCapacityTargetDetail`
--

LOCK TABLES `DistributorCapacityTargetDetail` WRITE;
/*!40000 ALTER TABLE `DistributorCapacityTargetDetail` DISABLE KEYS */;
INSERT INTO `DistributorCapacityTargetDetail` VALUES (111,15,2,4,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(112,15,3,1,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(113,15,4,3,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(114,15,5,2,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(115,15,6,2,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(116,15,7,3,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(117,15,8,3,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(118,15,9,1,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(119,15,10,3,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(120,15,11,2,NULL,'2013-09-05 03:48:39','2013-09-05 03:48:41'),(121,16,2,2,NULL,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(122,16,3,1,NULL,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(123,16,5,1,NULL,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(124,16,8,3,NULL,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(125,16,11,2,NULL,'2013-09-06 05:49:02','2013-09-06 05:49:05'),(126,17,2,1,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(127,17,3,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(128,17,4,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(129,17,5,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(130,17,6,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(131,17,7,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(132,17,8,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(133,17,9,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(134,17,10,1,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(135,17,11,2,NULL,'2013-09-06 08:02:29','2013-09-06 08:02:43'),(136,18,2,1,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(137,18,3,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(138,18,4,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(139,18,5,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(140,18,6,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(141,18,7,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(142,18,8,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(143,18,9,2,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(144,18,10,1,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(145,18,11,3,NULL,'2013-09-06 08:12:50','2013-09-06 08:13:05'),(146,19,2,3,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(147,19,3,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(148,19,4,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(149,19,5,4,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(150,19,6,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(151,19,7,3,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(152,19,8,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(153,19,9,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(154,19,10,2,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(155,19,11,3,NULL,'2013-09-06 11:29:39','2013-09-06 11:29:42'),(156,20,2,2,NULL,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(157,20,3,2,NULL,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(158,20,5,1,NULL,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(159,20,8,5,NULL,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(160,20,11,2,NULL,'2013-09-06 11:35:45','2013-09-06 11:35:47'),(161,21,2,2,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(162,21,3,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(163,21,4,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(164,21,5,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(165,21,6,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(166,21,7,5,NULL,'2013-09-10 10:58:38','2013-09-10 10:37:55'),(167,21,8,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(168,21,9,3,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(169,21,10,4,NULL,'2013-09-10 10:37:48','2013-09-10 10:37:55'),(170,21,11,5,NULL,'2013-09-10 10:58:46','2013-09-10 10:37:55'),(171,22,2,4,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(172,22,3,5,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(173,22,4,4,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(174,22,5,4,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(175,22,6,4,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(176,22,8,5,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(177,22,9,3,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(178,22,10,3,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(179,22,11,5,NULL,'2013-09-10 11:03:37','2013-09-10 11:03:44'),(180,23,2,3,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(181,23,3,2,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(182,23,4,2,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(183,23,5,3,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(184,23,6,3,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(185,23,7,3,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(186,23,8,2,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:58'),(187,23,9,2,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:59'),(188,23,10,4,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:59'),(189,23,11,3,NULL,'2013-09-12 04:50:49','2013-09-12 04:50:59');
/*!40000 ALTER TABLE `DistributorCapacityTargetDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorLevel`
--

DROP TABLE IF EXISTS `DistributorLevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorLevel` (
  `DistributorLevelID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`DistributorLevelID`),
  UNIQUE KEY `UQ_DistributorLevel` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorLevel`
--

LOCK TABLES `DistributorLevel` WRITE;
/*!40000 ALTER TABLE `DistributorLevel` DISABLE KEYS */;
INSERT INTO `DistributorLevel` VALUES (1,'Logistic','Lowest Level','2013-08-14 23:49:13','2013-08-15 00:25:54'),(2,'Value Added','Normal Level','2013-08-14 23:49:34',NULL),(3,'Strategic','Highest Level','2013-08-14 23:49:52',NULL);
/*!40000 ALTER TABLE `DistributorLevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorPerformanceAttribute`
--

DROP TABLE IF EXISTS `DistributorPerformanceAttribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorPerformanceAttribute` (
  `DistributorPerformanceAttributeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Field` varchar(255) NOT NULL,
  `Label` varchar(255) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`DistributorPerformanceAttributeID`),
  UNIQUE KEY `UQ_PerformanceAttribute` (`Field`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorPerformanceAttribute`
--

LOCK TABLES `DistributorPerformanceAttribute` WRITE;
/*!40000 ALTER TABLE `DistributorPerformanceAttribute` DISABLE KEYS */;
INSERT INTO `DistributorPerformanceAttribute` VALUES (8,'S1','S1',1),(9,'S2','S2',2),(10,'S3','S3',3),(11,'S4','S4',4),(12,'ROI','%ROI',5);
/*!40000 ALTER TABLE `DistributorPerformanceAttribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorPerformanceDetail`
--

DROP TABLE IF EXISTS `DistributorPerformanceDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorPerformanceDetail` (
  `DistributorPerformanceDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssessmentCapacityID` bigint(20) NOT NULL,
  `DistributorPerformanceAttributeID` bigint(20) NOT NULL,
  `Value` float DEFAULT NULL,
  PRIMARY KEY (`DistributorPerformanceDetailID`),
  UNIQUE KEY `UQ_DistributorPerformanceDetail` (`AssessmentCapacityID`,`DistributorPerformanceAttributeID`),
  KEY `FK_DistributorPerformanceDetail_PerformAtt` (`DistributorPerformanceAttributeID`),
  CONSTRAINT `FK_DistributorPerformanceDetail_Assessment` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorPerformanceDetail_PerformAtt` FOREIGN KEY (`DistributorPerformanceAttributeID`) REFERENCES `DistributorPerformanceAttribute` (`DistributorPerformanceAttributeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorPerformanceDetail`
--

LOCK TABLES `DistributorPerformanceDetail` WRITE;
/*!40000 ALTER TABLE `DistributorPerformanceDetail` DISABLE KEYS */;
INSERT INTO `DistributorPerformanceDetail` VALUES (6,15,8,3),(7,15,9,2),(8,15,10,3),(9,15,11,2),(10,15,12,1),(11,16,8,4),(12,16,9,4),(13,16,10,4),(14,16,11,2),(15,16,12,4),(16,17,8,20),(17,17,9,14),(18,17,10,12345),(19,17,11,321),(20,17,12,2),(21,18,8,21),(22,18,9,14.5),(23,18,10,15435),(24,18,11,344),(25,18,12,2),(26,19,8,3),(27,19,9,4),(28,19,10,4),(29,19,11,3),(30,19,12,4),(31,20,8,3),(32,20,9,4),(33,20,10,4),(34,20,11,5),(35,20,12,4),(36,23,8,3),(37,23,9,4),(38,23,10,4),(39,23,11,5),(40,23,12,6),(41,24,8,3),(42,24,9,5),(43,24,10,5),(44,24,11,4),(45,24,12,5),(46,25,8,4),(47,25,9,5),(48,25,10,6),(49,25,11,4),(50,25,12,5);
/*!40000 ALTER TABLE `DistributorPerformanceDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributorPerformanceTargetDetail`
--

DROP TABLE IF EXISTS `DistributorPerformanceTargetDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributorPerformanceTargetDetail` (
  `DistributorPerformanceTargetDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorCapacityTargetID` bigint(20) NOT NULL,
  `DistributorPerformanceAttributeID` bigint(20) NOT NULL,
  `Value` float DEFAULT NULL,
  PRIMARY KEY (`DistributorPerformanceTargetDetailID`),
  UNIQUE KEY `UQ_DistributorPerformanceTargetDetail` (`DistributorCapacityTargetID`,`DistributorPerformanceAttributeID`),
  KEY `FK_DistributorPerformanceTargetDetail_PerformAtt` (`DistributorPerformanceAttributeID`),
  CONSTRAINT `FK_DistributorPerformanceTargetDetail_Assessment` FOREIGN KEY (`DistributorCapacityTargetID`) REFERENCES `DistributorCapacityTarget` (`DistributorCapacityTargetID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorPerformanceTargetDetail_PerformAtt` FOREIGN KEY (`DistributorPerformanceAttributeID`) REFERENCES `DistributorPerformanceAttribute` (`DistributorPerformanceAttributeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributorPerformanceTargetDetail`
--

LOCK TABLES `DistributorPerformanceTargetDetail` WRITE;
/*!40000 ALTER TABLE `DistributorPerformanceTargetDetail` DISABLE KEYS */;
INSERT INTO `DistributorPerformanceTargetDetail` VALUES (6,15,8,32),(7,15,9,4),(8,15,10,3),(9,15,11,3),(10,15,12,4),(11,16,8,5),(12,16,9,5),(13,16,10,3),(14,16,11,4),(15,16,12,5),(16,17,8,21),(17,17,9,14.5),(18,17,10,13452),(19,17,11,322),(20,17,12,2),(21,18,8,21.5),(22,18,9,15),(23,18,10,14000),(24,18,11,325),(25,18,12,2),(26,19,8,4),(27,19,9,4),(28,19,10,4),(29,19,11,4),(30,19,12,5),(31,20,8,4),(32,20,9,3),(33,20,10,5),(34,20,11,4),(35,20,12,4),(36,21,8,4),(37,21,9,4),(38,21,10,3),(39,21,11,8),(40,21,12,8),(41,22,8,4),(42,22,9,4),(43,22,10,6),(44,22,11,6),(45,22,12,5),(46,23,8,4),(47,23,9,5),(48,23,10,5),(49,23,11,5),(50,23,12,5);
/*!40000 ALTER TABLE `DistributorPerformanceTargetDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `District`
--

DROP TABLE IF EXISTS `District`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `District` (
  `DistrictID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`DistrictID`),
  KEY `FK_District_Region` (`RegionID`),
  CONSTRAINT `FK_District_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `District`
--

LOCK TABLES `District` WRITE;
/*!40000 ALTER TABLE `District` DISABLE KEYS */;
INSERT INTO `District` VALUES (3992,'Quận 1',1),(3993,'Quận 2',1),(3994,'Quận 3',1),(3995,'Quận 4',1),(3996,'Quận 5',1),(3997,'Quận 6',1),(3998,'Quận 7',1),(3999,'Quận 8',1),(4000,'Quận 9',1),(4001,'Quận 10',1),(4002,'Quận 11',1),(4003,'Quận 12',1),(4004,'Quận Bình Thạnh',1),(4005,'Quận Nhà Bè',1),(4006,'Quận Hóc Môn',1),(4007,'Quận Thủ Đức',1),(4008,'Quận Gò Vấp',1),(4009,'Quận 1',2),(4010,'Quận 2',2),(4011,'Quận 3',2),(4012,'Quận 4',2),(4013,'Quận 5',2),(4014,'Quận 6',2),(4015,'Quận 7',2),(4016,'Quận 8',2),(4017,'Quận 9',2),(4018,'Quận 10',2),(4019,'Quận 11',2),(4020,'Quận 12',2),(4021,'Quận Nội Thành',2),(4022,'Quận Ngoại Thành',2),(4023,'Quận Xa Xa',2),(4024,'Quận Trường Xa',2),(4025,'Quận Hoàng Xa',2),(4026,'Quận Bãi Tắm',2),(4027,'Ba đình',3),(4028,'Thanh Xuân',3),(4029,'Phố Huế',3),(4030,'Chợ cũ',3),(4031,'Hồ gươm',3),(4032,'Nhà tôi',3),(4033,'Đâu đó',3),(4034,'Kia kìa',3),(4035,'Hay nhỉ',3),(4036,'Lạ ghê',3),(4037,'Quận 1',4),(4038,'Quận 2',4),(4039,'Quận 3',4),(4040,'Quận 4',4),(4041,'Quận 5',4),(4042,'Quận 6',4),(4043,'Quận 7',4),(4044,'Quận 8',4),(4045,'Quận 9',4),(4046,'Quận 10',4),(4047,'Quận 11',4),(4048,'Quận 12',4),(4049,'Quận Nội Thành',4),(4050,'Quận Ngoại Thành',4),(4051,'Quận Xa Xa',4),(4052,'Quận Trường Xa',4),(4053,'Quận Hoàng Xa',4),(4054,'Quận Bãi Tắm',4),(4055,'Quận 1',5),(4056,'Quận 2',5),(4057,'Quận 3',5),(4058,'Quận 4',5),(4059,'Quận 5',5),(4060,'Quận 6',5),(4061,'Quận 7',5),(4062,'Quận 8',5),(4063,'Quận 9',5),(4064,'Quận 10',5),(4065,'Quận 11',5),(4066,'Quận 12',5),(4067,'Quận Nội Thành',5),(4068,'Quận Ngoại Thành',5),(4069,'Quận Xa Xa',5),(4070,'Quận Trường Xa',5),(4071,'Quận Hoàng Xa',5),(4072,'Quận Bãi Tắm',5),(4073,'Quận 1',6),(4074,'Quận 2',6),(4075,'Quận 3',6),(4076,'Quận 4',6),(4077,'Quận 5',6),(4078,'Quận 6',6),(4079,'Quận 7',6),(4080,'Quận 8',6),(4081,'Quận 9',6),(4082,'Quận 10',6),(4083,'Quận 11',6),(4084,'Quận 12',6),(4085,'Quận Nội Thành',6),(4086,'Quận Ngoại Thành',6),(4087,'Quận Xa Xa',6),(4088,'Quận Trường Xa',6),(4089,'Quận Hoàng Xa',6),(4090,'Quận Bãi Tắm',6),(4091,'Quận 1',7),(4092,'Quận 2',7),(4093,'Quận 3',7),(4094,'Quận 4',7),(4095,'Quận 5',7),(4096,'Quận 6',7),(4097,'Quận 7',7),(4098,'Quận 8',7),(4099,'Quận 9',7),(4100,'Quận 10',7),(4101,'Quận 11',7),(4102,'Quận 12',7),(4103,'Quận Nội Thành',7),(4104,'Quận Ngoại Thành',7),(4105,'Quận Xa Xa',7),(4106,'Quận Trường Xa',7),(4107,'Quận Hoàng Xa',7),(4108,'Quận Bãi Tắm',7),(4109,'Quận 3',3),(4110,'Quận 4',3),(4111,'Quận 5',3),(4112,'Quận 6',3),(4113,'Quận 2',3);
/*!40000 ALTER TABLE `District` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FullRangeSKU`
--

DROP TABLE IF EXISTS `FullRangeSKU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FullRangeSKU` (
  `FullRangeSKUID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletBrandID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  `Ratio` int(11) NOT NULL DEFAULT '1',
  `PowerSKUID` bigint(20) DEFAULT NULL,
  `Subbrand` bigint(11) DEFAULT NULL,
  `Mensural` int(11) DEFAULT NULL,
  PRIMARY KEY (`FullRangeSKUID`),
  UNIQUE KEY `UQ_FullRangeSKU` (`Subbrand`,`Name`,`Mensural`),
  KEY `FK_FullRangeSKU_OBrand` (`OutletBrandID`),
  KEY `FK_FullRange_PowerSKU` (`PowerSKUID`),
  CONSTRAINT `FK_FullRangeSKU_OBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_FullRange_PowerSKU` FOREIGN KEY (`PowerSKUID`) REFERENCES `PowerSKU` (`PowerSKUID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fullrangesku_ibfk_1` FOREIGN KEY (`Subbrand`) REFERENCES `SubFullRangeBrand` (`SubFullRangeBrandID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FullRangeSKU`
--

LOCK TABLES `FullRangeSKU` WRITE;
/*!40000 ALTER TABLE `FullRangeSKU` DISABLE KEYS */;
INSERT INTO `FullRangeSKU` VALUES (1,1,'Friso Gold Mum 900g',9,1,1,1,2),(2,1,'Friso Gold 1 900g',11,1,2,2,2),(3,1,'Friso Gold 2 900g',14,1,3,3,2),(4,1,'Friso Gold 3 900g',16,1,4,4,2),(5,1,'Friso Gold 4 900g',18,1,10,5,2),(7,2,'Dutch Lady Regular Step 1 900g',5,1,6,10,2),(8,2,'Dutch Lady Regular Step 2 900g',8,1,7,11,2),(9,2,'Dutch Lady Regular 123 900g',11,1,9,12,2),(10,2,'Dutch Lady Regular 456 900g',17,1,8,13,2),(11,1,'Friso Gold 4 1500g',19,1,10,5,3),(12,1,'Friso Gold Mum 400g',8,2,1,1,1),(13,1,'Friso Gold 1 400g',10,2,2,2,1),(14,1,'Friso Gold 2 400g',13,2,3,3,1),(15,1,'Friso Gold 3 1500g',17,1,4,4,3),(16,1,'Friso Gold 3 400g',15,2,4,4,1),(17,2,'Dutch Lady Gold 1 400g',19,2,6,14,1),(18,2,'Dutch Lady Gold 1 900g',20,1,6,14,2),(19,2,'Dutch Lady Gold 2 400g',21,2,7,15,1),(20,2,'Dutch Lady Gold 2 900g',22,1,7,15,2),(21,2,'Dutch Lady Gold 123 400g',23,2,9,16,1),(22,2,'Dutch Lady Gold 123 900g',24,1,9,16,2),(23,2,'Dutch Lady Gold 123 1500g',25,1,9,16,3),(24,2,'Dutch Lady Gold 456 400g',26,2,8,17,1),(25,2,'Dutch Lady Gold 456 900g',27,1,8,17,2),(26,2,'Dutch Lady Gold 456 1500g',28,1,8,17,3),(27,1,'Friso Regular 1 400g',1,2,NULL,6,1),(28,1,'Friso Regular 1 900g',2,1,NULL,6,2),(29,1,'Friso Regular 2 900g',4,1,NULL,7,2),(30,1,'Friso Regular 3 900g',5,1,NULL,8,2),(31,1,'Friso Regular 3 1500g',6,1,NULL,8,3),(32,1,'Friso Regular 2 400g',3,2,NULL,7,1),(33,1,'Friso Regular 4 900g',7,1,NULL,9,2),(34,2,'Dutch Lady Regular Mum 900g',2,1,5,18,2),(35,2,'Dutch Lady Regular Step 1G 400g',3,2,6,19,1),(36,2,'Dutch Lady Regular Step 1 400g',4,2,6,10,1),(37,2,'Dutch Lady Regular Step 2G 400g',6,2,7,20,1),(38,2,'Dutch Lady Regular Step 2 400g',7,2,7,11,1),(39,2,'Dutch Lady Regular 123 400g',10,2,9,12,1),(40,2,'Dutch Lady Regular 456G 400g',15,2,8,22,1),(41,2,'Dutch Lady Regular 456 1500g',18,1,8,13,3),(42,2,'Dutch Lady Regular Mum 400g',1,2,5,18,1),(43,2,'Dutch Lady Regular 456 400g',16,2,8,13,1),(44,2,'Dutch Lady Regular 123 1500g',12,1,9,12,3),(45,2,'Dutch Lady Regular 123G 400g',9,2,9,21,1),(46,2,'Dutch Lady Complete 400g',13,2,12,23,1),(47,2,'Dutch Lady Complete 900g',14,1,12,23,2),(48,3,'DL UHT 180',1,1,13,24,0),(49,3,'DL UHT 110',2,1,14,25,0),(50,3,'Yomost 170',3,1,15,26,0),(51,3,'Yomost 110',4,1,16,27,0),(52,3,'DKY 110',5,1,17,28,0),(53,3,'Fristi',6,1,19,29,0),(54,3,'Sua Ðac',7,1,18,30,0);
/*!40000 ALTER TABLE `FullRangeSKU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GlobalDayOff`
--

DROP TABLE IF EXISTS `GlobalDayOff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GlobalDayOff` (
  `GlobalDayOffID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Year` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `DayOfWeek` int(11) DEFAULT NULL,
  `DayOfMonth` int(11) DEFAULT NULL,
  `MonthOfYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`GlobalDayOffID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GlobalDayOff`
--

LOCK TABLES `GlobalDayOff` WRITE;
/*!40000 ALTER TABLE `GlobalDayOff` DISABLE KEYS */;
INSERT INTO `GlobalDayOff` VALUES (10,2013,'Sunday date off',NULL,1,NULL,NULL),(13,2013,'Quốc Khánh',NULL,NULL,2,8),(15,2013,'Xmas Day',NULL,NULL,25,11),(16,2013,'Quoc Te Lao Dong',NULL,NULL,1,4),(17,2013,'Thong nhat dat nuoc',NULL,NULL,30,3),(18,2013,'Tet duong lich',NULL,NULL,1,0),(19,2013,'Nghi bu ten am lich 29 tet',NULL,NULL,13,1),(20,2013,'Nghi bu ten am lich 30 tet',NULL,NULL,14,1),(21,2013,'Nghi tet an lich 01 tet',NULL,NULL,11,1),(22,2013,'Nghi tet an lich 02 tet',NULL,NULL,12,1),(23,2013,'Gio To Hung Vuong',NULL,NULL,19,3);
/*!40000 ALTER TABLE `GlobalDayOff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IFTDisplayLocation`
--

DROP TABLE IF EXISTS `IFTDisplayLocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IFTDisplayLocation` (
  `IFTDisplayLocationID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(10) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  `OutletBrandID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`IFTDisplayLocationID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  KEY `FK_IFTDisplayLocation_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_IFTDisplayLocation_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IFTDisplayLocation`
--

LOCK TABLES `IFTDisplayLocation` WRITE;
/*!40000 ALTER TABLE `IFTDisplayLocation` DISABLE KEYS */;
INSERT INTO `IFTDisplayLocation` VALUES (1,'1','Trực diện nhìn từ ngoài vô; Khoảng cách dưới 3m từ cửa ra vào (1)',1,1),(2,'2','Bên trái cửa hàng, Khoảng cách dưới 3m từ cửa ra vào (2)',2,1),(3,'3','Bên phải cửa hàng, Khoảng cách dưới 3m từ cửa ra vào (3)',3,1),(4,'4','Phía trong, bên trái cửa hàng (4)',4,2),(5,'5','Phía trong, bên phải cửa hàng (5)',5,2),(6,'6','Trực diện, bên trong cửa hàng, Khoảng cách trên 3m từ cửa ra vào (6)',6,2),(7,'7','Khác (7)',7,2),(8,'8','Hot-zone',8,3);
/*!40000 ALTER TABLE `IFTDisplayLocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LevelRegister`
--

DROP TABLE IF EXISTS `LevelRegister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LevelRegister` (
  `LevelID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LevelName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Register` int(11) DEFAULT NULL,
  `MinimumValue` int(11) DEFAULT NULL,
  `CompleteMinimumValue` int(11) DEFAULT NULL,
  PRIMARY KEY (`LevelID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LevelRegister`
--

LOCK TABLES `LevelRegister` WRITE;
/*!40000 ALTER TABLE `LevelRegister` DISABLE KEYS */;
INSERT INTO `LevelRegister` VALUES (1,'2',12,1,1),(2,'3',24,2,2),(3,'4',50,3,3),(4,'5',100,4,4);
/*!40000 ALTER TABLE `LevelRegister` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARAuditSummary`
--

DROP TABLE IF EXISTS `OARAuditSummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARAuditSummary` (
  `OARAuditSummaryID` bigint(11) NOT NULL AUTO_INCREMENT,
  `OutletbrandID` bigint(11) NOT NULL,
  `OutletAuditResultID` bigint(11) NOT NULL,
  `LocationMeet` int(11) DEFAULT NULL,
  `PowerSKUMeet` int(11) DEFAULT NULL,
  `FullRangeSKUMeet` int(11) DEFAULT NULL,
  `NoFacingMeet` int(11) DEFAULT NULL,
  `POSMMeet` int(11) DEFAULT NULL,
  `CommissionMeet` int(11) DEFAULT NULL,
  PRIMARY KEY (`OARAuditSummaryID`),
  UNIQUE KEY `UQ_` (`OARAuditSummaryID`,`OutletbrandID`),
  KEY `FK_OARAuditSummary_Outletrbrand` (`OutletbrandID`),
  KEY `FK_OARAuditSummary_OutletAuditResult` (`OutletAuditResultID`),
  CONSTRAINT `FK_OARAuditSummary_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARAuditSummary_Outletrbrand` FOREIGN KEY (`OutletbrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARAuditSummary`
--

LOCK TABLES `OARAuditSummary` WRITE;
/*!40000 ALTER TABLE `OARAuditSummary` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARAuditSummary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARDBBPosmRegistered`
--

DROP TABLE IF EXISTS `OARDBBPosmRegistered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARDBBPosmRegistered` (
  `oardbbposmregisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`oardbbposmregisteredID`),
  UNIQUE KEY `UQ_OutletID_PosmID_OutletPosmID_OARDBBRegistered` (`OutletID`,`OutletBrandID`,`PosmID`),
  KEY `FK_OARDBBRegister_OutletBrand` (`OutletBrandID`),
  KEY `FK_OARDBBRegister_OutletPosm` (`PosmID`),
  KEY `FK_OARDBBRegister_OutletAuditResult` (`OutletAuditResultID`),
  CONSTRAINT `FK_OARDBBRegister_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_OutletPosm` FOREIGN KEY (`PosmID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARDBBPosmRegistered`
--

LOCK TABLES `OARDBBPosmRegistered` WRITE;
/*!40000 ALTER TABLE `OARDBBPosmRegistered` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARDBBPosmRegistered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARFacingIFTDisplay`
--

DROP TABLE IF EXISTS `OARFacingIFTDisplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARFacingIFTDisplay` (
  `OARFacingIFTDisplayID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  `IFTDisplayLocationID` bigint(20) NOT NULL,
  `Has` tinyint(4) NOT NULL,
  PRIMARY KEY (`OARFacingIFTDisplayID`),
  KEY `FK_ OARFacingIFTDisplay_OAR` (`OutletAuditResultID`),
  KEY `FK_OARFacingIFTDisplay_OB` (`OutletBrandID`),
  KEY `FK_ OARFacingIFTDisplay_IFTDisplay` (`IFTDisplayLocationID`),
  CONSTRAINT `FK_ OARFacingIFTDisplay_IFTDisplay` FOREIGN KEY (`IFTDisplayLocationID`) REFERENCES `IFTDisplayLocation` (`IFTDisplayLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ OARFacingIFTDisplay_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARFacingIFTDisplay_OB` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARFacingIFTDisplay`
--

LOCK TABLES `OARFacingIFTDisplay` WRITE;
/*!40000 ALTER TABLE `OARFacingIFTDisplay` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARFacingIFTDisplay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARFacingRegistered`
--

DROP TABLE IF EXISTS `OARFacingRegistered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARFacingRegistered` (
  `OARFacingRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  `Facing` int(11) DEFAULT NULL,
  `LevelRegisterID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OARFacingRegisteredID`),
  KEY `FK_OARFacingRegistered_OAR` (`OutletAuditResultID`),
  KEY `FK_OARFacingRegistered_OutletBrand` (`OutletBrandID`),
  KEY `FK_OARFacingRegistered_LevelRegister` (`LevelRegisterID`),
  CONSTRAINT `FK_OARFacingRegistered_LevelRegister` FOREIGN KEY (`LevelRegisterID`) REFERENCES `LevelRegister` (`LevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARFacingRegistered_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARFacingRegistered_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARFacingRegistered`
--

LOCK TABLES `OARFacingRegistered` WRITE;
/*!40000 ALTER TABLE `OARFacingRegistered` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARFacingRegistered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARFullRangeFacing`
--

DROP TABLE IF EXISTS `OARFullRangeFacing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARFullRangeFacing` (
  `OARFullRangeFacingID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  `Correct` tinyint(4) NOT NULL,
  PRIMARY KEY (`OARFullRangeFacingID`),
  UNIQUE KEY `UQ_OARPowerSKU` (`OutletAuditResultID`,`OutletBrandID`),
  KEY `FK_OARFullRangeFacing_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OARFullRangeFacing_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARFullRangeFacing_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARFullRangeFacing`
--

LOCK TABLES `OARFullRangeFacing` WRITE;
/*!40000 ALTER TABLE `OARFullRangeFacing` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARFullRangeFacing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARFullRangeSKU`
--

DROP TABLE IF EXISTS `OARFullRangeSKU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARFullRangeSKU` (
  `OARFullRangeSKUID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `FullRangeID` bigint(20) NOT NULL,
  `Facing` int(11) DEFAULT NULL,
  `POSMID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`OARFullRangeSKUID`),
  KEY `FK_OARFullRangeSKU_OAR` (`OutletAuditResultID`),
  KEY `FK_OARFullRangeSKU_FRS` (`FullRangeID`),
  CONSTRAINT `FK_OARFullRangeSKU_FRS` FOREIGN KEY (`FullRangeID`) REFERENCES `FullRangeSKU` (`FullRangeSKUID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARFullRangeSKU_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARFullRangeSKU`
--

LOCK TABLES `OARFullRangeSKU` WRITE;
/*!40000 ALTER TABLE `OARFullRangeSKU` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARFullRangeSKU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARLatestBonus`
--

DROP TABLE IF EXISTS `OARLatestBonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARLatestBonus` (
  `OarLatestBonusID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `Correct` int(20) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  PRIMARY KEY (`OarLatestBonusID`),
  KEY `FK_OarLastedBonus_OutletAuditResult` (`OutletAuditResultID`),
  KEY `FK_OarLastedBonus_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OarLastedBonus_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OarLastedBonus_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARLatestBonus`
--

LOCK TABLES `OARLatestBonus` WRITE;
/*!40000 ALTER TABLE `OARLatestBonus` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARLatestBonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARLocationRegistered`
--

DROP TABLE IF EXISTS `OARLocationRegistered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARLocationRegistered` (
  `OARLocationRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `IFTDisplayLocationID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OARLocationRegisteredID`),
  KEY `FK_OARLocReg_OAR` (`OutletAuditResultID`),
  KEY `FK_OARLocReg_OutletBrand` (`OutletBrandID`),
  KEY `FK_OARLocReg_Location` (`IFTDisplayLocationID`),
  CONSTRAINT `FK_OARLocReg_Location` FOREIGN KEY (`IFTDisplayLocationID`) REFERENCES `IFTDisplayLocation` (`IFTDisplayLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARLocReg_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARLocReg_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARLocationRegistered`
--

LOCK TABLES `OARLocationRegistered` WRITE;
/*!40000 ALTER TABLE `OARLocationRegistered` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARLocationRegistered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARMiniValuePosm`
--

DROP TABLE IF EXISTS `OARMiniValuePosm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARMiniValuePosm` (
  `OarMiniValuePosmID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  PRIMARY KEY (`OarMiniValuePosmID`),
  KEY `FK_1` (`OutletAuditResultID`),
  KEY `FK_2` (`PosmID`),
  CONSTRAINT `FK_1` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_2` FOREIGN KEY (`PosmID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARMiniValuePosm`
--

LOCK TABLES `OARMiniValuePosm` WRITE;
/*!40000 ALTER TABLE `OARMiniValuePosm` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARMiniValuePosm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARNoFacing`
--

DROP TABLE IF EXISTS `OARNoFacing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARNoFacing` (
  `OARNoFacingID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  `Facing` int(11) DEFAULT NULL,
  PRIMARY KEY (`OARNoFacingID`),
  KEY `FK_OARNoFacing_OAR` (`OutletAuditResultID`),
  KEY `FK_OARNoFacing_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OARNoFacing_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARNoFacing_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARNoFacing`
--

LOCK TABLES `OARNoFacing` WRITE;
/*!40000 ALTER TABLE `OARNoFacing` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARNoFacing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARPosm`
--

DROP TABLE IF EXISTS `OARPosm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARPosm` (
  `OARPosmID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `POSMID` bigint(20) NOT NULL,
  `Has` tinyint(4) NOT NULL,
  `StatusPosm` text,
  PRIMARY KEY (`OARPosmID`),
  KEY `FK_ OARPosm_OAR` (`OutletAuditResultID`),
  KEY `FK_ OARPosm_OPOSM` (`POSMID`),
  CONSTRAINT `FK_ OARPosm_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ OARPosm_OPOSM` FOREIGN KEY (`POSMID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARPosm`
--

LOCK TABLES `OARPosm` WRITE;
/*!40000 ALTER TABLE `OARPosm` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARPosm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARPosmMiniValue`
--

DROP TABLE IF EXISTS `OARPosmMiniValue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARPosmMiniValue` (
  `OARPOSMMiniValueID` bigint(20) NOT NULL AUTO_INCREMENT,
  `POSMID` bigint(20) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `Values` int(11) DEFAULT NULL,
  PRIMARY KEY (`OARPOSMMiniValueID`),
  KEY `FK_POSMMiniValue_OutletPosm` (`POSMID`) USING BTREE,
  KEY `FK_OARPOSMMiniValue_OutletAuditResult` (`OutletAuditResultID`),
  CONSTRAINT `FK_OARPOSMMiniValue_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARPOSMMiniValue_OutletPosm` FOREIGN KEY (`POSMID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARPosmMiniValue`
--

LOCK TABLES `OARPosmMiniValue` WRITE;
/*!40000 ALTER TABLE `OARPosmMiniValue` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARPosmMiniValue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARPowerSKU`
--

DROP TABLE IF EXISTS `OARPowerSKU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARPowerSKU` (
  `OARPowerSKUID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `PowerSKUID` bigint(20) NOT NULL,
  `Has` tinyint(4) NOT NULL,
  `OutletPosmID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OARPowerSKUID`),
  UNIQUE KEY `UQ_OARPowerSKU` (`OutletAuditResultID`,`PowerSKUID`,`OutletPosmID`),
  KEY `FK_OARPowerSKU_OAR` (`OutletAuditResultID`),
  KEY `FK_OARPowerSKU_PowerSKU` (`PowerSKUID`),
  CONSTRAINT `FK_OARPowerSKU_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARPowerSKU_PowerSKU` FOREIGN KEY (`PowerSKUID`) REFERENCES `PowerSKU` (`PowerSKUID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARPowerSKU`
--

LOCK TABLES `OARPowerSKU` WRITE;
/*!40000 ALTER TABLE `OARPowerSKU` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARPowerSKU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARPromotion`
--

DROP TABLE IF EXISTS `OARPromotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARPromotion` (
  `OARPromotionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OuletAuditResultID` bigint(20) NOT NULL,
  `PromotionID` bigint(20) NOT NULL,
  `GetQuantity` int(11) DEFAULT NULL,
  `UnitID` bigint(20) DEFAULT NULL,
  `ProductID` bigint(20) DEFAULT NULL,
  `Known` tinyint(4) DEFAULT NULL,
  `Correct` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`OARPromotionID`),
  KEY `FK_OARPromotion_OAR` (`OuletAuditResultID`),
  KEY `FK_OARPromotion_Promotion` (`PromotionID`),
  CONSTRAINT `FK_OARPromotion_OAR` FOREIGN KEY (`OuletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARPromotion_Promotion` FOREIGN KEY (`PromotionID`) REFERENCES `Promotion` (`PromotionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARPromotion`
--

LOCK TABLES `OARPromotion` WRITE;
/*!40000 ALTER TABLE `OARPromotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARPromotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OARStorePromotion`
--

DROP TABLE IF EXISTS `OARStorePromotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OARStorePromotion` (
  `OARStorePromotionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `StorePromotionID` bigint(20) NOT NULL,
  `GetQuantity` int(11) DEFAULT NULL,
  `UnitID` bigint(20) DEFAULT NULL,
  `ProductID` bigint(20) DEFAULT NULL,
  `Known` tinyint(4) DEFAULT NULL,
  `Correct` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`OARStorePromotionID`),
  UNIQUE KEY `UQ_OARStorePromotion` (`StoreAuditResultID`,`StorePromotionID`),
  KEY `FK_OARStorePromotion_OAR` (`StoreAuditResultID`),
  KEY `FK_OARStorePromotion_StorePromotion` (`StorePromotionID`),
  CONSTRAINT `FK_OARStorePromotion_OAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARStorePromotion_StorePromotion` FOREIGN KEY (`StorePromotionID`) REFERENCES `StorePromotion` (`StorePromotionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OARStorePromotion`
--

LOCK TABLES `OARStorePromotion` WRITE;
/*!40000 ALTER TABLE `OARStorePromotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `OARStorePromotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OarRival`
--

DROP TABLE IF EXISTS `OarRival`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OarRival` (
  `OarRivalID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Rival` int(11) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OarRivalID`),
  UNIQUE KEY `UQ_OutletAuditResultID` (`OutletAuditResultID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OarRival`
--

LOCK TABLES `OarRival` WRITE;
/*!40000 ALTER TABLE `OarRival` DISABLE KEYS */;
/*!40000 ALTER TABLE `OarRival` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Outlet`
--

DROP TABLE IF EXISTS `Outlet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Outlet` (
  `OutletID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorID` bigint(20) NOT NULL,
  `DMSCode` varchar(45) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  `DistrictID` bigint(20) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `GPSLatitude` float DEFAULT NULL,
  `GPSLongtitude` float DEFAULT NULL,
  `WardID` bigint(20) DEFAULT NULL,
  `OutletName` varchar(255) DEFAULT NULL,
  `CreatedBy` bigint(20) DEFAULT NULL,
  `AgentID` int(11) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT NULL,
  `HouseNumber` varchar(45) DEFAULT NULL,
  `ProvinceID` bigint(20) DEFAULT NULL,
  `Telephone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`OutletID`),
  UNIQUE KEY `DMSCode_UNIQUE` (`DMSCode`,`DistributorID`),
  KEY `FK_Outlet_Region` (`RegionID`),
  KEY `FK_Outlet_Distributor` (`DistributorID`),
  KEY `FK_Outlet_District` (`DistrictID`),
  KEY `FK_Outlet_User` (`CreatedBy`),
  KEY `FK_Outlet_Agent` (`AgentID`),
  CONSTRAINT `FK_Outlet_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_Outlet_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Outlet_District` FOREIGN KEY (`DistrictID`) REFERENCES `District` (`DistrictID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Outlet_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Outlet_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Outlet`
--

LOCK TABLES `Outlet` WRITE;
/*!40000 ALTER TABLE `Outlet` DISABLE KEYS */;
/*!40000 ALTER TABLE `Outlet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletAuditPicture`
--

DROP TABLE IF EXISTS `OutletAuditPicture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletAuditPicture` (
  `OutletAuditPicture` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Path` varchar(255) NOT NULL,
  PRIMARY KEY (`OutletAuditPicture`),
  KEY `FK_OutletAuditPicture_OAR` (`OutletAuditResultID`),
  CONSTRAINT `FK_OutletAuditPicture_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletAuditPicture`
--

LOCK TABLES `OutletAuditPicture` WRITE;
/*!40000 ALTER TABLE `OutletAuditPicture` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletAuditPicture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletAuditResult`
--

DROP TABLE IF EXISTS `OutletAuditResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletAuditResult` (
  `OutletAuditResultID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AuditorOutletTaskID` bigint(20) NOT NULL,
  `AuditDate` datetime NOT NULL,
  `SubmittedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `GPSLatitude` float DEFAULT NULL,
  `GPSLongtitude` float DEFAULT NULL,
  `ActiveStatus` int(11) NOT NULL DEFAULT '1',
  `FrisoLevelRegister` bigint(20) DEFAULT NULL,
  `DlLevelRegister` bigint(20) DEFAULT NULL,
  `Notes` varchar(512) DEFAULT NULL,
  `isImport` int(11) DEFAULT NULL,
  PRIMARY KEY (`OutletAuditResultID`),
  KEY `FK_OutletAuditResult_OAT` (`AuditorOutletTaskID`),
  KEY `FK_Outletauditresult_LevelRegister_Friso` (`FrisoLevelRegister`),
  KEY `FK_Outletauditresult_LevelRegister_Dl` (`DlLevelRegister`),
  CONSTRAINT `FK_Outletauditresult_LevelRegister_Dl` FOREIGN KEY (`DlLevelRegister`) REFERENCES `LevelRegister` (`LevelID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_Outletauditresult_LevelRegister_Friso` FOREIGN KEY (`FrisoLevelRegister`) REFERENCES `LevelRegister` (`LevelID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletAuditResult_OAT` FOREIGN KEY (`AuditorOutletTaskID`) REFERENCES `AuditorOutletTask` (`AuditorOutletTaskID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletAuditResult`
--

LOCK TABLES `OutletAuditResult` WRITE;
/*!40000 ALTER TABLE `OutletAuditResult` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletAuditResult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletBrand`
--

DROP TABLE IF EXISTS `OutletBrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletBrand` (
  `OutletBrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Code` varchar(50) DEFAULT NULL,
  `OutletBrandGroupID` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OutletBrandID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `UQ_OutletBrand_Code` (`Code`),
  KEY `FK_OutletBrand_Group` (`OutletBrandGroupID`),
  CONSTRAINT `FK_OutletBrand_Group` FOREIGN KEY (`OutletBrandGroupID`) REFERENCES `OutletBrandGroup` (`OutletBrandGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletBrand`
--

LOCK TABLES `OutletBrand` WRITE;
/*!40000 ALTER TABLE `OutletBrand` DISABLE KEYS */;
INSERT INTO `OutletBrand` VALUES (1,'Friso','FRISO',1),(2,'Dutch Lady IFT','DLIFT',1),(3,'Sua dac','SD_DBB',2);
/*!40000 ALTER TABLE `OutletBrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletBrandGroup`
--

DROP TABLE IF EXISTS `OutletBrandGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletBrandGroup` (
  `OutletBrandGroupID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`OutletBrandGroupID`),
  UNIQUE KEY `UQ_OutletBrandGroup` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletBrandGroup`
--

LOCK TABLES `OutletBrandGroup` WRITE;
/*!40000 ALTER TABLE `OutletBrandGroup` DISABLE KEYS */;
INSERT INTO `OutletBrandGroup` VALUES (1,'IFT','IFT'),(2,'DBB','DBB');
/*!40000 ALTER TABLE `OutletBrandGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletDistributionRegistered`
--

DROP TABLE IF EXISTS `OutletDistributionRegistered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletDistributionRegistered` (
  `OutletDistributionRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL DEFAULT '1',
  `Facing` int(11) DEFAULT NULL,
  `LevelRegisterID` bigint(20) DEFAULT NULL,
  `ImportedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`OutletDistributionRegisteredID`),
  KEY `FK_OutletDistributionReg_Outlet` (`OutletID`),
  KEY `FK_OutletDistReg_OutletBrand` (`OutletBrandID`),
  KEY `FK_OutletDistReg_LevelRegister` (`LevelRegisterID`),
  CONSTRAINT `FK_OutletDistReg_LevelRegister` FOREIGN KEY (`LevelRegisterID`) REFERENCES `LevelRegister` (`LevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletDistReg_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletDistributionReg_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletDistributionRegistered`
--

LOCK TABLES `OutletDistributionRegistered` WRITE;
/*!40000 ALTER TABLE `OutletDistributionRegistered` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletDistributionRegistered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletLocationRegister`
--

DROP TABLE IF EXISTS `OutletLocationRegister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletLocationRegister` (
  `OutletLocationRegisterID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `IFTDisplayLocationID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `ImportedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`OutletLocationRegisterID`),
  KEY `FK_TO_Location` (`IFTDisplayLocationID`),
  KEY `FK_TO_Oulet` (`OutletID`),
  KEY `FK_TO_OuletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_TO_Location` FOREIGN KEY (`IFTDisplayLocationID`) REFERENCES `IFTDisplayLocation` (`IFTDisplayLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TO_Oulet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TO_OuletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletLocationRegister`
--

LOCK TABLES `OutletLocationRegister` WRITE;
/*!40000 ALTER TABLE `OutletLocationRegister` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletLocationRegister` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletPOSM`
--

DROP TABLE IF EXISTS `OutletPOSM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletPOSM` (
  `OutletPOSMID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Active` tinyint(4) DEFAULT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  PRIMARY KEY (`OutletPOSMID`),
  UNIQUE KEY `FrisoCode_UNIQUE` (`Code`),
  KEY `FK_OutletPOSM_OBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OutletPOSM_OBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletPOSM`
--

LOCK TABLES `OutletPOSM` WRITE;
/*!40000 ALTER TABLE `OutletPOSM` DISABLE KEYS */;
INSERT INTO `OutletPOSM` VALUES (1,'FR-H','Miếng treo',0,1),(2,'DL-H','Miếng treo',0,2),(3,'FR-W','Miếng gắn kệ',0,1),(4,'DL-W','Miếng gắn kệ',0,2),(5,'FR-MS','Miếng dán nam châm',0,1),(6,'DL-MS','Miếng dán nam châm',0,2),(7,'FR-SF','Khung trưng bày',1,1),(8,'DL-SF','Khung trưng bày',1,2),(9,'FR-DB','Hộp trưng bày',1,1),(10,'DL-DB','Hộp trưng bày',1,2),(11,'FR-TP','Tờ trưng bày bán hàng',0,1),(12,'DL-TP','Tờ trưng bày bán hàng',0,2),(13,'FR-ST','Miếng dán kệ',0,1),(14,'DL-ST','Miếng dán kệ',0,2),(15,'FR-L','Tờ rơi',0,1),(16,'DL-L','Tờ rơi',0,2),(17,'FR-MU','Mô hình trưng bày',0,1),(18,'DL-MU','Mô hình trưng bày',0,2),(19,'FR_KE','Kệ Trưng Bày',1,1),(20,'DL_KE','Kệ Trưng Bày',1,2),(21,'FR_U','Ụ trưng bày Friso',1,1),(22,'DL-U','Ụ trưng bày Dutch Lady',1,2),(24,'U_FE','U Sat',1,3),(25,'KE_FE','Ke Sat',1,3);
/*!40000 ALTER TABLE `OutletPOSM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletPOSMHistory`
--

DROP TABLE IF EXISTS `OutletPOSMHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletPOSMHistory` (
  `OutletPOSMHistoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletPOSMID` bigint(20) NOT NULL,
  `Active` tinyint(4) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `ExpiredDate` datetime DEFAULT NULL,
  PRIMARY KEY (`OutletPOSMHistoryID`),
  KEY `FK_OutletPOSMHistory_OutletPOSM` (`OutletPOSMID`),
  CONSTRAINT `FK_OutletPOSMHistory_OutletPOSM` FOREIGN KEY (`OutletPOSMID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletPOSMHistory`
--

LOCK TABLES `OutletPOSMHistory` WRITE;
/*!40000 ALTER TABLE `OutletPOSMHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletPOSMHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletRoute`
--

DROP TABLE IF EXISTS `OutletRoute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletRoute` (
  `OutletRouteID` bigint(11) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(11) DEFAULT NULL,
  `UserID` bigint(11) DEFAULT NULL,
  `T2` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `T3` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `T4` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `T5` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `T6` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `T7` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`OutletRouteID`),
  KEY `FK_OutletRoute_OutletID` (`OutletID`),
  KEY `FK_OutletRoute_UserID` (`UserID`),
  CONSTRAINT `FK_OutletRoute_OutletID` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletRoute_UserID` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletRoute`
--

LOCK TABLES `OutletRoute` WRITE;
/*!40000 ALTER TABLE `OutletRoute` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletRoute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutletSaleman`
--

DROP TABLE IF EXISTS `OutletSaleman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutletSaleman` (
  `OutletSalemanID` bigint(11) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(11) NOT NULL,
  `SalemanID` bigint(11) NOT NULL,
  `OutletBrandID` bigint(11) NOT NULL,
  `FromDate` datetime NOT NULL,
  `ToDate` datetime DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`OutletSalemanID`),
  UNIQUE KEY `UQ_` (`OutletID`,`SalemanID`,`OutletBrandID`),
  KEY `FK_OutletSaleman_Saleman` (`SalemanID`),
  KEY `FK_OutletSaleman_Outlet` (`OutletID`),
  KEY `FK_OutletSaleman_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OutletSaleman_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletSaleman_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletSaleman_Saleman` FOREIGN KEY (`SalemanID`) REFERENCES `Saleman` (`SalemanID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutletSaleman`
--

LOCK TABLES `OutletSaleman` WRITE;
/*!40000 ALTER TABLE `OutletSaleman` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutletSaleman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POSMMiniValue`
--

DROP TABLE IF EXISTS `POSMMiniValue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `POSMMiniValue` (
  `POSMMiniValueID` int(11) NOT NULL AUTO_INCREMENT,
  `POSMID` bigint(11) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  PRIMARY KEY (`POSMMiniValueID`),
  KEY `FK_POSMMiniValue_OutletPOSM` (`POSMID`),
  CONSTRAINT `FK_POSMMiniValue_OutletPOSM` FOREIGN KEY (`POSMID`) REFERENCES `OutletPOSM` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POSMMiniValue`
--

LOCK TABLES `POSMMiniValue` WRITE;
/*!40000 ALTER TABLE `POSMMiniValue` DISABLE KEYS */;
INSERT INTO `POSMMiniValue` VALUES (1,24,126),(2,25,57);
/*!40000 ALTER TABLE `POSMMiniValue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PackingGroup`
--

DROP TABLE IF EXISTS `PackingGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PackingGroup` (
  `PackingGroupID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SOSBrandID` bigint(20) NOT NULL,
  `Size` float NOT NULL,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`PackingGroupID`),
  KEY `FK_PackingGroup_SOSBrand` (`SOSBrandID`),
  CONSTRAINT `FK_PackingGroup_SOSBrand` FOREIGN KEY (`SOSBrandID`) REFERENCES `SOSBrand` (`SOSBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PackingGroup`
--

LOCK TABLES `PackingGroup` WRITE;
/*!40000 ALTER TABLE `PackingGroup` DISABLE KEYS */;
INSERT INTO `PackingGroup` VALUES (1,1,21.5,'Lốc 110ml'),(2,1,21.5,'Lốc 180ml'),(3,1,9.5,'Hộp 1Lít'),(4,1,10,'Bịch 200ml'),(5,1,26,'Thùng 110ml/180ml/200ml'),(6,1,20,'Thùng 1Lít'),(7,2,21.5,'Lốc 110ml'),(8,2,21.5,'Lốc 170ml'),(9,2,15.5,'Lốc 80ml'),(10,2,26,'Thùng 80/110/170ml'),(11,3,7.5,'Lon 380g'),(12,3,30,'Thùng 380g'),(13,4,21.5,'Lốc 110ml'),(14,4,21.5,'Lốc 180ml'),(15,4,14,'IMP Hộp giấy'),(16,4,9,'IMP Hủ/Jar'),(17,5,10.5,'Lon 400g'),(18,5,13.5,'Lon 900g'),(19,5,16,'Lon 1.5kg'),(20,5,14,'Hộp giấy 400g'),(21,5,22,'Hộp giấy 1.6kg'),(22,5,27,'Hộp giấy 2kg'),(23,6,10.5,'Lon 400g'),(24,6,13.5,'Lon 900g'),(25,6,16,'Lon 1.5kg');
/*!40000 ALTER TABLE `PackingGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalDayOff`
--

DROP TABLE IF EXISTS `PersonalDayOff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalDayOff` (
  `PersonalDayOffID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Year` int(11) NOT NULL,
  `DayOfMonth` int(11) DEFAULT NULL,
  `MonthOfYear` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `OwnerID` bigint(20) NOT NULL,
  PRIMARY KEY (`PersonalDayOffID`),
  UNIQUE KEY `UQ_PersonalDayOff` (`OwnerID`,`DayOfMonth`,`MonthOfYear`,`Year`),
  CONSTRAINT `FK_PersonalDayOff_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalDayOff`
--

LOCK TABLES `PersonalDayOff` WRITE;
/*!40000 ALTER TABLE `PersonalDayOff` DISABLE KEYS */;
/*!40000 ALTER TABLE `PersonalDayOff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PowerSKU`
--

DROP TABLE IF EXISTS `PowerSKU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PowerSKU` (
  `PowerSKUID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletBrandID` bigint(20) NOT NULL COMMENT 'The product group: Friso or Dutch Lady',
  `Name` varchar(255) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`PowerSKUID`),
  KEY `FK_PowerSKU_OBrand` (`OutletBrandID`),
  CONSTRAINT `FK_PowerSKU_OBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PowerSKU`
--

LOCK TABLES `PowerSKU` WRITE;
/*!40000 ALTER TABLE `PowerSKU` DISABLE KEYS */;
INSERT INTO `PowerSKU` VALUES (1,1,'Friso Gold Mum',1),(2,1,'Friso Gold 1',2),(3,1,'Friso Gold 2',3),(4,1,'Friso Gold 3',4),(5,2,'Dutch Lady Regular Mum',1),(6,2,'Dutch Lady Step 1 + Gold 1',2),(7,2,'Dutch Lady Step 2 + Gold 2',3),(8,2,'Dutch Lady Step 456 + Gold 456',6),(9,2,'Dutch Lady Step 123 + Gold 123',4),(10,1,'Friso Gold 4',5),(12,2,'Complete',5),(13,3,'DL UHT 180',1),(14,3,'DL UHT 110',2),(15,3,'Yomost 170',3),(16,3,'Yomost 110',4),(17,3,'DKY 110',5),(18,3,'Sua Ðac',7),(19,3,'Fristi',6);
/*!40000 ALTER TABLE `PowerSKU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `ProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Size` varchar(45) DEFAULT NULL,
  `ProductGroupID` bigint(20) DEFAULT NULL,
  `ProductBrandID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `FK_Product_ProductGroup` (`ProductGroupID`),
  KEY `FK_Product_ProductBrand` (`ProductBrandID`),
  CONSTRAINT `FK_Product_ProductBrand` FOREIGN KEY (`ProductBrandID`) REFERENCES `ProductBrand` (`ProductBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Product_ProductGroup` FOREIGN KEY (`ProductGroupID`) REFERENCES `ProductGroup` (`ProductGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'IMP DL 400gr',NULL,NULL,1),(2,'IMP DL 900gr',NULL,NULL,1),(3,'IMP BIB 400gr',NULL,NULL,1),(4,'Step 1 400gr',NULL,NULL,1),(5,'Step 1 900gr',NULL,NULL,1),(6,'Step 2 400gr',NULL,NULL,1),(7,'Step 2 900gr',NULL,NULL,1),(8,'IMP 123 400gr',NULL,NULL,1),(9,'IMP 123 900gr',NULL,NULL,1),(10,'IMP 123 1500gr',NULL,NULL,1),(11,'IMP 123 2000gr',NULL,NULL,1),(12,'IMP 123 BIB',NULL,NULL,1),(13,'IMP 456 900gr',NULL,NULL,1),(14,'IMP 456 1500gr',NULL,NULL,1),(15,'IMP 456 2000gr',NULL,NULL,1),(16,'IMP 456 BIB',NULL,NULL,1),(17,'DL MUM 400gr',NULL,NULL,1),(18,'DL MUM 900gr',NULL,NULL,1),(19,'DL Gold Step 1 400gr',NULL,NULL,2),(20,'DL Gold Step 1 900gr',NULL,NULL,2),(21,'DL Gold Step 2 400gr',NULL,NULL,2),(22,'DL Gold Step 2 900gr',NULL,NULL,2),(23,'DL123 Gold 900gr',NULL,NULL,2),(24,'DL123 Gold 1500gr',NULL,NULL,2),(25,'DL123 Gold 2000gr',NULL,NULL,2),(26,'DL456 Gold 900gr',NULL,NULL,2),(27,'DL456 Gold 1500gr',NULL,NULL,2),(28,'Friso 1-900gr',NULL,NULL,3),(29,'Friso 2-900gr',NULL,NULL,3),(30,'Friso 3-900gr',NULL,NULL,3),(31,'Friso 3-1500gr',NULL,NULL,3),(32,'Friso 4-900gr',NULL,NULL,3),(33,'Friso 1 Gold 400gr',NULL,NULL,4),(34,'Friso 1 Gold 900gr',NULL,NULL,4),(35,'Friso 2 Gold 400gr',NULL,NULL,4),(36,'Friso 2 Gold 900gr',NULL,NULL,4),(37,'Friso 3 Gold 400gr',NULL,NULL,4),(38,'Friso 3 Gold 900gr',NULL,NULL,4),(39,'Friso3 Gold 1500gr',NULL,NULL,4),(40,'Friso 4 Gold 900gr',NULL,NULL,4),(41,'Friso 4 Gold 1500gr',NULL,NULL,4),(42,'Friso Gold Mum vani 400gr',NULL,NULL,4),(43,'Friso Gold Mum Ora 400gr',NULL,NULL,4),(44,'Friso Gold Mum vani 900gr',NULL,NULL,4),(45,'Friso Gold Mum Ora 900gr',NULL,NULL,4),(46,'SCM EXC',NULL,NULL,5),(47,'SCM NUTRI',NULL,NULL,5),(48,'SCM WTS',NULL,NULL,5),(49,'SCM COMP',NULL,NULL,5),(50,'UHT 110ml Vani',NULL,NULL,6),(51,'UHT 110ml Choco',NULL,NULL,6),(52,'UHT 110ml Straw',NULL,NULL,6),(53,'UHT Sweet 180ml',NULL,NULL,6),(54,'UHT Choco 180ml',NULL,NULL,6),(55,'UHT Straw 180ml',NULL,NULL,6),(56,'UHT 180ml Plain',NULL,NULL,6),(57,'UHT 1L Plain',NULL,NULL,6),(58,'UHT 1L Sweet',NULL,NULL,6),(59,'FINO Plain',NULL,NULL,6),(60,'FINO Sweet',NULL,NULL,6),(61,'FINO Straw',NULL,NULL,6),(62,'DKY. Straw 110ml',NULL,NULL,7),(63,'DKY. Ora 110ml',NULL,NULL,7),(64,'YO. Straw 170ml',NULL,NULL,7),(65,'YO. Ora 170ml',NULL,NULL,7),(66,'YO. Plain 170ml',NULL,NULL,7),(67,'YO. Pomegranate 170ml',NULL,NULL,7),(68,'YO. Seabuckthorn 170ml',NULL,NULL,7),(69,'YO. Peach 170ml',NULL,NULL,7),(70,'Fristi Straw 80ml',NULL,NULL,7),(71,'Fristi Grape 80ml',NULL,NULL,7),(72,'Fristi Orange 80ml',NULL,NULL,7),(73,'Fristi Mixed Fruit 80ml',NULL,NULL,7),(74,'Oval Jar 400gr',NULL,NULL,8),(75,'Oval Bib 285gr',NULL,NULL,8),(76,'Oval 3 in 1',NULL,NULL,8),(77,'Oval Swiss Choco Malt 260g',NULL,NULL,8),(78,'Oval Supreme Choco 300g',NULL,NULL,8),(79,'UHT Oval 110ml',NULL,NULL,8),(80,'UHT Oval 180ml',NULL,NULL,8);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductBrand`
--

DROP TABLE IF EXISTS `ProductBrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductBrand` (
  `ProductBrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `BrandGroupID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProductBrandID`),
  UNIQUE KEY `UQ_ProductBrand` (`Name`),
  KEY `FK_ProductBrand_BrandGroup` (`BrandGroupID`),
  CONSTRAINT `FK_ProductBrand_BrandGroup` FOREIGN KEY (`BrandGroupID`) REFERENCES `BrandGroup` (`BrandGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductBrand`
--

LOCK TABLES `ProductBrand` WRITE;
/*!40000 ALTER TABLE `ProductBrand` DISABLE KEYS */;
INSERT INTO `ProductBrand` VALUES (1,'DL REGULAR',1),(2,'DL GOLD',1),(3,'FRISO REGULAR',1),(4,'FRISO GOLD',1),(5,'SCM  ',2),(6,'UHT',2),(7,'DKY',2),(8,'TFD',2);
/*!40000 ALTER TABLE `ProductBrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductGroup`
--

DROP TABLE IF EXISTS `ProductGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductGroup` (
  `ProductGroupID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProductGroupID`),
  UNIQUE KEY `UQ_ProductGroup` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductGroup`
--

LOCK TABLES `ProductGroup` WRITE;
/*!40000 ALTER TABLE `ProductGroup` DISABLE KEYS */;
INSERT INTO `ProductGroup` VALUES (1,'Friso Gold','Friso'),(2,'Dutch Lady IFT','DLIFT');
/*!40000 ALTER TABLE `ProductGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Promotion`
--

DROP TABLE IF EXISTS `Promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Promotion` (
  `PromotionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `PromotionTypeID` bigint(20) NOT NULL,
  `OutletBrandID` bigint(20) NOT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `ExpireDate` datetime DEFAULT NULL,
  `BuyQuantity` int(11) DEFAULT NULL,
  `BuyUnitID` bigint(20) NOT NULL,
  `BuyProduct` varchar(255) DEFAULT NULL,
  `GetQuantity` bigint(20) DEFAULT NULL,
  `GetUnitID` bigint(20) DEFAULT NULL,
  `PromotionProductID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PromotionID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  KEY `FK_Promotion_BuyUnit` (`BuyUnitID`),
  KEY `FK_Promotion_GetUnit` (`GetUnitID`),
  KEY `FK_Promotion_GetProduct` (`PromotionProductID`),
  KEY `FK_Promotion_PromotionType` (`PromotionTypeID`),
  KEY `FK_Promotion_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_Promotion_BuyUnit` FOREIGN KEY (`BuyUnitID`) REFERENCES `Unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Promotion_GetProduct` FOREIGN KEY (`PromotionProductID`) REFERENCES `PromotionProduct` (`PromotionProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Promotion_GetUnit` FOREIGN KEY (`GetUnitID`) REFERENCES `Unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Promotion_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Promotion_PromotionType` FOREIGN KEY (`PromotionTypeID`) REFERENCES `PromotionType` (`PromotionTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promotion`
--

LOCK TABLES `Promotion` WRITE;
/*!40000 ALTER TABLE `Promotion` DISABLE KEYS */;
INSERT INTO `Promotion` VALUES (2,'0006','Khuyến mãi Friso L4',1,1,'2012-09-06 00:00:00','2012-09-30 00:00:00',1,1,'Friso Gold',1,2,3),(3,'0002','Khuyến mãi Dutch Lady L2',1,2,'2012-09-06 00:00:00','2012-09-30 00:00:00',1,2,'Dutch Lady 900g/1.5 kg',2,2,2),(6,'0003','Khuyến mãi Friso L1',1,1,'2012-09-06 00:00:00','2012-09-30 00:00:00',2,2,'Friso Gold 400g',5,2,1),(7,'0004','Khuyến mãi Friso L2',1,1,'2012-09-06 00:00:00','2012-09-30 00:00:00',1,2,'Friso Gold 900g',5,2,1),(8,'0001','Khuyến Mãi Dutch Lady IFT L1',1,2,'2012-09-06 00:00:00','2012-09-30 00:00:00',2,2,'Dutch Lady 400g',2,2,2),(9,'0005','Khuyến mãi Friso L3',1,1,'2012-09-06 00:00:00','2012-09-30 00:00:00',1,2,'Friso Gold 1.5 kg',8,1,1),(11,'0007','Khuyến mãi Friso 01/09/2012-30/09/2012',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',2,2,'Friso Regular 400g',3,2,1),(12,'0008','Khuyến mãi Friso (1/9/2012-30/9/2012',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'Friso Regular 900g',3,2,1),(13,'0009','Khuyến mãi Firso (01/09/2012-30/09/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'Friso Regular 1.5kg',5,2,1),(14,'0010','Khuyến mãi Friso (1/9/2012-30/9/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,1,'Friso Regular ',1,2,6),(15,'0011','Khuyến mãi Friso (01/09/2012-30/9/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',2,2,'Friso Gold 400g',5,2,1),(16,'0012','Khuyến mãi Friso (01/09/2012-30/09/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'Friso Gold 900g',5,2,1),(17,'0013','Khuyến mãi Friso (01/09/2012-30/09/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'Friso Gold 1.5kg',8,2,1),(18,'0014','Khuyến mãi Friso (01/09/2012-30/09/2012)',1,1,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,1,'Friso Gold',1,2,3),(19,'0015','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',2,2,'DL REGULAR 400G',2,2,1),(20,'0016','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'DL REGULAR 900G',2,2,1),(21,'0017','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'DL REGULAR 1.5KG',3,2,1),(22,'0018','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,1,'DL REGULAR ',1,2,12),(23,'0019','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',2,2,'DL GOLD 400G',3,2,1),(24,'0020','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'DL GOLD 900G',3,2,1),(25,'0021','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,2,'DL GOLD 1.5KG',5,2,1),(26,'0022','Khuyến mãi DL IFT (01/09/2012-30/09/2012)',1,2,'2012-09-01 00:00:00','2012-09-30 00:00:00',1,1,'DL GOLD',1,2,9),(30,'0023','DL IFT-Regular',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',2,2,'DL REGULAR 400G',2,2,1),(31,'0024','DL IFT-Regular',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'DL REGULAR 900G',2,2,1),(32,'0025','DL IFT-Regular',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'DL REGULAR 1.5KG',3,2,1),(33,'0026','DL IFT-Regular',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,1,'DL REGULAR ',1,2,12),(34,'0027','DL IFT-Gold',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',2,2,'DL GOLD 400G',3,2,1),(35,'0028','DL IFT-Gold',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'DL GOLD 900G',3,2,1),(36,'0029','DL IFT-Gold',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'DL GOLD 1.5KG',5,2,1),(37,'0030','DL IFT-Gold',1,2,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,1,'DL GOLD',1,2,9),(38,'0031','FRISO-Regular',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',2,2,'FRISO REGULAR 400G',3,2,1),(39,'0032','FRISO-Regular',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'FRISO REGULAR 900G',3,2,1),(40,'0033','FRISO-Regular',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'FRISO REGULAR 1.5KG',5,2,1),(41,'0034','FRISO-regular',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,1,'FRISO REGULAR',1,2,6),(42,'0035','FRISO-Gold',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',2,2,'FRISO GOLD 400G',5,2,1),(43,'0036','FRISO-Gold',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'FRISO GOLD 900G',5,2,1),(44,'0037','FRISO-Gold',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,2,'FRISO GOLD 1.5KG',8,2,1),(45,'0038','FRISO-Gold',1,1,'2012-10-01 00:00:00','2012-12-31 00:00:00',1,1,'FRISO GOLD',1,2,3);
/*!40000 ALTER TABLE `Promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromotionProduct`
--

DROP TABLE IF EXISTS `PromotionProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromotionProduct` (
  `PromotionProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`PromotionProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromotionProduct`
--

LOCK TABLES `PromotionProduct` WRITE;
/*!40000 ALTER TABLE `PromotionProduct` DISABLE KEYS */;
INSERT INTO `PromotionProduct` VALUES (1,'DL UHT 180'),(2,'DL UHT 110'),(3,'Friso Gold 900'),(4,'Friso Gold 400'),(5,'Friso Gold 1500'),(6,'Friso Reg 900'),(7,'Friso  Reg 400'),(8,'BIB DL 400g'),(9,'DL Gold 900'),(10,'DL Gold 1500'),(11,'DL Reg 400'),(12,'DL Reg 900'),(13,'DL Reg 1500'),(14,'SCM');
/*!40000 ALTER TABLE `PromotionProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromotionProductToHandheld`
--

DROP TABLE IF EXISTS `PromotionProductToHandheld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromotionProductToHandheld` (
  `PromotionProductToHandheldID` int(11) NOT NULL AUTO_INCREMENT,
  `PromotionID` bigint(20) NOT NULL,
  `PromotionProductID` bigint(20) NOT NULL,
  PRIMARY KEY (`PromotionProductToHandheldID`),
  UNIQUE KEY `UQ_PromotionProductToHandheld` (`PromotionID`,`PromotionProductID`),
  KEY `FK_PromotionProductToHandheld_Promotion` (`PromotionID`),
  KEY `FK_PromotionProductToHandheld_PromotionProduct` (`PromotionProductID`),
  CONSTRAINT `FK_PromotionProductToHandheld_Promotion` FOREIGN KEY (`PromotionID`) REFERENCES `Promotion` (`PromotionID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PromotionProductToHandheld_PromotionProduct` FOREIGN KEY (`PromotionProductID`) REFERENCES `PromotionProduct` (`PromotionProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromotionProductToHandheld`
--

LOCK TABLES `PromotionProductToHandheld` WRITE;
/*!40000 ALTER TABLE `PromotionProductToHandheld` DISABLE KEYS */;
INSERT INTO `PromotionProductToHandheld` VALUES (106,2,3),(107,3,2),(108,6,1),(109,7,1),(110,8,2),(111,9,1),(116,11,1),(117,12,1),(118,13,1),(119,14,6),(120,15,1),(121,16,1),(122,17,1),(123,18,3),(124,19,1),(125,20,1),(132,21,1),(134,22,12),(128,23,1),(129,24,1),(130,25,1),(131,26,9),(445,30,1),(446,30,2),(447,30,3),(448,30,4),(449,30,5),(450,30,6),(451,30,7),(452,30,8),(453,30,9),(454,30,10),(455,31,1),(456,31,8),(457,31,11),(458,31,13),(459,32,1),(460,32,2),(461,32,3),(462,32,4),(463,32,5),(464,32,6),(465,32,7),(466,32,8),(467,32,9),(468,32,10),(469,33,11),(470,33,12),(471,33,13),(476,34,1),(477,34,2),(478,34,3),(479,34,4),(480,35,1),(481,35,2),(482,35,3),(483,35,4),(484,35,5),(485,35,6),(486,36,1),(487,36,2),(488,36,3),(489,36,4),(490,36,5),(491,36,6),(492,36,7),(493,36,8),(494,36,9),(495,36,10),(496,36,11),(497,36,12),(498,36,13),(499,37,1),(500,37,2),(501,37,3),(502,37,4),(503,37,5),(504,37,6),(505,37,7),(506,37,8),(507,37,9),(508,37,10),(509,37,11),(510,37,12),(511,37,13),(512,38,1),(513,38,2),(514,38,3),(515,38,4),(516,38,5),(517,38,6),(518,38,7),(519,38,8),(520,38,9),(521,38,10),(522,38,11),(523,38,12),(524,38,13),(525,39,1),(526,39,2),(527,39,3),(528,39,4),(529,39,5),(530,39,6),(531,39,7),(532,39,8),(533,39,9),(534,39,10),(535,39,11),(536,39,12),(537,39,13),(538,40,1),(539,40,2),(540,40,3),(541,40,4),(542,40,5),(543,40,6),(544,40,7),(545,40,8),(546,40,9),(547,40,10),(548,40,11),(549,40,12),(550,40,13),(551,41,1),(552,41,2),(553,41,3),(554,41,4),(555,41,5),(556,41,6),(557,41,7),(558,42,1),(559,42,2),(560,42,3),(561,42,4),(562,42,5),(563,42,6),(564,42,7),(565,43,1),(566,43,2),(567,43,3),(568,43,4),(569,43,5),(570,43,6),(571,43,7),(572,43,8),(573,43,9),(574,43,10),(575,44,1),(576,44,2),(577,44,3),(578,44,4),(579,44,5),(580,44,6),(581,44,7),(582,45,1),(583,45,2),(584,45,3),(585,45,4),(586,45,5),(587,45,6),(588,45,7),(589,45,8),(590,45,9);
/*!40000 ALTER TABLE `PromotionProductToHandheld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromotionScope`
--

DROP TABLE IF EXISTS `PromotionScope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromotionScope` (
  `PromotionScopeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PromotionID` bigint(20) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`PromotionScopeID`),
  UNIQUE KEY `UQ_PromotionScope` (`PromotionID`,`RegionID`),
  KEY `FK_PromotionScope_Promotion` (`PromotionID`),
  KEY `FK_PromotionScope_Region` (`RegionID`),
  CONSTRAINT `FK_PromotionScope_Promotion` FOREIGN KEY (`PromotionID`) REFERENCES `Promotion` (`PromotionID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PromotionScope_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromotionScope`
--

LOCK TABLES `PromotionScope` WRITE;
/*!40000 ALTER TABLE `PromotionScope` DISABLE KEYS */;
INSERT INTO `PromotionScope` VALUES (49,2,1),(50,3,1),(51,6,1),(52,7,1),(53,8,1),(54,9,1),(66,11,1),(68,11,2),(65,11,3),(67,11,4),(63,11,5),(64,11,6),(70,12,1),(72,12,2),(69,12,3),(71,12,4),(76,13,1),(78,13,2),(75,13,3),(77,13,4),(73,13,5),(74,13,6),(82,14,1),(84,14,2),(81,14,3),(83,14,4),(79,14,5),(80,14,6),(88,15,1),(90,15,2),(87,15,3),(89,15,4),(85,15,5),(86,15,6),(94,16,1),(96,16,2),(93,16,3),(95,16,4),(91,16,5),(92,16,6),(100,17,1),(102,17,2),(99,17,3),(101,17,4),(97,17,5),(98,17,6),(106,18,1),(108,18,2),(105,18,3),(107,18,4),(103,18,5),(104,18,6),(112,19,1),(114,19,2),(111,19,3),(113,19,4),(109,19,5),(110,19,6),(118,20,1),(120,20,2),(117,20,3),(119,20,4),(115,20,5),(116,20,6),(160,21,1),(162,21,2),(159,21,3),(161,21,4),(157,21,5),(158,21,6),(172,22,1),(174,22,2),(171,22,3),(173,22,4),(169,22,5),(170,22,6),(136,23,1),(138,23,2),(135,23,3),(137,23,4),(133,23,5),(134,23,6),(142,24,1),(144,24,2),(141,24,3),(143,24,4),(139,24,5),(140,24,6),(148,25,1),(150,25,2),(147,25,3),(149,25,4),(145,25,5),(146,25,6),(154,26,1),(156,26,2),(153,26,3),(155,26,4),(151,26,5),(152,26,6),(413,30,1),(415,30,2),(411,30,3),(414,30,4),(409,30,5),(410,30,6),(412,30,7),(420,31,1),(422,31,2),(418,31,3),(421,31,4),(416,31,5),(417,31,6),(419,31,7),(427,32,1),(429,32,2),(425,32,3),(428,32,4),(423,32,5),(424,32,6),(426,32,7),(434,33,1),(436,33,2),(432,33,3),(435,33,4),(430,33,5),(431,33,6),(433,33,7),(448,34,1),(450,34,2),(446,34,3),(449,34,4),(444,34,5),(445,34,6),(447,34,7),(455,35,1),(457,35,2),(453,35,3),(456,35,4),(451,35,5),(452,35,6),(454,35,7),(462,36,1),(464,36,2),(460,36,3),(463,36,4),(458,36,5),(459,36,6),(461,36,7),(469,37,1),(471,37,2),(467,37,3),(470,37,4),(465,37,5),(466,37,6),(468,37,7),(476,38,1),(478,38,2),(474,38,3),(477,38,4),(472,38,5),(473,38,6),(475,38,7),(483,39,1),(485,39,2),(481,39,3),(484,39,4),(479,39,5),(480,39,6),(482,39,7),(490,40,1),(492,40,2),(488,40,3),(491,40,4),(486,40,5),(487,40,6),(489,40,7),(497,41,1),(499,41,2),(495,41,3),(498,41,4),(493,41,5),(494,41,6),(496,41,7),(504,42,1),(506,42,2),(502,42,3),(505,42,4),(500,42,5),(501,42,6),(503,42,7),(511,43,1),(513,43,2),(509,43,3),(512,43,4),(507,43,5),(508,43,6),(510,43,7),(518,44,1),(520,44,2),(516,44,3),(519,44,4),(514,44,5),(515,44,6),(517,44,7),(525,45,1),(527,45,2),(523,45,3),(526,45,4),(521,45,5),(522,45,6),(524,45,7);
/*!40000 ALTER TABLE `PromotionScope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromotionType`
--

DROP TABLE IF EXISTS `PromotionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromotionType` (
  `PromotionTypeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) NOT NULL,
  PRIMARY KEY (`PromotionTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromotionType`
--

LOCK TABLES `PromotionType` WRITE;
/*!40000 ALTER TABLE `PromotionType` DISABLE KEYS */;
INSERT INTO `PromotionType` VALUES (1,'Discount'),(2,'Rebate'),(3,'Display'),(4,'Mix');
/*!40000 ALTER TABLE `PromotionType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Province`
--

DROP TABLE IF EXISTS `Province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Province` (
  `ProvinceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProvinceID`),
  KEY `FK_Province_Region` (`RegionID`),
  CONSTRAINT `FK_Province_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3983 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Province`
--

LOCK TABLES `Province` WRITE;
/*!40000 ALTER TABLE `Province` DISABLE KEYS */;
INSERT INTO `Province` VALUES (3896,'Vũng tàu',1),(3897,'Nam cát tiên',1),(3898,'Miền Tây',1),(3899,'Tây Ninh',1),(3900,'Phụ cận HCM',1),(3901,'Trung tâm HCM',1),(3902,'Ngoại thành HCM',1),(3903,'Hồ chí minh',1),(3904,'Đồng nai',1),(3905,'Biên hòa',1),(3906,'NGHỆ AN',1),(3907,'HẢI PHÒNG',1),(3908,'VINH',1),(3909,'ĐiỆN BIÊN',1),(3910,'Chưa biết',7),(3911,'Hội An',2),(3912,'Quảng Ngãi',2),(3913,'Huế',2),(3914,'Phố Cổ',2),(3915,'Quảng Nam',2),(3916,'Quảng Quảng',2),(3917,'Mi Quảng',2),(3918,'Ngũ Hành Sơn',2),(3919,'Nội Chính',2),(3920,'Đà Nẵng',2),(3921,'Hà Đông',3),(3922,'Hà Hà',3),(3923,'Hà Hải',3),(3924,'Hà Mã',3),(3925,'Hà Ngoại',3),(3926,'Hà Nội',3),(3927,'Hà Trung',3),(3928,'Hà Nam',3),(3929,'Hà Bắc',3),(3930,'Hà Tây',3),(3931,'Tây Nguyên',4),(3932,'Đà Lạt',4),(3933,'Bảo Lọc',4),(3934,'Lâm Đông',4),(3935,'ĐakNong',4),(3936,'ĐakLak',4),(3937,'Gia Lai',4),(3938,'Playku',4),(3939,'Nha Trang',4),(3940,'Phan Rang',4),(3941,'Phan Thiết',4),(3942,'Tháp Chàm',4),(3943,'NGHỆ AN',5),(3944,'HẢI PHÒNG',5),(3945,'VINH',5),(3946,'ĐiỆN BIÊN',5),(3947,'TRUNG DU',5),(3948,'MiỀN NÚI',5),(3949,'BIÊN GIÓI',5),(3950,'HẢI DAO',5),(3951,'LẠNG SƠN',5),(3952,'MÓNG CÁI',5),(3953,'CAO BẰNG',5),(3954,'SƠN LA',5),(3955,'HẢI DƯƠNG',5),(3956,'TÂY BẮC',5),(3957,'ĐÔNG BẮC',5),(3958,'Cần Thơ',6),(3959,'Sóc Trăng',6),(3960,'Long An',6),(3961,'Cồn Phụng',6),(3962,'Cửu Long',6),(3963,'Tiền Giang',6),(3964,'Hậu Giang',6),(3965,'Mỹ Tho',6),(3966,'Mỹ Nhân',6),(3967,'Tâm Kế',6),(3968,'LẠNG SƠN',7),(3969,'MÓNG CÁI',7),(3970,'CAO BẰNG',7),(3971,'ĐiỆN BIÊN',7),(3972,'SƠN LA',7),(3973,'HẢI DƯƠNG',7),(3974,'TÂY BẮC',7),(3975,'ĐÔNG BẮC',7),(3976,'TRUNG DU',7),(3977,'MiỀN NÚI',7),(3978,'BIÊN GIÓI',7),(3979,'HẢI DAO',7),(3980,'Hồ Chí Minh',7),(3981,'Hồ Chí Minh',4),(3982,'Hồ Chí Minh',3);
/*!40000 ALTER TABLE `Province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Region`
--

DROP TABLE IF EXISTS `Region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Region` (
  `RegionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`RegionID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Region`
--

LOCK TABLES `Region` WRITE;
/*!40000 ALTER TABLE `Region` DISABLE KEYS */;
INSERT INTO `Region` VALUES (4,'Central'),(5,'East'),(3,'Ha Noi'),(1,'HCM'),(6,'Mekong'),(7,'North'),(2,'Đà Nẵng');
/*!40000 ALTER TABLE `Region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report4S`
--

DROP TABLE IF EXISTS `Report4S`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report4S` (
  `Report4SID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorID` bigint(20) NOT NULL,
  `DayOfMonth` int(11) DEFAULT NULL,
  `MonthOfYear` int(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `SMCode` varchar(255) DEFAULT NULL,
  `SECode` varchar(255) DEFAULT NULL,
  `ASMCode` varchar(255) DEFAULT NULL,
  `RSMCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Report4SID`),
  UNIQUE KEY `UQ_Report4S` (`DistributorID`,`SMCode`,`DayOfMonth`,`MonthOfYear`,`Year`),
  CONSTRAINT `FK_Report4S_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1593 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report4S`
--

LOCK TABLES `Report4S` WRITE;
/*!40000 ALTER TABLE `Report4S` DISABLE KEYS */;
INSERT INTO `Report4S` VALUES (269,3611,1,6,2013,'KLPS001','1527','0839','0938'),(270,3611,6,6,2013,'KLPS002','1527','0839','0938'),(271,3611,10,6,2013,'KLPS003','1527','0839','0938'),(272,3611,18,6,2013,'KLPS004','1527','0839','0938'),(273,3612,31,6,2013,'KIPS001','','0839','0938'),(274,3612,31,6,2013,'KIPS002','','0839','0938'),(275,3612,31,6,2013,'KIPS003','','0839','0938'),(276,3612,31,6,2013,'KIPS004','','0839','0938'),(277,3612,31,6,2013,'KIPS006','','0839','0938'),(278,3613,3,6,2013,'KNPS001','0523','0839','0938'),(279,3613,11,6,2013,'KNPS002','0523','0839','0938'),(280,3613,16,6,2013,'KNPS003','0523','0839','0938'),(281,3614,31,6,2013,'KOPS001','2652','0839','0938'),(282,3614,31,6,2013,'KOPS002','2652','0839','0938'),(283,3614,31,6,2013,'KOPS003','2652','0839','0938'),(284,3614,31,6,2013,'KOPS004','2652','0839','0938'),(285,3614,31,6,2013,'KOPS005','2652','0839','0938'),(286,3614,31,6,2013,'KOPS006','2652','0839','0938'),(287,3614,31,6,2013,'KOPS007','2652','0839','0938'),(288,3616,15,6,2013,'KKPS001','2724','0839','0938'),(289,3616,20,6,2013,'KKPS003','2724','0839','0938'),(290,3616,11,6,2013,'KKPS004','2724','0839','0938'),(291,3616,6,6,2013,'KKPS005','2724','0839','0938'),(292,3616,4,6,2013,'KKPS007','2724','0839','0938'),(293,3617,31,6,2013,'KHPS001','1475','0839','0938'),(294,3617,31,6,2013,'KHPS002','1475','0839','0938'),(295,3617,31,6,2013,'KHPS003','1475','0839','0938'),(296,3617,31,6,2013,'KHPS004','1475','0839','0938'),(297,3617,31,6,2013,'KHPS005','1475','0839','0938'),(298,3617,31,6,2013,'KHPS006','1475','0839','0938'),(299,3617,31,6,2013,'KHPS007','1475','0839','0938'),(300,3619,31,6,2013,'KTPS001','2664','1825','0938'),(301,3619,31,6,2013,'KTPS002','2664','1825','0938'),(302,3619,31,6,2013,'KTPS003','2664','1825','0938'),(303,3619,31,6,2013,'KTPS004','2664','1825','0938'),(304,3619,31,6,2013,'KTPS005','2664','1825','0938'),(305,3619,31,6,2013,'KTPS007','2664','1825','0938'),(306,3620,31,6,2013,'KYPS001','','1825','0938'),(307,3620,31,6,2013,'KYPS002','','1825','0938'),(308,3620,31,6,2013,'KYPS003','','1825','0938'),(309,3620,31,6,2013,'KYPS006','','1825','0938'),(310,3620,31,6,2013,'KYPS011','','1825','0938'),(311,3622,31,6,2013,'KUPS001','2696','1825','0938'),(312,3622,31,6,2013,'KUPS002','2696','1825','0938'),(313,3622,31,6,2013,'KUPS003','2696','1825','0938'),(314,3622,31,6,2013,'KUPS004','2696','1825','0938'),(315,3622,31,6,2013,'KUPS005','2696','1825','0938'),(316,3623,31,6,2013,'KVPS001','2501','1825','0938'),(317,3623,31,6,2013,'KVPS002','2501','1825','0938'),(318,3623,31,6,2013,'KVPS003','2501','1825','0938'),(319,3623,31,6,2013,'KVPS004','2501','1825','0938'),(320,3623,31,6,2013,'KVPS005','2501','1825','0938'),(321,3625,31,6,2013,'LDPS001','2907','1713','0938'),(322,3625,31,6,2013,'LDPS002','2907','1713','0938'),(323,3625,31,6,2013,'LDPS003','2907','1713','0938'),(324,3625,31,6,2013,'LDPS004','2907','1713','0938'),(325,3625,31,6,2013,'LDPS005','2907','1713','0938'),(326,3625,31,6,2013,'LDPS006','2907','1713','0938'),(327,3626,31,6,2013,'LEPS001','','1713','0938'),(328,3626,31,6,2013,'LEPS002','','1713','0938'),(329,3627,31,6,2013,'LHPS001','1181','1713','0938'),(330,3627,31,6,2013,'LHPS002','1181','1713','0938'),(331,3627,31,6,2013,'LHPS003','1181','1713','0938'),(332,3627,31,6,2013,'LHPS004','1181','1713','0938'),(333,3627,31,6,2013,'LHPS005','1181','1713','0938'),(334,3628,31,6,2013,'LFPS001','','1713','0938'),(335,3628,31,6,2013,'LFPS002','','1713','0938'),(336,3628,31,6,2013,'LFPS003','','1713','0938'),(337,3629,31,6,2013,'LBPS001','','1713','0938'),(338,3629,31,6,2013,'LBPS002','','1713','0938'),(339,3629,31,6,2013,'LBPS003','','1713','0938'),(340,3630,31,6,2013,'KZPS001','1962','1713','0938'),(341,3630,31,6,2013,'KZPS002','1962','1713','0938'),(342,3630,31,6,2013,'KZPS003','1962','1713','0938'),(343,3630,31,6,2013,'KZPS004','1962','1713','0938'),(344,3631,31,6,2013,'LIPS001','3061','1713','0938'),(345,3631,31,6,2013,'LIPS002','3061','1713','0938'),(346,3631,31,6,2013,'LIPS003','3061','1713','0938'),(347,3633,31,6,2013,'LLPS001','','1713','0938'),(348,3633,31,6,2013,'LLPS002','','1713','0938'),(349,3635,31,6,2013,'LJPS001','2791','1713','0938'),(350,3635,31,6,2013,'LJPS002','2791','1713','0938'),(351,3635,31,6,2013,'LJPS003','2791','1713','0938'),(352,3635,31,6,2013,'LJPS004','2791','1713','0938'),(353,3636,31,6,2013,'LCPS001','','1713','0938'),(354,3636,31,6,2013,'LCPS002','','1713','0938'),(355,3637,31,6,2013,'LGPS001','2790','1713','0938'),(356,3637,31,6,2013,'LGPS002','2790','1713','0938'),(357,3637,31,6,2013,'LGPS003','2790','1713','0938'),(358,3637,31,6,2013,'LGPS004','2790','1713','0938'),(359,3638,31,6,2013,'KAPS001','1857','1474','0938'),(360,3638,31,6,2013,'KAPS002','1857','1474','0938'),(361,3638,31,6,2013,'KAPS003','1857','1474','0938'),(362,3638,31,6,2013,'KAPS004','1857','1474','0938'),(363,3638,31,6,2013,'KAPS005','1857','1474','0938'),(364,3638,31,6,2013,'KAPS006','1857','1474','0938'),(365,3638,31,6,2013,'KAPS007','1857','1474','0938'),(366,3638,31,6,2013,'KAPS008','1857','1474','0938'),(367,3638,31,6,2013,'KAPS009','1857','1474','0938'),(368,3638,31,6,2013,'KAPS010','1857','1474','0938'),(369,3638,31,6,2013,'KAPS011','1857','1474','0938'),(370,3639,31,6,2013,'KCPS001','2908','1474','0938'),(371,3639,31,6,2013,'KCPS002','2908','1474','0938'),(372,3639,31,6,2013,'KCPS003','2908','1474','0938'),(373,3639,31,6,2013,'KCPS004','2908','1474','0938'),(374,3640,31,6,2013,'KFPS001','','1474','0938'),(375,3640,31,6,2013,'KFPS002','','1474','0938'),(376,3641,31,6,2013,'KEPS001','2757','1474','0938'),(377,3641,31,6,2013,'KEPS002','2757','1474','0938'),(378,3641,31,6,2013,'KEPS003','2757','1474','0938'),(379,3641,31,6,2013,'KEPS004','2757','1474','0938'),(380,3641,31,6,2013,'KEPS005','2757','1474','0938'),(381,3642,31,6,2013,'KBPS001','2502','1474','0938'),(382,3642,31,6,2013,'KBPS002','2502','1474','0938'),(383,3642,31,6,2013,'KBPS003','2502','1474','0938'),(384,3642,31,6,2013,'KBPS004','2502','1474','0938'),(385,3642,31,6,2013,'KBPS005','2502','1474','0938'),(386,3642,31,6,2013,'KBPS006','2502','1474','0938'),(387,3642,31,6,2013,'KBPS007','2502','1474','0938'),(388,3642,31,6,2013,'KBPS008','2502','1474','0938'),(389,3643,31,6,2013,'LQPS001','','1474','0938'),(390,3643,31,6,2013,'LQPS002','','1474','0938'),(391,3644,31,6,2013,'KDPS001','1714','1474','0938'),(392,3644,31,6,2013,'KDPS002','1714','1474','0938'),(393,3644,31,6,2013,'KDPS003','1714','1474','0938'),(394,3644,31,6,2013,'KDPS004','1714','1474','0938'),(395,3645,31,6,2013,'LNPS001','3082','1182','0938'),(396,3645,31,6,2013,'LNPS002','3082','1182','0938'),(397,3645,31,6,2013,'LNPS003','3082','1182','0938'),(398,3645,31,6,2013,'LNPS004','3082','1182','0938'),(399,3645,31,6,2013,'LNPS005','3082','1182','0938'),(400,3645,31,6,2013,'LNPS006','3082','1182','0938'),(401,3645,31,6,2013,'LNPS007','3082','1182','0938'),(402,3646,31,6,2013,'LOPS001','3081','1182','0938'),(403,3646,31,6,2013,'LOPS002','3081','1182','0938'),(404,3646,31,6,2013,'LOPS003','3081','1182','0938'),(405,3646,31,6,2013,'LOPS004','3081','1182','0938'),(406,3646,31,6,2013,'LOPS005','3081','1182','0938'),(407,3648,31,6,2013,'KPPS001','599','1182','0938'),(408,3648,31,6,2013,'KPPS002','599','1182','0938'),(409,3648,31,6,2013,'KPPS003','599','1182','0938'),(410,3648,31,6,2013,'KPPS004','599','1182','0938'),(411,3648,31,6,2013,'KPPS005','599','1182','0938'),(412,3648,31,6,2013,'KPPS006','599','1182','0938'),(413,3649,31,6,2013,'KXPS001','2758','1182','0938'),(414,3649,31,6,2013,'KXPS002','2758','1182','0938'),(415,3649,31,6,2013,'KXPS003','2758','1182','0938'),(416,3649,31,6,2013,'KXPS004','2758','1182','0938'),(417,3649,31,6,2013,'KXPS005','2758','1182','0938'),(418,3649,31,6,2013,'KXPS006','2758','1182','0938'),(419,3649,31,6,2013,'KXPS008','2758','1182','0938'),(420,3649,31,6,2013,'KXPS009','2758','1182','0938'),(421,3649,31,6,2013,'KXPS010','2758','1182','0938'),(422,3649,31,6,2013,'KXPS011','2758','1182','0938'),(423,3650,31,6,2013,'KSPS001','2899','1182','0938'),(424,3650,31,6,2013,'KSPS002','2899','1182','0938'),(425,3650,31,6,2013,'KSPS003','2899','1182','0938'),(426,3650,31,6,2013,'KSPS004','2899','1182','0938'),(427,3650,31,6,2013,'KSPS005','2899','1182','0938'),(428,3650,31,6,2013,'KSPS006','2899','1182','0938'),(429,3650,31,6,2013,'KSPS007','2899','1182','0938'),(430,3652,31,6,2013,'CKPS001','2760','0364','0575'),(431,3652,31,6,2013,'CKPS002','2760','0364','0575'),(432,3652,31,6,2013,'CKPS003','2760','0364','0575'),(433,3652,31,6,2013,'CKPS004','2760','0364','0575'),(434,3652,31,6,2013,'CKPS005','2760','0364','0575'),(435,3652,31,6,2013,'CKPS006','2760','0364','0575'),(436,3652,31,6,2013,'CKPS007','2760','0364','0575'),(437,3652,31,6,2013,'CKPS008','2760','0364','0575'),(438,3653,31,6,2013,'CMPS001','2894','0364','0575'),(439,3653,31,6,2013,'CMPS002','2894','0364','0575'),(440,3653,31,6,2013,'CMPS003','2894','0364','0575'),(441,3653,31,6,2013,'CMPS004','2894','0364','0575'),(442,3653,31,6,2013,'CMPS005','2894','0364','0575'),(443,3653,31,6,2013,'CMPS008','2894','0364','0575'),(444,3653,31,6,2013,'CMPS009','2894','0364','0575'),(445,3654,31,6,2013,'CEPS001','2281','0364','0575'),(446,3654,31,6,2013,'CEPS002','2281','0364','0575'),(447,3654,31,6,2013,'CEPS003','2281','0364','0575'),(448,3654,31,6,2013,'CEPS004','2281','0364','0575'),(449,3654,31,6,2013,'CEPS005','2281','0364','0575'),(450,3654,31,6,2013,'CEPS006','2281','0364','0575'),(451,3654,31,6,2013,'CEPS007','2281','0364','0575'),(452,3655,31,6,2013,'CAPS001','1724','0364','0575'),(453,3655,31,6,2013,'CAPS002','1724','0364','0575'),(454,3655,31,6,2013,'CAPS003','1724','0364','0575'),(455,3655,31,6,2013,'CAPS004','1724','0364','0575'),(456,3655,31,6,2013,'CAPS005','1724','0364','0575'),(457,3655,31,6,2013,'CAPS006','1724','0364','0575'),(458,3655,31,6,2013,'CAPS007','1724','0364','0575'),(459,3655,31,6,2013,'CAPS010','1724','0364','0575'),(460,3655,31,6,2013,'CAPS012','1724','0364','0575'),(461,3656,31,6,2013,'CHPS002','2125','0364','0575'),(462,3656,31,6,2013,'CHPS003','2125','0364','0575'),(463,3656,31,6,2013,'CHPS004','2125','0364','0575'),(464,3656,31,6,2013,'CHPS005','2125','0364','0575'),(465,3656,31,6,2013,'CHPS006','2125','0364','0575'),(466,3656,31,6,2013,'CHPS007','2125','0364','0575'),(467,3656,31,6,2013,'CHPS008','2125','0364','0575'),(468,3656,31,6,2013,'CHPS009','2125','0364','0575'),(469,3656,31,6,2013,'CHPS011','2125','0364','0575'),(470,3657,31,6,2013,'CBPS001','2770','0364','0575'),(471,3657,31,6,2013,'CBPS002','2770','0364','0575'),(472,3657,31,6,2013,'CBPS003','2770','0364','0575'),(473,3657,31,6,2013,'CBPS004','2770','0364','0575'),(474,3657,31,6,2013,'CBPS005','2770','0364','0575'),(475,3657,31,6,2013,'CBPS006','2770','0364','0575'),(476,3657,31,6,2013,'CBPS007','2770','0364','0575'),(477,3657,31,6,2013,'CBPS008','2770','0364','0575'),(478,3657,31,6,2013,'CBPS009','2770','0364','0575'),(479,3658,31,6,2013,'CCPS001','2607','0364','0575'),(480,3658,31,6,2013,'CCPS002','2607','0364','0575'),(481,3658,31,6,2013,'CCPS003','2607','0364','0575'),(482,3658,31,6,2013,'CCPS004','2607','0364','0575'),(483,3658,31,6,2013,'CCPS005','2607','0364','0575'),(484,3658,31,6,2013,'CCPS006','2607','0364','0575'),(485,3658,31,6,2013,'CCPS007','2607','0364','0575'),(486,3658,31,6,2013,'CCPS008','2607','0364','0575'),(487,3658,31,6,2013,'CCPS009','2607','0364','0575'),(488,3658,31,6,2013,'CCPS010','2607','0364','0575'),(489,3658,31,6,2013,'CCPS011','2607','0364','0575'),(490,3659,31,6,2013,'CDPS001','3154','1473','0575'),(491,3659,31,6,2013,'CDPS002','3154','1473','0575'),(492,3660,31,6,2013,'CIPS001','2723','1473','0575'),(493,3660,31,6,2013,'CIPS002','2723','1473','0575'),(494,3660,31,6,2013,'CIPS003','2723','1473','0575'),(495,3660,31,6,2013,'CIPS004','2723','1473','0575'),(496,3660,31,6,2013,'CIPS005','2723','1473','0575'),(497,3660,31,6,2013,'CIPS006','2723','1473','0575'),(498,3660,31,6,2013,'CIPS007','2723','1473','0575'),(499,3660,31,6,2013,'CIPS008','2723','1473','0575'),(500,3660,31,6,2013,'CIPS009','2723','1473','0575'),(501,3660,31,6,2013,'CIPS011','2723','1473','0575'),(502,3660,31,6,2013,'CIPS012','2723','1473','0575'),(503,3661,31,6,2013,'CLPS001','1572','1473','0575'),(504,3661,31,6,2013,'CLPS002','1572','1473','0575'),(505,3661,31,6,2013,'CLPS003','1572','1473','0575'),(506,3661,31,6,2013,'CLPS004','1572','1473','0575'),(507,3661,31,6,2013,'CLPS005','1572','1473','0575'),(508,3661,31,6,2013,'CLPS006','1572','1473','0575'),(509,3661,31,6,2013,'CLPS007','1572','1473','0575'),(510,3661,31,6,2013,'CLPS008','1572','1473','0575'),(511,3661,31,6,2013,'CLPS009','1572','1473','0575'),(512,3661,31,6,2013,'CLPS014','1572','1473','0575'),(513,3662,31,6,2013,'CLPS010','2052','1473','0575'),(514,3662,31,6,2013,'CLPS011','2052','1473','0575'),(515,3662,31,6,2013,'CLPS012','2052','1473','0575'),(516,3662,31,6,2013,'CLPS013','2052','1473','0575'),(517,3662,31,6,2013,'CLPS015','2052','1473','0575'),(518,3663,31,6,2013,'CJPS001','2623','1473','0575'),(519,3663,31,6,2013,'CJPS002','2623','1473','0575'),(520,3663,31,6,2013,'CJPS003','2623','1473','0575'),(521,3663,31,6,2013,'CJPS004','2623','1473','0575'),(522,3663,31,6,2013,'CJPS005','2623','1473','0575'),(523,3663,31,6,2013,'CJPS006','2623','1473','0575'),(524,3663,31,6,2013,'CJPS007','2623','1473','0575'),(525,3664,31,6,2013,'CGPS002','2651','1473','0575'),(526,3664,31,6,2013,'CGPS003','2651','1473','0575'),(527,3664,31,6,2013,'CGPS004','2651','1473','0575'),(528,3664,31,6,2013,'CGPS005','2651','1473','0575'),(529,3664,31,6,2013,'CGPS006','2651','1473','0575'),(530,3664,31,6,2013,'CGPS007','2651','1473','0575'),(531,3664,31,6,2013,'CGPS008','2651','1473','0575'),(532,3664,31,6,2013,'CGPS009','2651','1473','0575'),(533,3665,31,6,2013,'IDPS001','3159','2020','2615'),(534,3665,31,6,2013,'IDPS002','3159','2020','2615'),(535,3665,31,6,2013,'IDPS003','3159','2020','2615'),(536,3665,31,6,2013,'IDPS004','3159','2020','2615'),(537,3665,31,6,2013,'IDPS005','3159','2020','2615'),(538,3665,31,6,2013,'IDPS006','3159','2020','2615'),(539,3665,31,6,2013,'IDPS007','3159','2020','2615'),(540,3665,31,6,2013,'IDPS008','3159','2020','2615'),(541,3665,31,6,2013,'IDPS009','3159','2020','2615'),(542,3665,31,6,2013,'IDPS010','3159','2020','2615'),(543,3666,31,6,2013,'IBPS001','2324','2020','2615'),(544,3666,31,6,2013,'IBPS002','2324','2020','2615'),(545,3666,31,6,2013,'IBPS003','2324','2020','2615'),(546,3666,31,6,2013,'IBPS004','2324','2020','2615'),(547,3666,31,6,2013,'IBPS005','2324','2020','2615'),(548,3666,31,6,2013,'IBPS007','2324','2020','2615'),(549,3666,31,6,2013,'IBPS008','2324','2020','2615'),(550,3666,31,6,2013,'IBPS009','2324','2020','2615'),(551,3667,31,6,2013,'ICPS001','2846','2020','2615'),(552,3667,31,6,2013,'ICPS002','2846','2020','2615'),(553,3667,31,6,2013,'ICPS003','2846','2020','2615'),(554,3667,31,6,2013,'ICPS004','2846','2020','2615'),(555,3667,31,6,2013,'ICPS005','2846','2020','2615'),(556,3667,31,6,2013,'ICPS006','2846','2020','2615'),(557,3667,31,6,2013,'ICPS007','2846','2020','2615'),(558,3667,31,6,2013,'ICPS008','2846','2020','2615'),(559,3667,31,6,2013,'ICPS010','2846','2020','2615'),(560,3667,31,6,2013,'ICPS011','2846','2020','2615'),(561,3668,31,6,2013,'IAPS001','2807','2020','2615'),(562,3668,31,6,2013,'IAPS002','2807','2020','2615'),(563,3668,31,6,2013,'IAPS003','2807','2020','2615'),(564,3668,31,6,2013,'IAPS004','2807','2020','2615'),(565,3668,31,6,2013,'IAPS005','2807','2020','2615'),(566,3668,31,6,2013,'IAPS006','2807','2020','2615'),(567,3668,31,6,2013,'IAPS007','2807','2020','2615'),(568,3668,31,6,2013,'IAPS008','2807','2020','2615'),(569,3668,31,6,2013,'IAPS009','2807','2020','2615'),(570,3668,31,6,2013,'IAPS010','2807','2020','2615'),(571,3669,31,6,2013,'IRPS001','2139','1193','2615'),(572,3669,31,6,2013,'IRPS002','2139','1193','2615'),(573,3669,31,6,2013,'IRPS003','2139','1193','2615'),(574,3669,31,6,2013,'IRPS004','2139','1193','2615'),(575,3671,31,6,2013,'ISPS001','2593','1193','2615'),(576,3671,31,6,2013,'ISPS002','2593','1193','2615'),(577,3671,31,6,2013,'ISPS003','2593','1193','2615'),(578,3671,31,6,2013,'ISPS004','2593','1193','2615'),(579,3671,31,6,2013,'ISPS005','2593','1193','2615'),(580,3672,31,6,2013,'IPPS002','2070','1193','2615'),(581,3672,31,6,2013,'IPPS003','2070','1193','2615'),(582,3672,31,6,2013,'IPPS004','2070','1193','2615'),(583,3672,31,6,2013,'IPPS005','2070','1193','2615'),(584,3673,31,6,2013,'IPPS006','2070','1193','2615'),(585,3673,31,6,2013,'IPPS007','2070','1193','2615'),(586,3673,31,6,2013,'IPPS008','2070','1193','2615'),(587,3673,31,6,2013,'IPPS009','2070','1193','2615'),(588,3673,31,6,2013,'IPPS010','2070','1193','2615'),(589,3673,31,6,2013,'IPPS012','2070','1193','2615'),(590,3673,31,6,2013,'IPPS013','2070','1193','2615'),(591,3674,31,6,2013,'ILPS003','2679','1193','2615'),(592,3674,31,6,2013,'ILPS004','2679','1193','2615'),(593,3674,31,6,2013,'ILPS005','2679','1193','2615'),(594,3674,31,6,2013,'ILPS006','2679','1193','2615'),(595,3675,31,6,2013,'FHPS001','1193','1193','2615'),(596,3675,31,6,2013,'FHPS002','1193','1193','2615'),(597,3675,31,6,2013,'FHPS003','1193','1193','2615'),(598,3677,31,6,2013,'IOPS001','3064','1193','2615'),(599,3677,31,6,2013,'IOPS003','3064','1193','2615'),(600,3677,31,6,2013,'IOPS004','3064','1193','2615'),(601,3677,31,6,2013,'IOPS005','3064','1193','2615'),(602,3677,31,6,2013,'IOPS006','3064','1193','2615'),(603,3677,31,6,2013,'IOPS008','3064','1193','2615'),(604,3678,31,6,2013,'IXPS008','1912','1656','2615'),(605,3678,31,6,2013,'IXPS009','1912','1656','2615'),(606,3678,31,6,2013,'IXPS010','1912','1656','2615'),(607,3678,31,6,2013,'IXPS011','1912','1656','2615'),(608,3678,31,6,2013,'IXPS012','1912','1656','2615'),(609,3679,31,6,2013,'IXPS001','2037','1656','2615'),(610,3679,31,6,2013,'IXPS002','2037','1656','2615'),(611,3679,31,6,2013,'IXPS003','2037','1656','2615'),(612,3679,31,6,2013,'IXPS004','2037','1656','2615'),(613,3679,31,6,2013,'IXPS005','2037','1656','2615'),(614,3679,31,6,2013,'IXPS006','2037','1656','2615'),(615,3679,31,6,2013,'IXPS007','2037','1656','2615'),(616,3679,31,6,2013,'IXPS013','2037','1656','2615'),(617,3682,31,6,2013,'IWPS001','2060','1656','2615'),(618,3682,31,6,2013,'IWPS002','2060','1656','2615'),(619,3682,31,6,2013,'IWPS003','2060','1656','2615'),(620,3682,31,6,2013,'IWPS004','2060','1656','2615'),(621,3682,31,6,2013,'IWPS005','2060','1656','2615'),(622,3685,31,6,2013,'IVPS002','1656','1656','2615'),(623,3685,31,6,2013,'IVPS003','1656','1656','2615'),(624,3685,31,6,2013,'IVPS004','1656','1656','2615'),(625,3687,31,6,2013,'GTPS001','2947','0552','0817'),(626,3687,31,6,2013,'GTPS002','2947','0552','0817'),(627,3687,31,6,2013,'GTPS003','2947','0552','0817'),(628,3687,31,6,2013,'GTPS004','2947','0552','0817'),(629,3688,31,6,2013,'GQPS001','1051','0552','0817'),(630,3688,31,6,2013,'GQPS002','1051','0552','0817'),(631,3688,31,6,2013,'GQPS003','1051','0552','0817'),(632,3688,31,6,2013,'GQPS004','1051','0552','0817'),(633,3688,31,6,2013,'GQPS005','1051','0552','0817'),(634,3688,31,6,2013,'GQPS006','1051','0552','0817'),(635,3688,31,6,2013,'GQPS010','1051','0552','0817'),(636,3689,31,6,2013,'GXPS001','1051','0552','0817'),(637,3689,31,6,2013,'GXPS002','1051','0552','0817'),(638,3689,31,6,2013,'GXPS003','1051','0552','0817'),(639,3690,31,6,2013,'GRPS001','','0552','0817'),(640,3690,31,6,2013,'GRPS002','','0552','0817'),(641,3690,31,6,2013,'GRPS003','','0552','0817'),(642,3690,31,6,2013,'GRPS004','','0552','0817'),(643,3690,31,6,2013,'GRPS005','','0552','0817'),(644,3690,31,6,2013,'GRPS006','','0552','0817'),(645,3691,31,6,2013,'GSPS001','0988','0552','0817'),(646,3691,31,6,2013,'GSPS002','0988','0552','0817'),(647,3691,31,6,2013,'GSPS003','0988','0552','0817'),(648,3691,31,6,2013,'GSPS004','0988','0552','0817'),(649,3691,31,6,2013,'GSPS005','0988','0552','0817'),(650,3691,31,6,2013,'GSPS006','0988','0552','0817'),(651,3691,31,6,2013,'GSPS007','0988','0552','0817'),(652,3692,31,6,2013,'GOPS001','','1086','0817'),(653,3692,31,6,2013,'GOPS002','','1086','0817'),(654,3692,31,6,2013,'GOPS003','','1086','0817'),(655,3692,31,6,2013,'GOPS004','','1086','0817'),(656,3692,31,6,2013,'GOPS005','','1086','0817'),(657,3692,31,6,2013,'GOPS006','','1086','0817'),(658,3692,31,6,2013,'GOPS007','','1086','0817'),(659,3692,31,6,2013,'GOPS008','','1086','0817'),(660,3692,31,6,2013,'GOPS009','','1086','0817'),(661,3693,31,6,2013,'GLPS001','623','1086','0817'),(662,3693,31,6,2013,'GLPS002','623','1086','0817'),(663,3693,31,6,2013,'GLPS003','623','1086','0817'),(664,3693,31,6,2013,'GLPS004','623','1086','0817'),(665,3693,31,6,2013,'GLPS005','623','1086','0817'),(666,3693,31,6,2013,'GLPS006','623','1086','0817'),(667,3696,31,6,2013,'GNPS001','0743','1086','0817'),(668,3696,31,6,2013,'GNPS002','0743','1086','0817'),(669,3696,31,6,2013,'GNPS003','0743','1086','0817'),(670,3696,31,6,2013,'GNPS005','0743','1086','0817'),(671,3696,31,6,2013,'GNPS006','0743','1086','0817'),(672,3697,31,6,2013,'GPPS001','1244','1086','0817'),(673,3697,31,6,2013,'GPPS002','1244','1086','0817'),(674,3697,31,6,2013,'GPPS003','1244','1086','0817'),(675,3697,31,6,2013,'GPPS004','1244','1086','0817'),(676,3697,31,6,2013,'GPPS005','1244','1086','0817'),(677,3699,31,6,2013,'GCPS001','1278','0875','0817'),(678,3699,31,6,2013,'GCPS002','1278','0875','0817'),(679,3699,31,6,2013,'GCPS003','1278','0875','0817'),(680,3699,31,6,2013,'GCPS004','1278','0875','0817'),(681,3699,31,6,2013,'GCPS005','1278','0875','0817'),(682,3699,31,6,2013,'GCPS006','1278','0875','0817'),(683,3700,31,6,2013,'GDPS001','2736','0875','0817'),(684,3700,31,6,2013,'GDPS002','2736','0875','0817'),(685,3700,31,6,2013,'GDPS003','2736','0875','0817'),(686,3700,31,6,2013,'GDPS004','2736','0875','0817'),(687,3701,31,6,2013,'GAPS001','2194','0875','0817'),(688,3701,31,6,2013,'GAPS002','2194','0875','0817'),(689,3701,31,6,2013,'GAPS003','2194','0875','0817'),(690,3701,31,6,2013,'GAPS004','2194','0875','0817'),(691,3702,31,6,2013,'GWPS001','2923','0875','0817'),(692,3702,31,6,2013,'GWPS002','2923','0875','0817'),(693,3702,31,6,2013,'GWPS003','2923','0875','0817'),(694,3702,31,6,2013,'GWPS004','2923','0875','0817'),(695,3702,31,6,2013,'GWPS005','2923','0875','0817'),(696,3703,31,6,2013,'GBPS001','2938','0875','0817'),(697,3703,31,6,2013,'GBPS002','2938','0875','0817'),(698,3703,31,6,2013,'GBPS003','2938','0875','0817'),(699,3703,31,6,2013,'GBPS004','2938','0875','0817'),(700,3703,31,6,2013,'GBPS005','2938','0875','0817'),(701,3704,31,6,2013,'GFPS001','2352','0875','0817'),(702,3704,31,6,2013,'GFPS002','2352','0875','0817'),(703,3704,31,6,2013,'GFPS003','2352','0875','0817'),(704,3704,31,6,2013,'GFPS004','2352','0875','0817'),(705,3704,31,6,2013,'GFPS010','2352','0875','0817'),(706,3705,31,6,2013,'GFPS005','1647','0875','0817'),(707,3705,31,6,2013,'GFPS006','1647','0875','0817'),(708,3705,31,6,2013,'GFPS007','1647','0875','0817'),(709,3705,31,6,2013,'GFPS009','1647','0875','0817'),(710,3706,31,6,2013,'GGPS001','','0875','0817'),(711,3706,31,6,2013,'GGPS002','','0875','0817'),(712,3706,31,6,2013,'GGPS005','','0875','0817'),(713,3706,31,6,2013,'GGPS006','','0875','0817'),(714,3707,31,6,2013,'GIPS001','','1292','0817'),(715,3707,31,6,2013,'GIPS002','','1292','0817'),(716,3707,31,6,2013,'GIPS003','','1292','0817'),(717,3707,31,6,2013,'GIPS006','','1292','0817'),(718,3708,31,6,2013,'GIPS004','','1292','0817'),(719,3708,31,6,2013,'GIPS005','','1292','0817'),(720,3708,31,6,2013,'GIPS007','','1292','0817'),(721,3708,31,6,2013,'GIPS008','','1292','0817'),(722,3709,31,6,2013,'GJPS001','1581','1292','0817'),(723,3709,31,6,2013,'GJPS002','1581','1292','0817'),(724,3709,31,6,2013,'GJPS003','1581','1292','0817'),(725,3709,31,6,2013,'GJPS004','1581','1292','0817'),(726,3709,31,6,2013,'GJPS005','1581','1292','0817'),(727,3709,31,6,2013,'GJPS006','1581','1292','0817'),(728,3709,31,6,2013,'GJPS007','1581','1292','0817'),(729,3709,31,6,2013,'GJPS011','1581','1292','0817'),(730,3710,31,6,2013,'GJPS001','1581','1292','0817'),(731,3710,31,6,2013,'GJPS002','1581','1292','0817'),(732,3710,31,6,2013,'GJPS008','1581','1292','0817'),(733,3710,31,6,2013,'GJPS010','1581','1292','0817'),(734,3712,31,6,2013,'GHPS001','2966','1292','0817'),(735,3712,31,6,2013,'GHPS002','2966','1292','0817'),(736,3712,31,6,2013,'GHPS003','2966','1292','0817'),(737,3712,31,6,2013,'GHPS004','2966','1292','0817'),(738,3712,31,6,2013,'GHPS005','2966','1292','0817'),(739,3712,31,6,2013,'GHPS006','2966','1292','0817'),(740,3712,31,6,2013,'GHPS007','2966','1292','0817'),(741,3712,31,6,2013,'GHPS009','2966','1292','0817'),(742,3713,31,6,2013,'GHPS010','1855','1292','0817'),(743,3713,31,6,2013,'GHPS011','1855','1292','0817'),(744,3713,31,6,2013,'GHPS012','1855','1292','0817'),(745,3713,31,6,2013,'GHPS013','1855','1292','0817'),(746,3713,31,6,2013,'GHPS014','1855','1292','0817'),(747,3713,31,6,2013,'GHPS015','1855','1292','0817'),(748,3713,31,6,2013,'GHPS016','1855','1292','0817'),(749,3713,31,6,2013,'GHPS017','1855','1292','0817'),(750,3714,31,6,2013,'GVPS001','2921','1292','0817'),(751,3714,31,6,2013,'GVPS002','2921','1292','0817'),(752,3714,31,6,2013,'GVPS003','2921','1292','0817'),(753,3714,31,6,2013,'GVPS004','2921','1292','0817'),(754,3714,31,6,2013,'GVPS005','2921','1292','0817'),(755,3717,31,6,2013,'AFPS001','2421','1013','1493'),(756,3717,31,6,2013,'AFPS002','2421','1013','1493'),(757,3717,31,6,2013,'AFPS004','2421','1013','1493'),(758,3717,31,6,2013,'AFPS005','2421','1013','1493'),(759,3717,31,6,2013,'AFPS006','2421','1013','1493'),(760,3718,31,6,2013,'AFPS007','1471','1013','1493'),(761,3718,31,6,2013,'AFPS008','1471','1013','1493'),(762,3718,31,6,2013,'AFPS009','1471','1013','1493'),(763,3718,31,6,2013,'AFPS010','1471','1013','1493'),(764,3718,31,6,2013,'AFPS011','1471','1013','1493'),(765,3718,31,6,2013,'AFPS013','1471','1013','1493'),(766,3718,31,6,2013,'AFPS014','1471','1013','1493'),(767,3718,31,6,2013,'AFPS015','1471','1013','1493'),(768,3718,31,6,2013,'AFPS016','1471','1013','1493'),(769,3718,31,6,2013,'AFPS017','1471','1013','1493'),(770,3720,31,6,2013,'ACPS001','1568','1013','1493'),(771,3720,31,6,2013,'ACPS002','1568','1013','1493'),(772,3720,31,6,2013,'ACPS003','1568','1013','1493'),(773,3720,31,6,2013,'ACPS005','1568','1013','1493'),(774,3720,31,6,2013,'ACPS007','1568','1013','1493'),(775,3721,31,6,2013,'AVPS001','1168','1723','1493'),(776,3721,31,6,2013,'AVPS002','1168','1723','1493'),(777,3721,31,6,2013,'AVPS003','1168','1723','1493'),(778,3721,31,6,2013,'AVPS004','1168','1723','1493'),(779,3721,31,6,2013,'AVPS005','1168','1723','1493'),(780,3721,31,6,2013,'AVPS006','1168','1723','1493'),(781,3721,31,6,2013,'AVPS007','1168','1723','1493'),(782,3721,31,6,2013,'AVPS008','1168','1723','1493'),(783,3721,31,6,2013,'AVPS009','1168','1723','1493'),(784,3722,31,6,2013,'ASPS002','0612','1723','1493'),(785,3722,31,6,2013,'ASPS003','0612','1723','1493'),(786,3722,31,6,2013,'ASPS005','0612','1723','1493'),(787,3722,31,6,2013,'ASPS006','0612','1723','1493'),(788,3722,31,6,2013,'ASPS008','0612','1723','1493'),(789,3722,31,6,2013,'ASPS011','0612','1723','1493'),(790,3722,31,6,2013,'ASPS013','0612','1723','1493'),(791,3722,31,6,2013,'ASPS014','0612','1723','1493'),(792,3722,31,6,2013,'ASPS015','2467','1723','1493'),(793,3723,31,6,2013,'AOPS001','2467','1723','1493'),(794,3723,31,6,2013,'AOPS003','2467','1723','1493'),(795,3723,31,6,2013,'AOPS004','2467','1723','1493'),(796,3723,31,6,2013,'AOPS005','2467','1723','1493'),(797,3723,31,6,2013,'AOPS007','2467','1723','1493'),(798,3723,31,6,2013,'AOPS008','2467','1723','1493'),(799,3723,31,6,2013,'AOPS011','2467','1723','1493'),(800,3723,31,6,2013,'AOPS012','2467','1723','1493'),(801,3723,31,6,2013,'AOPS013','2467','1723','1493'),(802,3724,31,6,2013,'AMPS002','0618','1723','1493'),(803,3724,31,6,2013,'AMPS003','0618','1723','1493'),(804,3724,31,6,2013,'AMPS004','0618','1723','1493'),(805,3724,31,6,2013,'AMPS005','0618','1723','1493'),(806,3724,31,6,2013,'AMPS006','0618','1723','1493'),(807,3724,31,6,2013,'AMPS007','0618','1723','1493'),(808,3724,31,6,2013,'AMPS008','0618','1723','1493'),(809,3724,31,6,2013,'AMPS009','0618','1723','1493'),(810,3724,31,6,2013,'AMPS010','0618','1723','1493'),(811,3724,31,6,2013,'AMPS012','0618','1723','1493'),(812,3728,31,6,2013,'ANPS001','0431','0250','1493'),(813,3728,31,6,2013,'ANPS002','0431','0250','1493'),(814,3728,31,6,2013,'ANPS003','0431','0250','1493'),(815,3728,31,6,2013,'ANPS004','0431','0250','1493'),(816,3728,31,6,2013,'ANPS005','0431','0250','1493'),(817,3728,31,6,2013,'ANPS006','0431','0250','1493'),(818,3729,31,6,2013,'AQPS001','1225','0250','1493'),(819,3729,31,6,2013,'AQPS002','1225','0250','1493'),(820,3729,31,6,2013,'AQPS003','1225','0250','1493'),(821,3729,31,6,2013,'AQPS005','1225','0250','1493'),(822,3729,31,6,2013,'AQPS006','1225','0250','1493'),(823,3729,31,6,2013,'AQPS009','1225','0250','1493'),(824,3729,31,6,2013,'AQPS010','1225','0250','1493'),(825,3730,31,6,2013,'AWPS001','485','0250','1493'),(826,3730,31,6,2013,'AWPS002','485','0250','1493'),(827,3730,31,6,2013,'AWPS003','485','0250','1493'),(828,3731,31,6,2013,'AWPS004','2405','0021','1493'),(829,3731,31,6,2013,'AWPS005','2405','0021','1493'),(830,3731,31,6,2013,'AWPS006','2405','0021','1493'),(831,3731,31,6,2013,'AWPS007','2405','0021','1493'),(832,3731,31,6,2013,'AWPS008','2405','0021','1493'),(833,3732,31,6,2013,'AUPS001','1382','0250','1493'),(834,3732,31,6,2013,'AUPS002','1382','0250','1493'),(835,3732,31,6,2013,'AUPS003','1382','0250','1493'),(836,3732,31,6,2013,'AUPS004','1382','0250','1493'),(837,3732,31,6,2013,'AUPS005','1382','0250','1493'),(838,3732,31,6,2013,'AUPS006','1382','0250','1493'),(839,3732,31,6,2013,'AUPS007','1382','0250','1493'),(840,3732,31,6,2013,'AUPS008','1382','0250','1493'),(841,3732,31,6,2013,'AUPS010','1382','0250','1493'),(842,3733,31,6,2013,'APPS001','0286','0021','1493'),(843,3733,31,6,2013,'APPS002','0286','0021','1493'),(844,3733,31,6,2013,'APPS003','0286','0021','1493'),(845,3733,31,6,2013,'APPS004','0286','0021','1493'),(846,3733,31,6,2013,'APPS005','0286','0021','1493'),(847,3733,31,6,2013,'APPS006','0286','0021','1493'),(848,3733,31,6,2013,'APPS007','0286','0021','1493'),(849,3733,31,6,2013,'APPS008','0286','0021','1493'),(850,3733,31,6,2013,'APPS009','0286','0021','1493'),(851,3733,31,6,2013,'APPS011','0286','0021','1493'),(852,3733,31,6,2013,'APPS012','0286','0021','1493'),(853,3792,31,6,2013,'AGPS002','0619','0021','1493'),(854,3792,31,6,2013,'AGPS003','0619','0021','1493'),(855,3792,31,6,2013,'AGPS004','0619','0021','1493'),(856,3792,31,6,2013,'AGPS005','0619','0021','1493'),(857,3792,31,6,2013,'AGPS006','0619','0021','1493'),(858,3792,31,6,2013,'AGPS007','0619','0021','1493'),(859,3792,31,6,2013,'AGPS008','0619','0021','1493'),(860,3792,31,6,2013,'AGPS009','0619','0021','1493'),(861,3792,31,6,2013,'AGPS010','0619','0021','1493'),(862,3792,31,6,2013,'AGPS011','0619','0021','1493'),(863,3792,31,6,2013,'AGPS021','0619','0021','1493'),(864,3792,31,6,2013,'AGPS023','0619','0021','1493'),(865,3746,1,6,2013,'AGPS012','1014','0021','1493'),(866,3746,31,6,2013,'AGPS013','1014','0021','1493'),(867,3746,31,6,2013,'AGPS014','1014','0021','1493'),(868,3746,31,6,2013,'AGPS015','1014','0021','1493'),(869,3746,31,6,2013,'AGPS016','1014','0021','1493'),(870,3746,31,6,2013,'AGPS017','1014','0021','1493'),(871,3746,31,6,2013,'AGPS018','1014','0021','1493'),(872,3746,31,6,2013,'AGPS019','1014','0021','1493'),(873,3746,31,6,2013,'AGPS020','1014','0021','1493'),(874,3746,31,6,2013,'AGPS022','1014','0021','1493'),(875,3747,31,6,2013,'AEPS001','0240','0021','1493'),(876,3747,31,6,2013,'AEPS003','0240','0021','1493'),(877,3747,31,6,2013,'AEPS004','0240','0021','1493'),(878,3747,31,6,2013,'AEPS005','0240','0021','1493'),(879,3747,31,6,2013,'AEPS006','0240','0021','1493'),(880,3747,31,6,2013,'AEPS007','0240','0021','1493'),(881,3747,31,6,2013,'AEPS008','0240','0021','1493'),(882,3747,31,6,2013,'AEPS009','0240','0021','1493'),(883,3748,31,6,2013,'AHPS001','1170','0021','1493'),(884,3748,31,6,2013,'AHPS002','1170','0021','1493'),(885,3748,31,6,2013,'AHPS003','1170','0021','1493'),(886,3748,31,6,2013,'AHPS004','1170','0021','1493'),(887,3748,31,6,2013,'AHPS005','1170','0021','1493'),(888,3748,31,6,2013,'AHPS006','1170','0021','1493'),(889,3748,31,6,2013,'AHPS007','1170','0021','1493'),(890,3748,31,6,2013,'AHPS009','1170','0021','1493'),(891,3750,31,6,2013,'EGPS001','2663','2137','0254'),(892,3750,31,6,2013,'EGPS002','2663','2137','0254'),(893,3750,31,6,2013,'EGPS003','2663','2137','0254'),(894,3750,31,6,2013,'EGPS004','2663','2137','0254'),(895,3750,31,6,2013,'EGPS005','2663','2137','0254'),(896,3750,31,6,2013,'EGPS006','2663','2137','0254'),(897,3750,31,6,2013,'EGPS007','2663','2137','0254'),(898,3750,31,6,2013,'EGPS008','2663','2137','0254'),(899,3750,31,6,2013,'EGPS010','2663','2137','0254'),(900,3750,31,6,2013,'EGPS011','2663','2137','0254'),(901,3750,31,6,2013,'EGPS012','2663','2137','0254'),(902,3751,31,6,2013,'FJPS001','1750','2137','0254'),(903,3751,31,6,2013,'FJPS002','1750','2137','0254'),(904,3751,31,6,2013,'FJPS003','1750','2137','0254'),(905,3752,31,6,2013,'ETPS001','2078','2137','0254'),(906,3752,31,6,2013,'ETPS002','2078','2137','0254'),(907,3752,31,6,2013,'ETPS003','2078','2137','0254'),(908,3752,31,6,2013,'ETPS004','2078','2137','0254'),(909,3752,31,6,2013,'ETPS005','2078','2137','0254'),(910,3752,31,6,2013,'ETPS006','2078','2137','0254'),(911,3752,31,6,2013,'ETPS009','2078','2137','0254'),(912,3753,31,6,2013,'ECPS001','1166','2137','0254'),(913,3753,31,6,2013,'ECPS002','1166','2137','0254'),(914,3753,31,6,2013,'ECPS003','1166','2137','0254'),(915,3753,31,6,2013,'ECPS004','1166','2137','0254'),(916,3753,31,6,2013,'ECPS005','1166','2137','0254'),(917,3753,31,6,2013,'ECPS007','1166','2137','0254'),(918,3753,31,6,2013,'ECPS008','1166','2137','0254'),(919,3754,31,6,2013,'EUPS001','1750','2137','0254'),(920,3754,31,6,2013,'EUPS003','1750','2137','0254'),(921,3754,31,6,2013,'EUPS005','1750','2137','0254'),(922,3754,31,6,2013,'EUPS006','1750','2137','0254'),(923,3754,31,6,2013,'EUPS007','1750','2137','0254'),(924,3755,31,6,2013,'EAPS001','985','2137','0254'),(925,3755,31,6,2013,'EAPS002','985','2137','0254'),(926,3755,31,6,2013,'EAPS003','985','2137','0254'),(927,3755,31,6,2013,'EAPS004','985','2137','0254'),(928,3755,31,6,2013,'EAPS005','985','2137','0254'),(929,3755,31,6,2013,'EAPS006','985','2137','0254'),(930,3755,31,6,2013,'EAPS007','985','2137','0254'),(931,3755,31,6,2013,'EAPS008','985','2137','0254'),(932,3755,31,6,2013,'EAPS009','985','2137','0254'),(933,3756,31,6,2013,'EVPS001','1858','2137','0254'),(934,3756,31,6,2013,'EVPS002','1858','2137','0254'),(935,3756,31,6,2013,'EVPS003','1858','2137','0254'),(936,3756,31,6,2013,'EVPS004','1858','2137','0254'),(937,3756,31,6,2013,'EVPS005','1858','2137','0254'),(938,3756,31,6,2013,'EVPS006','1858','2137','0254'),(939,3756,31,6,2013,'EVPS008','1858','2137','0254'),(940,3757,31,6,2013,'EIPS001','2799','2406','0254'),(941,3757,31,6,2013,'EIPS002','2799','2406','0254'),(942,3757,31,6,2013,'EIPS003','2799','2406','0254'),(943,3757,31,6,2013,'EIPS004','2799','2406','0254'),(944,3757,31,6,2013,'EIPS005','2799','2406','0254'),(945,3757,31,6,2013,'EIPS006','2799','2406','0254'),(946,3757,31,6,2013,'EIPS008','2799','2406','0254'),(947,3758,31,6,2013,'FGPS001','2684','2406','0254'),(948,3758,31,6,2013,'FGPS002','2684','2406','0254'),(949,3758,31,6,2013,'FGPS003','2684','2406','0254'),(950,3759,31,6,2013,'EDPS001','1748','2406','0254'),(951,3759,31,6,2013,'EDPS002','1748','2406','0254'),(952,3759,31,6,2013,'EDPS003','1748','2406','0254'),(953,3759,31,6,2013,'EDPS004','1748','2406','0254'),(954,3759,31,6,2013,'EDPS006','1748','2406','0254'),(955,3760,31,6,2013,'EHPS001','2685','2406','0254'),(956,3760,31,6,2013,'EHPS002','2685','2406','0254'),(957,3760,31,6,2013,'EHPS003','2685','2406','0254'),(958,3760,31,6,2013,'EHPS004','2685','2406','0254'),(959,3760,31,6,2013,'EHPS005','2685','2406','0254'),(960,3760,31,6,2013,'EHPS006','2685','2406','0254'),(961,3760,31,6,2013,'EHPS007','2685','2406','0254'),(962,3760,31,6,2013,'EHPS008','2685','2406','0254'),(963,3760,31,6,2013,'EHPS009','2685','2406','0254'),(964,3760,31,6,2013,'EHPS010','2685','2406','0254'),(965,3760,31,6,2013,'EHPS013','2685','2406','0254'),(966,3761,31,6,2013,'FCPS001','2799','2406','0254'),(967,3761,31,6,2013,'FCPS002','2799','2406','0254'),(968,3761,31,6,2013,'FCPS003','2799','2406','0254'),(969,3761,31,6,2013,'FCPS005','2799','2406','0254'),(970,3762,31,6,2013,'EQPS001','2684','2406','0254'),(971,3762,31,6,2013,'EQPS002','2684','2406','0254'),(972,3762,31,6,2013,'EQPS003','2684','2406','0254'),(973,3762,31,6,2013,'EQPS004','2684','2406','0254'),(974,3762,31,6,2013,'EQPS005','2684','2406','0254'),(975,3762,31,6,2013,'EQPS006','2684','2406','0254'),(976,3762,31,6,2013,'EQPS007','2684','2406','0254'),(977,3762,31,6,2013,'EQPS008','2684','2406','0254'),(978,3762,31,6,2013,'EQPS009','2684','2406','0254'),(979,3764,31,6,2013,'EYPS001','1985','643','0254'),(980,3764,31,6,2013,'EYPS002','1985','643','0254'),(981,3764,31,6,2013,'EYPS003','1985','643','0254'),(982,3764,31,6,2013,'EYPS004','1985','643','0254'),(983,3764,31,6,2013,'EYPS005','1985','643','0254'),(984,3764,31,6,2013,'EYPS006','1985','643','0254'),(985,3764,31,6,2013,'EYPS007','1985','643','0254'),(986,3764,31,6,2013,'EYPS008','1985','643','0254'),(987,3765,31,6,2013,'EKPS001','2603','643','0254'),(988,3765,31,6,2013,'EKPS002','2603','643','0254'),(989,3765,31,6,2013,'EKPS003','2603','643','0254'),(990,3765,31,6,2013,'EKPS004','2603','643','0254'),(991,3765,31,6,2013,'EKPS006','2603','643','0254'),(992,3765,31,6,2013,'EKPS008','2603','643','0254'),(993,3766,31,6,2013,'FAPS001','2027','643','0254'),(994,3766,31,6,2013,'FAPS002','2027','643','0254'),(995,3766,31,6,2013,'FAPS003','2027','643','0254'),(996,3766,31,6,2013,'FAPS004','2027','643','0254'),(997,3766,31,6,2013,'FAPS007','2027','643','0254'),(998,3767,31,6,2013,'FIPS001','1985','643','0254'),(999,3767,31,6,2013,'FIPS002','1985','643','0254'),(1000,3767,31,6,2013,'FIPS003','1985','643','0254'),(1001,3767,31,6,2013,'FIPS004','1985','643','0254'),(1002,3768,31,6,2013,'EEPS001','887','643','0254'),(1003,3768,31,6,2013,'EEPS002','887','643','0254'),(1004,3768,31,6,2013,'EEPS003','887','643','0254'),(1005,3768,31,6,2013,'EEPS004','887','643','0254'),(1006,3768,31,6,2013,'EEPS005','887','643','0254'),(1007,3768,31,6,2013,'EEPS006','887','643','0254'),(1008,3768,31,6,2013,'EEPS007','887','643','0254'),(1009,3768,31,6,2013,'EEPS010','887','643','0254'),(1010,3769,31,6,2013,'FFPS001','643','643','0254'),(1011,3769,31,6,2013,'FFPS002','643','643','0254'),(1012,3769,31,6,2013,'FFPS003','643','643','0254'),(1013,3770,31,6,2013,'EZPS001','2027','643','0254'),(1014,3770,31,6,2013,'EZPS002','2027','643','0254'),(1015,3770,31,6,2013,'EZPS003','2027','643','0254'),(1016,3770,31,6,2013,'EZPS004','2027','643','0254'),(1017,3770,31,6,2013,'EZPS005','2027','643','0254'),(1018,3770,31,6,2013,'EZPS006','2027','643','0254'),(1019,3770,31,6,2013,'EZPS007','2027','643','0254'),(1020,3770,31,6,2013,'EZPS010','2027','643','0254'),(1021,3771,31,6,2013,'ELPS001','2036','643','0254'),(1022,3771,31,6,2013,'ELPS002','2036','643','0254'),(1023,3771,31,6,2013,'ELPS003','2036','643','0254'),(1024,3771,31,6,2013,'ELPS004','2036','643','0254'),(1025,3771,31,6,2013,'ELPS007','2036','643','0254'),(1026,3773,31,6,2013,'EXPS001','1023','1516','0254'),(1027,3773,31,6,2013,'EXPS002','1023','1516','0254'),(1028,3774,31,6,2013,'EWPS002','1023','1516','0254'),(1029,3774,31,6,2013,'EWPS003','1023','1516','0254'),(1030,3774,31,6,2013,'EWPS004','1023','1516','0254'),(1031,3774,31,6,2013,'EWPS005','1023','1516','0254'),(1032,3774,31,6,2013,'EWPS006','1023','1516','0254'),(1033,3774,31,6,2013,'EWPS007','1023','1516','0254'),(1034,3774,31,6,2013,'EWPS008','1023','1516','0254'),(1035,3774,31,6,2013,'EWPS009','1023','1516','0254'),(1036,3774,31,6,2013,'EWPS013','1023','1516','0254'),(1037,3776,31,6,2013,'EMPS001','Sales Master - chưa có code','1516','0254'),(1038,3776,31,6,2013,'EMPS002','Sales Master - chưa có code','1516','0254'),(1039,3776,31,6,2013,'EMPS003','Sales Master - chưa có code','1516','0254'),(1040,3776,31,6,2013,'EMPS004','Sales Master - chưa có code','1516','0254'),(1041,3776,31,6,2013,'EMPS005','Sales Master - chưa có code','1516','0254'),(1042,3776,31,6,2013,'EMPS006','Sales Master - chưa có code','1516','0254'),(1043,3776,31,6,2013,'EMPS007','Sales Master - chưa có code','1516','0254'),(1044,3776,31,6,2013,'EMPS008','Sales Master - chưa có code','1516','0254'),(1045,3777,31,6,2013,'EOPS001','1499','1516','0254'),(1046,3777,31,6,2013,'EOPS002','1499','1516','0254'),(1047,3777,31,6,2013,'EOPS003','1499','1516','0254'),(1048,3777,31,6,2013,'EOPS004','1499','1516','0254'),(1049,3777,31,6,2013,'EOPS005','1499','1516','0254'),(1050,3777,31,6,2013,'EOPS006','1499','1516','0254'),(1051,3777,31,6,2013,'EOPS010','1499','1516','0254'),(1052,3777,31,6,2013,'EOPS011','1499','1516','0254'),(1053,3777,31,6,2013,'EOPS012','1499','1516','0254'),(1054,3778,31,6,2013,'FEPS001','1023','1516','0254'),(1055,3778,31,6,2013,'FEPS002','1023','1516','0254'),(1056,3778,31,6,2013,'FEPS003','1023','1516','0254'),(1057,3747,1,5,2013,'AEPS001','0903673624','0903925449','0903025508'),(1058,3747,1,5,2013,'AEPS003','903673624','0903925449','0903025508'),(1059,3747,1,5,2013,'AEPS004','0903673624','0903925449','0903025508'),(1060,3747,1,5,2013,'AEPS005','0903673624','0903925449','0903025508'),(1061,3747,1,5,2013,'AEPS006','0903673624','0903925449','0903025508'),(1062,3747,1,5,2013,'AEPS007','0903673624','0903925449','0903025508'),(1063,3747,1,5,2013,'AEPS008','0903673624','0903925449','0903025508'),(1064,3747,1,5,2013,'AEPS009','0903673624','0903925449','0903025508'),(1065,3747,2,5,2013,'AEPS001','SE006','0021','0903025508'),(1066,3747,2,5,2013,'AEPS003','SE006','0021','0903025508'),(1067,3747,2,5,2013,'AEPS004','SE006','0021','0903025508'),(1068,3747,2,5,2013,'AEPS005','SE006','0021','0903025508'),(1069,3747,2,5,2013,'AEPS006','SE006','0021','0903025508'),(1070,3747,2,5,2013,'AEPS007','SE006','0021','0903025508'),(1071,3747,2,5,2013,'AEPS008','SE006','0021','0903025508'),(1072,3747,2,5,2013,'AEPS009','SE006','0021','0903025508'),(1073,3747,3,5,2013,'AEPS001','SE006','0021','0903025508'),(1074,3747,3,5,2013,'AEPS003','SE006','0021','0903025508'),(1075,3747,3,5,2013,'AEPS004','SE006','0021','0903025508'),(1076,3747,3,5,2013,'AEPS005','SE006','0021','0903025508'),(1077,3747,3,5,2013,'AEPS006','SE006','0021','0903025508'),(1078,3747,3,5,2013,'AEPS007','SE006','0021','0903025508'),(1079,3747,3,5,2013,'AEPS008','SE006','0021','0903025508'),(1080,3747,3,5,2013,'AEPS009','SE006','0021','0903025508'),(1081,3747,4,5,2013,'AEPS001','SE006','0021','0903025508'),(1082,3747,4,5,2013,'AEPS003','SE006','0021','0903025508'),(1083,3747,4,5,2013,'AEPS004','SE006','0021','0903025508'),(1084,3747,4,5,2013,'AEPS005','SE006','0021','0903025508'),(1085,3747,4,5,2013,'AEPS006','SE006','0021','0903025508'),(1086,3747,4,5,2013,'AEPS007','SE006','0021','0903025508'),(1087,3747,4,5,2013,'AEPS008','SE006','0021','0903025508'),(1088,3747,4,5,2013,'AEPS009','SE006','0021','0903025508'),(1089,3747,5,5,2013,'AEPS001','SE006','0021','0903025508'),(1090,3747,5,5,2013,'AEPS003','SE006','0021','0903025508'),(1091,3747,5,5,2013,'AEPS004','SE006','0021','0903025508'),(1092,3747,5,5,2013,'AEPS005','SE006','0021','0903025508'),(1093,3747,5,5,2013,'AEPS006','SE006','0021','0903025508'),(1094,3747,5,5,2013,'AEPS007','SE006','0021','0903025508'),(1095,3747,5,5,2013,'AEPS008','SE006','0021','0903025508'),(1096,3747,5,5,2013,'AEPS009','SE006','0021','0903025508'),(1097,3747,6,5,2013,'AEPS001','SE006','0021','0903025508'),(1098,3747,6,5,2013,'AEPS003','SE006','0021','0903025508'),(1099,3747,6,5,2013,'AEPS004','SE006','0021','0903025508'),(1100,3747,6,5,2013,'AEPS005','SE006','0021','0903025508'),(1101,3747,6,5,2013,'AEPS006','SE006','0021','0903025508'),(1102,3747,6,5,2013,'AEPS007','SE006','0021','0903025508'),(1103,3747,6,5,2013,'AEPS008','SE006','0021','0903025508'),(1104,3747,6,5,2013,'AEPS009','SE006','0021','0903025508'),(1105,3747,7,5,2013,'AEPS001','SE006','0021','0903025508'),(1106,3747,7,5,2013,'AEPS003','SE006','0021','0903025508'),(1107,3747,7,5,2013,'AEPS004','SE006','0021','0903025508'),(1108,3747,7,5,2013,'AEPS005','SE006','0021','0903025508'),(1109,3747,7,5,2013,'AEPS006','SE006','0021','0903025508'),(1110,3747,7,5,2013,'AEPS007','SE006','0021','0903025508'),(1111,3747,7,5,2013,'AEPS008','SE006','0021','0903025508'),(1112,3747,7,5,2013,'AEPS009','SE006','0021','0903025508'),(1113,3747,8,5,2013,'AEPS001','SE006','0021','0903025508'),(1114,3747,8,5,2013,'AEPS003','SE006','0021','0903025508'),(1115,3747,8,5,2013,'AEPS004','SE006','0021','0903025508'),(1116,3747,8,5,2013,'AEPS005','SE006','0021','0903025508'),(1117,3747,8,5,2013,'AEPS006','SE006','0021','0903025508'),(1118,3747,8,5,2013,'AEPS007','SE006','0021','0903025508'),(1119,3747,8,5,2013,'AEPS008','SE006','0021','0903025508'),(1120,3747,8,5,2013,'AEPS009','SE006','0021','0903025508'),(1121,3747,9,5,2013,'AEPS001','SE006','0021','0903025508'),(1122,3747,9,5,2013,'AEPS003','SE006','0021','0903025508'),(1123,3747,9,5,2013,'AEPS004','SE006','0021','0903025508'),(1124,3747,9,5,2013,'AEPS005','SE006','0021','0903025508'),(1125,3747,9,5,2013,'AEPS006','SE006','0021','0903025508'),(1126,3747,9,5,2013,'AEPS007','SE006','0021','0903025508'),(1127,3747,9,5,2013,'AEPS008','SE006','0021','0903025508'),(1128,3747,9,5,2013,'AEPS009','SE006','0021','0903025508'),(1129,3747,10,5,2013,'AEPS001','SE006','0021','0903025508'),(1130,3747,10,5,2013,'AEPS003','SE006','0021','0903025508'),(1131,3747,10,5,2013,'AEPS004','SE006','0021','0903025508'),(1132,3747,10,5,2013,'AEPS005','SE006','0021','0903025508'),(1133,3747,10,5,2013,'AEPS006','SE006','0021','0903025508'),(1134,3747,10,5,2013,'AEPS007','SE006','0021','0903025508'),(1135,3747,10,5,2013,'AEPS008','SE006','0021','0903025508'),(1136,3747,10,5,2013,'AEPS009','SE006','0021','0903025508'),(1137,3747,11,5,2013,'AEPS001','SE006','0021','0903025508'),(1138,3747,11,5,2013,'AEPS003','SE006','0021','0903025508'),(1139,3747,11,5,2013,'AEPS004','SE006','0021','0903025508'),(1140,3747,11,5,2013,'AEPS005','SE006','0021','0903025508'),(1141,3747,11,5,2013,'AEPS006','SE006','0021','0903025508'),(1142,3747,11,5,2013,'AEPS007','SE006','0021','0903025508'),(1143,3747,11,5,2013,'AEPS008','SE006','0021','0903025508'),(1144,3747,11,5,2013,'AEPS009','SE006','0021','0903025508'),(1145,3747,12,5,2013,'AEPS001','SE006','0021','0903025508'),(1146,3747,12,5,2013,'AEPS003','SE006','0021','0903025508'),(1147,3747,12,5,2013,'AEPS004','SE006','0021','0903025508'),(1148,3747,12,5,2013,'AEPS005','SE006','0021','0903025508'),(1149,3747,12,5,2013,'AEPS006','SE006','0021','0903025508'),(1150,3747,12,5,2013,'AEPS007','SE006','0021','0903025508'),(1151,3747,12,5,2013,'AEPS008','SE006','0021','0903025508'),(1152,3747,12,5,2013,'AEPS009','SE006','0021','0903025508'),(1153,3747,13,5,2013,'AEPS001','SE006','0021','0903025508'),(1154,3747,13,5,2013,'AEPS003','SE006','0021','0903025508'),(1155,3747,13,5,2013,'AEPS004','SE006','0021','0903025508'),(1156,3747,13,5,2013,'AEPS005','SE006','0021','0903025508'),(1157,3747,13,5,2013,'AEPS006','SE006','0021','0903025508'),(1158,3747,13,5,2013,'AEPS007','SE006','0021','0903025508'),(1159,3747,13,5,2013,'AEPS008','SE006','0021','0903025508'),(1160,3747,13,5,2013,'AEPS009','SE006','0021','0903025508'),(1161,3747,14,5,2013,'AEPS001','SE006','0021','0903025508'),(1162,3747,14,5,2013,'AEPS003','SE006','0021','0903025508'),(1163,3747,14,5,2013,'AEPS004','SE006','0021','0903025508'),(1164,3747,14,5,2013,'AEPS005','SE006','0021','0903025508'),(1165,3747,14,5,2013,'AEPS006','SE006','0021','0903025508'),(1166,3747,14,5,2013,'AEPS007','SE006','0021','0903025508'),(1167,3747,14,5,2013,'AEPS008','SE006','0021','0903025508'),(1168,3747,14,5,2013,'AEPS009','SE006','0021','0903025508'),(1169,3747,15,5,2013,'AEPS001','SE006','0021','0903025508'),(1170,3747,15,5,2013,'AEPS003','SE006','0021','0903025508'),(1171,3747,15,5,2013,'AEPS004','SE006','0021','0903025508'),(1172,3747,15,5,2013,'AEPS005','SE006','0021','0903025508'),(1173,3747,15,5,2013,'AEPS006','SE006','0021','0903025508'),(1174,3747,15,5,2013,'AEPS007','SE006','0021','0903025508'),(1175,3747,15,5,2013,'AEPS008','SE006','0021','0903025508'),(1176,3747,15,5,2013,'AEPS009','SE006','0021','0903025508'),(1177,3747,16,5,2013,'AEPS001','SE006','0021','0903025508'),(1178,3747,16,5,2013,'AEPS003','SE006','0021','0903025508'),(1179,3747,16,5,2013,'AEPS004','SE006','0021','0903025508'),(1180,3747,16,5,2013,'AEPS005','SE006','0021','0903025508'),(1181,3747,16,5,2013,'AEPS006','SE006','0021','0903025508'),(1182,3747,16,5,2013,'AEPS007','SE006','0021','0903025508'),(1183,3747,16,5,2013,'AEPS008','SE006','0021','0903025508'),(1184,3747,16,5,2013,'AEPS009','SE006','0021','0903025508'),(1185,3747,17,5,2013,'AEPS001','SE006','0021','0903025508'),(1186,3747,17,5,2013,'AEPS003','SE006','0021','0903025508'),(1187,3747,17,5,2013,'AEPS004','SE006','0021','0903025508'),(1188,3747,17,5,2013,'AEPS005','SE006','0021','0903025508'),(1189,3747,17,5,2013,'AEPS006','SE006','0021','0903025508'),(1190,3747,17,5,2013,'AEPS007','SE006','0021','0903025508'),(1191,3747,17,5,2013,'AEPS008','SE006','0021','0903025508'),(1192,3747,17,5,2013,'AEPS009','SE006','0021','0903025508'),(1193,3747,18,5,2013,'AEPS001','SE006','0021','0903025508'),(1194,3747,18,5,2013,'AEPS003','SE006','0021','0903025508'),(1195,3747,18,5,2013,'AEPS004','SE006','0021','0903025508'),(1196,3747,18,5,2013,'AEPS005','SE006','0021','0903025508'),(1197,3747,18,5,2013,'AEPS006','SE006','0021','0903025508'),(1198,3747,18,5,2013,'AEPS007','SE006','0021','0903025508'),(1199,3747,18,5,2013,'AEPS008','SE006','0021','0903025508'),(1200,3747,18,5,2013,'AEPS009','SE006','0021','0903025508'),(1201,3747,19,5,2013,'AEPS001','SE006','0021','0903025508'),(1202,3747,19,5,2013,'AEPS003','SE006','0021','0903025508'),(1203,3747,19,5,2013,'AEPS004','SE006','0021','0903025508'),(1204,3747,19,5,2013,'AEPS005','SE006','0021','0903025508'),(1205,3747,19,5,2013,'AEPS006','SE006','0021','0903025508'),(1206,3747,19,5,2013,'AEPS007','SE006','0021','0903025508'),(1207,3747,19,5,2013,'AEPS008','SE006','0021','0903025508'),(1208,3747,19,5,2013,'AEPS009','SE006','0021','0903025508'),(1209,3747,20,5,2013,'AEPS001','SE006','0021','0903025508'),(1210,3747,20,5,2013,'AEPS003','SE006','0021','0903025508'),(1211,3747,20,5,2013,'AEPS004','SE006','0021','0903025508'),(1212,3747,20,5,2013,'AEPS005','SE006','0021','0903025508'),(1213,3747,20,5,2013,'AEPS006','SE006','0021','0903025508'),(1214,3747,20,5,2013,'AEPS007','SE006','0021','0903025508'),(1215,3747,20,5,2013,'AEPS008','SE006','0021','0903025508'),(1216,3747,20,5,2013,'AEPS009','SE006','0021','0903025508'),(1217,3747,21,5,2013,'AEPS001','SE006','0021','0903025508'),(1218,3747,21,5,2013,'AEPS003','SE006','0021','0903025508'),(1219,3747,21,5,2013,'AEPS004','SE006','0021','0903025508'),(1220,3747,21,5,2013,'AEPS005','SE006','0021','0903025508'),(1221,3747,21,5,2013,'AEPS006','SE006','0021','0903025508'),(1222,3747,21,5,2013,'AEPS007','SE006','0021','0903025508'),(1223,3747,21,5,2013,'AEPS008','SE006','0021','0903025508'),(1224,3747,21,5,2013,'AEPS009','SE006','0021','0903025508'),(1225,3747,22,5,2013,'AEPS001','SE006','0021','0903025508'),(1226,3747,22,5,2013,'AEPS003','SE006','0021','0903025508'),(1227,3747,22,5,2013,'AEPS004','SE006','0021','0903025508'),(1228,3747,22,5,2013,'AEPS005','SE006','0021','0903025508'),(1229,3747,22,5,2013,'AEPS006','SE006','0021','0903025508'),(1230,3747,22,5,2013,'AEPS007','SE006','0021','0903025508'),(1231,3747,22,5,2013,'AEPS008','SE006','0021','0903025508'),(1232,3747,22,5,2013,'AEPS009','SE006','0021','0903025508'),(1233,3747,23,5,2013,'AEPS001','SE006','0021','0903025508'),(1234,3747,23,5,2013,'AEPS003','SE006','0021','0903025508'),(1235,3747,23,5,2013,'AEPS004','SE006','0021','0903025508'),(1236,3747,23,5,2013,'AEPS005','SE006','0021','0903025508'),(1237,3747,23,5,2013,'AEPS006','SE006','0021','0903025508'),(1238,3747,23,5,2013,'AEPS007','SE006','0021','0903025508'),(1239,3747,23,5,2013,'AEPS008','SE006','0021','0903025508'),(1240,3747,23,5,2013,'AEPS009','SE006','0021','0903025508'),(1241,3747,24,5,2013,'AEPS001','SE006','0021','0903025508'),(1242,3747,24,5,2013,'AEPS003','SE006','0021','0903025508'),(1243,3747,24,5,2013,'AEPS004','SE006','0021','0903025508'),(1244,3747,24,5,2013,'AEPS005','SE006','0021','0903025508'),(1245,3747,24,5,2013,'AEPS006','SE006','0021','0903025508'),(1246,3747,24,5,2013,'AEPS007','SE006','0021','0903025508'),(1247,3747,24,5,2013,'AEPS008','SE006','0021','0903025508'),(1248,3747,24,5,2013,'AEPS009','SE006','0021','0903025508'),(1249,3747,25,5,2013,'AEPS001','SE006','0021','0903025508'),(1250,3747,25,5,2013,'AEPS003','SE006','0021','0903025508'),(1251,3747,25,5,2013,'AEPS004','SE006','0021','0903025508'),(1252,3747,25,5,2013,'AEPS005','SE006','0021','0903025508'),(1253,3747,25,5,2013,'AEPS006','SE006','0021','0903025508'),(1254,3747,25,5,2013,'AEPS007','SE006','0021','0903025508'),(1255,3747,25,5,2013,'AEPS008','SE006','0021','0903025508'),(1256,3747,25,5,2013,'AEPS009','SE006','0021','0903025508'),(1257,3747,30,5,2013,'AEPS001','SE006','0021','0903025508'),(1258,3747,30,5,2013,'AEPS003','SE006','0021','0903025508'),(1259,3747,30,5,2013,'AEPS004','SE006','0021','0903025508'),(1260,3747,30,5,2013,'AEPS005','SE006','0021','0903025508'),(1261,3747,30,5,2013,'AEPS006','SE006','0021','0903025508'),(1262,3747,30,5,2013,'AEPS007','SE006','0021','0903025508'),(1263,3747,30,5,2013,'AEPS008','SE006','0021','0903025508'),(1264,3747,30,5,2013,'AEPS009','SE006','0021','0903025508'),(1265,3611,3,8,2013,'','','0903.495.554','0903.495.559'),(1266,3612,3,8,2013,'','','0903.495.554','0903.495.559'),(1267,3613,3,8,2013,'','','0903.495.554','0903.495.559'),(1268,3614,3,8,2013,'','','0903.495.554','0903.495.559'),(1269,3615,3,8,2013,'','','0903.495.554','0903.495.559'),(1270,3616,3,8,2013,'','','0903.495.554','0903.495.559'),(1271,3617,3,8,2013,'','','0903.495.554','0903.495.559'),(1272,3618,3,8,2013,'','','0903.495.554','0903.495.559'),(1273,3619,3,8,2013,'','','0904.018111','0903.495.559'),(1274,3620,3,8,2013,'','','0904.018111','0903.495.559'),(1275,3621,3,8,2013,'','','0904.018111','0903.495.559'),(1276,3622,3,8,2013,'','','0904.018111','0903.495.559'),(1277,3623,3,8,2013,'','','0904.018111','0903.495.559'),(1278,3624,3,8,2013,'','','0904.018111','0903.495.559'),(1279,3625,3,8,2013,'','','0903.488.767','0903.495.559'),(1280,3626,3,8,2013,'','','0903.488.767','0903.495.559'),(1281,3627,3,8,2013,'','','0903.488.767','0903.495.559'),(1282,3628,3,8,2013,'','','0903.488.767','0903.495.559'),(1283,3629,3,8,2013,'','','0903.488.767','0903.495.559'),(1284,3630,3,8,2013,'','','0903.488.767','0903.495.559'),(1285,3631,3,8,2013,'','','0903.488.767','0903.495.559'),(1286,3632,3,8,2013,'','','0903.488.767','0903.495.559'),(1287,3633,3,8,2013,'','','0903.488.767','0903.495.559'),(1288,3634,3,8,2013,'','','0903.488.767','0903.495.559'),(1289,3635,3,8,2013,'','','0903.488.767','0903.495.559'),(1290,3636,3,8,2013,'','','0903.488.767','0903.495.559'),(1291,3637,3,8,2013,'','','0903.488.767','0903.495.559'),(1292,3638,3,8,2013,'','','0904.111.335','0903.495.559'),(1293,3639,3,8,2013,'','','0904.111.335','0903.495.559'),(1294,3640,3,8,2013,'','','0904.111.335','0903.495.559'),(1295,3641,3,8,2013,'','','0904.111.335','0903.495.559'),(1296,3642,3,8,2013,'','','0904.111.335','0903.495.559'),(1297,3643,3,8,2013,'','','0904.111.335','0903.495.559'),(1298,3644,3,8,2013,'','','0904.111.335','0903.495.559'),(1299,3645,3,8,2013,'','','0903.495.553','0903.495.559'),(1300,3646,3,8,2013,'','','0903.495.553','0903.495.559'),(1301,3647,3,8,2013,'','','0903.495.553','0903.495.559'),(1302,3648,3,8,2013,'','','0903.495.553','0903.495.559'),(1303,3649,3,8,2013,'','','0903.495.553','0903.495.559'),(1304,3650,3,8,2013,'','','0903.495.554','0903.495.560'),(1305,3651,3,8,2013,'','','0903.495.553','0903.495.559'),(1306,3652,3,8,2013,'','','0903.444.214','0903.479.543'),(1307,3653,3,8,2013,'','','0903.444.214','0903.479.543'),(1308,3654,3,8,2013,'','','0903.444.214','0903.479.543'),(1309,3655,3,8,2013,'','','0903.444.214','0903.479.543'),(1310,3656,3,8,2013,'','','0903.444.214','0903.479.543'),(1311,3657,3,8,2013,'','','0903.444.214','0903.479.543'),(1312,3658,3,8,2013,'','','0903.444.214','0903.479.543'),(1313,3659,3,8,2013,'','','0903.420.269','0903.479.543'),(1314,3660,3,8,2013,'','','0903.420.269','0903.479.543'),(1315,3661,3,8,2013,'','','0903.420.269','0903.479.543'),(1316,3662,3,8,2013,'','','0903.420.269','0903.479.543'),(1317,3663,3,8,2013,'','','0903.420.269','0903.479.543'),(1318,3664,3,8,2013,'','','0903.420.269','0903.479.543'),(1319,3665,3,8,2013,'','','0905376222','0905002007'),(1320,3666,3,8,2013,'','','0905376222','0905002007'),(1321,3667,3,8,2013,'','','0905376222','0905002007'),(1322,3668,3,8,2013,'','','0905376222','0905002007'),(1323,3669,3,8,2013,'','','0905107031','0905002007'),(1324,3671,3,8,2013,'','','0905107031','0905002007'),(1325,3672,3,8,2013,'','','0905107031','0905002007'),(1326,3673,3,8,2013,'','','0905107031','0905002007'),(1327,3674,3,8,2013,'','','0905107031','0905002007'),(1328,3675,3,8,2013,'','','0905107031','0905002007'),(1329,3676,3,8,2013,'','','0905107031','0905002007'),(1330,3677,3,8,2013,'','','0905107031','0905002007'),(1331,3678,3,8,2013,'','','0903582593','0905002007'),(1332,3679,3,8,2013,'','','0903582593','0905002007'),(1333,3680,3,8,2013,'','','0905107031','0905002007'),(1334,3681,3,8,2013,'','','0903582593','0905002007'),(1335,3682,3,8,2013,'','','0903582593','0905002007'),(1336,3683,3,8,2013,'','','0903582593','0905002007'),(1337,3684,3,8,2013,'','','0903582593','0905002007'),(1338,3685,3,8,2013,'','','0903582593','0905002007'),(1339,3686,3,8,2013,'','','0903.052.927','0903011689'),(1340,3687,3,8,2013,'','','0903.052.927','0903011689'),(1341,3688,3,8,2013,'','','0903.052.927','0903011689'),(1342,3689,3,8,2013,'','','0903.052.927','0903011689'),(1343,3690,3,8,2013,'','','0903.052.927','0903011689'),(1344,3691,3,8,2013,'','','0903.052.927','0903011689'),(1345,3692,3,8,2013,'','','0903.052.927','0903011689'),(1346,3693,3,8,2013,'','','0909.046.436','0903011689'),(1347,3694,3,8,2013,'','','0909.046.436','0903011689'),(1348,3695,3,8,2013,'','','0909.046.436','0903011689'),(1349,3696,3,8,2013,'','','0909.046.436','0903011689'),(1350,3697,3,8,2013,'','','0903.052.927','0903011689'),(1351,3698,3,8,2013,'','','0908.058.279','0903011689'),(1352,3699,3,8,2013,'','','0908.058.279','0903011689'),(1353,3700,3,8,2013,'','','0908.058.279','0903011689'),(1354,3701,3,8,2013,'','','0908.058.279','0903011689'),(1355,3702,3,8,2013,'','','0908.058.279','0903011689'),(1356,3703,3,8,2013,'','','0908.058.279','0903011689'),(1357,3704,3,8,2013,'','','0908.058.279','0903011689'),(1358,3705,3,8,2013,'','','0908.058.279','0903011689'),(1359,3706,3,8,2013,'','','0908.058.279','0903011689'),(1360,3707,3,8,2013,'','','0908.001.089','0903011689'),(1361,3709,3,8,2013,'','','0908.001.089','0903011689'),(1362,3710,3,8,2013,'','','0908.001.089','0903011689'),(1363,3711,3,8,2013,'','','0908.001.089','0903011689'),(1364,3712,3,8,2013,'','','0908.001.089','0903011689'),(1365,3713,3,8,2013,'','','0908.001.089','0903011689'),(1366,3714,3,8,2013,'','','0908.001.089','0903011689'),(1367,3715,3,8,2013,'','','0903011698','0903025508'),(1368,3716,3,8,2013,'','','0903011698','0903025508'),(1369,3717,3,8,2013,'','','0903011698','0903025508'),(1370,3718,3,8,2013,'','','0903011698','0903025508'),(1371,3719,3,8,2013,'','','0903011698','0903025508'),(1372,3720,3,8,2013,'','','0903011698','0903025508'),(1373,3721,3,8,2013,'','','0903005185','0903025508'),(1374,3722,3,8,2013,'','','0903005185','0903025508'),(1375,3723,3,8,2013,'','','0903005185','0903025508'),(1376,3724,3,8,2013,'','','0903005185','0903025508'),(1377,3725,3,8,2013,'','','0903005185','0903025508'),(1378,3726,3,8,2013,'','','0903005185','0903025508'),(1379,3728,3,8,2013,'','','0903713672','0903025508'),(1380,3729,3,8,2013,'','','0903713672','0903025508'),(1381,3730,3,8,2013,'','','0903713672','0903025508'),(1382,3731,3,8,2013,'','','0903713672','0903025508'),(1383,3732,3,8,2013,'','','0903713672','0903025508'),(1384,3733,3,8,2013,'','','0903925449','0903025508'),(1385,3792,3,8,2013,'','','0903925449','0903025508'),(1386,3746,3,8,2013,'','','0903925449','0903025508'),(1387,3747,3,8,2013,'','','0903925449','0903025508'),(1388,3748,3,8,2013,'','','0903925449','0903025508'),(1389,3749,3,8,2013,'','','0902.354.359','0908638008'),(1390,3750,3,8,2013,'','','0902.354.359','0908638008'),(1391,3751,3,8,2013,'','','0902.354.359','0908638008'),(1392,3752,3,8,2013,'','','0902.354.359','0908638008'),(1393,3753,3,8,2013,'','','0902.354.359','0908638008'),(1394,3754,3,8,2013,'','','0902.354.359','0908638008'),(1395,3755,3,8,2013,'','','0902.354.359','0908638008'),(1396,3756,3,8,2013,'','','0902.354.359','0908638008'),(1397,3757,3,8,2013,'','','0908.475.556','0908638008'),(1398,3758,3,8,2013,'','','0908.475.556','0908638008'),(1399,3759,3,8,2013,'','','0908.475.556','0908638008'),(1400,3760,3,8,2013,'','','0908.475.556','0908638008'),(1401,3761,3,8,2013,'','','0908.475.556','0908638008'),(1402,3762,3,8,2013,'','','0908.475.556','0908638008'),(1403,3763,3,8,2013,'','','0908.475.556','0908638008'),(1404,3764,3,8,2013,'','','0908.599.907','0908638008'),(1405,3765,3,8,2013,'','','0908.599.907','0908638008'),(1406,3766,3,8,2013,'','','0908.599.907','0908638008'),(1407,3767,3,8,2013,'','','0908.599.907','0908638008'),(1408,3768,3,8,2013,'','','0908.599.907','0908638008'),(1409,3769,3,8,2013,'','','0902.354.359','0908638008'),(1410,3770,3,8,2013,'','','0908.599.907','0908638008'),(1411,3771,3,8,2013,'','','0908.599.907','0908638008'),(1412,3772,3,8,2013,'','','0908.599.907','0908638008'),(1413,3773,3,8,2013,'','','0908.125.850','0908638008'),(1414,3774,3,8,2013,'','','0908.125.850','0908638008'),(1415,3775,3,8,2013,'','','0908.125.850','0908638008'),(1416,3776,3,8,2013,'','','0908.125.850','0908638008'),(1417,3777,3,8,2013,'','','0908.125.850','0908638008'),(1418,3778,3,8,2013,'','','0908.125.850','0908638008'),(1419,3619,3,8,2013,'KTPS001','2664','1825','0938'),(1420,3619,3,8,2013,'KTPS002','2664','1825','0938'),(1421,3619,3,8,2013,'KTPS003','2664','1825','0938'),(1422,3619,3,8,2013,'KTPS004','2664','1825','0938'),(1423,3619,3,8,2013,'KTPS005','2664','1825','0938'),(1424,3619,3,8,2013,'KTPS007','2664','1825','0938'),(1425,3620,3,8,2013,'KYPS001','','1825','0938'),(1426,3620,3,8,2013,'KYPS002','','1825','0938'),(1427,3620,3,8,2013,'KYPS003','','1825','0938'),(1428,3620,3,8,2013,'KYPS005','','1825','0938'),(1429,3620,3,8,2013,'KYPS006','','1825','0938'),(1430,3620,3,8,2013,'KYPS011','2895','1825','0938'),(1431,3621,3,8,2013,'LMPS001','2895','1825','0938'),(1432,3621,3,8,2013,'LMPS002','2895','1825','0938'),(1433,3621,3,8,2013,'LMPS003','2895','1825','0938'),(1434,3621,3,8,2013,'LMPS004','2696','1825','0938'),(1435,3622,3,8,2013,'KUPS001','2696','1825','0938'),(1436,3622,3,8,2013,'KUPS002','2696','1825','0938'),(1437,3622,3,8,2013,'KUPS003','2696','1825','0938'),(1438,3622,3,8,2013,'KUPS004','2696','1825','0938'),(1439,3622,3,8,2013,'KUPS005','2501','1825','0938'),(1440,3623,3,8,2013,'KVPS001','2501','1825','0938'),(1441,3623,3,8,2013,'KVPS002','2501','1825','0938'),(1442,3623,3,8,2013,'KVPS003','2501','1825','0938'),(1443,3623,3,8,2013,'KVPS004','2501','1825','0938'),(1444,3623,3,8,2013,'KVPS005','1477','1825','0938'),(1445,3624,3,8,2013,'KWPS002','1477','1825','0938'),(1446,3624,3,8,2013,'KWPS003','1477','1825','0938'),(1447,3624,3,8,2013,'KWPS004','0903.452466','1825','0938'),(1448,3619,4,8,2013,'KTPS001','2664','1825','0938'),(1449,3619,4,8,2013,'KTPS002','2664','1825','0938'),(1450,3619,4,8,2013,'KTPS003','2664','1825','0938'),(1451,3619,4,8,2013,'KTPS004','2664','1825','0938'),(1452,3619,4,8,2013,'KTPS005','2664','1825','0938'),(1453,3619,4,8,2013,'KTPS007','2664','1825','0938'),(1454,3620,4,8,2013,'KYPS001','','1825','0938'),(1455,3620,4,8,2013,'KYPS002','','1825','0938'),(1456,3620,4,8,2013,'KYPS003','','1825','0938'),(1457,3620,4,8,2013,'KYPS005','','1825','0938'),(1458,3620,4,8,2013,'KYPS006','','1825','0938'),(1459,3620,4,8,2013,'KYPS011','2895','1825','0938'),(1460,3621,4,8,2013,'LMPS001','2895','1825','0938'),(1461,3621,4,8,2013,'LMPS002','2895','1825','0938'),(1462,3621,4,8,2013,'LMPS003','2895','1825','0938'),(1463,3621,4,8,2013,'LMPS004','2696','1825','0938'),(1464,3622,4,8,2013,'KUPS001','2696','1825','0938'),(1465,3622,4,8,2013,'KUPS002','2696','1825','0938'),(1466,3622,4,8,2013,'KUPS003','2696','1825','0938'),(1467,3622,4,8,2013,'KUPS004','2696','1825','0938'),(1468,3622,4,8,2013,'KUPS005','2501','1825','0938'),(1469,3623,4,8,2013,'KVPS001','2501','1825','0938'),(1470,3623,4,8,2013,'KVPS002','2501','1825','0938'),(1471,3623,4,8,2013,'KVPS003','2501','1825','0938'),(1472,3623,4,8,2013,'KVPS004','2501','1825','0938'),(1473,3623,4,8,2013,'KVPS005','1477','1825','0938'),(1474,3624,4,8,2013,'KWPS002','1477','1825','0938'),(1475,3624,4,8,2013,'KWPS003','1477','1825','0938'),(1476,3624,4,8,2013,'KWPS004','0903.452466','1825','0938'),(1477,3619,5,8,2013,'KTPS001','2664','1825','0938'),(1478,3619,5,8,2013,'KTPS002','2664','1825','0938'),(1479,3619,5,8,2013,'KTPS003','2664','1825','0938'),(1480,3619,5,8,2013,'KTPS004','2664','1825','0938'),(1481,3619,5,8,2013,'KTPS005','2664','1825','0938'),(1482,3619,5,8,2013,'KTPS007','2664','1825','0938'),(1483,3620,5,8,2013,'KYPS001','','1825','0938'),(1484,3620,5,8,2013,'KYPS002','','1825','0938'),(1485,3620,5,8,2013,'KYPS003','','1825','0938'),(1486,3620,5,8,2013,'KYPS005','','1825','0938'),(1487,3620,5,8,2013,'KYPS006','','1825','0938'),(1488,3620,5,8,2013,'KYPS011','2895','1825','0938'),(1489,3621,5,8,2013,'LMPS001','2895','1825','0938'),(1490,3621,5,8,2013,'LMPS002','2895','1825','0938'),(1491,3621,5,8,2013,'LMPS003','2895','1825','0938'),(1492,3621,5,8,2013,'LMPS004','2696','1825','0938'),(1493,3622,5,8,2013,'KUPS001','2696','1825','0938'),(1494,3622,5,8,2013,'KUPS002','2696','1825','0938'),(1495,3622,5,8,2013,'KUPS003','2696','1825','0938'),(1496,3622,5,8,2013,'KUPS004','2696','1825','0938'),(1497,3622,5,8,2013,'KUPS005','2501','1825','0938'),(1498,3623,5,8,2013,'KVPS001','2501','1825','0938'),(1499,3623,5,8,2013,'KVPS002','2501','1825','0938'),(1500,3623,5,8,2013,'KVPS003','2501','1825','0938'),(1501,3623,5,8,2013,'KVPS004','2501','1825','0938'),(1502,3623,5,8,2013,'KVPS005','1477','1825','0938'),(1503,3624,5,8,2013,'KWPS002','1477','1825','0938'),(1504,3624,5,8,2013,'KWPS003','1477','1825','0938'),(1505,3624,5,8,2013,'KWPS004','0903.452466','1825','0938'),(1506,3619,6,8,2013,'KTPS001','2664','1825','0938'),(1507,3619,6,8,2013,'KTPS002','2664','1825','0938'),(1508,3619,6,8,2013,'KTPS003','2664','1825','0938'),(1509,3619,6,8,2013,'KTPS004','2664','1825','0938'),(1510,3619,6,8,2013,'KTPS005','2664','1825','0938'),(1511,3619,6,8,2013,'KTPS007','2664','1825','0938'),(1512,3620,6,8,2013,'KYPS001','','1825','0938'),(1513,3620,6,8,2013,'KYPS002','','1825','0938'),(1514,3620,6,8,2013,'KYPS003','','1825','0938'),(1515,3620,6,8,2013,'KYPS005','','1825','0938'),(1516,3620,6,8,2013,'KYPS006','','1825','0938'),(1517,3620,6,8,2013,'KYPS011','2895','1825','0938'),(1518,3621,6,8,2013,'LMPS001','2895','1825','0938'),(1519,3621,6,8,2013,'LMPS002','2895','1825','0938'),(1520,3621,6,8,2013,'LMPS003','2895','1825','0938'),(1521,3621,6,8,2013,'LMPS004','2696','1825','0938'),(1522,3622,6,8,2013,'KUPS001','2696','1825','0938'),(1523,3622,6,8,2013,'KUPS002','2696','1825','0938'),(1524,3622,6,8,2013,'KUPS003','2696','1825','0938'),(1525,3622,6,8,2013,'KUPS004','2696','1825','0938'),(1526,3622,6,8,2013,'KUPS005','2501','1825','0938'),(1527,3623,6,8,2013,'KVPS001','2501','1825','0938'),(1528,3623,6,8,2013,'KVPS002','2501','1825','0938'),(1529,3623,6,8,2013,'KVPS003','2501','1825','0938'),(1530,3623,6,8,2013,'KVPS004','2501','1825','0938'),(1531,3623,6,8,2013,'KVPS005','1477','1825','0938'),(1532,3624,6,8,2013,'KWPS002','1477','1825','0938'),(1533,3624,6,8,2013,'KWPS003','1477','1825','0938'),(1534,3624,6,8,2013,'KWPS004','0903.452466','1825','0938'),(1535,3619,7,8,2013,'KTPS001','2664','1825','0938'),(1536,3619,7,8,2013,'KTPS002','2664','1825','0938'),(1537,3619,7,8,2013,'KTPS003','2664','1825','0938'),(1538,3619,7,8,2013,'KTPS004','2664','1825','0938'),(1539,3619,7,8,2013,'KTPS005','2664','1825','0938'),(1540,3619,7,8,2013,'KTPS007','2664','1825','0938'),(1541,3620,7,8,2013,'KYPS001','','1825','0938'),(1542,3620,7,8,2013,'KYPS002','','1825','0938'),(1543,3620,7,8,2013,'KYPS003','','1825','0938'),(1544,3620,7,8,2013,'KYPS005','','1825','0938'),(1545,3620,7,8,2013,'KYPS006','','1825','0938'),(1546,3620,7,8,2013,'KYPS011','2895','1825','0938'),(1547,3621,7,8,2013,'LMPS001','2895','1825','0938'),(1548,3621,7,8,2013,'LMPS002','2895','1825','0938'),(1549,3621,7,8,2013,'LMPS003','2895','1825','0938'),(1550,3621,7,8,2013,'LMPS004','2696','1825','0938'),(1551,3622,7,8,2013,'KUPS001','2696','1825','0938'),(1552,3622,7,8,2013,'KUPS002','2696','1825','0938'),(1553,3622,7,8,2013,'KUPS003','2696','1825','0938'),(1554,3622,7,8,2013,'KUPS004','2696','1825','0938'),(1555,3622,7,8,2013,'KUPS005','2501','1825','0938'),(1556,3623,7,8,2013,'KVPS001','2501','1825','0938'),(1557,3623,7,8,2013,'KVPS002','2501','1825','0938'),(1558,3623,7,8,2013,'KVPS003','2501','1825','0938'),(1559,3623,7,8,2013,'KVPS004','2501','1825','0938'),(1560,3623,7,8,2013,'KVPS005','1477','1825','0938'),(1561,3624,7,8,2013,'KWPS002','1477','1825','0938'),(1562,3624,7,8,2013,'KWPS003','1477','1825','0938'),(1563,3624,7,8,2013,'KWPS004','0903.452466','1825','0938'),(1564,3619,9,8,2013,'KTPS001','2664','1825','0938'),(1565,3619,9,8,2013,'KTPS002','2664','1825','0938'),(1566,3619,9,8,2013,'KTPS003','2664','1825','0938'),(1567,3619,9,8,2013,'KTPS004','2664','1825','0938'),(1568,3619,9,8,2013,'KTPS005','2664','1825','0938'),(1569,3619,9,8,2013,'KTPS007','2664','1825','0938'),(1570,3620,9,8,2013,'KYPS001','','1825','0938'),(1571,3620,9,8,2013,'KYPS002','','1825','0938'),(1572,3620,9,8,2013,'KYPS003','','1825','0938'),(1573,3620,9,8,2013,'KYPS005','','1825','0938'),(1574,3620,9,8,2013,'KYPS006','','1825','0938'),(1575,3620,9,8,2013,'KYPS011','2895','1825','0938'),(1576,3621,9,8,2013,'LMPS001','2895','1825','0938'),(1577,3621,9,8,2013,'LMPS002','2895','1825','0938'),(1578,3621,9,8,2013,'LMPS003','2895','1825','0938'),(1579,3621,9,8,2013,'LMPS004','2696','1825','0938'),(1580,3622,9,8,2013,'KUPS001','2696','1825','0938'),(1581,3622,9,8,2013,'KUPS002','2696','1825','0938'),(1582,3622,9,8,2013,'KUPS003','2696','1825','0938'),(1583,3622,9,8,2013,'KUPS004','2696','1825','0938'),(1584,3622,9,8,2013,'KUPS005','2501','1825','0938'),(1585,3623,9,8,2013,'KVPS001','2501','1825','0938'),(1586,3623,9,8,2013,'KVPS002','2501','1825','0938'),(1587,3623,9,8,2013,'KVPS003','2501','1825','0938'),(1588,3623,9,8,2013,'KVPS004','2501','1825','0938'),(1589,3623,9,8,2013,'KVPS005','1477','1825','0938'),(1590,3624,9,8,2013,'KWPS002','1477','1825','0938'),(1591,3624,9,8,2013,'KWPS003','1477','1825','0938'),(1592,3624,9,8,2013,'KWPS004','0903.452466','1825','0938');
/*!40000 ALTER TABLE `Report4S` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report4SAttribute`
--

DROP TABLE IF EXISTS `Report4SAttribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report4SAttribute` (
  `Report4SAttributeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Field` varchar(255) NOT NULL,
  `Label` varchar(255) NOT NULL,
  `TargetValue` float DEFAULT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`Report4SAttributeID`),
  UNIQUE KEY `UQ_Report4SAttribute` (`Field`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report4SAttribute`
--

LOCK TABLES `Report4SAttribute` WRITE;
/*!40000 ALTER TABLE `Report4SAttribute` DISABLE KEYS */;
INSERT INTO `Report4SAttribute` VALUES (1,'S1','S1',100,1),(2,'S2','S2',100,2),(3,'S3','S3',100,3),(4,'S4','S4',100,4);
/*!40000 ALTER TABLE `Report4SAttribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report4SDetail`
--

DROP TABLE IF EXISTS `Report4SDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report4SDetail` (
  `Report4SDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Report4SAttributeID` bigint(20) NOT NULL,
  `Report4SID` bigint(20) NOT NULL,
  `Value` float DEFAULT NULL,
  PRIMARY KEY (`Report4SDetailID`),
  UNIQUE KEY `UQ_Report4SDetail` (`Report4SAttributeID`,`Report4SID`),
  KEY `FK_Report4SDetail_4S` (`Report4SID`),
  CONSTRAINT `FK_Report4SDetail_4S` FOREIGN KEY (`Report4SID`) REFERENCES `Report4S` (`Report4SID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_Report4SDetail_Attribute` FOREIGN KEY (`Report4SAttributeID`) REFERENCES `Report4SAttribute` (`Report4SAttributeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6348 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report4SDetail`
--

LOCK TABLES `Report4SDetail` WRITE;
/*!40000 ALTER TABLE `Report4SDetail` DISABLE KEYS */;
INSERT INTO `Report4SDetail` VALUES (1044,1,269,123.3),(1045,2,269,125.2),(1046,3,269,100.7),(1047,4,269,100),(1048,1,270,130.9),(1049,2,270,122.7),(1050,3,270,100.9),(1051,4,270,100),(1052,1,271,119.3),(1053,2,271,117.7),(1054,3,271,100.5),(1055,4,271,100),(1056,1,272,124.3),(1057,2,272,127),(1058,3,272,100.5),(1059,4,272,100),(1060,1,273,117.8),(1061,2,273,123),(1062,3,273,64.1),(1063,4,273,100),(1064,1,274,124.6),(1065,2,274,56.2),(1066,3,274,41.2),(1067,4,274,100),(1068,1,275,122.8),(1069,2,275,118.9),(1070,3,275,48.9),(1071,4,275,100),(1072,1,276,122.6),(1073,2,276,119.9),(1074,3,276,117.4),(1075,4,276,100),(1076,1,277,48.9),(1077,2,277,0),(1078,3,277,113.3),(1079,4,277,100),(1080,1,278,120.4),(1081,2,278,126.1),(1082,3,278,53.3),(1083,4,278,100),(1084,1,279,125.7),(1085,2,279,124.8),(1086,3,279,92),(1087,4,279,100),(1088,1,280,118.7),(1089,2,280,120.2),(1090,3,280,57.2),(1091,4,280,100),(1092,1,281,157.2),(1093,2,281,149.7),(1094,3,281,100.6),(1095,4,281,100),(1096,1,282,161.5),(1097,2,282,139.1),(1098,3,282,138.7),(1099,4,282,100),(1100,1,283,157.8),(1101,2,283,142.2),(1102,3,283,120.5),(1103,4,283,100),(1104,1,284,148.7),(1105,2,284,120.8),(1106,3,284,114.7),(1107,4,284,100),(1108,1,285,168.7),(1109,2,285,117.7),(1110,3,285,178.6),(1111,4,285,100),(1112,1,286,134.8),(1113,2,286,139.4),(1114,3,286,155.2),(1115,4,286,100),(1116,1,287,65),(1117,2,287,21.7),(1118,3,287,40.8),(1119,4,287,100),(1120,1,288,118),(1121,2,288,55.9),(1122,3,288,63.1),(1123,4,288,100),(1124,1,289,119.3),(1125,2,289,37.6),(1126,3,289,110),(1127,4,289,100),(1128,1,290,122),(1129,2,290,35.7),(1130,3,290,111.5),(1131,4,290,100),(1132,1,291,119.8),(1133,2,291,11.2),(1134,3,291,101.4),(1135,4,291,100),(1136,1,292,124.6),(1137,2,292,5.9),(1138,3,292,110.9),(1139,4,292,100),(1140,1,293,115.7),(1141,2,293,111.2),(1142,3,293,65.5),(1143,4,293,100),(1144,1,294,111.7),(1145,2,294,111.5),(1146,3,294,108.5),(1147,4,294,100),(1148,1,295,131.7),(1149,2,295,113.4),(1150,3,295,102.3),(1151,4,295,100),(1152,1,296,113),(1153,2,296,110.9),(1154,3,296,110.4),(1155,4,296,100),(1156,1,297,121.3),(1157,2,297,109.9),(1158,3,297,110),(1159,4,297,100),(1160,1,298,134.3),(1161,2,298,114.6),(1162,3,298,108.5),(1163,4,298,100),(1164,1,299,120.4),(1165,2,299,110.2),(1166,3,299,100.5),(1167,4,299,100),(1168,1,300,125.4),(1169,2,300,0),(1170,3,300,46.1),(1171,4,300,100),(1172,1,301,134.3),(1173,2,301,0.6),(1174,3,301,111.2),(1175,4,301,100),(1176,1,302,124.3),(1177,2,302,0),(1178,3,302,53.1),(1179,4,302,100),(1180,1,303,122.8),(1181,2,303,0),(1182,3,303,111.2),(1183,4,303,100),(1184,1,304,113),(1185,2,304,1.3),(1186,3,304,130.2),(1187,4,304,100),(1188,1,305,0),(1189,2,305,0),(1190,3,305,0),(1191,4,305,100),(1192,1,306,133.5),(1193,2,306,120.8),(1194,3,306,65.3),(1195,4,306,100),(1196,1,307,131.5),(1197,2,307,118.3),(1198,3,307,72.9),(1199,4,307,100),(1200,1,308,133.3),(1201,2,308,118.9),(1202,3,308,109.5),(1203,4,308,100),(1204,1,309,136.1),(1205,2,309,118),(1206,3,309,101.1),(1207,4,309,100),(1208,1,310,132),(1209,2,310,94.1),(1210,3,310,84.5),(1211,4,310,100),(1212,1,311,134.3),(1213,2,311,101.2),(1214,3,311,101.1),(1215,4,311,100),(1216,1,312,155.4),(1217,2,312,124.5),(1218,3,312,101.9),(1219,4,312,100),(1220,1,313,133.5),(1221,2,313,148.1),(1222,3,313,93.6),(1223,4,313,100),(1224,1,314,138.7),(1225,2,314,122),(1226,3,314,101.7),(1227,4,314,100),(1228,1,315,132.8),(1229,2,315,118.6),(1230,3,315,119.5),(1231,4,315,100),(1232,1,316,118.7),(1233,2,316,7.1),(1234,3,316,114.7),(1235,4,316,100),(1236,1,317,121.3),(1237,2,317,3.4),(1238,3,317,110.8),(1239,4,317,100),(1240,1,318,103.9),(1241,2,318,1.6),(1242,3,318,76),(1243,4,318,100),(1244,1,319,121.1),(1245,2,319,71.7),(1246,3,319,115.1),(1247,4,319,100),(1248,1,320,119.3),(1249,2,320,35.1),(1250,3,320,113.1),(1251,4,320,100),(1252,1,321,130.9),(1253,2,321,124.8),(1254,3,321,105.3),(1255,4,321,100),(1256,1,322,138.3),(1257,2,322,124.5),(1258,3,322,100.6),(1259,4,322,100),(1260,1,323,130.7),(1261,2,323,128.6),(1262,3,323,84.1),(1263,4,323,100),(1264,1,324,135.2),(1265,2,324,122.4),(1266,3,324,107.5),(1267,4,324,100),(1268,1,325,137.2),(1269,2,325,129.2),(1270,3,325,49.1),(1271,4,325,100),(1272,1,326,132.8),(1273,2,326,128.6),(1274,3,326,76),(1275,4,326,100),(1276,1,327,126.5),(1277,2,327,120.2),(1278,3,327,120.1),(1279,4,327,100),(1280,1,328,115.2),(1281,2,328,114.6),(1282,3,328,92),(1283,4,328,100),(1284,1,329,132.4),(1285,2,329,140.1),(1286,3,329,108.5),(1287,4,329,100),(1288,1,330,115),(1289,2,330,124.2),(1290,3,330,110.5),(1291,4,330,100),(1292,1,331,121.5),(1293,2,331,116.5),(1294,3,331,102.4),(1295,4,331,100),(1296,1,332,133.5),(1297,2,332,126.1),(1298,3,332,102.5),(1299,4,332,100),(1300,1,333,123.5),(1301,2,333,156.5),(1302,3,333,111),(1303,4,333,100),(1304,1,334,124.1),(1305,2,334,111.2),(1306,3,334,114.5),(1307,4,334,100),(1308,1,335,129.3),(1309,2,335,115.5),(1310,3,335,113.3),(1311,4,335,100),(1312,1,336,115.9),(1313,2,336,35.7),(1314,3,336,85.3),(1315,4,336,100),(1316,1,337,149.8),(1317,2,337,122),(1318,3,337,101.9),(1319,4,337,100),(1320,1,338,143.3),(1321,2,338,123),(1322,3,338,99.1),(1323,4,338,100),(1324,1,339,178.7),(1325,2,339,121.1),(1326,3,339,98.4),(1327,4,339,100),(1328,1,340,136.5),(1329,2,340,112.1),(1330,3,340,77.1),(1331,4,340,100),(1332,1,341,127.6),(1333,2,341,109.6),(1334,3,341,51.1),(1335,4,341,100),(1336,1,342,132.2),(1337,2,342,114.9),(1338,3,342,75.5),(1339,4,342,100),(1340,1,343,144.6),(1341,2,343,114.3),(1342,3,343,67.9),(1343,4,343,100),(1344,1,344,113.7),(1345,2,344,115.2),(1346,3,344,103),(1347,4,344,100),(1348,1,345,109.8),(1349,2,345,135.1),(1350,3,345,100.2),(1351,4,345,100),(1352,1,346,127.2),(1353,2,346,109.3),(1354,3,346,100.2),(1355,4,346,100),(1356,1,347,82.8),(1357,2,347,39.1),(1358,3,347,109.9),(1359,4,347,100),(1360,1,348,75.4),(1361,2,348,39.8),(1362,3,348,110.6),(1363,4,348,100),(1364,1,349,134.1),(1365,2,349,116.1),(1366,3,349,45.9),(1367,4,349,100),(1368,1,350,132.2),(1369,2,350,112.4),(1370,3,350,51.5),(1371,4,350,100),(1372,1,351,146.5),(1373,2,351,111.8),(1374,3,351,110),(1375,4,351,100),(1376,1,352,147.8),(1377,2,352,109.3),(1378,3,352,83),(1379,4,352,100),(1380,1,353,131.3),(1381,2,353,114.3),(1382,3,353,11.3),(1383,4,353,100),(1384,1,354,103),(1385,2,354,114.6),(1386,3,354,99.7),(1387,4,354,100),(1388,1,355,117.8),(1389,2,355,119.9),(1390,3,355,116.6),(1391,4,355,100),(1392,1,356,114.3),(1393,2,356,117.7),(1394,3,356,55.5),(1395,4,356,100),(1396,1,357,117),(1397,2,357,118.6),(1398,3,357,108.5),(1399,4,357,100),(1400,1,358,115),(1401,2,358,132.9),(1402,3,358,108.4),(1403,4,358,100),(1404,1,359,124.6),(1405,2,359,119.3),(1406,3,359,111.7),(1407,4,359,100),(1408,1,360,123.5),(1409,2,360,125.5),(1410,3,360,111.5),(1411,4,360,100),(1412,1,361,147.4),(1413,2,361,119.6),(1414,3,361,101.8),(1415,4,361,100),(1416,1,362,130.2),(1417,2,362,118.9),(1418,3,362,91.5),(1419,4,362,100),(1420,1,363,122.4),(1421,2,363,119.6),(1422,3,363,111),(1423,4,363,100),(1424,1,364,119.8),(1425,2,364,119.3),(1426,3,364,113.8),(1427,4,364,100),(1428,1,365,138.3),(1429,2,365,120.8),(1430,3,365,74.4),(1431,4,365,100),(1432,1,366,117.8),(1433,2,366,118.9),(1434,3,366,110),(1435,4,366,100),(1436,1,367,67.8),(1437,2,367,7.8),(1438,3,367,91.9),(1439,4,367,100),(1440,1,368,121.1),(1441,2,368,119.6),(1442,3,368,101),(1443,4,368,100),(1444,1,369,118.7),(1445,2,369,48.4),(1446,3,369,94.8),(1447,4,369,100),(1448,1,370,143.5),(1449,2,370,124.5),(1450,3,370,118.6),(1451,4,370,100),(1452,1,371,146.7),(1453,2,371,130.4),(1454,3,371,111.2),(1455,4,371,100),(1456,1,372,153.5),(1457,2,372,118.6),(1458,3,372,111.9),(1459,4,372,100),(1460,1,373,152.4),(1461,2,373,122),(1462,3,373,111.2),(1463,4,373,100),(1464,1,374,123),(1465,2,374,117.7),(1466,3,374,116.5),(1467,4,374,100),(1468,1,375,119.6),(1469,2,375,117.7),(1470,3,375,130),(1471,4,375,100),(1472,1,376,144.8),(1473,2,376,120.5),(1474,3,376,101.6),(1475,4,376,100),(1476,1,377,144.1),(1477,2,377,118.9),(1478,3,377,110.5),(1479,4,377,100),(1480,1,378,143.3),(1481,2,378,118.6),(1482,3,378,114.9),(1483,4,378,100),(1484,1,379,142.4),(1485,2,379,119.3),(1486,3,379,110.7),(1487,4,379,100),(1488,1,380,140.2),(1489,2,380,119.6),(1490,3,380,111),(1491,4,380,100),(1492,1,381,126.1),(1493,2,381,126.7),(1494,3,381,136),(1495,4,381,100),(1496,1,382,139.3),(1497,2,382,128.3),(1498,3,382,116.9),(1499,4,382,100),(1500,1,383,130.7),(1501,2,383,127.6),(1502,3,383,121.8),(1503,4,383,100),(1504,1,384,124.1),(1505,2,384,64.9),(1506,3,384,120.7),(1507,4,384,100),(1508,1,385,137.6),(1509,2,385,128),(1510,3,385,133.1),(1511,4,385,100),(1512,1,386,128.7),(1513,2,386,128.9),(1514,3,386,130.4),(1515,4,386,100),(1516,1,387,98.5),(1517,2,387,21.4),(1518,3,387,134.2),(1519,4,387,100),(1520,1,388,55.4),(1521,2,388,22),(1522,3,388,125.6),(1523,4,388,100),(1524,1,389,90),(1525,2,389,68.9),(1526,3,389,93.8),(1527,4,389,100),(1528,1,390,71.7),(1529,2,390,76.7),(1530,3,390,102),(1531,4,390,100),(1532,1,391,119.1),(1533,2,391,97.2),(1534,3,391,120.1),(1535,4,391,100),(1536,1,392,120.2),(1537,2,392,45.7),(1538,3,392,120.4),(1539,4,392,100),(1540,1,393,120),(1541,2,393,46.9),(1542,3,393,117.2),(1543,4,393,100),(1544,1,394,87),(1545,2,394,32.3),(1546,3,394,127.8),(1547,4,394,100),(1548,1,395,53),(1549,2,395,0),(1550,3,395,72.3),(1551,4,395,100),(1552,1,396,36.3),(1553,2,396,0),(1554,3,396,50.1),(1555,4,396,100),(1556,1,397,93.7),(1557,2,397,0.3),(1558,3,397,107.5),(1559,4,397,100),(1560,1,398,62.2),(1561,2,398,0),(1562,3,398,91.1),(1563,4,398,100),(1564,1,399,63.3),(1565,2,399,0),(1566,3,399,93.7),(1567,4,399,100),(1568,1,400,39.6),(1569,2,400,0),(1570,3,400,16.9),(1571,4,400,100),(1572,1,401,0),(1573,2,401,0),(1574,3,401,0),(1575,4,401,100),(1576,1,402,62.4),(1577,2,402,0.3),(1578,3,402,130.8),(1579,4,402,100),(1580,1,403,63.5),(1581,2,403,0),(1582,3,403,128.5),(1583,4,403,100),(1584,1,404,67),(1585,2,404,0.3),(1586,3,404,146),(1587,4,404,100),(1588,1,405,58.5),(1589,2,405,0),(1590,3,405,142.3),(1591,4,405,100),(1592,1,406,0),(1593,2,406,0),(1594,3,406,0),(1595,4,406,100),(1596,1,407,131.3),(1597,2,407,119.6),(1598,3,407,46.1),(1599,4,407,100),(1600,1,408,39.6),(1601,2,408,4.3),(1602,3,408,110.8),(1603,4,408,100),(1604,1,409,118.7),(1605,2,409,117.7),(1606,3,409,45.6),(1607,4,409,100),(1608,1,410,115.9),(1609,2,410,118.9),(1610,3,410,39.4),(1611,4,410,100),(1612,1,411,80),(1613,2,411,88.5),(1614,3,411,55.6),(1615,4,411,100),(1616,1,412,120.7),(1617,2,412,79.8),(1618,3,412,56.4),(1619,4,412,100),(1620,1,413,118.5),(1621,2,413,0),(1622,3,413,105.7),(1623,4,413,100),(1624,1,414,129.3),(1625,2,414,0),(1626,3,414,110.3),(1627,4,414,100),(1628,1,415,122.8),(1629,2,415,0.3),(1630,3,415,82.2),(1631,4,415,100),(1632,1,416,110.4),(1633,2,416,1.6),(1634,3,416,83.5),(1635,4,416,100),(1636,1,417,95.2),(1637,2,417,0),(1638,3,417,56.8),(1639,4,417,100),(1640,1,418,115.4),(1641,2,418,1),(1642,3,418,111.8),(1643,4,418,100),(1644,1,419,74.1),(1645,2,419,0.6),(1646,3,419,55.8),(1647,4,419,100),(1648,1,420,105.9),(1649,2,420,0),(1650,3,420,100.9),(1651,4,420,100),(1652,1,421,215.7),(1653,2,421,31.7),(1654,3,421,66.2),(1655,4,421,100),(1656,1,422,70.4),(1657,2,422,2.8),(1658,3,422,33.5),(1659,4,422,100),(1660,1,423,137.2),(1661,2,423,119.6),(1662,3,423,66.7),(1663,4,423,100),(1664,1,424,134.8),(1665,2,424,118.6),(1666,3,424,116.6),(1667,4,424,100),(1668,1,425,107),(1669,2,425,9),(1670,3,425,109.8),(1671,4,425,100),(1672,1,426,143.7),(1673,2,426,121.7),(1674,3,426,110.8),(1675,4,426,100),(1676,1,427,118.9),(1677,2,427,0.3),(1678,3,427,110.5),(1679,4,427,100),(1680,1,428,112),(1681,2,428,45),(1682,3,428,110.6),(1683,4,428,100),(1684,1,429,75.7),(1685,2,429,28),(1686,3,429,30.1),(1687,4,429,100),(1688,1,430,134.8),(1689,2,430,110.9),(1690,3,430,30.2),(1691,4,430,100),(1692,1,431,81.5),(1693,2,431,56.5),(1694,3,431,104.6),(1695,4,431,100),(1696,1,432,125),(1697,2,432,111.8),(1698,3,432,107.4),(1699,4,432,100),(1700,1,433,29.3),(1701,2,433,0.3),(1702,3,433,9.8),(1703,4,433,100),(1704,1,434,94.6),(1705,2,434,18),(1706,3,434,110.3),(1707,4,434,100),(1708,1,435,111.1),(1709,2,435,23.9),(1710,3,435,94.8),(1711,4,435,100),(1712,1,436,126.3),(1713,2,436,112.7),(1714,3,436,78.1),(1715,4,436,100),(1716,1,437,123.9),(1717,2,437,108.7),(1718,3,437,108.9),(1719,4,437,100),(1720,1,438,25),(1721,2,438,3.7),(1722,3,438,109.8),(1723,4,438,100),(1724,1,439,113),(1725,2,439,13.7),(1726,3,439,30.8),(1727,4,439,100),(1728,1,440,117.4),(1729,2,440,14),(1730,3,440,110.5),(1731,4,440,100),(1732,1,441,110),(1733,2,441,14),(1734,3,441,110.2),(1735,4,441,100),(1736,1,442,113.9),(1737,2,442,6.2),(1738,3,442,110.4),(1739,4,442,100),(1740,1,443,9.1),(1741,2,443,1.9),(1742,3,443,33.1),(1743,4,443,100),(1744,1,444,37.2),(1745,2,444,1.2),(1746,3,444,33.5),(1747,4,444,100),(1748,1,445,139.1),(1749,2,445,125.2),(1750,3,445,35.3),(1751,4,445,100),(1752,1,446,133.3),(1753,2,446,118),(1754,3,446,38.6),(1755,4,446,100),(1756,1,447,118.7),(1757,2,447,3.4),(1758,3,447,112.2),(1759,4,447,100),(1760,1,448,119.8),(1761,2,448,6.5),(1762,3,448,101.6),(1763,4,448,100),(1764,1,449,137),(1765,2,449,130.4),(1766,3,449,103.9),(1767,4,449,100),(1768,1,450,94.6),(1769,2,450,23.3),(1770,3,450,111.1),(1771,4,450,100),(1772,1,451,135.9),(1773,2,451,129.8),(1774,3,451,110.6),(1775,4,451,100),(1776,1,452,120.7),(1777,2,452,6.8),(1778,3,452,109.7),(1779,4,452,100),(1780,1,453,118.7),(1781,2,453,16.8),(1782,3,453,109.1),(1783,4,453,100),(1784,1,454,118.9),(1785,2,454,29.5),(1786,3,454,110),(1787,4,454,100),(1788,1,455,117.6),(1789,2,455,23.9),(1790,3,455,111),(1791,4,455,100),(1792,1,456,118.9),(1793,2,456,6.8),(1794,3,456,109.6),(1795,4,456,100),(1796,1,457,15.2),(1797,2,457,2.2),(1798,3,457,32.1),(1799,4,457,100),(1800,1,458,78.3),(1801,2,458,17.4),(1802,3,458,100),(1803,4,458,100),(1804,1,459,115),(1805,2,459,7.5),(1806,3,459,111.5),(1807,4,459,100),(1808,1,460,111.5),(1809,2,460,9.3),(1810,3,460,110),(1811,4,460,100),(1812,1,461,119.6),(1813,2,461,110.6),(1814,3,461,111.3),(1815,4,461,100),(1816,1,462,117.8),(1817,2,462,108.1),(1818,3,462,111.3),(1819,4,462,100),(1820,1,463,123.9),(1821,2,463,109.6),(1822,3,463,110.5),(1823,4,463,100),(1824,1,464,123.5),(1825,2,464,109.6),(1826,3,464,111.3),(1827,4,464,100),(1828,1,465,122.6),(1829,2,465,7.1),(1830,3,465,95),(1831,4,465,100),(1832,1,466,135),(1833,2,466,114.9),(1834,3,466,110.2),(1835,4,466,100),(1836,1,467,114.6),(1837,2,467,112.7),(1838,3,467,110.5),(1839,4,467,100),(1840,1,468,119.6),(1841,2,468,7.5),(1842,3,468,105.7),(1843,4,468,100),(1844,1,469,110.9),(1845,2,469,111.2),(1846,3,469,110.1),(1847,4,469,100),(1848,1,470,118.7),(1849,2,470,118.9),(1850,3,470,100.5),(1851,4,470,100),(1852,1,471,118.7),(1853,2,471,119.6),(1854,3,471,100.5),(1855,4,471,100),(1856,1,472,125.2),(1857,2,472,5.3),(1858,3,472,109.1),(1859,4,472,0),(1860,1,473,121.7),(1861,2,473,119.6),(1862,3,473,100.6),(1863,4,473,100),(1864,1,474,124.3),(1865,2,474,5.9),(1866,3,474,102.7),(1867,4,474,0),(1868,1,475,121.3),(1869,2,475,119.9),(1870,3,475,100.3),(1871,4,475,100),(1872,1,476,125.4),(1873,2,476,125.5),(1874,3,476,100.1),(1875,4,476,100),(1876,1,477,120),(1877,2,477,118.6),(1878,3,477,101),(1879,4,477,100),(1880,1,478,120.4),(1881,2,478,119.6),(1882,3,478,101.9),(1883,4,478,100),(1884,1,479,126.1),(1885,2,479,109.3),(1886,3,479,43.3),(1887,4,479,100),(1888,1,480,108.9),(1889,2,480,26.7),(1890,3,480,102.7),(1891,4,480,100),(1892,1,481,106.1),(1893,2,481,32),(1894,3,481,38.6),(1895,4,481,100),(1896,1,482,140.2),(1897,2,482,122.7),(1898,3,482,130.5),(1899,4,482,100),(1900,1,483,112.8),(1901,2,483,33.5),(1902,3,483,51),(1903,4,483,100),(1904,1,484,78.7),(1905,2,484,21.7),(1906,3,484,110.6),(1907,4,484,100),(1908,1,485,51.7),(1909,2,485,20.2),(1910,3,485,111.1),(1911,4,485,100),(1912,1,486,53),(1913,2,486,15.8),(1914,3,486,110.6),(1915,4,486,100),(1916,1,487,56.5),(1917,2,487,21.4),(1918,3,487,83.8),(1919,4,487,100),(1920,1,488,124.3),(1921,2,488,110.6),(1922,3,488,36.4),(1923,4,488,100),(1924,1,489,135.7),(1925,2,489,120.2),(1926,3,489,42.7),(1927,4,489,100),(1928,1,490,143.3),(1929,2,490,122.4),(1930,3,490,112.7),(1931,4,490,100),(1932,1,491,118.5),(1933,2,491,6.5),(1934,3,491,112.6),(1935,4,491,100),(1936,1,492,119.3),(1937,2,492,19.9),(1938,3,492,100.9),(1939,4,492,100),(1940,1,493,75.9),(1941,2,493,34.8),(1942,3,493,52.9),(1943,4,493,100),(1944,1,494,112.8),(1945,2,494,10.6),(1946,3,494,101),(1947,4,494,100),(1948,1,495,133.3),(1949,2,495,68),(1950,3,495,64.8),(1951,4,495,100),(1952,1,496,127.6),(1953,2,496,109.6),(1954,3,496,79.5),(1955,4,496,100),(1956,1,497,118.9),(1957,2,497,122.4),(1958,3,497,49.9),(1959,4,497,100),(1960,1,498,118),(1961,2,498,11.2),(1962,3,498,101.5),(1963,4,498,100),(1964,1,499,127.4),(1965,2,499,96.9),(1966,3,499,56.6),(1967,4,499,100),(1968,1,500,154.3),(1969,2,500,119.3),(1970,3,500,87.3),(1971,4,500,100),(1972,1,501,119.3),(1973,2,501,96.9),(1974,3,501,45.5),(1975,4,501,100),(1976,1,502,120.2),(1977,2,502,19.9),(1978,3,502,76.4),(1979,4,502,100),(1980,1,503,112.4),(1981,2,503,27.3),(1982,3,503,91.2),(1983,4,503,100),(1984,1,504,113.3),(1985,2,504,21.7),(1986,3,504,92.2),(1987,4,504,100),(1988,1,505,112.6),(1989,2,505,31.4),(1990,3,505,90.6),(1991,4,505,100),(1992,1,506,115.4),(1993,2,506,16.5),(1994,3,506,91.3),(1995,4,506,100),(1996,1,507,110),(1997,2,507,23.6),(1998,3,507,91.8),(1999,4,507,100),(2000,1,508,105.9),(2001,2,508,7.5),(2002,3,508,51.9),(2003,4,508,100),(2004,1,509,114.8),(2005,2,509,11.8),(2006,3,509,111.1),(2007,4,509,100),(2008,1,510,115.2),(2009,2,510,43.2),(2010,3,510,102.4),(2011,4,510,100),(2012,1,511,112.4),(2013,2,511,28.9),(2014,3,511,100.3),(2015,4,511,100),(2016,1,512,116.1),(2017,2,512,20.8),(2018,3,512,91.2),(2019,4,512,100),(2020,1,513,100.7),(2021,2,513,5.3),(2022,3,513,110.8),(2023,4,513,100),(2024,1,514,133.7),(2025,2,514,110.2),(2026,3,514,107.1),(2027,4,514,100),(2028,1,515,121.1),(2029,2,515,110.6),(2030,3,515,105.2),(2031,4,515,100),(2032,1,516,131.3),(2033,2,516,112.4),(2034,3,516,131.2),(2035,4,516,100),(2036,1,517,102.8),(2037,2,517,5.9),(2038,3,517,120.3),(2039,4,517,100),(2040,1,518,159.1),(2041,2,518,125.5),(2042,3,518,106.9),(2043,4,518,100),(2044,1,519,156.3),(2045,2,519,122),(2046,3,519,102.9),(2047,4,519,100),(2048,1,520,142),(2049,2,520,121.7),(2050,3,520,104.5),(2051,4,520,100),(2052,1,521,148.7),(2053,2,521,124.2),(2054,3,521,101.4),(2055,4,521,100),(2056,1,522,116.3),(2057,2,522,8.4),(2058,3,522,101.2),(2059,4,522,100),(2060,1,523,119.6),(2061,2,523,9.3),(2062,3,523,104.4),(2063,4,523,100),(2064,1,524,146.7),(2065,2,524,116.8),(2066,3,524,110.7),(2067,4,524,100),(2068,1,525,113),(2069,2,525,9),(2070,3,525,90.8),(2071,4,525,100),(2072,1,526,111.1),(2073,2,526,4.7),(2074,3,526,86),(2075,4,526,100),(2076,1,527,112),(2077,2,527,41.9),(2078,3,527,100.9),(2079,4,527,100),(2080,1,528,153),(2081,2,528,116.5),(2082,3,528,100.5),(2083,4,528,100),(2084,1,529,158),(2085,2,529,112.7),(2086,3,529,110.5),(2087,4,529,100),(2088,1,530,112.2),(2089,2,530,115.2),(2090,3,530,115.9),(2091,4,530,100),(2092,1,531,115.4),(2093,2,531,13.4),(2094,3,531,104.4),(2095,4,531,100),(2096,1,532,143.3),(2097,2,532,111.5),(2098,3,532,100.4),(2099,4,532,100),(2100,1,533,131.6),(2101,2,533,117.1),(2102,3,533,78.6),(2103,4,533,100),(2104,1,534,110),(2105,2,534,76.6),(2106,3,534,57.3),(2107,4,534,100),(2108,1,535,104.4),(2109,2,535,35.1),(2110,3,535,43.6),(2111,4,535,100),(2112,1,536,123.8),(2113,2,536,119.7),(2114,3,536,42.2),(2115,4,536,100),(2116,1,537,109.2),(2117,2,537,83.1),(2118,3,537,115.8),(2119,4,537,100),(2120,1,538,132.8),(2121,2,538,122),(2122,3,538,64.9),(2123,4,538,100),(2124,1,539,109.8),(2125,2,539,117.7),(2126,3,539,113.7),(2127,4,539,100),(2128,1,540,115.8),(2129,2,540,70),(2130,3,540,58.4),(2131,4,540,100),(2132,1,541,107.6),(2133,2,541,84.3),(2134,3,541,77),(2135,4,541,100),(2136,1,542,105.6),(2137,2,542,25.4),(2138,3,542,51.4),(2139,4,542,100),(2140,1,543,114.2),(2141,2,543,116.9),(2142,3,543,104.3),(2143,4,543,100),(2144,1,544,112.4),(2145,2,544,116.9),(2146,3,544,100.7),(2147,4,544,100),(2148,1,545,112.6),(2149,2,545,117.4),(2150,3,545,100.6),(2151,4,545,100),(2152,1,546,114.2),(2153,2,546,116.9),(2154,3,546,100),(2155,4,546,100),(2156,1,547,125.8),(2157,2,547,118),(2158,3,547,100.4),(2159,4,547,100),(2160,1,548,127.8),(2161,2,548,117.1),(2162,3,548,100.8),(2163,4,548,100),(2164,1,549,107.6),(2165,2,549,41.7),(2166,3,549,102),(2167,4,549,100),(2168,1,550,126.2),(2169,2,550,118.6),(2170,3,550,104.4),(2171,4,550,100),(2172,1,551,135.6),(2173,2,551,118.3),(2174,3,551,58.9),(2175,4,551,100),(2176,1,552,127.4),(2177,2,552,118.9),(2178,3,552,26),(2179,4,552,100),(2180,1,553,127.8),(2181,2,553,121.7),(2182,3,553,92.3),(2183,4,553,100),(2184,1,554,119.8),(2185,2,554,120),(2186,3,554,53.8),(2187,4,554,100),(2188,1,555,129.4),(2189,2,555,116.9),(2190,3,555,37.6),(2191,4,555,100),(2192,1,556,129.6),(2193,2,556,120),(2194,3,556,51),(2195,4,556,100),(2196,1,557,133.8),(2197,2,557,124),(2198,3,557,46.9),(2199,4,557,100),(2200,1,558,124),(2201,2,558,119.4),(2202,3,558,76.3),(2203,4,558,100),(2204,1,559,130.8),(2205,2,559,123.4),(2206,3,559,68.5),(2207,4,559,100),(2208,1,560,10.8),(2209,2,560,0),(2210,3,560,16.8),(2211,4,560,100),(2212,1,561,117.4),(2213,2,561,54),(2214,3,561,100.7),(2215,4,561,100),(2216,1,562,122),(2217,2,562,112.3),(2218,3,562,102.5),(2219,4,562,100),(2220,1,563,112.8),(2221,2,563,100),(2222,3,563,100.9),(2223,4,563,100),(2224,1,564,111),(2225,2,564,90.9),(2226,3,564,100.8),(2227,4,564,100),(2228,1,565,104.2),(2229,2,565,54.9),(2230,3,565,104.2),(2231,4,565,100),(2232,1,566,119),(2233,2,566,79.7),(2234,3,566,101.4),(2235,4,566,100),(2236,1,567,101.4),(2237,2,567,35.1),(2238,3,567,108.6),(2239,4,567,100),(2240,1,568,73),(2241,2,568,27.7),(2242,3,568,100.3),(2243,4,568,100),(2244,1,569,107.6),(2245,2,569,60.6),(2246,3,569,100.5),(2247,4,569,100),(2248,1,570,116.8),(2249,2,570,30.3),(2250,3,570,102.2),(2251,4,570,100),(2252,1,571,112),(2253,2,571,116.6),(2254,3,571,34.5),(2255,4,571,100),(2256,1,572,116.4),(2257,2,572,115.7),(2258,3,572,40.2),(2259,4,572,100),(2260,1,573,108),(2261,2,573,53.7),(2262,3,573,39.2),(2263,4,573,100),(2264,1,574,115),(2265,2,574,117.7),(2266,3,574,46),(2267,4,574,100),(2268,1,575,131.4),(2269,2,575,94.9),(2270,3,575,57.7),(2271,4,575,100),(2272,1,576,122),(2273,2,576,68.9),(2274,3,576,44.7),(2275,4,576,100),(2276,1,577,105),(2277,2,577,5.7),(2278,3,577,63.3),(2279,4,577,100),(2280,1,578,119.8),(2281,2,578,17.7),(2282,3,578,76.2),(2283,4,578,100),(2284,1,579,120.4),(2285,2,579,56.9),(2286,3,579,61.1),(2287,4,579,100),(2288,1,580,131.2),(2289,2,580,119.1),(2290,3,580,81.9),(2291,4,580,100),(2292,1,581,123.4),(2293,2,581,116.3),(2294,3,581,68.4),(2295,4,581,100),(2296,1,582,119.6),(2297,2,582,115.7),(2298,3,582,103.9),(2299,4,582,100),(2300,1,583,120.6),(2301,2,583,117.1),(2302,3,583,94.7),(2303,4,583,100),(2304,1,584,86.6),(2305,2,584,44.6),(2306,3,584,53.1),(2307,4,584,100),(2308,1,585,125.4),(2309,2,585,116.6),(2310,3,585,54.5),(2311,4,585,100),(2312,1,586,120.4),(2313,2,586,117.1),(2314,3,586,74.4),(2315,4,586,100),(2316,1,587,116.2),(2317,2,587,58.3),(2318,3,587,50.9),(2319,4,587,100),(2320,1,588,118.8),(2321,2,588,85.1),(2322,3,588,58.8),(2323,4,588,100),(2324,1,589,122.2),(2325,2,589,62.9),(2326,3,589,93.5),(2327,4,589,100),(2328,1,590,53),(2329,2,590,19.1),(2330,3,590,60.1),(2331,4,590,100),(2332,1,591,119.4),(2333,2,591,116),(2334,3,591,60.7),(2335,4,591,100),(2336,1,592,123.6),(2337,2,592,116),(2338,3,592,97.3),(2339,4,592,100),(2340,1,593,114.8),(2341,2,593,116.3),(2342,3,593,108.1),(2343,4,593,100),(2344,1,594,126.2),(2345,2,594,113.4),(2346,3,594,70),(2347,4,594,100),(2348,1,595,114.4),(2349,2,595,118),(2350,3,595,39),(2351,4,595,100),(2352,1,596,117.6),(2353,2,596,116.6),(2354,3,596,42.8),(2355,4,596,100),(2356,1,597,124),(2357,2,597,101.1),(2358,3,597,27.4),(2359,4,597,100),(2360,1,598,115.8),(2361,2,598,117.4),(2362,3,598,61.4),(2363,4,598,100),(2364,1,599,122.6),(2365,2,599,120.3),(2366,3,599,61.5),(2367,4,599,100),(2368,1,600,122.6),(2369,2,600,119.7),(2370,3,600,58),(2371,4,600,100),(2372,1,601,140.8),(2373,2,601,118.6),(2374,3,601,59.7),(2375,4,601,100),(2376,1,602,118.4),(2377,2,602,118.6),(2378,3,602,48.6),(2379,4,602,100),(2380,1,603,112.6),(2381,2,603,116.3),(2382,3,603,42.6),(2383,4,603,100),(2384,1,604,135),(2385,2,604,118.3),(2386,3,604,60.6),(2387,4,604,100),(2388,1,605,136.2),(2389,2,605,117.4),(2390,3,605,71.1),(2391,4,605,100),(2392,1,606,126),(2393,2,606,119.1),(2394,3,606,47.5),(2395,4,606,100),(2396,1,607,141.4),(2397,2,607,118),(2398,3,607,40.9),(2399,4,607,100),(2400,1,608,138.8),(2401,2,608,121.1),(2402,3,608,73.8),(2403,4,608,100),(2404,1,609,123.2),(2405,2,609,119.7),(2406,3,609,57.6),(2407,4,609,100),(2408,1,610,124.2),(2409,2,610,118),(2410,3,610,110.7),(2411,4,610,100),(2412,1,611,108.4),(2413,2,611,116.3),(2414,3,611,68.4),(2415,4,611,100),(2416,1,612,113),(2417,2,612,117.1),(2418,3,612,62.5),(2419,4,612,100),(2420,1,613,115),(2421,2,613,116.3),(2422,3,613,90.5),(2423,4,613,100),(2424,1,614,86.4),(2425,2,614,40.6),(2426,3,614,79.3),(2427,4,614,100),(2428,1,615,116.8),(2429,2,615,119.4),(2430,3,615,59.4),(2431,4,615,100),(2432,1,616,120),(2433,2,616,118.6),(2434,3,616,59.4),(2435,4,616,100),(2436,1,617,30.6),(2437,2,617,7.1),(2438,3,617,52),(2439,4,617,100),(2440,1,618,129.4),(2441,2,618,122.6),(2442,3,618,50.2),(2443,4,618,100),(2444,1,619,140.4),(2445,2,619,116.9),(2446,3,619,51.9),(2447,4,619,100),(2448,1,620,24.8),(2449,2,620,2.3),(2450,3,620,112.8),(2451,4,620,100),(2452,1,621,141.2),(2453,2,621,121.1),(2454,3,621,63.1),(2455,4,621,100),(2456,1,622,122.6),(2457,2,622,55.1),(2458,3,622,52.6),(2459,4,622,100),(2460,1,623,110.8),(2461,2,623,38),(2462,3,623,100.7),(2463,4,623,100),(2464,1,624,119.8),(2465,2,624,10.9),(2466,3,624,58.2),(2467,4,624,100),(2468,1,625,100.8),(2469,2,625,8),(2470,3,625,60.6),(2471,4,625,100),(2472,1,626,94.6),(2473,2,626,14.3),(2474,3,626,61.9),(2475,4,626,100),(2476,1,627,90.6),(2477,2,627,7.4),(2478,3,627,63.5),(2479,4,627,100),(2480,1,628,94),(2481,2,628,18),(2482,3,628,68.8),(2483,4,628,100),(2484,1,629,154.2),(2485,2,629,110),(2486,3,629,78.3),(2487,4,629,100),(2488,1,630,127.2),(2489,2,630,109.4),(2490,3,630,63),(2491,4,630,100),(2492,1,631,149.4),(2493,2,631,120),(2494,3,631,61.1),(2495,4,631,100),(2496,1,632,147.2),(2497,2,632,108.6),(2498,3,632,50.2),(2499,4,632,100),(2500,1,633,127.6),(2501,2,633,109.4),(2502,3,633,70.3),(2503,4,633,100),(2504,1,634,152.2),(2505,2,634,109.1),(2506,3,634,53.1),(2507,4,634,100),(2508,1,635,123.8),(2509,2,635,109.1),(2510,3,635,63.6),(2511,4,635,100),(2512,1,636,140.8),(2513,2,636,111.1),(2514,3,636,63.4),(2515,4,636,100),(2516,1,637,153.4),(2517,2,637,108.3),(2518,3,637,65.4),(2519,4,637,100),(2520,1,638,168),(2521,2,638,108),(2522,3,638,54.6),(2523,4,638,100),(2524,1,639,115.4),(2525,2,639,108.3),(2526,3,639,35.4),(2527,4,639,100),(2528,1,640,120.8),(2529,2,640,108.9),(2530,3,640,35.6),(2531,4,640,100),(2532,1,641,118.6),(2533,2,641,109.1),(2534,3,641,40.2),(2535,4,641,100),(2536,1,642,114),(2537,2,642,24.9),(2538,3,642,35.5),(2539,4,642,100),(2540,1,643,116.8),(2541,2,643,108.6),(2542,3,643,47.3),(2543,4,643,100),(2544,1,644,111.4),(2545,2,644,74),(2546,3,644,39.3),(2547,4,644,100),(2548,1,645,132.2),(2549,2,645,111.1),(2550,3,645,35.2),(2551,4,645,100),(2552,1,646,136),(2553,2,646,122),(2554,3,646,26.9),(2555,4,646,100),(2556,1,647,127.8),(2557,2,647,117.7),(2558,3,647,30),(2559,4,647,100),(2560,1,648,122.2),(2561,2,648,110.3),(2562,3,648,31.3),(2563,4,648,100),(2564,1,649,107.8),(2565,2,649,105.7),(2566,3,649,27.3),(2567,4,649,100),(2568,1,650,160.8),(2569,2,650,111.1),(2570,3,650,40.3),(2571,4,650,100),(2572,1,651,133.6),(2573,2,651,110),(2574,3,651,68.1),(2575,4,651,100),(2576,1,652,109.4),(2577,2,652,64),(2578,3,652,50.4),(2579,4,652,100),(2580,1,653,136.4),(2581,2,653,118.6),(2582,3,653,60.1),(2583,4,653,100),(2584,1,654,123.8),(2585,2,654,89.4),(2586,3,654,69.3),(2587,4,654,100),(2588,1,655,126.2),(2589,2,655,116.3),(2590,3,655,71.6),(2591,4,655,100),(2592,1,656,143.4),(2593,2,656,116.3),(2594,3,656,55.8),(2595,4,656,100),(2596,1,657,126.6),(2597,2,657,116.3),(2598,3,657,78),(2599,4,657,100),(2600,1,658,146),(2601,2,658,102.3),(2602,3,658,77.6),(2603,4,658,100),(2604,1,659,123.6),(2605,2,659,70),(2606,3,659,64.1),(2607,4,659,100),(2608,1,660,118.6),(2609,2,660,59.4),(2610,3,660,67.4),(2611,4,660,100),(2612,1,661,115.6),(2613,2,661,68.9),(2614,3,661,59.4),(2615,4,661,100),(2616,1,662,123.2),(2617,2,662,108.6),(2618,3,662,64.7),(2619,4,662,100),(2620,1,663,111),(2621,2,663,81.7),(2622,3,663,72.4),(2623,4,663,100),(2624,1,664,124.2),(2625,2,664,109.1),(2626,3,664,60.2),(2627,4,664,100),(2628,1,665,129.6),(2629,2,665,108.9),(2630,3,665,51.1),(2631,4,665,100),(2632,1,666,111),(2633,2,666,6.6),(2634,3,666,59.9),(2635,4,666,100),(2636,1,667,120.4),(2637,2,667,81.7),(2638,3,667,74.7),(2639,4,667,100),(2640,1,668,128.8),(2641,2,668,108),(2642,3,668,48.4),(2643,4,668,100),(2644,1,669,124),(2645,2,669,111.1),(2646,3,669,60.3),(2647,4,669,100),(2648,1,670,125),(2649,2,670,108.9),(2650,3,670,59.5),(2651,4,670,100),(2652,1,671,32.6),(2653,2,671,10.9),(2654,3,671,23.6),(2655,4,671,100),(2656,1,672,145.6),(2657,2,672,118),(2658,3,672,69),(2659,4,672,100),(2660,1,673,138.2),(2661,2,673,117.7),(2662,3,673,59.5),(2663,4,673,100),(2664,1,674,153.8),(2665,2,674,118),(2666,3,674,73),(2667,4,674,100),(2668,1,675,146.4),(2669,2,675,118.6),(2670,3,675,61.9),(2671,4,675,100),(2672,1,676,139),(2673,2,676,118),(2674,3,676,51.1),(2675,4,676,100),(2676,1,677,127),(2677,2,677,111.1),(2678,3,677,51.6),(2679,4,677,100),(2680,1,678,128.6),(2681,2,678,112.6),(2682,3,678,56.7),(2683,4,678,100),(2684,1,679,122.6),(2685,2,679,109.1),(2686,3,679,45.4),(2687,4,679,100),(2688,1,680,126.8),(2689,2,680,109.1),(2690,3,680,50.5),(2691,4,680,100),(2692,1,681,123.4),(2693,2,681,110),(2694,3,681,118.3),(2695,4,681,100),(2696,1,682,118.6),(2697,2,682,111.4),(2698,3,682,46.8),(2699,4,682,100),(2700,1,683,130.8),(2701,2,683,0.9),(2702,3,683,26.5),(2703,4,683,100),(2704,1,684,130.4),(2705,2,684,116.6),(2706,3,684,22.7),(2707,4,684,100),(2708,1,685,130.2),(2709,2,685,116.9),(2710,3,685,20.9),(2711,4,685,100),(2712,1,686,132),(2713,2,686,116.3),(2714,3,686,35.3),(2715,4,686,100),(2716,1,687,130.2),(2717,2,687,116),(2718,3,687,66.3),(2719,4,687,100),(2720,1,688,154),(2721,2,688,120.6),(2722,3,688,60.1),(2723,4,688,100),(2724,1,689,122.2),(2725,2,689,113.7),(2726,3,689,56.4),(2727,4,689,100),(2728,1,690,171.6),(2729,2,690,127.7),(2730,3,690,64.4),(2731,4,690,100),(2732,1,691,158.6),(2733,2,691,120.9),(2734,3,691,45.5),(2735,4,691,100),(2736,1,692,142.6),(2737,2,692,111.4),(2738,3,692,62.5),(2739,4,692,100),(2740,1,693,168),(2741,2,693,118.9),(2742,3,693,64.9),(2743,4,693,100),(2744,1,694,114),(2745,2,694,10.6),(2746,3,694,46),(2747,4,694,100),(2748,1,695,167.8),(2749,2,695,129.4),(2750,3,695,68.1),(2751,4,695,100),(2752,1,696,106.8),(2753,2,696,4.9),(2754,3,696,22.2),(2755,4,696,100),(2756,1,697,125.4),(2757,2,697,100.6),(2758,3,697,39.4),(2759,4,697,100),(2760,1,698,122.6),(2761,2,698,111.1),(2762,3,698,29.5),(2763,4,698,100),(2764,1,699,125),(2765,2,699,19.7),(2766,3,699,23.4),(2767,4,699,100),(2768,1,700,139.2),(2769,2,700,108),(2770,3,700,36.5),(2771,4,700,100),(2772,1,701,128.4),(2773,2,701,109.7),(2774,3,701,60.6),(2775,4,701,100),(2776,1,702,123.8),(2777,2,702,109.4),(2778,3,702,57.4),(2779,4,702,100),(2780,1,703,131.8),(2781,2,703,113.1),(2782,3,703,65.3),(2783,4,703,100),(2784,1,704,116.8),(2785,2,704,112.6),(2786,3,704,65.7),(2787,4,704,100),(2788,1,705,114.2),(2789,2,705,110.6),(2790,3,705,101.3),(2791,4,705,100),(2792,1,706,122.6),(2793,2,706,111.4),(2794,3,706,54.3),(2795,4,706,100),(2796,1,707,116.8),(2797,2,707,110.3),(2798,3,707,52.8),(2799,4,707,100),(2800,1,708,118),(2801,2,708,109.1),(2802,3,708,70.8),(2803,4,708,100),(2804,1,709,113.8),(2805,2,709,112.3),(2806,3,709,62),(2807,4,709,100),(2808,1,710,60.2),(2809,2,710,23.4),(2810,3,710,80.5),(2811,4,710,100),(2812,1,711,108.2),(2813,2,711,56.3),(2814,3,711,56.5),(2815,4,711,100),(2816,1,712,23.4),(2817,2,712,12.3),(2818,3,712,18.5),(2819,4,712,100),(2820,1,713,29.6),(2821,2,713,0.3),(2822,3,713,32.7),(2823,4,713,100),(2824,1,714,128.8),(2825,2,714,90.6),(2826,3,714,48),(2827,4,714,100),(2828,1,715,140.2),(2829,2,715,119.1),(2830,3,715,42.8),(2831,4,715,100),(2832,1,716,132.8),(2833,2,716,122),(2834,3,716,49.5),(2835,4,716,100),(2836,1,717,129.6),(2837,2,717,117.4),(2838,3,717,50.1),(2839,4,717,100),(2840,1,718,125.2),(2841,2,718,65.7),(2842,3,718,58.6),(2843,4,718,100),(2844,1,719,129.8),(2845,2,719,116.3),(2846,3,719,69.5),(2847,4,719,100),(2848,1,720,96.8),(2849,2,720,98),(2850,3,720,51.2),(2851,4,720,100),(2852,1,721,122.4),(2853,2,721,110.9),(2854,3,721,71.1),(2855,4,721,100),(2856,1,722,107.8),(2857,2,722,13.4),(2858,3,722,49.9),(2859,4,722,100),(2860,1,723,109.6),(2861,2,723,2.3),(2862,3,723,37.8),(2863,4,723,100),(2864,1,724,113.4),(2865,2,724,11.7),(2866,3,724,53.3),(2867,4,724,100),(2868,1,725,108),(2869,2,725,2.6),(2870,3,725,54.4),(2871,4,725,100),(2872,1,726,114.2),(2873,2,726,14.9),(2874,3,726,68.7),(2875,4,726,100),(2876,1,727,115),(2877,2,727,4.6),(2878,3,727,73.4),(2879,4,727,100),(2880,1,728,111),(2881,2,728,3.7),(2882,3,728,47.7),(2883,4,728,100),(2884,1,729,106.6),(2885,2,729,8),(2886,3,729,76.8),(2887,4,729,100),(2888,1,730,107.8),(2889,2,730,13.4),(2890,3,730,49.9),(2891,4,730,100),(2892,1,731,109.6),(2893,2,731,2.3),(2894,3,731,37.8),(2895,4,731,100),(2896,1,732,105.8),(2897,2,732,3.4),(2898,3,732,61.5),(2899,4,732,100),(2900,1,733,108.8),(2901,2,733,8.9),(2902,3,733,56.3),(2903,4,733,100),(2904,1,734,129.4),(2905,2,734,116.6),(2906,3,734,55.9),(2907,4,734,100),(2908,1,735,134.6),(2909,2,735,120),(2910,3,735,37.9),(2911,4,735,100),(2912,1,736,132.6),(2913,2,736,118.9),(2914,3,736,43.4),(2915,4,736,100),(2916,1,737,130.2),(2917,2,737,117.1),(2918,3,737,45.4),(2919,4,737,100),(2920,1,738,129.8),(2921,2,738,116),(2922,3,738,44),(2923,4,738,100),(2924,1,739,113.6),(2925,2,739,117.4),(2926,3,739,35.9),(2927,4,739,100),(2928,1,740,134.6),(2929,2,740,124),(2930,3,740,48.1),(2931,4,740,100),(2932,1,741,141),(2933,2,741,120.9),(2934,3,741,47.6),(2935,4,741,100),(2936,1,742,129),(2937,2,742,116.6),(2938,3,742,41.6),(2939,4,742,100),(2940,1,743,129),(2941,2,743,116.9),(2942,3,743,47),(2943,4,743,100),(2944,1,744,123.6),(2945,2,744,116.6),(2946,3,744,46),(2947,4,744,100),(2948,1,745,136),(2949,2,745,117.4),(2950,3,745,83.7),(2951,4,745,100),(2952,1,746,135.6),(2953,2,746,116.3),(2954,3,746,48.8),(2955,4,746,100),(2956,1,747,132),(2957,2,747,117.4),(2958,3,747,46.4),(2959,4,747,100),(2960,1,748,143.6),(2961,2,748,116.9),(2962,3,748,55.6),(2963,4,748,100),(2964,1,749,120.8),(2965,2,749,116.6),(2966,3,749,76),(2967,4,749,100),(2968,1,750,110.2),(2969,2,750,110.3),(2970,3,750,61.2),(2971,4,750,100),(2972,1,751,108.4),(2973,2,751,108.6),(2974,3,751,43),(2975,4,751,100),(2976,1,752,111.2),(2977,2,752,108.9),(2978,3,752,65.8),(2979,4,752,100),(2980,1,753,110.6),(2981,2,753,110.9),(2982,3,753,51.9),(2983,4,753,100),(2984,1,754,112.2),(2985,2,754,108.3),(2986,3,754,48.8),(2987,4,754,100),(2988,1,755,105.2),(2989,2,755,0),(2990,3,755,24.2),(2991,4,755,100),(2992,1,756,105.6),(2993,2,756,0),(2994,3,756,115),(2995,4,756,100),(2996,1,757,100.8),(2997,2,757,0.6),(2998,3,757,110.2),(2999,4,757,100),(3000,1,758,111.4),(3001,2,758,0),(3002,3,758,111.5),(3003,4,758,100),(3004,1,759,99.6),(3005,2,759,0),(3006,3,759,81.8),(3007,4,759,100),(3008,1,760,108.4),(3009,2,760,51),(3010,3,760,50.4),(3011,4,760,100),(3012,1,761,110.6),(3013,2,761,0.3),(3014,3,761,118),(3015,4,761,100),(3016,1,762,117.8),(3017,2,762,0),(3018,3,762,110.7),(3019,4,762,100),(3020,1,763,117.6),(3021,2,763,113.5),(3022,3,763,49.7),(3023,4,763,100),(3024,1,764,129.2),(3025,2,764,0),(3026,3,764,112.7),(3027,4,764,100),(3028,1,765,109.4),(3029,2,765,115),(3030,3,765,33.1),(3031,4,765,100),(3032,1,766,114.6),(3033,2,766,0.3),(3034,3,766,110.6),(3035,4,766,100),(3036,1,767,104),(3037,2,767,0),(3038,3,767,45.7),(3039,4,767,100),(3040,1,768,107.8),(3041,2,768,113.5),(3042,3,768,53.9),(3043,4,768,100),(3044,1,769,114),(3045,2,769,45.1),(3046,3,769,126.2),(3047,4,769,100),(3048,1,770,123.6),(3049,2,770,0),(3050,3,770,119.4),(3051,4,770,100),(3052,1,771,117.6),(3053,2,771,0),(3054,3,771,114.8),(3055,4,771,100),(3056,1,772,122.6),(3057,2,772,0.3),(3058,3,772,113.6),(3059,4,772,100),(3060,1,773,112),(3061,2,773,93.9),(3062,3,773,55.6),(3063,4,773,100),(3064,1,774,11.6),(3065,2,774,2.6),(3066,3,774,23.3),(3067,4,774,100),(3068,1,775,88.4),(3069,2,775,19.6),(3070,3,775,51.2),(3071,4,775,100),(3072,1,776,29.2),(3073,2,776,1.3),(3074,3,776,119.4),(3075,4,776,100),(3076,1,777,124.2),(3077,2,777,0.6),(3078,3,777,103.4),(3079,4,777,100),(3080,1,778,129.2),(3081,2,778,0),(3082,3,778,95.9),(3083,4,778,100),(3084,1,779,116.6),(3085,2,779,0),(3086,3,779,103.6),(3087,4,779,100),(3088,1,780,117.6),(3089,2,780,0),(3090,3,780,77.4),(3091,4,780,100),(3092,1,781,122.2),(3093,2,781,0.3),(3094,3,781,75.8),(3095,4,781,100),(3096,1,782,108.2),(3097,2,782,0),(3098,3,782,86.3),(3099,4,782,100),(3100,1,783,78.8),(3101,2,783,13.1),(3102,3,783,123.1),(3103,4,783,100),(3104,1,784,110.4),(3105,2,784,0),(3106,3,784,115.7),(3107,4,784,100),(3108,1,785,112.6),(3109,2,785,0),(3110,3,785,111.2),(3111,4,785,100),(3112,1,786,103.8),(3113,2,786,78.8),(3114,3,786,43.5),(3115,4,786,100),(3116,1,787,118.8),(3117,2,787,0),(3118,3,787,115.3),(3119,4,787,100),(3120,1,788,113.4),(3121,2,788,109),(3122,3,788,39.5),(3123,4,788,100),(3124,1,789,106.8),(3125,2,789,23),(3126,3,789,232.2),(3127,4,789,100),(3128,1,790,121.4),(3129,2,790,0),(3130,3,790,112.7),(3131,4,790,100),(3132,1,791,120.2),(3133,2,791,0),(3134,3,791,110.9),(3135,4,791,100),(3136,1,792,104.4),(3137,2,792,36.7),(3138,3,792,11.5),(3139,4,792,100),(3140,1,793,121.2),(3141,2,793,124.4),(3142,3,793,70.4),(3143,4,793,100),(3144,1,794,39),(3145,2,794,0.3),(3146,3,794,12.1),(3147,4,794,100),(3148,1,795,139.2),(3149,2,795,0.6),(3150,3,795,59),(3151,4,795,100),(3152,1,796,43.8),(3153,2,796,0),(3154,3,796,15.8),(3155,4,796,100),(3156,1,797,126.6),(3157,2,797,0),(3158,3,797,63.9),(3159,4,797,100),(3160,1,798,121.4),(3161,2,798,0.3),(3162,3,798,31.9),(3163,4,798,100),(3164,1,799,53.6),(3165,2,799,0),(3166,3,799,111),(3167,4,799,100),(3168,1,800,0),(3169,2,800,0),(3170,3,800,0),(3171,4,800,100),(3172,1,801,57.6),(3173,2,801,1.9),(3174,3,801,150.9),(3175,4,801,100),(3176,1,802,123.2),(3177,2,802,117.6),(3178,3,802,66.2),(3179,4,802,100),(3180,1,803,125.4),(3181,2,803,117.9),(3182,3,803,100.6),(3183,4,803,100),(3184,1,804,120),(3185,2,804,117.6),(3186,3,804,66.7),(3187,4,804,100),(3188,1,805,117),(3189,2,805,117.9),(3190,3,805,66.7),(3191,4,805,100),(3192,1,806,112),(3193,2,806,2.6),(3194,3,806,114.4),(3195,4,806,100),(3196,1,807,119.8),(3197,2,807,116.4),(3198,3,807,66.7),(3199,4,807,100),(3200,1,808,125.4),(3201,2,808,118.5),(3202,3,808,110.8),(3203,4,808,100),(3204,1,809,99.6),(3205,2,809,0.3),(3206,3,809,111.1),(3207,4,809,100),(3208,1,810,127.4),(3209,2,810,117.6),(3210,3,810,59.3),(3211,4,810,100),(3212,1,811,100.8),(3213,2,811,0.6),(3214,3,811,117.4),(3215,4,811,100),(3216,1,812,130.4),(3217,2,812,0.6),(3218,3,812,111.7),(3219,4,812,100),(3220,1,813,119),(3221,2,813,0.3),(3222,3,813,114.1),(3223,4,813,100),(3224,1,814,127.2),(3225,2,814,0.6),(3226,3,814,64.3),(3227,4,814,100),(3228,1,815,86),(3229,2,815,56.9),(3230,3,815,29.6),(3231,4,815,100),(3232,1,816,87.8),(3233,2,816,0),(3234,3,816,48.7),(3235,4,816,100),(3236,1,817,16),(3237,2,817,0),(3238,3,817,0),(3239,4,817,100),(3240,1,818,114.6),(3241,2,818,0),(3242,3,818,35),(3243,4,818,100),(3244,1,819,118.2),(3245,2,819,117.9),(3246,3,819,77.8),(3247,4,819,100),(3248,1,820,115),(3249,2,820,0),(3250,3,820,43),(3251,4,820,100),(3252,1,821,115.2),(3253,2,821,0),(3254,3,821,36),(3255,4,821,100),(3256,1,822,113.6),(3257,2,822,1.8),(3258,3,822,40.3),(3259,4,822,100),(3260,1,823,110.6),(3261,2,823,117),(3262,3,823,42.8),(3263,4,823,100),(3264,1,824,108.4),(3265,2,824,15),(3266,3,824,116.7),(3267,4,824,100),(3268,1,825,104.6),(3269,2,825,119.7),(3270,3,825,26.7),(3271,4,825,100),(3272,1,826,123.6),(3273,2,826,0),(3274,3,826,117),(3275,4,826,100),(3276,1,827,132.6),(3277,2,827,0),(3278,3,827,117.2),(3279,4,827,100),(3280,1,828,123.4),(3281,2,828,109.9),(3282,3,828,101.8),(3283,4,828,100),(3284,1,829,118.8),(3285,2,829,0.3),(3286,3,829,102.1),(3287,4,829,100),(3288,1,830,136.6),(3289,2,830,0.9),(3290,3,830,112),(3291,4,830,100),(3292,1,831,116.4),(3293,2,831,0),(3294,3,831,111.9),(3295,4,831,100),(3296,1,832,47.6),(3297,2,832,6.7),(3298,3,832,136.4),(3299,4,832,100),(3300,1,833,116.2),(3301,2,833,0.6),(3302,3,833,47.2),(3303,4,833,100),(3304,1,834,108),(3305,2,834,0),(3306,3,834,51.6),(3307,4,834,100),(3308,1,835,114.8),(3309,2,835,0),(3310,3,835,37.3),(3311,4,835,100),(3312,1,836,110.2),(3313,2,836,0),(3314,3,836,45.7),(3315,4,836,100),(3316,1,837,96.2),(3317,2,837,0),(3318,3,837,45.1),(3319,4,837,100),(3320,1,838,91),(3321,2,838,103.7),(3322,3,838,51.8),(3323,4,838,100),(3324,1,839,231.2),(3325,2,839,123.2),(3326,3,839,420.6),(3327,4,839,100),(3328,1,840,104.4),(3329,2,840,115),(3330,3,840,37.8),(3331,4,840,100),(3332,1,841,39),(3333,2,841,0),(3334,3,841,10.5),(3335,4,841,100),(3336,1,842,117.8),(3337,2,842,0),(3338,3,842,110.2),(3339,4,842,100),(3340,1,843,105.8),(3341,2,843,117.3),(3342,3,843,113.8),(3343,4,843,100),(3344,1,844,119.2),(3345,2,844,0),(3346,3,844,111.3),(3347,4,844,100),(3348,1,845,103.6),(3349,2,845,108.1),(3350,3,845,115.7),(3351,4,845,100),(3352,1,846,109),(3353,2,846,111.7),(3354,3,846,113.5),(3355,4,846,100),(3356,1,847,124),(3357,2,847,0),(3358,3,847,110.7),(3359,4,847,100),(3360,1,848,113.8),(3361,2,848,0),(3362,3,848,112.8),(3363,4,848,100),(3364,1,849,103),(3365,2,849,0),(3366,3,849,112.2),(3367,4,849,100),(3368,1,850,110),(3369,2,850,0),(3370,3,850,111.4),(3371,4,850,100),(3372,1,851,106.4),(3373,2,851,0),(3374,3,851,122.4),(3375,4,851,100),(3376,1,852,101.2),(3377,2,852,5.8),(3378,3,852,113.2),(3379,4,852,100),(3380,1,853,119),(3381,2,853,0),(3382,3,853,13.2),(3383,4,853,100),(3384,1,854,115.6),(3385,2,854,0),(3386,3,854,23.3),(3387,4,854,100),(3388,1,855,101.2),(3389,2,855,0),(3390,3,855,20.1),(3391,4,855,100),(3392,1,856,126.2),(3393,2,856,0),(3394,3,856,24.8),(3395,4,856,100),(3396,1,857,100.6),(3397,2,857,0),(3398,3,857,17),(3399,4,857,100),(3400,1,858,52.2),(3401,2,858,22.8),(3402,3,858,41.3),(3403,4,858,100),(3404,1,859,104.6),(3405,2,859,39.7),(3406,3,859,40.1),(3407,4,859,100),(3408,1,860,102),(3409,2,860,0),(3410,3,860,14.8),(3411,4,860,100),(3412,1,861,105.8),(3413,2,861,0),(3414,3,861,18.6),(3415,4,861,100),(3416,1,862,103.2),(3417,2,862,29.6),(3418,3,862,39.3),(3419,4,862,100),(3420,1,863,62.8),(3421,2,863,7.7),(3422,3,863,295),(3423,4,863,100),(3424,1,864,48.8),(3425,2,864,5.1),(3426,3,864,118.6),(3427,4,864,100),(3428,1,865,128.6),(3429,2,865,0.3),(3430,3,865,44.4),(3431,4,865,100),(3432,1,866,138.4),(3433,2,866,0),(3434,3,866,53.4),(3435,4,866,100),(3436,1,867,128.2),(3437,2,867,0.3),(3438,3,867,45.4),(3439,4,867,100),(3440,1,868,90.4),(3441,2,868,119.7),(3442,3,868,53.5),(3443,4,868,100),(3444,1,869,110.4),(3445,2,869,0),(3446,3,869,29),(3447,4,869,100),(3448,1,870,126.8),(3449,2,870,0.3),(3450,3,870,36.2),(3451,4,870,100),(3452,1,871,103.4),(3453,2,871,114.1),(3454,3,871,68.3),(3455,4,871,100),(3456,1,872,104),(3457,2,872,0),(3458,3,872,40.2),(3459,4,872,100),(3460,1,873,125.4),(3461,2,873,0),(3462,3,873,41.2),(3463,4,873,100),(3464,1,874,112.8),(3465,2,874,1.6),(3466,3,874,167.4),(3467,4,874,100),(3468,1,875,106.6),(3469,2,875,119.7),(3470,3,875,72.8),(3471,4,875,100),(3472,1,876,108.6),(3473,2,876,19.6),(3474,3,876,110.3),(3475,4,876,100),(3476,1,877,108.8),(3477,2,877,108.4),(3478,3,877,102.9),(3479,4,877,100),(3480,1,878,111.4),(3481,2,878,117.3),(3482,3,878,106.2),(3483,4,878,100),(3484,1,879,105.6),(3485,2,879,0.3),(3486,3,879,109.8),(3487,4,879,100),(3488,1,880,107),(3489,2,880,0),(3490,3,880,110.1),(3491,4,880,100),(3492,1,881,109.8),(3493,2,881,0),(3494,3,881,110.4),(3495,4,881,100),(3496,1,882,216),(3497,2,882,129.9),(3498,3,882,113.5),(3499,4,882,100),(3500,1,883,119.2),(3501,2,883,0.6),(3502,3,883,72.5),(3503,4,883,100),(3504,1,884,115.8),(3505,2,884,0),(3506,3,884,73.4),(3507,4,884,100),(3508,1,885,124.2),(3509,2,885,0),(3510,3,885,61.6),(3511,4,885,100),(3512,1,886,125),(3513,2,886,0),(3514,3,886,102.3),(3515,4,886,100),(3516,1,887,108.2),(3517,2,887,20.4),(3518,3,887,71.4),(3519,4,887,100),(3520,1,888,115.6),(3521,2,888,31.7),(3522,3,888,68),(3523,4,888,100),(3524,1,889,111.2),(3525,2,889,0.6),(3526,3,889,103.5),(3527,4,889,100),(3528,1,890,126.4),(3529,2,890,0),(3530,3,890,258),(3531,4,890,100),(3532,1,891,139.4),(3533,2,891,110.6),(3534,3,891,58.5),(3535,4,891,100),(3536,1,892,141.6),(3537,2,892,109.4),(3538,3,892,34.1),(3539,4,892,100),(3540,1,893,148),(3541,2,893,114.6),(3542,3,893,37.4),(3543,4,893,100),(3544,1,894,130.6),(3545,2,894,109.4),(3546,3,894,36.2),(3547,4,894,100),(3548,1,895,142.4),(3549,2,895,109.7),(3550,3,895,48.5),(3551,4,895,100),(3552,1,896,149.4),(3553,2,896,110),(3554,3,896,32.8),(3555,4,896,100),(3556,1,897,141.2),(3557,2,897,112),(3558,3,897,43.6),(3559,4,897,100),(3560,1,898,161.2),(3561,2,898,108.3),(3562,3,898,28.3),(3563,4,898,100),(3564,1,899,144.8),(3565,2,899,109.7),(3566,3,899,44),(3567,4,899,100),(3568,1,900,132.8),(3569,2,900,116.6),(3570,3,900,39.4),(3571,4,900,100),(3572,1,901,138.4),(3573,2,901,116.3),(3574,3,901,41),(3575,4,901,100),(3576,1,902,29.2),(3577,2,902,8),(3578,3,902,24.2),(3579,4,902,100),(3580,1,903,10.4),(3581,2,903,0),(3582,3,903,9.1),(3583,4,903,100),(3584,1,904,38.6),(3585,2,904,3.1),(3586,3,904,56.7),(3587,4,904,100),(3588,1,905,125.8),(3589,2,905,126),(3590,3,905,17.8),(3591,4,905,100),(3592,1,906,110.6),(3593,2,906,120),(3594,3,906,17.4),(3595,4,906,100),(3596,1,907,112),(3597,2,907,121.1),(3598,3,907,26.7),(3599,4,907,100),(3600,1,908,133),(3601,2,908,117.7),(3602,3,908,87.1),(3603,4,908,100),(3604,1,909,120.8),(3605,2,909,111.7),(3606,3,909,112.3),(3607,4,909,100),(3608,1,910,114.8),(3609,2,910,122.9),(3610,3,910,60.2),(3611,4,910,100),(3612,1,911,119.4),(3613,2,911,125.7),(3614,3,911,111.4),(3615,4,911,100),(3616,1,912,160.6),(3617,2,912,110.6),(3618,3,912,60),(3619,4,912,100),(3620,1,913,154.6),(3621,2,913,67.1),(3622,3,913,61.5),(3623,4,913,100),(3624,1,914,150.8),(3625,2,914,92.6),(3626,3,914,58.1),(3627,4,914,100),(3628,1,915,143.8),(3629,2,915,109.4),(3630,3,915,57.4),(3631,4,915,100),(3632,1,916,153.4),(3633,2,916,113.1),(3634,3,916,85.4),(3635,4,916,100),(3636,1,917,133.6),(3637,2,917,107.7),(3638,3,917,60.8),(3639,4,917,100),(3640,1,918,125.4),(3641,2,918,109.4),(3642,3,918,68.1),(3643,4,918,100),(3644,1,919,132.8),(3645,2,919,120.6),(3646,3,919,24.9),(3647,4,919,100),(3648,1,920,124.8),(3649,2,920,116.6),(3650,3,920,23.6),(3651,4,920,100),(3652,1,921,106),(3653,2,921,128),(3654,3,921,41.3),(3655,4,921,100),(3656,1,922,120.4),(3657,2,922,121.7),(3658,3,922,38.2),(3659,4,922,100),(3660,1,923,106.2),(3661,2,923,120),(3662,3,923,36.5),(3663,4,923,100),(3664,1,924,114.8),(3665,2,924,108.9),(3666,3,924,111.4),(3667,4,924,100),(3668,1,925,118.6),(3669,2,925,111.4),(3670,3,925,114.5),(3671,4,925,100),(3672,1,926,126.6),(3673,2,926,110.6),(3674,3,926,111.8),(3675,4,926,100),(3676,1,927,131.6),(3677,2,927,108.3),(3678,3,927,113.4),(3679,4,927,100),(3680,1,928,134.6),(3681,2,928,110),(3682,3,928,30.3),(3683,4,928,100),(3684,1,929,119.6),(3685,2,929,110),(3686,3,929,110.6),(3687,4,929,100),(3688,1,930,128.6),(3689,2,930,113.4),(3690,3,930,111.2),(3691,4,930,100),(3692,1,931,173.6),(3693,2,931,118.9),(3694,3,931,106),(3695,4,931,100),(3696,1,932,121.2),(3697,2,932,110.9),(3698,3,932,109.9),(3699,4,932,100),(3700,1,933,105.8),(3701,2,933,61.1),(3702,3,933,34.9),(3703,4,933,100),(3704,1,934,91.8),(3705,2,934,44),(3706,3,934,55.4),(3707,4,934,100),(3708,1,935,110.2),(3709,2,935,109.7),(3710,3,935,43.9),(3711,4,935,100),(3712,1,936,131.4),(3713,2,936,112),(3714,3,936,111.8),(3715,4,936,100),(3716,1,937,132.2),(3717,2,937,109.7),(3718,3,937,53.9),(3719,4,937,100),(3720,1,938,123.4),(3721,2,938,106.3),(3722,3,938,105.8),(3723,4,938,100),(3724,1,939,114.2),(3725,2,939,108.9),(3726,3,939,97.8),(3727,4,939,100),(3728,1,940,134.8),(3729,2,940,120.3),(3730,3,940,66.2),(3731,4,940,100),(3732,1,941,120.8),(3733,2,941,121.4),(3734,3,941,40.9),(3735,4,941,100),(3736,1,942,117),(3737,2,942,121.4),(3738,3,942,122.7),(3739,4,942,100),(3740,1,943,117.8),(3741,2,943,116.6),(3742,3,943,41.5),(3743,4,943,100),(3744,1,944,118.4),(3745,2,944,119.1),(3746,3,944,111.2),(3747,4,944,100),(3748,1,945,118.6),(3749,2,945,119.1),(3750,3,945,112.5),(3751,4,945,100),(3752,1,946,137),(3753,2,946,117.7),(3754,3,946,14.1),(3755,4,946,100),(3756,1,947,149.4),(3757,2,947,111.4),(3758,3,947,59.3),(3759,4,947,100),(3760,1,948,107),(3761,2,948,0.3),(3762,3,948,59.8),(3763,4,948,100),(3764,1,949,133.8),(3765,2,949,110.6),(3766,3,949,52.1),(3767,4,949,100),(3768,1,950,134.8),(3769,2,950,120.3),(3770,3,950,64.3),(3771,4,950,100),(3772,1,951,147.2),(3773,2,951,116),(3774,3,951,53.9),(3775,4,951,100),(3776,1,952,132.6),(3777,2,952,117.4),(3778,3,952,56.6),(3779,4,952,100),(3780,1,953,137.4),(3781,2,953,117.4),(3782,3,953,70.3),(3783,4,953,100),(3784,1,954,133.8),(3785,2,954,108.6),(3786,3,954,62.1),(3787,4,954,100),(3788,1,955,135.6),(3789,2,955,111.7),(3790,3,955,60.1),(3791,4,955,100),(3792,1,956,139.6),(3793,2,956,119.4),(3794,3,956,79.3),(3795,4,956,100),(3796,1,957,143.8),(3797,2,957,111.7),(3798,3,957,97.8),(3799,4,957,100),(3800,1,958,129),(3801,2,958,118.6),(3802,3,958,105.3),(3803,4,958,100),(3804,1,959,165.6),(3805,2,959,111.1),(3806,3,959,102.2),(3807,4,959,100),(3808,1,960,168.6),(3809,2,960,109.7),(3810,3,960,92.4),(3811,4,960,100),(3812,1,961,150.2),(3813,2,961,112),(3814,3,961,55.6),(3815,4,961,100),(3816,1,962,147.4),(3817,2,962,114),(3818,3,962,100.1),(3819,4,962,100),(3820,1,963,137.8),(3821,2,963,112),(3822,3,963,61.9),(3823,4,963,100),(3824,1,964,129.4),(3825,2,964,109.4),(3826,3,964,52.4),(3827,4,964,100),(3828,1,965,128.2),(3829,2,965,77.7),(3830,3,965,101.6),(3831,4,965,100),(3832,1,966,131.6),(3833,2,966,115.4),(3834,3,966,52.9),(3835,4,966,100),(3836,1,967,117.8),(3837,2,967,137.7),(3838,3,967,48.4),(3839,4,967,100),(3840,1,968,118.2),(3841,2,968,129.1),(3842,3,968,110.7),(3843,4,968,100),(3844,1,969,120.4),(3845,2,969,111.1),(3846,3,969,48.9),(3847,4,969,100),(3848,1,970,125.4),(3849,2,970,109.1),(3850,3,970,52.8),(3851,4,970,100),(3852,1,971,131),(3853,2,971,108.9),(3854,3,971,58.5),(3855,4,971,100),(3856,1,972,124.6),(3857,2,972,110),(3858,3,972,91.7),(3859,4,972,100),(3860,1,973,127),(3861,2,973,112.9),(3862,3,973,47.2),(3863,4,973,100),(3864,1,974,129.8),(3865,2,974,110),(3866,3,974,51.5),(3867,4,974,100),(3868,1,975,130.2),(3869,2,975,111.1),(3870,3,975,58.3),(3871,4,975,100),(3872,1,976,124),(3873,2,976,109.4),(3874,3,976,50.8),(3875,4,976,100),(3876,1,977,128.2),(3877,2,977,108.6),(3878,3,977,46),(3879,4,977,100),(3880,1,978,130.8),(3881,2,978,110.3),(3882,3,978,56.4),(3883,4,978,100),(3884,1,979,143.4),(3885,2,979,120.9),(3886,3,979,110.5),(3887,4,979,100),(3888,1,980,84.4),(3889,2,980,30.3),(3890,3,980,72.3),(3891,4,980,100),(3892,1,981,82.4),(3893,2,981,22),(3894,3,981,30.5),(3895,4,981,100),(3896,1,982,147),(3897,2,982,122.6),(3898,3,982,69.5),(3899,4,982,100),(3900,1,983,71),(3901,2,983,32.3),(3902,3,983,87.9),(3903,4,983,100),(3904,1,984,124),(3905,2,984,123.7),(3906,3,984,101.6),(3907,4,984,100),(3908,1,985,86.8),(3909,2,985,31.7),(3910,3,985,60),(3911,4,985,100),(3912,1,986,98.8),(3913,2,986,81.7),(3914,3,986,47.3),(3915,4,986,100),(3916,1,987,109.4),(3917,2,987,71.4),(3918,3,987,60.8),(3919,4,987,100),(3920,1,988,144.4),(3921,2,988,112.9),(3922,3,988,103.9),(3923,4,988,100),(3924,1,989,109.6),(3925,2,989,116.3),(3926,3,989,36.3),(3927,4,989,100),(3928,1,990,89.2),(3929,2,990,112.6),(3930,3,990,102.3),(3931,4,990,100),(3932,1,991,121.6),(3933,2,991,111.4),(3934,3,991,59.9),(3935,4,991,100),(3936,1,992,113.4),(3937,2,992,114.3),(3938,3,992,38.4),(3939,4,992,100),(3940,1,993,124.2),(3941,2,993,119.4),(3942,3,993,75.6),(3943,4,993,100),(3944,1,994,157.6),(3945,2,994,118.3),(3946,3,994,110.5),(3947,4,994,100),(3948,1,995,139.4),(3949,2,995,116.3),(3950,3,995,112.9),(3951,4,995,100),(3952,1,996,151.6),(3953,2,996,119.7),(3954,3,996,62.3),(3955,4,996,100),(3956,1,997,127),(3957,2,997,118),(3958,3,997,110.2),(3959,4,997,100),(3960,1,998,111.2),(3961,2,998,46),(3962,3,998,61.7),(3963,4,998,100),(3964,1,999,112),(3965,2,999,72.9),(3966,3,999,51.9),(3967,4,999,100),(3968,1,1000,108.6),(3969,2,1000,64.9),(3970,3,1000,56.9),(3971,4,1000,100),(3972,1,1001,91),(3973,2,1001,50.9),(3974,3,1001,48.8),(3975,4,1001,100),(3976,1,1002,84.4),(3977,2,1002,12.6),(3978,3,1002,44.1),(3979,4,1002,100),(3980,1,1003,126.8),(3981,2,1003,43.1),(3982,3,1003,61),(3983,4,1003,100),(3984,1,1004,112.8),(3985,2,1004,39.1),(3986,3,1004,75.6),(3987,4,1004,100),(3988,1,1005,81.2),(3989,2,1005,7.7),(3990,3,1005,29.3),(3991,4,1005,100),(3992,1,1006,102.8),(3993,2,1006,21.4),(3994,3,1006,48.3),(3995,4,1006,100),(3996,1,1007,109.2),(3997,2,1007,26.6),(3998,3,1007,102.8),(3999,4,1007,100),(4000,1,1008,68),(4001,2,1008,6.6),(4002,3,1008,73.2),(4003,4,1008,100),(4004,1,1009,108.6),(4005,2,1009,7.1),(4006,3,1009,65.6),(4007,4,1009,100),(4008,1,1010,114.4),(4009,2,1010,112.6),(4010,3,1010,109.7),(4011,4,1010,100),(4012,1,1011,116),(4013,2,1011,131.7),(4014,3,1011,30.4),(4015,4,1011,100),(4016,1,1012,109.4),(4017,2,1012,115.7),(4018,3,1012,22.5),(4019,4,1012,100),(4020,1,1013,137),(4021,2,1013,117.4),(4022,3,1013,75.3),(4023,4,1013,100),(4024,1,1014,119.4),(4025,2,1014,116.9),(4026,3,1014,40),(4027,4,1014,100),(4028,1,1015,131.6),(4029,2,1015,117.4),(4030,3,1015,78),(4031,4,1015,100),(4032,1,1016,135.6),(4033,2,1016,116.3),(4034,3,1016,40.9),(4035,4,1016,100),(4036,1,1017,109.8),(4037,2,1017,117.1),(4038,3,1017,65),(4039,4,1017,100),(4040,1,1018,122),(4041,2,1018,118.9),(4042,3,1018,75),(4043,4,1018,100),(4044,1,1019,117.2),(4045,2,1019,120),(4046,3,1019,61.5),(4047,4,1019,100),(4048,1,1020,113),(4049,2,1020,117.7),(4050,3,1020,63.3),(4051,4,1020,100),(4052,1,1021,114.8),(4053,2,1021,108.3),(4054,3,1021,107.9),(4055,4,1021,100),(4056,1,1022,122.2),(4057,2,1022,116),(4058,3,1022,69.5),(4059,4,1022,100),(4060,1,1023,112.4),(4061,2,1023,108),(4062,3,1023,109.3),(4063,4,1023,100),(4064,1,1024,129.6),(4065,2,1024,111.1),(4066,3,1024,57.7),(4067,4,1024,100),(4068,1,1025,81.8),(4069,2,1025,63.4),(4070,3,1025,36),(4071,4,1025,100),(4072,1,1026,126),(4073,2,1026,80.3),(4074,3,1026,40.9),(4075,4,1026,100),(4076,1,1027,119.6),(4077,2,1027,111.4),(4078,3,1027,110),(4079,4,1027,100),(4080,1,1028,133.8),(4081,2,1028,108.3),(4082,3,1028,111.1),(4083,4,1028,100),(4084,1,1029,131.2),(4085,2,1029,108.6),(4086,3,1029,27.7),(4087,4,1029,100),(4088,1,1030,134.4),(4089,2,1030,108.9),(4090,3,1030,18.4),(4091,4,1030,100),(4092,1,1031,134),(4093,2,1031,109.4),(4094,3,1031,119.1),(4095,4,1031,100),(4096,1,1032,140.6),(4097,2,1032,108.9),(4098,3,1032,66.2),(4099,4,1032,100),(4100,1,1033,127.6),(4101,2,1033,109.1),(4102,3,1033,79.7),(4103,4,1033,100),(4104,1,1034,133.6),(4105,2,1034,110),(4106,3,1034,120.1),(4107,4,1034,100),(4108,1,1035,134.2),(4109,2,1035,110),(4110,3,1035,113.5),(4111,4,1035,100),(4112,1,1036,131.2),(4113,2,1036,109.1),(4114,3,1036,15.5),(4115,4,1036,100),(4116,1,1037,113.4),(4117,2,1037,56),(4118,3,1037,43.7),(4119,4,1037,100),(4120,1,1038,166.2),(4121,2,1038,110.6),(4122,3,1038,81.4),(4123,4,1038,100),(4124,1,1039,135.6),(4125,2,1039,108),(4126,3,1039,55.9),(4127,4,1039,100),(4128,1,1040,112.8),(4129,2,1040,52.9),(4130,3,1040,54.8),(4131,4,1040,100),(4132,1,1041,130.4),(4133,2,1041,62.9),(4134,3,1041,46.9),(4135,4,1041,100),(4136,1,1042,96.8),(4137,2,1042,46.9),(4138,3,1042,112),(4139,4,1042,100),(4140,1,1043,97.2),(4141,2,1043,51.4),(4142,3,1043,83.9),(4143,4,1043,100),(4144,1,1044,137.2),(4145,2,1044,105.1),(4146,3,1044,65),(4147,4,1044,100),(4148,1,1045,174.2),(4149,2,1045,111.7),(4150,3,1045,115.4),(4151,4,1045,100),(4152,1,1046,126.8),(4153,2,1046,112),(4154,3,1046,123.6),(4155,4,1046,100),(4156,1,1047,123.6),(4157,2,1047,113.7),(4158,3,1047,121.5),(4159,4,1047,100),(4160,1,1048,125),(4161,2,1048,109.4),(4162,3,1048,20.6),(4163,4,1048,100),(4164,1,1049,118.8),(4165,2,1049,111.4),(4166,3,1049,123.2),(4167,4,1049,100),(4168,1,1050,132.6),(4169,2,1050,113.4),(4170,3,1050,36.1),(4171,4,1050,100),(4172,1,1051,130.4),(4173,2,1051,111.4),(4174,3,1051,139.5),(4175,4,1051,100),(4176,1,1052,159),(4177,2,1052,124.6),(4178,3,1052,137.1),(4179,4,1052,100),(4180,1,1053,151),(4181,2,1053,110.3),(4182,3,1053,44.1),(4183,4,1053,100),(4184,1,1054,146.4),(4185,2,1054,112),(4186,3,1054,52.2),(4187,4,1054,100),(4188,1,1055,130.6),(4189,2,1055,108.6),(4190,3,1055,24.2),(4191,4,1055,100),(4192,1,1056,135.2),(4193,2,1056,109.4),(4194,3,1056,128.7),(4195,4,1056,100),(4196,1,1057,127),(4197,2,1057,51.9),(4198,3,1057,83.3),(4199,4,1057,100),(4200,1,1058,115.8),(4201,2,1058,88.9),(4202,3,1058,115.5),(4203,4,1058,100),(4204,1,1059,106),(4205,2,1059,111.1),(4206,3,1059,84.3),(4207,4,1059,100),(4208,1,1060,107.4),(4209,2,1060,96.3),(4210,3,1060,43.1),(4211,4,1060,100),(4212,1,1061,120.6),(4213,2,1061,88.9),(4214,3,1061,88.3),(4215,4,1061,100),(4216,1,1062,105),(4217,2,1062,66.7),(4218,3,1062,94.3),(4219,4,1062,100),(4220,1,1063,106.4),(4221,2,1063,59.3),(4222,3,1063,59.4),(4223,4,1063,100),(4224,1,1064,101.6),(4225,2,1064,3.2),(4226,3,1064,218.5),(4227,4,1064,100),(4228,1,1065,127),(4229,2,1065,159.4),(4230,3,1065,110.9),(4231,4,1065,100),(4232,1,1066,115.8),(4233,2,1066,178.4),(4234,3,1066,115.5),(4235,4,1066,100),(4236,1,1067,106),(4237,2,1067,145.2),(4238,3,1067,124.8),(4239,4,1067,100),(4240,1,1068,107.4),(4241,2,1068,133),(4242,3,1068,102.2),(4243,4,1068,100),(4244,1,1069,120.6),(4245,2,1069,113.2),(4246,3,1069,110),(4247,4,1069,100),(4248,1,1070,105),(4249,2,1070,114.4),(4250,3,1070,110.5),(4251,4,1070,100),(4252,1,1071,106.4),(4253,2,1071,125.3),(4254,3,1071,114.7),(4255,4,1071,100),(4256,1,1072,101.6),(4257,2,1072,3.2),(4258,3,1072,218.5),(4259,4,1072,100),(4260,1,1073,127),(4261,2,1073,159.4),(4262,3,1073,110.9),(4263,4,1073,100),(4264,1,1074,115.8),(4265,2,1074,178.4),(4266,3,1074,115.5),(4267,4,1074,100),(4268,1,1075,106),(4269,2,1075,145.2),(4270,3,1075,124.8),(4271,4,1075,100),(4272,1,1076,107.4),(4273,2,1076,133),(4274,3,1076,102.2),(4275,4,1076,100),(4276,1,1077,120.6),(4277,2,1077,113.2),(4278,3,1077,110),(4279,4,1077,100),(4280,1,1078,105),(4281,2,1078,114.4),(4282,3,1078,110.5),(4283,4,1078,100),(4284,1,1079,106.4),(4285,2,1079,125.3),(4286,3,1079,114.7),(4287,4,1079,100),(4288,1,1080,101.6),(4289,2,1080,3.2),(4290,3,1080,218.5),(4291,4,1080,100),(4292,1,1081,127),(4293,2,1081,159.4),(4294,3,1081,110.9),(4295,4,1081,100),(4296,1,1082,115.8),(4297,2,1082,178.4),(4298,3,1082,115.5),(4299,4,1082,100),(4300,1,1083,106),(4301,2,1083,145.2),(4302,3,1083,124.8),(4303,4,1083,100),(4304,1,1084,107.4),(4305,2,1084,133),(4306,3,1084,102.2),(4307,4,1084,100),(4308,1,1085,120.6),(4309,2,1085,113.2),(4310,3,1085,110),(4311,4,1085,100),(4312,1,1086,105),(4313,2,1086,114.4),(4314,3,1086,110.5),(4315,4,1086,100),(4316,1,1087,106.4),(4317,2,1087,125.3),(4318,3,1087,114.7),(4319,4,1087,100),(4320,1,1088,101.6),(4321,2,1088,3.2),(4322,3,1088,218.5),(4323,4,1088,100),(4324,1,1089,127),(4325,2,1089,159.4),(4326,3,1089,110.9),(4327,4,1089,100),(4328,1,1090,115.8),(4329,2,1090,178.4),(4330,3,1090,115.5),(4331,4,1090,100),(4332,1,1091,106),(4333,2,1091,145.2),(4334,3,1091,124.8),(4335,4,1091,100),(4336,1,1092,107.4),(4337,2,1092,133),(4338,3,1092,102.2),(4339,4,1092,100),(4340,1,1093,120.6),(4341,2,1093,113.2),(4342,3,1093,110),(4343,4,1093,100),(4344,1,1094,105),(4345,2,1094,114.4),(4346,3,1094,110.5),(4347,4,1094,100),(4348,1,1095,106.4),(4349,2,1095,125.3),(4350,3,1095,114.7),(4351,4,1095,100),(4352,1,1096,101.6),(4353,2,1096,3.2),(4354,3,1096,218.5),(4355,4,1096,100),(4356,1,1097,127),(4357,2,1097,159.4),(4358,3,1097,110.9),(4359,4,1097,100),(4360,1,1098,115.8),(4361,2,1098,178.4),(4362,3,1098,115.5),(4363,4,1098,100),(4364,1,1099,106),(4365,2,1099,145.2),(4366,3,1099,124.8),(4367,4,1099,100),(4368,1,1100,107.4),(4369,2,1100,133),(4370,3,1100,102.2),(4371,4,1100,100),(4372,1,1101,120.6),(4373,2,1101,113.2),(4374,3,1101,110),(4375,4,1101,100),(4376,1,1102,105),(4377,2,1102,114.4),(4378,3,1102,110.5),(4379,4,1102,100),(4380,1,1103,106.4),(4381,2,1103,125.3),(4382,3,1103,114.7),(4383,4,1103,100),(4384,1,1104,101.6),(4385,2,1104,3.2),(4386,3,1104,218.5),(4387,4,1104,100),(4388,1,1105,127),(4389,2,1105,159.4),(4390,3,1105,110.9),(4391,4,1105,100),(4392,1,1106,115.8),(4393,2,1106,178.4),(4394,3,1106,115.5),(4395,4,1106,100),(4396,1,1107,106),(4397,2,1107,145.2),(4398,3,1107,124.8),(4399,4,1107,100),(4400,1,1108,107.4),(4401,2,1108,133),(4402,3,1108,102.2),(4403,4,1108,100),(4404,1,1109,120.6),(4405,2,1109,113.2),(4406,3,1109,110),(4407,4,1109,100),(4408,1,1110,105),(4409,2,1110,114.4),(4410,3,1110,110.5),(4411,4,1110,100),(4412,1,1111,106.4),(4413,2,1111,125.3),(4414,3,1111,114.7),(4415,4,1111,100),(4416,1,1112,101.6),(4417,2,1112,3.2),(4418,3,1112,218.5),(4419,4,1112,100),(4420,1,1113,127),(4421,2,1113,159.4),(4422,3,1113,110.9),(4423,4,1113,100),(4424,1,1114,115.8),(4425,2,1114,178.4),(4426,3,1114,115.5),(4427,4,1114,100),(4428,1,1115,106),(4429,2,1115,145.2),(4430,3,1115,124.8),(4431,4,1115,100),(4432,1,1116,107.4),(4433,2,1116,133),(4434,3,1116,102.2),(4435,4,1116,100),(4436,1,1117,120.6),(4437,2,1117,113.2),(4438,3,1117,110),(4439,4,1117,100),(4440,1,1118,105),(4441,2,1118,114.4),(4442,3,1118,110.5),(4443,4,1118,100),(4444,1,1119,106.4),(4445,2,1119,125.3),(4446,3,1119,114.7),(4447,4,1119,100),(4448,1,1120,101.6),(4449,2,1120,3.2),(4450,3,1120,218.5),(4451,4,1120,100),(4452,1,1121,127),(4453,2,1121,159.4),(4454,3,1121,110.9),(4455,4,1121,100),(4456,1,1122,115.8),(4457,2,1122,178.4),(4458,3,1122,115.5),(4459,4,1122,100),(4460,1,1123,106),(4461,2,1123,145.2),(4462,3,1123,124.8),(4463,4,1123,100),(4464,1,1124,107.4),(4465,2,1124,133),(4466,3,1124,102.2),(4467,4,1124,100),(4468,1,1125,120.6),(4469,2,1125,113.2),(4470,3,1125,110),(4471,4,1125,100),(4472,1,1126,105),(4473,2,1126,114.4),(4474,3,1126,110.5),(4475,4,1126,100),(4476,1,1127,106.4),(4477,2,1127,125.3),(4478,3,1127,114.7),(4479,4,1127,100),(4480,1,1128,101.6),(4481,2,1128,3.2),(4482,3,1128,218.5),(4483,4,1128,100),(4484,1,1129,127),(4485,2,1129,159.4),(4486,3,1129,110.9),(4487,4,1129,100),(4488,1,1130,115.8),(4489,2,1130,178.4),(4490,3,1130,115.5),(4491,4,1130,100),(4492,1,1131,106),(4493,2,1131,145.2),(4494,3,1131,124.8),(4495,4,1131,100),(4496,1,1132,107.4),(4497,2,1132,133),(4498,3,1132,102.2),(4499,4,1132,100),(4500,1,1133,120.6),(4501,2,1133,113.2),(4502,3,1133,110),(4503,4,1133,100),(4504,1,1134,105),(4505,2,1134,114.4),(4506,3,1134,110.5),(4507,4,1134,100),(4508,1,1135,106.4),(4509,2,1135,125.3),(4510,3,1135,114.7),(4511,4,1135,100),(4512,1,1136,101.6),(4513,2,1136,3.2),(4514,3,1136,218.5),(4515,4,1136,100),(4516,1,1137,127),(4517,2,1137,159.4),(4518,3,1137,110.9),(4519,4,1137,100),(4520,1,1138,115.8),(4521,2,1138,178.4),(4522,3,1138,115.5),(4523,4,1138,100),(4524,1,1139,106),(4525,2,1139,145.2),(4526,3,1139,124.8),(4527,4,1139,100),(4528,1,1140,107.4),(4529,2,1140,133),(4530,3,1140,102.2),(4531,4,1140,100),(4532,1,1141,120.6),(4533,2,1141,113.2),(4534,3,1141,110),(4535,4,1141,100),(4536,1,1142,105),(4537,2,1142,114.4),(4538,3,1142,110.5),(4539,4,1142,100),(4540,1,1143,106.4),(4541,2,1143,125.3),(4542,3,1143,114.7),(4543,4,1143,100),(4544,1,1144,101.6),(4545,2,1144,3.2),(4546,3,1144,218.5),(4547,4,1144,100),(4548,1,1145,127),(4549,2,1145,159.4),(4550,3,1145,110.9),(4551,4,1145,100),(4552,1,1146,115.8),(4553,2,1146,178.4),(4554,3,1146,115.5),(4555,4,1146,100),(4556,1,1147,106),(4557,2,1147,145.2),(4558,3,1147,124.8),(4559,4,1147,100),(4560,1,1148,107.4),(4561,2,1148,133),(4562,3,1148,102.2),(4563,4,1148,100),(4564,1,1149,120.6),(4565,2,1149,113.2),(4566,3,1149,110),(4567,4,1149,100),(4568,1,1150,105),(4569,2,1150,114.4),(4570,3,1150,110.5),(4571,4,1150,100),(4572,1,1151,106.4),(4573,2,1151,125.3),(4574,3,1151,114.7),(4575,4,1151,100),(4576,1,1152,101.6),(4577,2,1152,3.2),(4578,3,1152,218.5),(4579,4,1152,100),(4580,1,1153,127),(4581,2,1153,159.4),(4582,3,1153,110.9),(4583,4,1153,100),(4584,1,1154,115.8),(4585,2,1154,178.4),(4586,3,1154,115.5),(4587,4,1154,100),(4588,1,1155,106),(4589,2,1155,145.2),(4590,3,1155,124.8),(4591,4,1155,100),(4592,1,1156,107.4),(4593,2,1156,133),(4594,3,1156,102.2),(4595,4,1156,100),(4596,1,1157,120.6),(4597,2,1157,113.2),(4598,3,1157,110),(4599,4,1157,100),(4600,1,1158,105),(4601,2,1158,114.4),(4602,3,1158,110.5),(4603,4,1158,100),(4604,1,1159,106.4),(4605,2,1159,125.3),(4606,3,1159,114.7),(4607,4,1159,100),(4608,1,1160,101.6),(4609,2,1160,3.2),(4610,3,1160,218.5),(4611,4,1160,100),(4612,1,1161,127),(4613,2,1161,159.4),(4614,3,1161,110.9),(4615,4,1161,100),(4616,1,1162,115.8),(4617,2,1162,178.4),(4618,3,1162,115.5),(4619,4,1162,100),(4620,1,1163,106),(4621,2,1163,145.2),(4622,3,1163,124.8),(4623,4,1163,100),(4624,1,1164,107.4),(4625,2,1164,133),(4626,3,1164,102.2),(4627,4,1164,100),(4628,1,1165,120.6),(4629,2,1165,113.2),(4630,3,1165,110),(4631,4,1165,100),(4632,1,1166,105),(4633,2,1166,114.4),(4634,3,1166,110.5),(4635,4,1166,100),(4636,1,1167,106.4),(4637,2,1167,125.3),(4638,3,1167,114.7),(4639,4,1167,100),(4640,1,1168,101.6),(4641,2,1168,3.2),(4642,3,1168,218.5),(4643,4,1168,100),(4644,1,1169,127),(4645,2,1169,159.4),(4646,3,1169,110.9),(4647,4,1169,100),(4648,1,1170,115.8),(4649,2,1170,178.4),(4650,3,1170,115.5),(4651,4,1170,100),(4652,1,1171,106),(4653,2,1171,145.2),(4654,3,1171,124.8),(4655,4,1171,100),(4656,1,1172,107.4),(4657,2,1172,133),(4658,3,1172,102.2),(4659,4,1172,100),(4660,1,1173,120.6),(4661,2,1173,113.2),(4662,3,1173,110),(4663,4,1173,100),(4664,1,1174,105),(4665,2,1174,114.4),(4666,3,1174,110.5),(4667,4,1174,100),(4668,1,1175,106.4),(4669,2,1175,125.3),(4670,3,1175,114.7),(4671,4,1175,100),(4672,1,1176,101.6),(4673,2,1176,3.2),(4674,3,1176,218.5),(4675,4,1176,100),(4676,1,1177,127),(4677,2,1177,159.4),(4678,3,1177,110.9),(4679,4,1177,100),(4680,1,1178,115.8),(4681,2,1178,178.4),(4682,3,1178,115.5),(4683,4,1178,100),(4684,1,1179,106),(4685,2,1179,145.2),(4686,3,1179,124.8),(4687,4,1179,100),(4688,1,1180,107.4),(4689,2,1180,133),(4690,3,1180,102.2),(4691,4,1180,100),(4692,1,1181,120.6),(4693,2,1181,113.2),(4694,3,1181,110),(4695,4,1181,100),(4696,1,1182,105),(4697,2,1182,114.4),(4698,3,1182,110.5),(4699,4,1182,100),(4700,1,1183,106.4),(4701,2,1183,125.3),(4702,3,1183,114.7),(4703,4,1183,100),(4704,1,1184,101.6),(4705,2,1184,3.2),(4706,3,1184,218.5),(4707,4,1184,100),(4708,1,1185,127),(4709,2,1185,159.4),(4710,3,1185,110.9),(4711,4,1185,100),(4712,1,1186,115.8),(4713,2,1186,178.4),(4714,3,1186,115.5),(4715,4,1186,100),(4716,1,1187,106),(4717,2,1187,145.2),(4718,3,1187,124.8),(4719,4,1187,100),(4720,1,1188,107.4),(4721,2,1188,133),(4722,3,1188,102.2),(4723,4,1188,100),(4724,1,1189,120.6),(4725,2,1189,113.2),(4726,3,1189,110),(4727,4,1189,100),(4728,1,1190,105),(4729,2,1190,114.4),(4730,3,1190,110.5),(4731,4,1190,100),(4732,1,1191,106.4),(4733,2,1191,125.3),(4734,3,1191,114.7),(4735,4,1191,100),(4736,1,1192,101.6),(4737,2,1192,3.2),(4738,3,1192,218.5),(4739,4,1192,100),(4740,1,1193,127),(4741,2,1193,159.4),(4742,3,1193,110.9),(4743,4,1193,100),(4744,1,1194,115.8),(4745,2,1194,178.4),(4746,3,1194,115.5),(4747,4,1194,100),(4748,1,1195,106),(4749,2,1195,145.2),(4750,3,1195,124.8),(4751,4,1195,100),(4752,1,1196,107.4),(4753,2,1196,133),(4754,3,1196,102.2),(4755,4,1196,100),(4756,1,1197,120.6),(4757,2,1197,113.2),(4758,3,1197,110),(4759,4,1197,100),(4760,1,1198,105),(4761,2,1198,114.4),(4762,3,1198,110.5),(4763,4,1198,100),(4764,1,1199,106.4),(4765,2,1199,125.3),(4766,3,1199,114.7),(4767,4,1199,100),(4768,1,1200,101.6),(4769,2,1200,3.2),(4770,3,1200,218.5),(4771,4,1200,100),(4772,1,1201,127),(4773,2,1201,159.4),(4774,3,1201,110.9),(4775,4,1201,100),(4776,1,1202,115.8),(4777,2,1202,178.4),(4778,3,1202,115.5),(4779,4,1202,100),(4780,1,1203,106),(4781,2,1203,145.2),(4782,3,1203,124.8),(4783,4,1203,100),(4784,1,1204,107.4),(4785,2,1204,133),(4786,3,1204,102.2),(4787,4,1204,100),(4788,1,1205,120.6),(4789,2,1205,113.2),(4790,3,1205,110),(4791,4,1205,100),(4792,1,1206,105),(4793,2,1206,114.4),(4794,3,1206,110.5),(4795,4,1206,100),(4796,1,1207,106.4),(4797,2,1207,125.3),(4798,3,1207,114.7),(4799,4,1207,100),(4800,1,1208,101.6),(4801,2,1208,3.2),(4802,3,1208,218.5),(4803,4,1208,100),(4804,1,1209,127),(4805,2,1209,159.4),(4806,3,1209,110.9),(4807,4,1209,100),(4808,1,1210,115.8),(4809,2,1210,178.4),(4810,3,1210,115.5),(4811,4,1210,100),(4812,1,1211,106),(4813,2,1211,145.2),(4814,3,1211,124.8),(4815,4,1211,100),(4816,1,1212,107.4),(4817,2,1212,133),(4818,3,1212,102.2),(4819,4,1212,100),(4820,1,1213,120.6),(4821,2,1213,113.2),(4822,3,1213,110),(4823,4,1213,100),(4824,1,1214,105),(4825,2,1214,114.4),(4826,3,1214,110.5),(4827,4,1214,100),(4828,1,1215,106.4),(4829,2,1215,125.3),(4830,3,1215,114.7),(4831,4,1215,100),(4832,1,1216,101.6),(4833,2,1216,3.2),(4834,3,1216,218.5),(4835,4,1216,100),(4836,1,1217,127),(4837,2,1217,159.4),(4838,3,1217,110.9),(4839,4,1217,100),(4840,1,1218,115.8),(4841,2,1218,178.4),(4842,3,1218,115.5),(4843,4,1218,100),(4844,1,1219,106),(4845,2,1219,145.2),(4846,3,1219,124.8),(4847,4,1219,100),(4848,1,1220,107.4),(4849,2,1220,133),(4850,3,1220,102.2),(4851,4,1220,100),(4852,1,1221,120.6),(4853,2,1221,113.2),(4854,3,1221,110),(4855,4,1221,100),(4856,1,1222,105),(4857,2,1222,114.4),(4858,3,1222,110.5),(4859,4,1222,100),(4860,1,1223,106.4),(4861,2,1223,125.3),(4862,3,1223,114.7),(4863,4,1223,100),(4864,1,1224,101.6),(4865,2,1224,3.2),(4866,3,1224,218.5),(4867,4,1224,100),(4868,1,1225,127),(4869,2,1225,159.4),(4870,3,1225,110.9),(4871,4,1225,100),(4872,1,1226,115.8),(4873,2,1226,178.4),(4874,3,1226,115.5),(4875,4,1226,100),(4876,1,1227,106),(4877,2,1227,145.2),(4878,3,1227,124.8),(4879,4,1227,100),(4880,1,1228,107.4),(4881,2,1228,133),(4882,3,1228,102.2),(4883,4,1228,100),(4884,1,1229,120.6),(4885,2,1229,113.2),(4886,3,1229,110),(4887,4,1229,100),(4888,1,1230,105),(4889,2,1230,114.4),(4890,3,1230,110.5),(4891,4,1230,100),(4892,1,1231,106.4),(4893,2,1231,125.3),(4894,3,1231,114.7),(4895,4,1231,100),(4896,1,1232,101.6),(4897,2,1232,3.2),(4898,3,1232,218.5),(4899,4,1232,100),(4900,1,1233,127),(4901,2,1233,159.4),(4902,3,1233,110.9),(4903,4,1233,100),(4904,1,1234,115.8),(4905,2,1234,178.4),(4906,3,1234,115.5),(4907,4,1234,100),(4908,1,1235,106),(4909,2,1235,145.2),(4910,3,1235,124.8),(4911,4,1235,100),(4912,1,1236,107.4),(4913,2,1236,133),(4914,3,1236,102.2),(4915,4,1236,100),(4916,1,1237,120.6),(4917,2,1237,113.2),(4918,3,1237,110),(4919,4,1237,100),(4920,1,1238,105),(4921,2,1238,114.4),(4922,3,1238,110.5),(4923,4,1238,100),(4924,1,1239,106.4),(4925,2,1239,125.3),(4926,3,1239,114.7),(4927,4,1239,100),(4928,1,1240,101.6),(4929,2,1240,3.2),(4930,3,1240,218.5),(4931,4,1240,100),(4932,1,1241,127),(4933,2,1241,159.4),(4934,3,1241,110.9),(4935,4,1241,100),(4936,1,1242,115.8),(4937,2,1242,178.4),(4938,3,1242,115.5),(4939,4,1242,100),(4940,1,1243,106),(4941,2,1243,145.2),(4942,3,1243,124.8),(4943,4,1243,100),(4944,1,1244,107.4),(4945,2,1244,133),(4946,3,1244,102.2),(4947,4,1244,100),(4948,1,1245,120.6),(4949,2,1245,113.2),(4950,3,1245,110),(4951,4,1245,100),(4952,1,1246,105),(4953,2,1246,114.4),(4954,3,1246,110.5),(4955,4,1246,100),(4956,1,1247,106.4),(4957,2,1247,125.3),(4958,3,1247,114.7),(4959,4,1247,100),(4960,1,1248,101.6),(4961,2,1248,3.2),(4962,3,1248,218.5),(4963,4,1248,100),(4964,1,1249,127),(4965,2,1249,159.4),(4966,3,1249,110.9),(4967,4,1249,100),(4968,1,1250,115.8),(4969,2,1250,178.4),(4970,3,1250,115.5),(4971,4,1250,100),(4972,1,1251,106),(4973,2,1251,145.2),(4974,3,1251,124.8),(4975,4,1251,100),(4976,1,1252,107.4),(4977,2,1252,133),(4978,3,1252,102.2),(4979,4,1252,100),(4980,1,1253,120.6),(4981,2,1253,113.2),(4982,3,1253,110),(4983,4,1253,100),(4984,1,1254,105),(4985,2,1254,114.4),(4986,3,1254,110.5),(4987,4,1254,100),(4988,1,1255,106.4),(4989,2,1255,125.3),(4990,3,1255,114.7),(4991,4,1255,100),(4992,1,1256,101.6),(4993,2,1256,3.2),(4994,3,1256,218.5),(4995,4,1256,100),(4996,1,1257,127),(4997,2,1257,159.4),(4998,3,1257,110.9),(4999,4,1257,100),(5000,1,1258,115.8),(5001,2,1258,178.4),(5002,3,1258,115.5),(5003,4,1258,100),(5004,1,1259,106),(5005,2,1259,145.2),(5006,3,1259,124.8),(5007,4,1259,100),(5008,1,1260,107.4),(5009,2,1260,133),(5010,3,1260,102.2),(5011,4,1260,100),(5012,1,1261,120.6),(5013,2,1261,113.2),(5014,3,1261,110),(5015,4,1261,100),(5016,1,1262,105),(5017,2,1262,114.4),(5018,3,1262,110.5),(5019,4,1262,100),(5020,1,1263,106.4),(5021,2,1263,125.3),(5022,3,1263,114.7),(5023,4,1263,100),(5024,1,1264,101.6),(5025,2,1264,3.2),(5026,3,1264,218.5),(5027,4,1264,100),(5036,1,1265,13250),(5037,2,1265,10890),(5038,3,1265,3000),(5039,4,1265,10000),(5040,1,1266,3500),(5041,2,1266,220),(5042,3,1266,2570),(5043,4,1266,10000),(5044,1,1267,11920),(5045,2,1267,11780),(5046,3,1267,1750),(5047,4,1267,10000),(5048,1,1268,7420),(5049,2,1268,440),(5050,3,1268,1860),(5051,4,1268,10000),(5052,1,1269,7000),(5053,2,1269,6890),(5054,3,1269,2370),(5055,4,1269,10000),(5056,1,1270,19580),(5057,2,1270,19000),(5058,3,1270,1950),(5059,4,1270,10000),(5060,1,1271,13500),(5061,2,1271,8780),(5062,3,1271,2220),(5063,4,1271,10000),(5064,1,1272,14830),(5065,2,1272,12220),(5066,3,1272,2530),(5067,4,1272,10000),(5068,1,1273,4420),(5069,2,1273,1470),(5070,3,1273,2060),(5071,4,1273,10000),(5072,1,1274,5920),(5073,2,1274,890),(5074,3,1274,1620),(5075,4,1274,10000),(5076,1,1275,14920),(5077,2,1275,12780),(5078,3,1275,2850),(5079,4,1275,10000),(5080,1,1276,15830),(5081,2,1276,13440),(5082,3,1276,3520),(5083,4,1276,10000),(5084,1,1277,18580),(5085,2,1277,11440),(5086,3,1277,2700),(5087,4,1277,10000),(5088,1,1278,14420),(5089,2,1278,10330),(5090,3,1278,2580),(5091,4,1278,10000),(5092,1,1279,22330),(5093,2,1279,14000),(5094,3,1279,3130),(5095,4,1279,10000),(5096,1,1280,11580),(5097,2,1280,10670),(5098,3,1280,1460),(5099,4,1280,10000),(5100,1,1281,10420),(5101,2,1281,8780),(5102,3,1281,2660),(5103,4,1281,10000),(5104,1,1282,12080),(5105,2,1282,10330),(5106,3,1282,2680),(5107,4,1282,10000),(5108,1,1283,14580),(5109,2,1283,7330),(5110,3,1283,2450),(5111,4,1283,10000),(5112,1,1284,12750),(5113,2,1284,9780),(5114,3,1284,1840),(5115,4,1284,10000),(5116,1,1285,4000),(5117,2,1285,5110),(5118,3,1285,710),(5119,4,1285,10000),(5120,1,1286,8500),(5121,2,1286,560),(5122,3,1286,2220),(5123,4,1286,10000),(5124,1,1287,4170),(5125,2,1287,1440),(5126,3,1287,840),(5127,4,1287,10000),(5128,1,1288,1830),(5129,2,1288,440),(5130,3,1288,1430),(5131,4,1288,10000),(5132,1,1289,6830),(5133,2,1289,4000),(5134,3,1289,510),(5135,4,1289,10000),(5136,1,1290,11580),(5137,2,1290,5220),(5138,3,1290,2980),(5139,4,1290,10000),(5140,1,1291,12330),(5141,2,1291,12890),(5142,3,1291,1420),(5143,4,1291,10000),(5144,1,1292,11080),(5145,2,1292,7780),(5146,3,1292,1660),(5147,4,1292,10000),(5148,1,1293,14250),(5149,2,1293,11890),(5150,3,1293,3840),(5151,4,1293,10000),(5152,1,1294,11420),(5153,2,1294,7780),(5154,3,1294,2140),(5155,4,1294,10000),(5156,1,1295,11420),(5157,2,1295,8440),(5158,3,1295,2780),(5159,4,1295,10000),(5160,1,1296,14420),(5161,2,1296,13780),(5162,3,1296,2520),(5163,4,1296,10000),(5164,1,1297,15330),(5165,2,1297,15780),(5166,3,1297,3900),(5167,4,1297,10000),(5168,1,1298,11000),(5169,2,1298,5670),(5170,3,1298,1730),(5171,4,1298,10000),(5172,1,1299,0),(5173,2,1299,0),(5174,3,1299,0),(5175,4,1299,10000),(5176,1,1300,0),(5177,2,1300,0),(5178,3,1300,0),(5179,4,1300,10000),(5180,1,1301,10000),(5181,2,1301,4890),(5182,3,1301,1510),(5183,4,1301,10000),(5184,1,1302,9000),(5185,2,1302,0),(5186,3,1302,1340),(5187,4,1302,10000),(5188,1,1303,2500),(5189,2,1303,0),(5190,3,1303,440),(5191,4,1303,10000),(5192,1,1304,4000),(5193,2,1304,330),(5194,3,1304,-1960),(5195,4,1304,10000),(5196,1,1305,11000),(5197,2,1305,9670),(5198,3,1305,1660),(5199,4,1305,10000),(5200,1,1306,4000),(5201,2,1306,1670),(5202,3,1306,770),(5203,4,1306,10000),(5204,1,1307,4920),(5205,2,1307,220),(5206,3,1307,1200),(5207,4,1307,10000),(5208,1,1308,8500),(5209,2,1308,8670),(5210,3,1308,1190),(5211,4,1308,10000),(5212,1,1309,8670),(5213,2,1309,2110),(5214,3,1309,2040),(5215,4,1309,10000),(5216,1,1310,10420),(5217,2,1310,9330),(5218,3,1310,1380),(5219,4,1310,10000),(5220,1,1311,13000),(5221,2,1311,12000),(5222,3,1311,1540),(5223,4,1311,10000),(5224,1,1312,9750),(5225,2,1312,6220),(5226,3,1312,1740),(5227,4,1312,10000),(5228,1,1313,6670),(5229,2,1313,220),(5230,3,1313,1160),(5231,4,1313,10000),(5232,1,1314,11500),(5233,2,1314,10110),(5234,3,1314,2350),(5235,4,1314,10000),(5236,1,1315,12330),(5237,2,1315,5440),(5238,3,1315,1750),(5239,4,1315,10000),(5240,1,1316,0),(5241,2,1316,0),(5242,3,1316,0),(5243,4,1316,10000),(5244,1,1317,10250),(5245,2,1317,10110),(5246,3,1317,2700),(5247,4,1317,10000),(5248,1,1318,11170),(5249,2,1318,10670),(5250,3,1318,2940),(5251,4,1318,10000),(5252,1,1319,3420),(5253,2,1319,0),(5254,3,1319,410),(5255,4,1319,10000),(5256,1,1320,14000),(5257,2,1320,14110),(5258,3,1320,1090),(5259,4,1320,10000),(5260,1,1321,14830),(5261,2,1321,11440),(5262,3,1321,1140),(5263,4,1321,0),(5264,1,1322,12670),(5265,2,1322,10000),(5266,3,1322,1900),(5267,4,1322,10000),(5268,1,1323,9920),(5269,2,1323,6440),(5270,3,1323,1150),(5271,4,1323,10000),(5272,1,1324,14670),(5273,2,1324,10220),(5274,3,1324,760),(5275,4,1324,10000),(5276,1,1325,10580),(5277,2,1325,4560),(5278,3,1325,2850),(5279,4,1325,10000),(5280,1,1326,10830),(5281,2,1326,1890),(5282,3,1326,1400),(5283,4,1326,10000),(5284,1,1327,13670),(5285,2,1327,14890),(5286,3,1327,1950),(5287,4,1327,10000),(5288,1,1328,10170),(5289,2,1328,1330),(5290,3,1328,690),(5291,4,1328,10000),(5292,1,1329,12920),(5293,2,1329,12670),(5294,3,1329,2450),(5295,4,1329,10000),(5296,1,1330,14170),(5297,2,1330,16110),(5298,3,1330,570),(5299,4,1330,10000),(5300,1,1331,10920),(5301,2,1331,4220),(5302,3,1331,2000),(5303,4,1331,10000),(5304,1,1332,12750),(5305,2,1332,12780),(5306,3,1332,2580),(5307,4,1332,10000),(5308,1,1333,9670),(5309,2,1333,10670),(5310,3,1333,1950),(5311,4,1333,10000),(5312,1,1334,12580),(5313,2,1334,12560),(5314,3,1334,1840),(5315,4,1334,10000),(5316,1,1335,13830),(5317,2,1335,6000),(5318,3,1335,2410),(5319,4,1335,10000),(5320,1,1336,15330),(5321,2,1336,13780),(5322,3,1336,2280),(5323,4,1336,10000),(5324,1,1337,8750),(5325,2,1337,3330),(5326,3,1337,2040),(5327,4,1337,10000),(5328,1,1338,12420),(5329,2,1338,1670),(5330,3,1338,4020),(5331,4,1338,10000),(5332,1,1339,14670),(5333,2,1339,110),(5334,3,1339,2700),(5335,4,1339,10000),(5336,1,1340,10580),(5337,2,1340,1890),(5338,3,1340,2480),(5339,4,1340,10000),(5340,1,1341,17420),(5341,2,1341,8560),(5342,3,1341,2240),(5343,4,1341,10000),(5344,1,1342,5330),(5345,2,1342,110),(5346,3,1342,1470),(5347,4,1342,10000),(5348,1,1343,14580),(5349,2,1343,11440),(5350,3,1343,2130),(5351,4,1343,10000),(5352,1,1344,14000),(5353,2,1344,11560),(5354,3,1344,2280),(5355,4,1344,10000),(5356,1,1345,13670),(5357,2,1345,7220),(5358,3,1345,1490),(5359,4,1345,10000),(5360,1,1346,11670),(5361,2,1346,9000),(5362,3,1346,2240),(5363,4,1346,10000),(5364,1,1347,7330),(5365,2,1347,1560),(5366,3,1347,1080),(5367,4,1347,10000),(5368,1,1348,16250),(5369,2,1348,15000),(5370,3,1348,3150),(5371,4,1348,10000),(5372,1,1349,7000),(5373,2,1349,1560),(5374,3,1349,2310),(5375,4,1349,10000),(5376,1,1350,14920),(5377,2,1350,10110),(5378,3,1350,1260),(5379,4,1350,10000),(5380,1,1351,3250),(5381,2,1351,110),(5382,3,1351,260),(5383,4,1351,10000),(5384,1,1352,15250),(5385,2,1352,13000),(5386,3,1352,1840),(5387,4,1352,10000),(5388,1,1353,15750),(5389,2,1353,15670),(5390,3,1353,2490),(5391,4,1353,10000),(5392,1,1354,14670),(5393,2,1354,14560),(5394,3,1354,1260),(5395,4,1354,10000),(5396,1,1355,19080),(5397,2,1355,9000),(5398,3,1355,1300),(5399,4,1355,10000),(5400,1,1356,3670),(5401,2,1356,1440),(5402,3,1356,840),(5403,4,1356,10000),(5404,1,1357,13750),(5405,2,1357,10330),(5406,3,1357,2340),(5407,4,1357,10000),(5408,1,1358,14080),(5409,2,1358,9780),(5410,3,1358,1740),(5411,4,1358,10000),(5412,1,1359,11080),(5413,2,1359,11110),(5414,3,1359,1810),(5415,4,1359,10000),(5416,1,1360,13670),(5417,2,1360,14000),(5418,3,1360,1500),(5419,4,1360,10000),(5420,1,1361,10250),(5421,2,1361,2780),(5422,3,1361,2060),(5423,4,1361,10000),(5424,1,1362,10250),(5425,2,1362,6110),(5426,3,1362,1820),(5427,4,1362,10000),(5428,1,1363,16000),(5429,2,1363,12670),(5430,3,1363,-150),(5431,4,1363,10000),(5432,1,1364,4500),(5433,2,1364,5670),(5434,3,1364,110),(5435,4,1364,10000),(5436,1,1365,14000),(5437,2,1365,9780),(5438,3,1365,1550),(5439,4,1365,10000),(5440,1,1366,7170),(5441,2,1366,8000),(5442,3,1366,1440),(5443,4,1366,10000),(5444,1,1367,10580),(5445,2,1367,10340),(5446,3,1367,780),(5447,4,1367,10000),(5448,1,1368,9580),(5449,2,1368,10340),(5450,3,1368,2340),(5451,4,1368,10000),(5452,1,1369,7830),(5453,2,1369,8970),(5454,3,1369,630),(5455,4,1369,10000),(5456,1,1370,9580),(5457,2,1370,1730),(5458,3,1370,3060),(5459,4,1370,10000),(5460,1,1371,6750),(5461,2,1371,0),(5462,3,1371,4530),(5463,4,1371,10000),(5464,1,1372,5080),(5465,2,1372,6780),(5466,3,1372,4210),(5467,4,1372,10000),(5468,1,1373,5330),(5469,2,1373,0),(5470,3,1373,4670),(5471,4,1373,10000),(5472,1,1374,13500),(5473,2,1374,10340),(5474,3,1374,2480),(5475,4,1374,10000),(5476,1,1375,10750),(5477,2,1375,0),(5478,3,1375,4200),(5479,4,1375,10000),(5480,1,1376,6750),(5481,2,1376,0),(5482,3,1376,2410),(5483,4,1376,10000),(5484,1,1377,11170),(5485,2,1377,0),(5486,3,1377,4440),(5487,4,1377,10000),(5488,1,1378,12500),(5489,2,1378,17130),(5490,3,1378,940),(5491,4,1378,10000),(5492,1,1379,10080),(5493,2,1379,6440),(5494,3,1379,1680),(5495,4,1379,10000),(5496,1,1380,5000),(5497,2,1380,4600),(5498,3,1380,570),(5499,4,1380,10000),(5500,1,1381,17830),(5501,2,1381,12640),(5502,3,1381,1660),(5503,4,1381,10000),(5504,1,1382,14580),(5505,2,1382,17130),(5506,3,1382,4060),(5507,4,1382,10000),(5508,1,1383,8670),(5509,2,1383,9770),(5510,3,1383,870),(5511,4,1383,10000),(5512,1,1384,5580),(5513,2,1384,0),(5514,3,1384,3350),(5515,4,1384,10000),(5516,1,1385,0),(5517,2,1385,0),(5518,3,1385,0),(5519,4,1385,10000),(5520,1,1386,11500),(5521,2,1386,14670),(5522,3,1386,1030),(5523,4,1386,10000),(5524,1,1387,9250),(5525,2,1387,11610),(5526,3,1387,900),(5527,4,1387,10000),(5528,1,1388,11330),(5529,2,1388,10340),(5530,3,1388,3630),(5531,4,1388,10000),(5532,1,1389,18250),(5533,2,1389,13220),(5534,3,1389,2300),(5535,4,1389,10000),(5536,1,1390,16170),(5537,2,1390,12220),(5538,3,1390,2090),(5539,4,1390,10000),(5540,1,1391,11330),(5541,2,1391,8780),(5542,3,1391,4600),(5543,4,1391,10000),(5544,1,1392,8420),(5545,2,1392,6000),(5546,3,1392,1120),(5547,4,1392,10000),(5548,1,1393,15420),(5549,2,1393,11440),(5550,3,1393,2260),(5551,4,1393,10000),(5552,1,1394,13580),(5553,2,1394,14670),(5554,3,1394,1040),(5555,4,1394,10000),(5556,1,1395,15920),(5557,2,1395,11440),(5558,3,1395,2270),(5559,4,1395,10000),(5560,1,1396,16330),(5561,2,1396,17330),(5562,3,1396,2270),(5563,4,1396,10000),(5564,1,1397,12750),(5565,2,1397,12670),(5566,3,1397,2990),(5567,4,1397,10000),(5568,1,1398,15080),(5569,2,1398,10670),(5570,3,1398,3320),(5571,4,1398,10000),(5572,1,1399,12920),(5573,2,1399,10780),(5574,3,1399,1720),(5575,4,1399,10000),(5576,1,1400,16420),(5577,2,1400,12000),(5578,3,1400,2940),(5579,4,1400,10000),(5580,1,1401,16500),(5581,2,1401,14670),(5582,3,1401,3220),(5583,4,1401,10000),(5584,1,1402,15330),(5585,2,1402,12440),(5586,3,1402,1210),(5587,4,1402,10000),(5588,1,1403,2920),(5589,2,1403,0),(5590,3,1403,1200),(5591,4,1403,10000),(5592,1,1404,13330),(5593,2,1404,8890),(5594,3,1404,820),(5595,4,1404,10000),(5596,1,1405,12500),(5597,2,1405,4890),(5598,3,1405,2460),(5599,4,1405,10000),(5600,1,1406,12500),(5601,2,1406,8330),(5602,3,1406,1830),(5603,4,1406,10000),(5604,1,1407,14750),(5605,2,1407,5780),(5606,3,1407,1740),(5607,4,1407,10000),(5608,1,1408,13000),(5609,2,1408,220),(5610,3,1408,1720),(5611,4,1408,10000),(5612,1,1409,13830),(5613,2,1409,14560),(5614,3,1409,1850),(5615,4,1409,10000),(5616,1,1410,9920),(5617,2,1410,8780),(5618,3,1410,1850),(5619,4,1410,10000),(5620,1,1411,9580),(5621,2,1411,10220),(5622,3,1411,1690),(5623,4,1411,10000),(5624,1,1412,11170),(5625,2,1412,7780),(5626,3,1412,1670),(5627,4,1412,10000),(5628,1,1413,17420),(5629,2,1413,15440),(5630,3,1413,2490),(5631,4,1413,10000),(5632,1,1414,15000),(5633,2,1414,10670),(5634,3,1414,2650),(5635,4,1414,10000),(5636,1,1415,14580),(5637,2,1415,12890),(5638,3,1415,1430),(5639,4,1415,10000),(5640,1,1416,14830),(5641,2,1416,12890),(5642,3,1416,4210),(5643,4,1416,10000),(5644,1,1417,12330),(5645,2,1417,1890),(5646,3,1417,2230),(5647,4,1417,10000),(5648,1,1418,15250),(5649,2,1418,11440),(5650,3,1418,4500),(5651,4,1418,10000),(5652,1,1419,128.3),(5653,2,1419,124.1),(5654,3,1419,21.3),(5655,4,1419,100),(5656,1,1420,130.8),(5657,2,1420,112.6),(5658,3,1420,27),(5659,4,1420,100),(5660,1,1421,100),(5661,2,1421,113.8),(5662,3,1421,13.7),(5663,4,1421,100),(5664,1,1422,113.3),(5665,2,1422,100),(5666,3,1422,29.6),(5667,4,1422,100),(5668,1,1423,115),(5669,2,1423,104.6),(5670,3,1423,15.7),(5671,4,1423,100),(5672,1,1424,44.2),(5673,2,1424,14.7),(5674,3,1424,20.6),(5675,4,1424,100),(5676,1,1425,143.3),(5677,2,1425,115.6),(5678,3,1425,22.4),(5679,4,1425,100),(5680,1,1426,130),(5681,2,1426,125.6),(5682,3,1426,39.6),(5683,4,1426,100),(5684,1,1427,124.2),(5685,2,1427,127.8),(5686,3,1427,36.8),(5687,4,1427,100),(5688,1,1428,12.5),(5689,2,1428,4.4),(5690,3,1428,11.6),(5691,4,1428,100),(5692,1,1429,85.8),(5693,2,1429,65.6),(5694,3,1429,21.3),(5695,4,1429,100),(5696,1,1430,59.2),(5697,2,1430,8.9),(5698,3,1430,16.2),(5699,4,1430,100),(5700,1,1431,163.3),(5701,2,1431,144.4),(5702,3,1431,36.7),(5703,4,1431,100),(5704,1,1432,162.5),(5705,2,1432,133.3),(5706,3,1432,49.2),(5707,4,1432,100),(5708,1,1433,138.3),(5709,2,1433,133.3),(5710,3,1433,31.3),(5711,4,1433,100),(5712,1,1434,149.2),(5713,2,1434,127.8),(5714,3,1434,28.5),(5715,4,1434,100),(5716,1,1435,165.8),(5717,2,1435,141.1),(5718,3,1435,21.7),(5719,4,1435,100),(5720,1,1436,175),(5721,2,1436,167.8),(5722,3,1436,22.7),(5723,4,1436,100),(5724,1,1437,125),(5725,2,1437,117.8),(5726,3,1437,16.4),(5727,4,1437,100),(5728,1,1438,167.5),(5729,2,1438,102.2),(5730,3,1438,32.9),(5731,4,1438,100),(5732,1,1439,158.3),(5733,2,1439,134.4),(5734,3,1439,35.2),(5735,4,1439,100),(5736,1,1440,186.7),(5737,2,1440,125.6),(5738,3,1440,22.9),(5739,4,1440,100),(5740,1,1441,192.5),(5741,2,1441,141.1),(5742,3,1441,21.3),(5743,4,1441,100),(5744,1,1442,158.3),(5745,2,1442,105.6),(5746,3,1442,19.9),(5747,4,1442,100),(5748,1,1443,190.8),(5749,2,1443,132.2),(5750,3,1443,34.9),(5751,4,1443,100),(5752,1,1444,185.8),(5753,2,1444,114.4),(5754,3,1444,27),(5755,4,1444,100),(5756,1,1445,164.2),(5757,2,1445,111.1),(5758,3,1445,25.8),(5759,4,1445,100),(5760,1,1446,169.2),(5761,2,1446,140),(5762,3,1446,31.5),(5763,4,1446,100),(5764,1,1447,144.2),(5765,2,1447,103.3),(5766,3,1447,25.8),(5767,4,1447,100),(5768,1,1448,128.3),(5769,2,1448,124.1),(5770,3,1448,21.3),(5771,4,1448,100),(5772,1,1449,130.8),(5773,2,1449,112.6),(5774,3,1449,27),(5775,4,1449,100),(5776,1,1450,100),(5777,2,1450,113.8),(5778,3,1450,13.7),(5779,4,1450,100),(5780,1,1451,113.3),(5781,2,1451,100),(5782,3,1451,29.6),(5783,4,1451,100),(5784,1,1452,115),(5785,2,1452,104.6),(5786,3,1452,15.7),(5787,4,1452,100),(5788,1,1453,44.2),(5789,2,1453,14.7),(5790,3,1453,20.6),(5791,4,1453,100),(5792,1,1454,143.3),(5793,2,1454,115.6),(5794,3,1454,22.4),(5795,4,1454,100),(5796,1,1455,130),(5797,2,1455,125.6),(5798,3,1455,39.6),(5799,4,1455,100),(5800,1,1456,124.2),(5801,2,1456,127.8),(5802,3,1456,36.8),(5803,4,1456,100),(5804,1,1457,12.5),(5805,2,1457,4.4),(5806,3,1457,11.6),(5807,4,1457,100),(5808,1,1458,85.8),(5809,2,1458,65.6),(5810,3,1458,21.3),(5811,4,1458,100),(5812,1,1459,59.2),(5813,2,1459,8.9),(5814,3,1459,16.2),(5815,4,1459,100),(5816,1,1460,163.3),(5817,2,1460,144.4),(5818,3,1460,36.7),(5819,4,1460,100),(5820,1,1461,162.5),(5821,2,1461,133.3),(5822,3,1461,49.2),(5823,4,1461,100),(5824,1,1462,138.3),(5825,2,1462,133.3),(5826,3,1462,31.3),(5827,4,1462,100),(5828,1,1463,149.2),(5829,2,1463,127.8),(5830,3,1463,28.5),(5831,4,1463,100),(5832,1,1464,165.8),(5833,2,1464,141.1),(5834,3,1464,21.7),(5835,4,1464,100),(5836,1,1465,175),(5837,2,1465,167.8),(5838,3,1465,22.7),(5839,4,1465,100),(5840,1,1466,125),(5841,2,1466,117.8),(5842,3,1466,16.4),(5843,4,1466,100),(5844,1,1467,167.5),(5845,2,1467,102.2),(5846,3,1467,32.9),(5847,4,1467,100),(5848,1,1468,158.3),(5849,2,1468,134.4),(5850,3,1468,35.2),(5851,4,1468,100),(5852,1,1469,186.7),(5853,2,1469,125.6),(5854,3,1469,22.9),(5855,4,1469,100),(5856,1,1470,192.5),(5857,2,1470,141.1),(5858,3,1470,21.3),(5859,4,1470,100),(5860,1,1471,158.3),(5861,2,1471,105.6),(5862,3,1471,19.9),(5863,4,1471,100),(5864,1,1472,190.8),(5865,2,1472,132.2),(5866,3,1472,34.9),(5867,4,1472,100),(5868,1,1473,185.8),(5869,2,1473,114.4),(5870,3,1473,27),(5871,4,1473,100),(5872,1,1474,164.2),(5873,2,1474,111.1),(5874,3,1474,25.8),(5875,4,1474,100),(5876,1,1475,169.2),(5877,2,1475,140),(5878,3,1475,31.5),(5879,4,1475,100),(5880,1,1476,144.2),(5881,2,1476,103.3),(5882,3,1476,25.8),(5883,4,1476,100),(5884,1,1477,128.3),(5885,2,1477,124.1),(5886,3,1477,21.3),(5887,4,1477,100),(5888,1,1478,130.8),(5889,2,1478,112.6),(5890,3,1478,27),(5891,4,1478,100),(5892,1,1479,100),(5893,2,1479,113.8),(5894,3,1479,13.7),(5895,4,1479,100),(5896,1,1480,113.3),(5897,2,1480,100),(5898,3,1480,29.6),(5899,4,1480,100),(5900,1,1481,115),(5901,2,1481,104.6),(5902,3,1481,15.7),(5903,4,1481,100),(5904,1,1482,44.2),(5905,2,1482,14.7),(5906,3,1482,20.6),(5907,4,1482,100),(5908,1,1483,143.3),(5909,2,1483,115.6),(5910,3,1483,22.4),(5911,4,1483,100),(5912,1,1484,130),(5913,2,1484,125.6),(5914,3,1484,39.6),(5915,4,1484,100),(5916,1,1485,124.2),(5917,2,1485,127.8),(5918,3,1485,36.8),(5919,4,1485,100),(5920,1,1486,12.5),(5921,2,1486,4.4),(5922,3,1486,11.6),(5923,4,1486,100),(5924,1,1487,85.8),(5925,2,1487,65.6),(5926,3,1487,21.3),(5927,4,1487,100),(5928,1,1488,59.2),(5929,2,1488,8.9),(5930,3,1488,16.2),(5931,4,1488,100),(5932,1,1489,163.3),(5933,2,1489,144.4),(5934,3,1489,36.7),(5935,4,1489,100),(5936,1,1490,162.5),(5937,2,1490,133.3),(5938,3,1490,49.2),(5939,4,1490,100),(5940,1,1491,138.3),(5941,2,1491,133.3),(5942,3,1491,31.3),(5943,4,1491,100),(5944,1,1492,149.2),(5945,2,1492,127.8),(5946,3,1492,28.5),(5947,4,1492,100),(5948,1,1493,165.8),(5949,2,1493,141.1),(5950,3,1493,21.7),(5951,4,1493,100),(5952,1,1494,175),(5953,2,1494,167.8),(5954,3,1494,22.7),(5955,4,1494,100),(5956,1,1495,125),(5957,2,1495,117.8),(5958,3,1495,16.4),(5959,4,1495,100),(5960,1,1496,167.5),(5961,2,1496,102.2),(5962,3,1496,32.9),(5963,4,1496,100),(5964,1,1497,158.3),(5965,2,1497,134.4),(5966,3,1497,35.2),(5967,4,1497,100),(5968,1,1498,186.7),(5969,2,1498,125.6),(5970,3,1498,22.9),(5971,4,1498,100),(5972,1,1499,192.5),(5973,2,1499,141.1),(5974,3,1499,21.3),(5975,4,1499,100),(5976,1,1500,158.3),(5977,2,1500,105.6),(5978,3,1500,19.9),(5979,4,1500,100),(5980,1,1501,190.8),(5981,2,1501,132.2),(5982,3,1501,34.9),(5983,4,1501,100),(5984,1,1502,185.8),(5985,2,1502,114.4),(5986,3,1502,27),(5987,4,1502,100),(5988,1,1503,164.2),(5989,2,1503,111.1),(5990,3,1503,25.8),(5991,4,1503,100),(5992,1,1504,169.2),(5993,2,1504,140),(5994,3,1504,31.5),(5995,4,1504,100),(5996,1,1505,144.2),(5997,2,1505,103.3),(5998,3,1505,25.8),(5999,4,1505,100),(6000,1,1506,128.3),(6001,2,1506,124.1),(6002,3,1506,21.3),(6003,4,1506,100),(6004,1,1507,130.8),(6005,2,1507,112.6),(6006,3,1507,27),(6007,4,1507,100),(6008,1,1508,100),(6009,2,1508,113.8),(6010,3,1508,13.7),(6011,4,1508,100),(6012,1,1509,113.3),(6013,2,1509,100),(6014,3,1509,29.6),(6015,4,1509,100),(6016,1,1510,115),(6017,2,1510,104.6),(6018,3,1510,15.7),(6019,4,1510,100),(6020,1,1511,44.2),(6021,2,1511,14.7),(6022,3,1511,20.6),(6023,4,1511,100),(6024,1,1512,143.3),(6025,2,1512,115.6),(6026,3,1512,22.4),(6027,4,1512,100),(6028,1,1513,130),(6029,2,1513,125.6),(6030,3,1513,39.6),(6031,4,1513,100),(6032,1,1514,124.2),(6033,2,1514,127.8),(6034,3,1514,36.8),(6035,4,1514,100),(6036,1,1515,12.5),(6037,2,1515,4.4),(6038,3,1515,11.6),(6039,4,1515,100),(6040,1,1516,85.8),(6041,2,1516,65.6),(6042,3,1516,21.3),(6043,4,1516,100),(6044,1,1517,59.2),(6045,2,1517,8.9),(6046,3,1517,16.2),(6047,4,1517,100),(6048,1,1518,163.3),(6049,2,1518,144.4),(6050,3,1518,36.7),(6051,4,1518,100),(6052,1,1519,162.5),(6053,2,1519,133.3),(6054,3,1519,49.2),(6055,4,1519,100),(6056,1,1520,138.3),(6057,2,1520,133.3),(6058,3,1520,31.3),(6059,4,1520,100),(6060,1,1521,149.2),(6061,2,1521,127.8),(6062,3,1521,28.5),(6063,4,1521,100),(6064,1,1522,165.8),(6065,2,1522,141.1),(6066,3,1522,21.7),(6067,4,1522,100),(6068,1,1523,175),(6069,2,1523,167.8),(6070,3,1523,22.7),(6071,4,1523,100),(6072,1,1524,125),(6073,2,1524,117.8),(6074,3,1524,16.4),(6075,4,1524,100),(6076,1,1525,167.5),(6077,2,1525,102.2),(6078,3,1525,32.9),(6079,4,1525,100),(6080,1,1526,158.3),(6081,2,1526,134.4),(6082,3,1526,35.2),(6083,4,1526,100),(6084,1,1527,186.7),(6085,2,1527,125.6),(6086,3,1527,22.9),(6087,4,1527,100),(6088,1,1528,192.5),(6089,2,1528,141.1),(6090,3,1528,21.3),(6091,4,1528,100),(6092,1,1529,158.3),(6093,2,1529,105.6),(6094,3,1529,19.9),(6095,4,1529,100),(6096,1,1530,190.8),(6097,2,1530,132.2),(6098,3,1530,34.9),(6099,4,1530,100),(6100,1,1531,185.8),(6101,2,1531,114.4),(6102,3,1531,27),(6103,4,1531,100),(6104,1,1532,164.2),(6105,2,1532,111.1),(6106,3,1532,25.8),(6107,4,1532,100),(6108,1,1533,169.2),(6109,2,1533,140),(6110,3,1533,31.5),(6111,4,1533,100),(6112,1,1534,144.2),(6113,2,1534,103.3),(6114,3,1534,25.8),(6115,4,1534,100),(6116,1,1535,128.3),(6117,2,1535,124.1),(6118,3,1535,21.3),(6119,4,1535,100),(6120,1,1536,130.8),(6121,2,1536,112.6),(6122,3,1536,27),(6123,4,1536,100),(6124,1,1537,100),(6125,2,1537,113.8),(6126,3,1537,13.7),(6127,4,1537,100),(6128,1,1538,113.3),(6129,2,1538,100),(6130,3,1538,29.6),(6131,4,1538,100),(6132,1,1539,115),(6133,2,1539,104.6),(6134,3,1539,15.7),(6135,4,1539,100),(6136,1,1540,44.2),(6137,2,1540,14.7),(6138,3,1540,20.6),(6139,4,1540,100),(6140,1,1541,143.3),(6141,2,1541,115.6),(6142,3,1541,22.4),(6143,4,1541,100),(6144,1,1542,130),(6145,2,1542,125.6),(6146,3,1542,39.6),(6147,4,1542,100),(6148,1,1543,124.2),(6149,2,1543,127.8),(6150,3,1543,36.8),(6151,4,1543,100),(6152,1,1544,12.5),(6153,2,1544,4.4),(6154,3,1544,11.6),(6155,4,1544,100),(6156,1,1545,85.8),(6157,2,1545,65.6),(6158,3,1545,21.3),(6159,4,1545,100),(6160,1,1546,59.2),(6161,2,1546,8.9),(6162,3,1546,16.2),(6163,4,1546,100),(6164,1,1547,163.3),(6165,2,1547,144.4),(6166,3,1547,36.7),(6167,4,1547,100),(6168,1,1548,162.5),(6169,2,1548,133.3),(6170,3,1548,49.2),(6171,4,1548,100),(6172,1,1549,138.3),(6173,2,1549,133.3),(6174,3,1549,31.3),(6175,4,1549,100),(6176,1,1550,149.2),(6177,2,1550,127.8),(6178,3,1550,28.5),(6179,4,1550,100),(6180,1,1551,165.8),(6181,2,1551,141.1),(6182,3,1551,21.7),(6183,4,1551,100),(6184,1,1552,175),(6185,2,1552,167.8),(6186,3,1552,22.7),(6187,4,1552,100),(6188,1,1553,125),(6189,2,1553,117.8),(6190,3,1553,16.4),(6191,4,1553,100),(6192,1,1554,167.5),(6193,2,1554,102.2),(6194,3,1554,32.9),(6195,4,1554,100),(6196,1,1555,158.3),(6197,2,1555,134.4),(6198,3,1555,35.2),(6199,4,1555,100),(6200,1,1556,186.7),(6201,2,1556,125.6),(6202,3,1556,22.9),(6203,4,1556,100),(6204,1,1557,192.5),(6205,2,1557,141.1),(6206,3,1557,21.3),(6207,4,1557,100),(6208,1,1558,158.3),(6209,2,1558,105.6),(6210,3,1558,19.9),(6211,4,1558,100),(6212,1,1559,190.8),(6213,2,1559,132.2),(6214,3,1559,34.9),(6215,4,1559,100),(6216,1,1560,185.8),(6217,2,1560,114.4),(6218,3,1560,27),(6219,4,1560,100),(6220,1,1561,164.2),(6221,2,1561,111.1),(6222,3,1561,25.8),(6223,4,1561,100),(6224,1,1562,169.2),(6225,2,1562,140),(6226,3,1562,31.5),(6227,4,1562,100),(6228,1,1563,144.2),(6229,2,1563,103.3),(6230,3,1563,25.8),(6231,4,1563,100),(6232,1,1564,128.3),(6233,2,1564,124.1),(6234,3,1564,21.3),(6235,4,1564,100),(6236,1,1565,130.8),(6237,2,1565,112.6),(6238,3,1565,27),(6239,4,1565,100),(6240,1,1566,100),(6241,2,1566,113.8),(6242,3,1566,13.7),(6243,4,1566,100),(6244,1,1567,113.3),(6245,2,1567,100),(6246,3,1567,29.6),(6247,4,1567,100),(6248,1,1568,115),(6249,2,1568,104.6),(6250,3,1568,15.7),(6251,4,1568,100),(6252,1,1569,44.2),(6253,2,1569,14.7),(6254,3,1569,20.6),(6255,4,1569,100),(6256,1,1570,143.3),(6257,2,1570,115.6),(6258,3,1570,22.4),(6259,4,1570,100),(6260,1,1571,130),(6261,2,1571,125.6),(6262,3,1571,39.6),(6263,4,1571,100),(6264,1,1572,124.2),(6265,2,1572,127.8),(6266,3,1572,36.8),(6267,4,1572,100),(6268,1,1573,12.5),(6269,2,1573,4.4),(6270,3,1573,11.6),(6271,4,1573,100),(6272,1,1574,85.8),(6273,2,1574,65.6),(6274,3,1574,21.3),(6275,4,1574,100),(6276,1,1575,59.2),(6277,2,1575,8.9),(6278,3,1575,16.2),(6279,4,1575,100),(6280,1,1576,163.3),(6281,2,1576,144.4),(6282,3,1576,36.7),(6283,4,1576,100),(6284,1,1577,162.5),(6285,2,1577,133.3),(6286,3,1577,49.2),(6287,4,1577,100),(6288,1,1578,138.3),(6289,2,1578,133.3),(6290,3,1578,31.3),(6291,4,1578,100),(6292,1,1579,149.2),(6293,2,1579,127.8),(6294,3,1579,28.5),(6295,4,1579,100),(6296,1,1580,165.8),(6297,2,1580,141.1),(6298,3,1580,21.7),(6299,4,1580,100),(6300,1,1581,175),(6301,2,1581,167.8),(6302,3,1581,22.7),(6303,4,1581,100),(6304,1,1582,125),(6305,2,1582,117.8),(6306,3,1582,16.4),(6307,4,1582,100),(6308,1,1583,167.5),(6309,2,1583,102.2),(6310,3,1583,32.9),(6311,4,1583,100),(6312,1,1584,158.3),(6313,2,1584,134.4),(6314,3,1584,35.2),(6315,4,1584,100),(6316,1,1585,186.7),(6317,2,1585,125.6),(6318,3,1585,22.9),(6319,4,1585,100),(6320,1,1586,192.5),(6321,2,1586,141.1),(6322,3,1586,21.3),(6323,4,1586,100),(6324,1,1587,158.3),(6325,2,1587,105.6),(6326,3,1587,19.9),(6327,4,1587,100),(6328,1,1588,190.8),(6329,2,1588,132.2),(6330,3,1588,34.9),(6331,4,1588,100),(6332,1,1589,185.8),(6333,2,1589,114.4),(6334,3,1589,27),(6335,4,1589,100),(6336,1,1590,164.2),(6337,2,1590,111.1),(6338,3,1590,25.8),(6339,4,1590,100),(6340,1,1591,169.2),(6341,2,1591,140),(6342,3,1591,31.5),(6343,4,1591,100),(6344,1,1592,144.2),(6345,2,1592,103.3),(6346,3,1592,25.8),(6347,4,1592,100);
/*!40000 ALTER TABLE `Report4SDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SARPosm`
--

DROP TABLE IF EXISTS `SARPosm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SARPosm` (
  `SARPosmID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `StorePOSM` bigint(20) NOT NULL,
  `Has` tinyint(4) NOT NULL,
  PRIMARY KEY (`SARPosmID`),
  UNIQUE KEY `UQ_SARPosm` (`StoreAuditResultID`,`StorePOSM`),
  KEY `FK_SARPosm_SAR` (`StoreAuditResultID`),
  KEY `FK_SARPosm_StorePOSM` (`StorePOSM`),
  CONSTRAINT `FK_SARPosm_SAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SARPosm_StorePOSM` FOREIGN KEY (`StorePOSM`) REFERENCES `StorePOSM` (`StorePOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SARPosm`
--

LOCK TABLES `SARPosm` WRITE;
/*!40000 ALTER TABLE `SARPosm` DISABLE KEYS */;
/*!40000 ALTER TABLE `SARPosm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SARRegisterProduct`
--

DROP TABLE IF EXISTS `SARRegisterProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SARRegisterProduct` (
  `SARRegisterProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `ProductID` bigint(20) NOT NULL,
  `Has` tinyint(4) NOT NULL,
  PRIMARY KEY (`SARRegisterProductID`),
  UNIQUE KEY `UQ_SARRegisterProduct` (`StoreAuditResultID`,`ProductID`),
  KEY `FK_SARRegisterProduct_SAR` (`StoreAuditResultID`),
  KEY `FK_SARRegisterProduct_Product` (`ProductID`),
  CONSTRAINT `FK_SARRegisterProduct_Product` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SARRegisterProduct_SAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SARRegisterProduct`
--

LOCK TABLES `SARRegisterProduct` WRITE;
/*!40000 ALTER TABLE `SARRegisterProduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `SARRegisterProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SARSBrandLocation`
--

DROP TABLE IF EXISTS `SARSBrandLocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SARSBrandLocation` (
  `SARSBrandLocationID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `BrandID` bigint(20) NOT NULL,
  `Has` tinyint(4) DEFAULT NULL,
  `IsRight` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`SARSBrandLocationID`),
  UNIQUE KEY `UQ_ SARSBrandLocation` (`StoreAuditResultID`,`BrandID`),
  KEY `FK_ SARSBrandLocation_SAR` (`StoreAuditResultID`),
  KEY `FK_SARSBrandLocation_Brand` (`BrandID`),
  CONSTRAINT `FK_ SARSBrandLocation_SAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SARSBrandLocation_Brand` FOREIGN KEY (`BrandID`) REFERENCES `Brand` (`BrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SARSBrandLocation`
--

LOCK TABLES `SARSBrandLocation` WRITE;
/*!40000 ALTER TABLE `SARSBrandLocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `SARSBrandLocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SARShareOfDisplay`
--

DROP TABLE IF EXISTS `SARShareOfDisplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SARShareOfDisplay` (
  `SARShareOfDisplayID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `SOSBrandID` bigint(20) NOT NULL,
  `FCVSS` int(11) DEFAULT NULL,
  `FCVGE` int(11) DEFAULT NULL,
  `FCVOther` int(11) DEFAULT NULL,
  `StoreSS` int(11) DEFAULT NULL,
  `StoreGE` int(11) DEFAULT NULL,
  `StoreOther` int(11) DEFAULT NULL,
  PRIMARY KEY (`SARShareOfDisplayID`),
  UNIQUE KEY `UQ_SARShareOfDisplay` (`StoreAuditResultID`,`SOSBrandID`),
  KEY `FK_SARShareOfDisplay_SAR` (`StoreAuditResultID`),
  KEY `FK_SARShareOfDisplay_BrandGroup` (`SOSBrandID`),
  KEY `FK_SARShareOfDisplay_SOSBrand` (`SOSBrandID`),
  CONSTRAINT `FK_SARShareOfDisplay_SAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SARShareOfDisplay_SOSBrand` FOREIGN KEY (`SOSBrandID`) REFERENCES `SOSBrand` (`SOSBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SARShareOfDisplay`
--

LOCK TABLES `SARShareOfDisplay` WRITE;
/*!40000 ALTER TABLE `SARShareOfDisplay` DISABLE KEYS */;
/*!40000 ALTER TABLE `SARShareOfDisplay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SARShareOfShelf`
--

DROP TABLE IF EXISTS `SARShareOfShelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SARShareOfShelf` (
  `SARShareOfShelfID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `PackingGroupID` bigint(20) NOT NULL,
  `Quatity` int(11) DEFAULT NULL,
  PRIMARY KEY (`SARShareOfShelfID`),
  UNIQUE KEY `UQ_SARShareOfShelf` (`StoreAuditResultID`,`PackingGroupID`),
  KEY `FK_SARShareOfShelf_SAR` (`StoreAuditResultID`),
  KEY `FK_SARShareOfShelf_PG` (`PackingGroupID`),
  CONSTRAINT `FK_SARShareOfShelf_PG` FOREIGN KEY (`PackingGroupID`) REFERENCES `PackingGroup` (`PackingGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SARShareOfShelf_SAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SARShareOfShelf`
--

LOCK TABLES `SARShareOfShelf` WRITE;
/*!40000 ALTER TABLE `SARShareOfShelf` DISABLE KEYS */;
/*!40000 ALTER TABLE `SARShareOfShelf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SOSBrand`
--

DROP TABLE IF EXISTS `SOSBrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SOSBrand` (
  `SOSBrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL COMMENT 'Ex: Loc 110ml',
  `BrandGroupID` bigint(20) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`SOSBrandID`),
  KEY `FK_SOSBrand_BrandGroup` (`BrandGroupID`),
  CONSTRAINT `FK_SOSBrand_BrandGroup` FOREIGN KEY (`BrandGroupID`) REFERENCES `BrandGroup` (`BrandGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SOSBrand`
--

LOCK TABLES `SOSBrand` WRITE;
/*!40000 ALTER TABLE `SOSBrand` DISABLE KEYS */;
INSERT INTO `SOSBrand` VALUES (1,'UHT',2,1),(2,'DKY',2,2),(3,'SCM',2,3),(4,'TFD',2,4),(5,'DL.IFT',1,1),(6,'FRISO',1,2);
/*!40000 ALTER TABLE `SOSBrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Saleman`
--

DROP TABLE IF EXISTS `Saleman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Saleman` (
  `SalemanID` bigint(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Name` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Telephone` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Type` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The type of sale man NA, MR, SA',
  `ManageID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`SalemanID`),
  KEY `FK_Manage` (`ManageID`),
  CONSTRAINT `FK_Manage` FOREIGN KEY (`ManageID`) REFERENCES `Saleman` (`SalemanID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Saleman`
--

LOCK TABLES `Saleman` WRITE;
/*!40000 ALTER TABLE `Saleman` DISABLE KEYS */;
/*!40000 ALTER TABLE `Saleman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCard`
--

DROP TABLE IF EXISTS `ScoreCard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCard` (
  `ScoreCardID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorID` bigint(20) NOT NULL,
  `Year` int(11) DEFAULT NULL,
  `Month` int(11) DEFAULT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedBy` bigint(20) DEFAULT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ScoreCardID`),
  UNIQUE KEY `UQ_ScoreCard` (`DistributorID`,`Year`,`Month`),
  CONSTRAINT `FK_ScoreCard_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=727 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCard`
--

LOCK TABLES `ScoreCard` WRITE;
/*!40000 ALTER TABLE `ScoreCard` DISABLE KEYS */;
INSERT INTO `ScoreCard` VALUES (715,3617,2012,1,3037,'2012-01-03 07:03:21',3037,'2012-01-03 07:04:39'),(716,3617,2012,2,3037,'2012-01-03 07:03:21',3037,'2012-02-03 07:06:33'),(717,3617,2012,3,3037,'2012-01-03 07:03:21',3037,'2012-03-03 07:15:16'),(718,3617,2012,4,3037,'2012-01-03 07:03:21',3037,'2012-04-03 07:24:30'),(719,3617,2012,5,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:31'),(720,3617,2012,6,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:31'),(721,3617,2012,7,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:31'),(722,3617,2012,8,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:31'),(723,3617,2012,9,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:32'),(724,3617,2012,10,3037,'2012-01-03 07:03:21',NULL,'2013-09-03 07:03:32'),(725,3617,2012,11,3037,'2012-01-03 07:03:22',NULL,'2013-09-03 07:03:32'),(726,3617,2012,12,3037,'2012-01-03 07:03:22',NULL,'2013-09-03 07:03:32');
/*!40000 ALTER TABLE `ScoreCard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardBestEstimate`
--

DROP TABLE IF EXISTS `ScoreCardBestEstimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardBestEstimate` (
  `ScoreCardBestEstimateID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScoreCardID` bigint(20) NOT NULL,
  `ScoreCardKPIID` bigint(20) NOT NULL,
  `Target` float DEFAULT NULL,
  `Result` float DEFAULT NULL,
  `TargetInvestment` float DEFAULT NULL,
  `TargetReturn` float DEFAULT NULL,
  `ResultInvestment` float DEFAULT NULL,
  `ResultReturn` float DEFAULT NULL,
  `Field1` float DEFAULT NULL COMMENT 'Friso in GT6/SE',
  `Field2` float DEFAULT NULL COMMENT 'DL IFT in GT6/NBH',
  `Field3` float DEFAULT NULL COMMENT 'RTDM in GT6 or Merchandisers',
  `Field4` float DEFAULT NULL COMMENT 'WTD of power SKUs (pts)',
  `TargetRolling` float DEFAULT NULL,
  PRIMARY KEY (`ScoreCardBestEstimateID`),
  UNIQUE KEY `UQ_ScoreCardBestEstimate` (`ScoreCardID`,`ScoreCardKPIID`),
  KEY `FK_ScoreCardBE_KPI` (`ScoreCardKPIID`),
  CONSTRAINT `FK_ScoreCardBE_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardBE_ScoreCard` FOREIGN KEY (`ScoreCardID`) REFERENCES `ScoreCard` (`ScoreCardID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardBestEstimate`
--

LOCK TABLES `ScoreCardBestEstimate` WRITE;
/*!40000 ALTER TABLE `ScoreCardBestEstimate` DISABLE KEYS */;
/*!40000 ALTER TABLE `ScoreCardBestEstimate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardDetail`
--

DROP TABLE IF EXISTS `ScoreCardDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardDetail` (
  `ScoreCardDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScoreCardID` bigint(20) NOT NULL,
  `ScoreCardKPIID` bigint(20) NOT NULL,
  `Target` float DEFAULT NULL,
  `Result` float DEFAULT NULL,
  `TargetInvestment` float DEFAULT NULL,
  `TargetReturn` float DEFAULT NULL,
  `ResultInvestment` float DEFAULT NULL,
  `ResultReturn` float DEFAULT NULL,
  `Field1` float DEFAULT NULL COMMENT 'Friso in GT6/SE',
  `Field2` float DEFAULT NULL COMMENT 'DL IFT in GT6/NBH',
  `Field3` float DEFAULT NULL COMMENT 'RTDM in GT6 or Merchandisers',
  `Field4` float DEFAULT NULL COMMENT 'WTD of power SKUs (pts)',
  `TargetRolling` float DEFAULT NULL,
  PRIMARY KEY (`ScoreCardDetailID`),
  UNIQUE KEY `UQ_ScoreCardDetail` (`ScoreCardID`,`ScoreCardKPIID`),
  KEY `FK_ScoreCardDetail_KPI` (`ScoreCardKPIID`),
  CONSTRAINT `FK_ScoreCardDetail_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardDetail_ScoreCard` FOREIGN KEY (`ScoreCardID`) REFERENCES `ScoreCard` (`ScoreCardID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardDetail`
--

LOCK TABLES `ScoreCardDetail` WRITE;
/*!40000 ALTER TABLE `ScoreCardDetail` DISABLE KEYS */;
INSERT INTO `ScoreCardDetail` VALUES (11049,715,1,1,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11050,715,2,12,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11051,715,3,12,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11052,715,4,14,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11053,715,5,14,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11054,715,6,14,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11055,715,7,12,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11056,715,8,12,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11057,715,9,NULL,NULL,NULL,NULL,NULL,NULL,21,21,9,10,NULL),(11058,715,10,21,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11059,715,11,23,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11060,715,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11061,715,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11062,715,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11063,715,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11064,715,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11065,716,1,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11066,716,2,14,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11067,716,3,12,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11068,716,4,54,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11069,716,5,12,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11070,716,6,5,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11071,716,7,12,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11072,716,8,14,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11073,716,9,NULL,NULL,NULL,NULL,NULL,NULL,21,14,9,10,NULL),(11074,716,10,21,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11075,716,11,25,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11076,716,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11077,716,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11078,716,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11079,716,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11080,716,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11081,717,1,3,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11082,717,2,15,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11083,717,3,36,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11084,717,4,36,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11085,717,5,10,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11086,717,6,24,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11087,717,7,11,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11088,717,8,12,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11089,717,9,NULL,NULL,NULL,NULL,NULL,NULL,14,9,9,11,NULL),(11090,717,10,32,36,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11091,717,11,26,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11092,717,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11093,717,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11094,717,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11095,717,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11096,717,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11097,718,1,4,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11098,718,2,12,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11099,718,3,2,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11100,718,4,2,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11101,718,5,8,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11102,718,6,21,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11103,718,7,11,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11104,718,8,15,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11105,718,9,NULL,NULL,NULL,NULL,NULL,NULL,1,8,9,10,NULL),(11106,718,10,34,38,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11107,718,11,24,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11108,718,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11109,718,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11110,718,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11111,718,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11112,718,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11113,719,1,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11114,719,2,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11115,719,3,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11116,719,4,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11117,719,5,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11118,719,6,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11119,719,7,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11120,719,8,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11121,719,9,NULL,NULL,NULL,NULL,NULL,NULL,5,8,9,12,NULL),(11122,719,10,35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11123,719,11,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11124,719,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11125,719,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11126,719,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11127,719,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11128,719,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11129,720,1,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11130,720,2,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11131,720,3,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11132,720,4,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11133,720,5,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11134,720,6,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11135,720,7,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11136,720,8,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11137,720,9,NULL,NULL,NULL,NULL,NULL,NULL,6,8,10,14,NULL),(11138,720,10,36,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11139,720,11,26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11140,720,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11141,720,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11142,720,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11143,720,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11144,720,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11145,721,1,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11146,721,2,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11147,721,3,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11148,721,4,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11149,721,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11150,721,6,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11151,721,7,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11152,721,8,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11153,721,9,NULL,NULL,NULL,NULL,NULL,NULL,4,7,1,15,NULL),(11154,721,10,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11155,721,11,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11156,721,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11157,721,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11158,721,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11159,721,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11160,721,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11161,722,1,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11162,722,2,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11163,722,3,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11164,722,4,41,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11165,722,5,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11166,722,6,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11167,722,7,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11168,722,8,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11169,722,9,NULL,NULL,NULL,NULL,NULL,NULL,5,8,14,15,NULL),(11170,722,10,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11171,722,11,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11172,722,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11173,722,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11174,722,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11175,722,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11176,722,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11177,723,1,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11178,723,2,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11179,723,3,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11180,723,4,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11181,723,5,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11182,723,6,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11183,723,7,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11184,723,8,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11185,723,9,NULL,NULL,NULL,NULL,NULL,NULL,8,9,15,15,NULL),(11186,723,10,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11187,723,11,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11188,723,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11189,723,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11190,723,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11191,723,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11192,723,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11193,724,1,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11194,724,2,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11195,724,3,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11196,724,4,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11197,724,5,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11198,724,6,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11199,724,7,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11200,724,8,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11201,724,9,NULL,NULL,NULL,NULL,NULL,NULL,5,8,15,15,NULL),(11202,724,10,29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11203,724,11,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11204,724,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11205,724,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11206,724,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11207,724,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11208,724,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11209,725,1,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11210,725,2,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11211,725,3,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11212,725,4,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11213,725,5,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11214,725,6,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11215,725,7,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11216,725,8,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11217,725,9,NULL,NULL,NULL,NULL,NULL,NULL,9,7,12,14,NULL),(11218,725,10,31,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11219,725,11,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11220,725,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11221,725,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11222,725,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11223,725,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11224,725,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11225,726,1,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11226,726,2,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11227,726,3,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11228,726,4,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11229,726,5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11230,726,6,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11231,726,7,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11232,726,8,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11233,726,9,NULL,NULL,NULL,NULL,NULL,NULL,5,8,12,14,NULL),(11234,726,10,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11235,726,11,18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11236,726,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11237,726,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11238,726,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11239,726,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11240,726,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ScoreCardDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardKPI`
--

DROP TABLE IF EXISTS `ScoreCardKPI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardKPI` (
  `ScoreCardKPIID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScoreCardKPICategoryID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `DisplayOrder` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Code` varchar(255) NOT NULL,
  PRIMARY KEY (`ScoreCardKPIID`),
  UNIQUE KEY `Name` (`Name`,`ScoreCardKPICategoryID`),
  KEY `FK_ScoreCardKPI_Category` (`ScoreCardKPICategoryID`),
  CONSTRAINT `FK_ScoreCardKPI_Category` FOREIGN KEY (`ScoreCardKPICategoryID`) REFERENCES `ScoreCardKPICategory` (`ScoreCardKPICategoryID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardKPI`
--

LOCK TABLES `ScoreCardKPI` WRITE;
/*!40000 ALTER TABLE `ScoreCardKPI` DISABLE KEYS */;
INSERT INTO `ScoreCardKPI` VALUES (1,1,'DBB Sales Volume (million ctns)','DBB Sales Volume (million ctns)',1,'2013-08-17 07:43:13','2013-08-17 07:55:08','VB1'),(2,1,'IFT Sales Volume (million ctns)','IFT Sales Volume (million ctns)',2,'2013-08-17 07:55:28','2013-08-17 07:55:24','VB2'),(3,2,'# Distributors','# Distributors',3,'2013-08-17 07:56:08','2013-08-17 07:56:04','PT1'),(4,2,'# Sub Distributor','# Sub Distributor',4,'2013-08-17 07:56:30','2013-08-17 07:56:26','PT1'),(5,2,'Direct coverage (# outlet)','Direct coverage (# outlet)',5,'2013-08-17 07:56:55','2013-08-17 07:56:51','PT1'),(6,3,'S1- # Effective Calls','S1- # Effective Calls',6,'2013-08-17 07:57:23','2013-08-17 07:57:19','PT2'),(7,3,'S2 - No invoice > 10 SKUs','S2 - No invoice > 10 SKUs',7,'2013-08-17 07:57:43','2013-08-17 07:57:39','PT2'),(8,3,'S4 - Quality Display stores','S4 - Quality Display stores',8,'2013-08-17 07:58:03','2013-08-17 07:58:00','PT2'),(9,3,'WTD of power SKUs (pts)','WTD of power SKUs (pts)',9,'2013-08-17 07:58:21','2013-08-17 07:58:17','PT3'),(10,4,'# Standard Distributors','# Standard Distributors',10,'2013-08-17 07:58:49','2013-08-17 07:58:45','PT1'),(11,4,'# WCDC','# WCDC',11,'2013-08-17 07:59:05','2013-08-17 07:59:01','PT1'),(12,4,'% ROI','% ROI ',12,'2013-08-17 07:59:21','2013-08-17 07:59:17','PT1'),(13,5,'# SE','# SE',13,'2013-08-17 07:59:42','2013-09-20 01:26:20','BT'),(14,5,'# NVBH Qualified 4S','# NVBH Qualified 4S ',15,'2013-08-17 07:59:59','2013-09-20 01:26:36','BT'),(15,5,'# SE Qualified 4S','# SE Qualified 4S',16,'2013-08-17 08:00:13','2013-09-20 01:26:53','BT'),(16,5,'% SM Attrition rate','% Attrition rate',17,'2013-08-17 08:00:28','2013-09-20 01:27:08','BT'),(17,5,'# NVBH','# NVBH',14,'2013-09-20 01:27:36','2013-09-20 01:28:16','BT2');
/*!40000 ALTER TABLE `ScoreCardKPI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardKPICategory`
--

DROP TABLE IF EXISTS `ScoreCardKPICategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardKPICategory` (
  `ScoreCardKPICategoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `DisplayOrder` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ScoreCardKPICategoryID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardKPICategory`
--

LOCK TABLES `ScoreCardKPICategory` WRITE;
/*!40000 ALTER TABLE `ScoreCardKPICategory` DISABLE KEYS */;
INSERT INTO `ScoreCardKPICategory` VALUES (1,'Sales Out Volume','Sales Out Volume',1,'2013-08-17 07:25:58','2013-08-17 07:53:44'),(2,'Quality Coverage Expansion','Quality Coverage Expansion',2,'2013-08-17 07:26:17','2013-08-17 07:53:55'),(3,'Superior Instore Presence','Superior Instore Presence',3,'2013-08-17 07:26:30','2013-08-17 07:54:06'),(4,'Upgraded Distributor Operation','Upgraded Distributor Operation',4,'2013-08-17 07:54:21','2013-08-17 07:54:17'),(5,'Build word class capability for GT Sales Team','Build word class capability for GT Sales Team',5,'2013-08-17 07:54:33','2013-08-17 07:54:29');
/*!40000 ALTER TABLE `ScoreCardKPICategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardYear`
--

DROP TABLE IF EXISTS `ScoreCardYear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardYear` (
  `ScoreCardYearID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DistributorID` bigint(20) NOT NULL,
  `Year` int(11) DEFAULT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedBy` bigint(20) DEFAULT NULL,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ScoreCardYearID`),
  UNIQUE KEY `UQ_ScoreCardYear` (`DistributorID`,`Year`),
  CONSTRAINT `FK_ScoreCardYear_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardYear`
--

LOCK TABLES `ScoreCardYear` WRITE;
/*!40000 ALTER TABLE `ScoreCardYear` DISABLE KEYS */;
INSERT INTO `ScoreCardYear` VALUES (120,3617,2012,3037,'2012-04-03 07:16:07',3037,'2012-04-03 07:24:30');
/*!40000 ALTER TABLE `ScoreCardYear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScoreCardYearDetail`
--

DROP TABLE IF EXISTS `ScoreCardYearDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScoreCardYearDetail` (
  `ScoreCardYearDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScoreCardYearID` bigint(20) NOT NULL,
  `ScoreCardKPIID` bigint(20) NOT NULL,
  `Target` float DEFAULT NULL,
  `Result` float DEFAULT NULL,
  `TargetInvestment` float DEFAULT NULL,
  `TargetReturn` float DEFAULT NULL,
  `ResultInvestment` float DEFAULT NULL,
  `ResultReturn` float DEFAULT NULL,
  `Field1` float DEFAULT NULL COMMENT 'Friso in GT6/SE',
  `Field2` float DEFAULT NULL COMMENT 'DL IFT in GT6/NBH',
  `Field3` float DEFAULT NULL COMMENT 'RTDM in GT6 or Merchandisers',
  `Field4` float DEFAULT NULL COMMENT 'WTD of power SKUs (pts)',
  `TargetRolling` float DEFAULT NULL,
  PRIMARY KEY (`ScoreCardYearDetailID`),
  UNIQUE KEY `UQ_ScoreCardYearDetail` (`ScoreCardYearID`,`ScoreCardKPIID`),
  KEY `FK_ScoreCardYearDetail_KPI` (`ScoreCardKPIID`),
  CONSTRAINT `FK_ScoreCardYearDetail_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardYearDetail_Year` FOREIGN KEY (`ScoreCardYearID`) REFERENCES `ScoreCardYear` (`ScoreCardYearID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=865 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScoreCardYearDetail`
--

LOCK TABLES `ScoreCardYearDetail` WRITE;
/*!40000 ALTER TABLE `ScoreCardYearDetail` DISABLE KEYS */;
INSERT INTO `ScoreCardYearDetail` VALUES (849,120,1,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(850,120,2,215,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(851,120,3,254,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(852,120,4,215,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(853,120,5,125,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(854,120,6,254,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(855,120,7,154,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(856,120,8,154,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(857,120,9,NULL,NULL,NULL,NULL,NULL,NULL,145,154,150,130,NULL),(858,120,10,321,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(859,120,11,251,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(860,120,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(861,120,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(862,120,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(863,120,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(864,120,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ScoreCardYearDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Setting`
--

DROP TABLE IF EXISTS `Setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Setting` (
  `SettingID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(45) NOT NULL,
  `FieldValue` varchar(45) NOT NULL,
  `Label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SettingID`),
  UNIQUE KEY `FieldName_UNIQUE` (`FieldName`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Setting`
--

LOCK TABLES `Setting` WRITE;
/*!40000 ALTER TABLE `Setting` DISABLE KEYS */;
INSERT INTO `Setting` VALUES (1,'Password','123456',NULL),(2,'SE_SFD','18',NULL),(3,'dcdt.assessment.deadline.se','1-5',NULL),(4,'dcdt.assessment.deadline.asm','1-5',NULL),(5,'dcdt.assessment.deadline.rsm','1-5',NULL),(6,'dcdt.assessment.deadline.alert1','2',NULL),(7,'dcdt.assessment.deadline.alert2','4',NULL),(8,'dcdt.workingplan.fielddate.se','18',NULL),(9,'dcdt.workingplan.fielddate.asm','18',NULL),(10,'dcdt.workingplan.fielddate.rsm','18',NULL),(11,'dcdt.workingplan.deadline.plan.se','1-5',NULL),(12,'dcdt.workingplan.deadline.plan.asm','2-6',NULL),(13,'dcdt.workingplan.deadline.plan.rsm','3-7',NULL),(14,'dcdt.workingplan.deadline.report.se','1-5',NULL),(15,'dcdt.workingplan.deadline.report.asm','2-6',NULL),(16,'dcdt.workingplan.deadline.report.rsm','3-7',NULL),(17,'dcdt.workingplan.deadline.plan.alert1','4',NULL),(18,'dcdt.workingplan.deadline.plan.alert2','2',NULL),(19,'dcdt.workingplan.deadline.report.alert1','4',NULL),(20,'dcdt.workingplan.deadline.report.alert2','2',NULL),(21,'dcdt.scorecard.attrition.threshold','30',NULL);
/*!40000 ALTER TABLE `Setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Store`
--

DROP TABLE IF EXISTS `Store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Store` (
  `StoreID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(512) DEFAULT NULL,
  `RegionID` bigint(20) NOT NULL,
  `AccountID` bigint(20) NOT NULL,
  `GPSLatitude` float DEFAULT NULL,
  `GPSLongtitude` float DEFAULT NULL,
  PRIMARY KEY (`StoreID`),
  KEY `FK_Store_Region` (`RegionID`),
  KEY `FK_Store_Account` (`AccountID`),
  CONSTRAINT `FK_Store_Account` FOREIGN KEY (`AccountID`) REFERENCES `Account` (`AccountID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Store_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Store`
--

LOCK TABLES `Store` WRITE;
/*!40000 ALTER TABLE `Store` DISABLE KEYS */;
INSERT INTO `Store` VALUES (1,'10','TRUNG TÂM METRO CASH & CARRY AN PHÚ','Khu đô thị mới An Phú – An Khánh, P.An Phú, Q.2, Thành phố Hồ Chí Minh',1,3,NULL,NULL),(4,'11','TRUNG TÂM METRO CASH & CARRY BÌNH PHÚ','Khu dân cư Bình Phú, Phường 10 – 11, Quận 6, Thành phố Hồ Chí Minh',1,3,NULL,NULL),(5,'12','TRUNG TÂM METRO CASH & CARRY HIỆP PHÚ','Phường Tân Thới Hiệp, Quận 12, Thành phố Hồ Chí Minh',1,3,NULL,NULL);
/*!40000 ALTER TABLE `Store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreAuditPicture`
--

DROP TABLE IF EXISTS `StoreAuditPicture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreAuditPicture` (
  `StoreAuditPicture` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditResultID` bigint(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Path` varchar(255) NOT NULL,
  PRIMARY KEY (`StoreAuditPicture`),
  KEY `FK_StoreAuditPicture_OAR` (`StoreAuditResultID`),
  CONSTRAINT `FK_StoreAuditPicture_OAR` FOREIGN KEY (`StoreAuditResultID`) REFERENCES `StoreAuditResult` (`StoreAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreAuditPicture`
--

LOCK TABLES `StoreAuditPicture` WRITE;
/*!40000 ALTER TABLE `StoreAuditPicture` DISABLE KEYS */;
/*!40000 ALTER TABLE `StoreAuditPicture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreAuditResult`
--

DROP TABLE IF EXISTS `StoreAuditResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreAuditResult` (
  `StoreAuditResultID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreAuditTaskID` bigint(20) NOT NULL,
  `AuditedDate` datetime DEFAULT NULL,
  `SubmittedDate` datetime DEFAULT NULL,
  `GPSLatitude` float DEFAULT NULL,
  `GPSLongtitude` float DEFAULT NULL,
  PRIMARY KEY (`StoreAuditResultID`),
  KEY `FK_StoreAuditResult_AST` (`StoreAuditTaskID`),
  CONSTRAINT `FK_StoreAuditResult_AST` FOREIGN KEY (`StoreAuditTaskID`) REFERENCES `AuditorStoreTask` (`AuditorStoreTaskID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreAuditResult`
--

LOCK TABLES `StoreAuditResult` WRITE;
/*!40000 ALTER TABLE `StoreAuditResult` DISABLE KEYS */;
/*!40000 ALTER TABLE `StoreAuditResult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePOSM`
--

DROP TABLE IF EXISTS `StorePOSM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePOSM` (
  `StorePOSMID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Active` tinyint(4) DEFAULT NULL,
  `BrandGroupID` bigint(20) NOT NULL,
  PRIMARY KEY (`StorePOSMID`),
  UNIQUE KEY `DBBCode_UNIQUE` (`Code`),
  KEY `FK_StorePOSM_BrandGroup` (`BrandGroupID`),
  CONSTRAINT `FK_StorePOSM_BrandGroup` FOREIGN KEY (`BrandGroupID`) REFERENCES `BrandGroup` (`BrandGroupID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePOSM`
--

LOCK TABLES `StorePOSM` WRITE;
/*!40000 ALTER TABLE `StorePOSM` DISABLE KEYS */;
INSERT INTO `StorePOSM` VALUES (1,'DBB-TROL','Xe đẩy',0,2),(2,'IMP-TROL','Xe đẩy',0,1),(3,'DBB-HS','Khung trưng bày 1',0,2),(4,'IMP-HS','Khung trưng bày 1',0,1),(5,'DBB-GE','Đầu kệ',0,2),(6,'IMP-GE','Đầu kệ',0,1),(7,'DBB-CROS','Trưng bày tại ngành hàng khác',0,2),(8,'IMP-CROS','Trừng bày tại ngành hàng khác',0,1),(9,'DBB-TSD','Khung trưng bày 2',0,2),(10,'IMP-TSD','Khung trưng bày 2',0,1),(11,'DBB-WOB','Miếng quảng cáo',0,2),(12,'IMP-WOB','Miếng quảng cáo',0,1),(13,'DBB-ON SH','Khung trưng bày 3',0,2),(14,'IMP-ON SH','Khung trưng bày 3',0,1),(15,'DBB-LIG DIVI','Hộp đèn và vách ngăn kệ',0,2),(16,'IMP-LIH DIVI','Hộp đèn và vách ngăn kệ',0,1),(17,'DBB-SG','Cổng từ',0,2),(18,'IMP-SG','Cổng từ',0,1),(19,'KB-TB','Kệ trưng bày',1,1),(20,'KN-TB','Kệ trưng bày',1,2),(21,'KB-KTB','Khung Trưng Bày',1,1),(22,'KN-KTB','Khung Trưng Bày',1,2),(23,'KB-HTB','Hộp Trưng Bày',1,1),(26,'KN-HTB','Hộp Trưng Bày',1,2);
/*!40000 ALTER TABLE `StorePOSM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePOSMHistory`
--

DROP TABLE IF EXISTS `StorePOSMHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePOSMHistory` (
  `StorePOSMHistory` bigint(20) NOT NULL AUTO_INCREMENT,
  `StorePOSMID` bigint(20) NOT NULL,
  `Active` tinyint(4) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `ExpiredDate` datetime DEFAULT NULL,
  PRIMARY KEY (`StorePOSMHistory`),
  KEY `FK_StorePOSMHistory_POSM` (`StorePOSMID`),
  CONSTRAINT `FK_StorePOSMHistory_POSM` FOREIGN KEY (`StorePOSMID`) REFERENCES `StorePOSM` (`StorePOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePOSMHistory`
--

LOCK TABLES `StorePOSMHistory` WRITE;
/*!40000 ALTER TABLE `StorePOSMHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `StorePOSMHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePromotion`
--

DROP TABLE IF EXISTS `StorePromotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePromotion` (
  `StorePromotionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `StorePromotionTypeID` bigint(20) NOT NULL,
  `SOSBrandID` bigint(20) NOT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `ExpireDate` datetime DEFAULT NULL,
  `BuyQuantity` int(11) DEFAULT NULL,
  `BuyUnitID` bigint(20) NOT NULL,
  `BuyProduct` varchar(255) DEFAULT NULL,
  `GetQuantity` bigint(20) DEFAULT NULL,
  `GetUnitID` bigint(20) DEFAULT NULL,
  `StorePromotionProductID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`StorePromotionID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  KEY `FK_StorePromotion_BuyUnit` (`BuyUnitID`),
  KEY `FK_StorePromotion_GetUnit` (`GetUnitID`),
  KEY `FK_StorePromotion_GetProduct` (`StorePromotionProductID`),
  KEY `FK_StorePromotion_StorePromotionType` (`StorePromotionTypeID`),
  KEY `FK_StorePromotion_SOSBrand` (`SOSBrandID`),
  CONSTRAINT `FK_StorePromotion_BuyUnit` FOREIGN KEY (`BuyUnitID`) REFERENCES `Unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotion_GetProduct` FOREIGN KEY (`StorePromotionProductID`) REFERENCES `StorePromotionProduct` (`StorePromotionProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotion_GetUnit` FOREIGN KEY (`GetUnitID`) REFERENCES `Unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotion_SOSBrand` FOREIGN KEY (`SOSBrandID`) REFERENCES `SOSBrand` (`SOSBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotion_StorePromotionType` FOREIGN KEY (`StorePromotionTypeID`) REFERENCES `StorePromotionType` (`StorePromotionTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePromotion`
--

LOCK TABLES `StorePromotion` WRITE;
/*!40000 ALTER TABLE `StorePromotion` DISABLE KEYS */;
INSERT INTO `StorePromotion` VALUES (2,'001','KM Siêu Thị T7',3,1,'2012-07-19 00:00:00','2012-08-01 00:00:00',1,1,'Friso Gold',1,2,1);
/*!40000 ALTER TABLE `StorePromotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePromotionProduct`
--

DROP TABLE IF EXISTS `StorePromotionProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePromotionProduct` (
  `StorePromotionProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`StorePromotionProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePromotionProduct`
--

LOCK TABLES `StorePromotionProduct` WRITE;
/*!40000 ALTER TABLE `StorePromotionProduct` DISABLE KEYS */;
INSERT INTO `StorePromotionProduct` VALUES (1,'UHT 110ml'),(2,'Tô thủy tinh'),(3,'Phiếu QT 50.000đ của Co.op'),(4,'Gift Xe Đạp');
/*!40000 ALTER TABLE `StorePromotionProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePromotionProductToHandheld`
--

DROP TABLE IF EXISTS `StorePromotionProductToHandheld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePromotionProductToHandheld` (
  `StorePromotionProductToHandheldID` int(11) NOT NULL AUTO_INCREMENT,
  `StorePromotionID` bigint(20) NOT NULL,
  `StorePromotionProductID` bigint(20) NOT NULL,
  PRIMARY KEY (`StorePromotionProductToHandheldID`),
  UNIQUE KEY `UQ_StorePromotionProductToHandheld` (`StorePromotionID`,`StorePromotionProductID`),
  KEY `FK_StorePromotionProductToHandheld_StorePromotion` (`StorePromotionID`),
  KEY `FK_StorePromotionProductToHandheld_StorePromotionProduct` (`StorePromotionProductID`),
  CONSTRAINT `FK_StorePromotionProductToHandheld_StorePromotion` FOREIGN KEY (`StorePromotionID`) REFERENCES `StorePromotion` (`StorePromotionID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotionProductToHandheld_StorePromotionProduct` FOREIGN KEY (`StorePromotionProductID`) REFERENCES `StorePromotionProduct` (`StorePromotionProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePromotionProductToHandheld`
--

LOCK TABLES `StorePromotionProductToHandheld` WRITE;
/*!40000 ALTER TABLE `StorePromotionProductToHandheld` DISABLE KEYS */;
INSERT INTO `StorePromotionProductToHandheld` VALUES (28,2,1),(29,2,2),(30,2,3),(31,2,4);
/*!40000 ALTER TABLE `StorePromotionProductToHandheld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePromotionScope`
--

DROP TABLE IF EXISTS `StorePromotionScope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePromotionScope` (
  `StorePromotionScopeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StorePromotionID` bigint(20) NOT NULL,
  `AccountID` bigint(20) NOT NULL,
  PRIMARY KEY (`StorePromotionScopeID`),
  UNIQUE KEY `UQ_StorePromotionScope` (`StorePromotionID`,`AccountID`),
  KEY `FK_StorePromotionScope_StorePromotion` (`StorePromotionID`),
  KEY `FK_StorePromotionScope_Account` (`AccountID`),
  CONSTRAINT `FK_StorePromotionScope_Account` FOREIGN KEY (`AccountID`) REFERENCES `Account` (`AccountID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StorePromotionScope_StorePromotion` FOREIGN KEY (`StorePromotionID`) REFERENCES `StorePromotion` (`StorePromotionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePromotionScope`
--

LOCK TABLES `StorePromotionScope` WRITE;
/*!40000 ALTER TABLE `StorePromotionScope` DISABLE KEYS */;
INSERT INTO `StorePromotionScope` VALUES (10,2,3);
/*!40000 ALTER TABLE `StorePromotionScope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StorePromotionType`
--

DROP TABLE IF EXISTS `StorePromotionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StorePromotionType` (
  `StorePromotionTypeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) NOT NULL,
  PRIMARY KEY (`StorePromotionTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StorePromotionType`
--

LOCK TABLES `StorePromotionType` WRITE;
/*!40000 ALTER TABLE `StorePromotionType` DISABLE KEYS */;
INSERT INTO `StorePromotionType` VALUES (1,'Freegood'),(2,'GIFT'),(3,'Voucher'),(4,'Discount');
/*!40000 ALTER TABLE `StorePromotionType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreRegisterProduct`
--

DROP TABLE IF EXISTS `StoreRegisterProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreRegisterProduct` (
  `StoreRegisteredProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreID` bigint(20) NOT NULL,
  `ProductID` bigint(20) NOT NULL,
  PRIMARY KEY (`StoreRegisteredProductID`),
  UNIQUE KEY `UQ_StoreRegisteredProduct` (`StoreID`,`ProductID`),
  KEY `FK_StoreProduct_Store` (`StoreID`),
  KEY `FK_StoreProduct_Product` (`ProductID`),
  CONSTRAINT `FK_StoreProduct_Product` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StoreProduct_Store` FOREIGN KEY (`StoreID`) REFERENCES `Store` (`StoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreRegisterProduct`
--

LOCK TABLES `StoreRegisterProduct` WRITE;
/*!40000 ALTER TABLE `StoreRegisterProduct` DISABLE KEYS */;
INSERT INTO `StoreRegisterProduct` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60),(61,1,61),(62,1,62),(63,1,63),(64,1,64),(65,1,65),(66,1,66),(67,1,67),(68,1,68),(69,1,69),(70,1,70),(71,1,71),(72,1,72),(73,1,73),(74,1,74),(75,1,75),(76,1,76),(77,1,77),(78,1,78),(79,1,79),(80,1,80),(81,4,1),(82,4,2),(83,4,3),(84,4,4),(85,4,5),(86,4,6),(87,4,7),(88,4,8),(89,4,9),(90,4,10),(91,4,11),(92,4,12),(93,4,13),(94,4,14),(95,4,15),(96,4,16),(97,4,17),(98,4,18),(99,4,19),(100,4,20),(101,4,21),(102,4,22),(103,4,23),(104,4,24),(105,4,25),(106,4,26),(107,4,27),(108,4,28),(109,4,29),(110,4,30),(111,4,31),(112,4,32),(113,4,33),(114,4,34),(115,4,35),(116,4,36),(117,4,37),(118,4,38),(119,4,39),(120,4,40),(121,4,41),(122,4,42),(123,4,43),(124,4,44),(125,4,45),(126,4,46),(127,4,47),(128,4,48),(129,4,49),(130,4,50),(131,4,51),(132,4,52),(133,4,53),(134,4,54),(135,4,55),(136,4,56),(137,4,57),(138,4,58),(139,4,59),(140,4,60),(141,4,61),(142,4,62),(143,4,63),(144,4,64),(145,4,65),(146,4,66),(147,4,67),(148,4,68),(149,4,69),(150,4,70),(151,4,71),(152,4,72),(153,4,73),(154,4,74),(155,4,75),(156,4,76),(157,4,77),(158,4,78),(159,4,79),(160,4,80),(161,5,1),(162,5,2),(163,5,3),(164,5,4),(165,5,5),(166,5,6),(167,5,7),(168,5,8),(169,5,9),(170,5,10),(171,5,11),(172,5,12),(173,5,13),(174,5,14),(175,5,15),(176,5,16),(177,5,17),(178,5,18),(179,5,19),(180,5,20),(181,5,21),(182,5,22),(183,5,23),(184,5,24),(185,5,25),(186,5,26),(187,5,27),(188,5,28),(189,5,29),(190,5,30),(191,5,31),(192,5,32),(193,5,33),(194,5,34),(195,5,35),(196,5,36),(197,5,37),(198,5,38),(199,5,39),(200,5,40),(201,5,41),(202,5,42),(203,5,43),(204,5,44),(205,5,45),(206,5,46),(207,5,47),(208,5,48),(209,5,49),(210,5,50),(211,5,51),(212,5,52),(213,5,53),(214,5,54),(215,5,55),(216,5,56),(217,5,57),(218,5,58),(219,5,59),(220,5,60),(221,5,61),(222,5,62),(223,5,63),(224,5,64),(225,5,65),(226,5,66),(227,5,67),(228,5,68),(229,5,69),(230,5,70),(231,5,71),(232,5,72),(233,5,73),(234,5,74),(235,5,75),(236,5,76),(237,5,77),(238,5,78),(239,5,79),(240,5,80);
/*!40000 ALTER TABLE `StoreRegisterProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreSOSMaster`
--

DROP TABLE IF EXISTS `StoreSOSMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreSOSMaster` (
  `StoreSOSMasterID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreID` bigint(20) NOT NULL,
  `BrandGroupID` bigint(20) NOT NULL,
  `ShelfInMain` int(11) NOT NULL,
  `TrayInShelf` int(11) NOT NULL,
  `LengthOfTray` float NOT NULL,
  PRIMARY KEY (`StoreSOSMasterID`),
  UNIQUE KEY `UQ_StoreSOSMaster` (`StoreID`,`BrandGroupID`),
  KEY `FK_StoreSOSMaster_Store` (`StoreID`),
  KEY `FK_StoreSOSMaster_BrandGroup` (`BrandGroupID`),
  CONSTRAINT `FK_StoreSOSMaster_BrandGroup` FOREIGN KEY (`BrandGroupID`) REFERENCES `BrandGroup` (`BrandGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StoreSOSMaster_Store` FOREIGN KEY (`StoreID`) REFERENCES `Store` (`StoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreSOSMaster`
--

LOCK TABLES `StoreSOSMaster` WRITE;
/*!40000 ALTER TABLE `StoreSOSMaster` DISABLE KEYS */;
INSERT INTO `StoreSOSMaster` VALUES (1,1,1,7,4,2.66),(2,1,2,9,3,2.66),(3,4,1,7,4,2.66),(4,4,2,9,4,2.66),(5,5,1,7,4,2.66),(6,5,2,7,4,2.66);
/*!40000 ALTER TABLE `StoreSOSMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StudentAssignment`
--

DROP TABLE IF EXISTS `StudentAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StudentAssignment` (
  `StudentAssignmentID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AssignmentID` bigint(20) NOT NULL,
  `ClassRosterID` bigint(20) NOT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`StudentAssignmentID`),
  KEY `FK_StudentAssignment_ClassRoster` (`ClassRosterID`),
  KEY `FK_StudentAssignment_Assignment` (`AssignmentID`),
  CONSTRAINT `FK_StudentAssignment_ClassRoster` FOREIGN KEY (`ClassRosterID`) REFERENCES `ClassRoster` (`ClassRosterID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_StudentAssignment_Assignment` FOREIGN KEY (`AssignmentID`) REFERENCES `Assignment` (`AssignmentID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StudentAssignment`
--

LOCK TABLES `StudentAssignment` WRITE;
/*!40000 ALTER TABLE `StudentAssignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `StudentAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubFullRangeBrand`
--

DROP TABLE IF EXISTS `SubFullRangeBrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubFullRangeBrand` (
  `SubFullRangeBrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`SubFullRangeBrandID`),
  UNIQUE KEY `UQ_Name_FullrangeSKU` (`Name`),
  KEY `FK_SubBrand_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_SubBrand_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubFullRangeBrand`
--

LOCK TABLES `SubFullRangeBrand` WRITE;
/*!40000 ALTER TABLE `SubFullRangeBrand` DISABLE KEYS */;
INSERT INTO `SubFullRangeBrand` VALUES (1,'Friso Gold Mum',1,NULL),(2,'Friso Gold 1',1,NULL),(3,'Friso Gold 2',1,NULL),(4,'Friso Gold 3',1,NULL),(5,'Friso Gold 4',1,NULL),(6,'Friso Regular 1',1,NULL),(7,'Friso Regular 2',1,NULL),(8,'Friso Regular 3',1,NULL),(9,'Friso Regular 4',1,NULL),(10,'Dutch Lady Regular Step 1',2,NULL),(11,'Dutch Lady Regular Step 2',2,NULL),(12,'Dutch Lady Regular 123',2,NULL),(13,'Dutch Lady Regular 456',2,NULL),(14,'Dutch Lady Gold 1',2,NULL),(15,'Dutch Lady Gold 2',2,NULL),(16,'Dutch Lady Gold 123',2,NULL),(17,'Dutch Lady Gold 456',2,NULL),(18,'Dutch Lady Regular Mum',2,NULL),(19,'Dutch Lady Regular Step 1G',2,NULL),(20,'Dutch Lady Regular Step 2G',2,NULL),(21,'Dutch Lady Regular 123G',2,NULL),(22,'Dutch Lady Regular 456G',2,NULL),(23,'Dutch Lady Complete',2,NULL),(24,'DL UHT 180',3,NULL),(25,'DL UHT 110',3,NULL),(26,'Yomost 170',3,NULL),(27,'Yomost 110',3,NULL),(28,'DKY 110',3,NULL),(29,'Fristi',3,NULL),(30,'Sua Dac',3,NULL);
/*!40000 ALTER TABLE `SubFullRangeBrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TradeLevel`
--

DROP TABLE IF EXISTS `TradeLevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TradeLevel` (
  `TradeLevelID` bigint(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MinPerformance` tinyint(4) DEFAULT NULL,
  `Bonus` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`TradeLevelID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TradeLevel`
--

LOCK TABLES `TradeLevel` WRITE;
/*!40000 ALTER TABLE `TradeLevel` DISABLE KEYS */;
/*!40000 ALTER TABLE `TradeLevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Unit`
--

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Unit` (
  `UnitID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Unit` varchar(255) NOT NULL,
  PRIMARY KEY (`UnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unit`
--

LOCK TABLES `Unit` WRITE;
/*!40000 ALTER TABLE `Unit` DISABLE KEYS */;
INSERT INTO `Unit` VALUES (1,'Thùng'),(2,'Hộp/Lon'),(3,'VND');
/*!40000 ALTER TABLE `Unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `UserID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Fullname` varchar(255) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Status` int(11) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `AgentID` int(11) DEFAULT NULL,
  `Moderator` int(11) DEFAULT NULL,
  `LiveManagerID` bigint(20) DEFAULT NULL,
  `UserCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `UQ_UserCode` (`UserCode`),
  KEY `FK_User_Agent` (`AgentID`),
  KEY `FK_User_LiveManager` (`LiveManagerID`),
  CONSTRAINT `FK_User_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_User_LiveManager` FOREIGN KEY (`LiveManagerID`) REFERENCES `User` (`UserID`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'admin','FmMBvO967Ew=','Administrator','vien.nguyen@banvien.com',1,'AUDITOR',NULL,NULL,NULL,'BOSS01'),(3036,'0938','FmMBvO967Ew=','Lê Duy Minh','Minh.leduy@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'RSM001'),(3037,'dinhvandam','FmMBvO967Ew=','Đinh Văn Đạm','dam.dinhvan@frieslandcampina.com',1,'ASM',NULL,NULL,3036,'ASM001'),(3038,'1527','FmMBvO967Ew=','Phạm Xuân Ninh','ninh.phamxuan@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'1527'),(3040,'100153','FmMBvO967Ew=','BẢO KHÁNH','100153@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100153'),(3046,'100149','FmMBvO967Ew=','HƯNG THỊNH','100149@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100149'),(3051,'0523','FmMBvO967Ew=','Nguyễn Văn Đạt','dat.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'0523'),(3053,'100152','FmMBvO967Ew=','LIÊN HƯƠNG','100152@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100152'),(3056,'2652','FmMBvO967Ew=','Phạm Ánh Dương','duong.phamanh@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'2652'),(3058,'100156','FmMBvO967Ew=','PHƯƠNG LAN','100156@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100156'),(3066,'100151','FmMBvO967Ew=','TÂN HOÀNG PHÁT','100151@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100151'),(3069,'nguyenhuuthai','FmMBvO967Ew=','Nguyễn Hữu Thái','thai.nguyenhuu@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'SE007'),(3071,'100154','FmMBvO967Ew=','THÁI NHẬT HOA','100154@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100154'),(3076,'1475','FmMBvO967Ew=','Trần Văn Đoàn','doan.tranvan@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'1475'),(3078,'100148','FmMBvO967Ew=','TOÀN DƯƠNG','100148@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100148'),(3085,'1403','FmMBvO967Ew=','Nguyễn Văn Thắng','thang.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3037,'1403'),(3087,'100150','FmMBvO967Ew=','VÂN TRANG','100150@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100150'),(3093,'1825','FmMBvO967Ew=','Đỗ Minh Thắng ','thang.dominh@dutchlady.com.vn',1,'ASM',NULL,NULL,3036,'1825'),(3094,'2664','FmMBvO967Ew=','Lê Văn Lâm','lam.levan@dutchlady.com.vn',1,'SE',NULL,NULL,3093,'2664'),(3096,'100119','FmMBvO967Ew=','HẢI YẾN','100119@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100119'),(3103,'100116','FmMBvO967Ew=','HƯNG PHÁT','100116@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100116'),(3108,'2895','FmMBvO967Ew=','Nguyễn Thế Hùng','hung.nguyenthe@dutchlady.com.vn',1,'SE',NULL,NULL,3093,'2895'),(3110,'102612','FmMBvO967Ew=','Nam Thái','102612@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102612'),(3114,'2696','FmMBvO967Ew=','Nguyễn Mạnh Hùng','hung.nguyenmanh@dutchlady.com.vn',1,'SE',NULL,NULL,3093,'2696'),(3116,'100110','FmMBvO967Ew=','NGỌC SƠN','100110@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100110'),(3121,'2501','FmMBvO967Ew=','Đoàn Lê Linh','linh.doanle@dutchlady.com.vn',1,'SE',NULL,NULL,3093,'2501'),(3123,'100105','FmMBvO967Ew=','THÀNH ĐẠT','100105@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100105'),(3128,'1477','FmMBvO967Ew=','Mai Xuân Hải','hai.maixuan@dutchlady.com.vn',1,'SE',NULL,NULL,3093,'1477'),(3130,'100230','FmMBvO967Ew=','TÙNG HOA','100230@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100230'),(3133,'1713','FmMBvO967Ew=','Đồng Mạnh Hùng','hung.dongmanh@dutchlady.com.vn',1,'ASM',NULL,NULL,3036,'1713'),(3134,'2907','FmMBvO967Ew=','Giang Hoàng Hà ','ha.gianghoang@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'2907'),(3136,'100117','FmMBvO967Ew=','CHÂU HIỆP','100117@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100117'),(3143,'100101','FmMBvO967Ew=','ĐOÀN THỊ NGHI','100101@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100101'),(3145,'1181','FmMBvO967Ew=','Đoàn Quốc Thành','thanh.doanquoc@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'1181'),(3147,'100124','FmMBvO967Ew=','HẢI PHƯỢNG','100124@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100124'),(3153,'100103','FmMBvO967Ew=','HỒNG TƯ','100103@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100103'),(3157,'100120','FmMBvO967Ew=','HƯƠNG TOÀN','100120@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100120'),(3160,'1962','FmMBvO967Ew=','Kiều Quang Huy','huy.kieuquang@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'1962'),(3162,'100121','FmMBvO967Ew=','HỮU NGUYÊN','100121@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100121'),(3166,'3061','FmMBvO967Ew=','Đỗ Đình Xuân','xuan.dodinh@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'3061'),(3168,'100159','FmMBvO967Ew=','MAI LINH','100159@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100159'),(3171,'1860','FmMBvO967Ew=','Vũ Văn Quý','quy.vuvan@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'1860'),(3173,'100627','FmMBvO967Ew=','MINH LIÊN','100627@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100627'),(3177,'101819','FmMBvO967Ew=','NAM HẢI','101819@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101819'),(3180,'100157','FmMBvO967Ew=','NGÔ THANH CHI','100157@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100157'),(3182,'2791','FmMBvO967Ew=','Vũ Đình Toàn','toan.vudinh@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'2791'),(3184,'100115','FmMBvO967Ew=','NGUYỄN TIẾN LÂM','100115@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100115'),(3189,'100104','FmMBvO967Ew=','PHẠM THỊ MAI PHƯƠNG','100104@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100104'),(3191,'2790','FmMBvO967Ew=','Ngô Ngọc Sơn','son.ngongoc@dutchlady.com.vn',1,'SE',NULL,NULL,3133,'2790'),(3193,'100155','FmMBvO967Ew=','PHƯỢNG SÁNG','100155@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100155'),(3197,'nguyenthecuong','FmMBvO967Ew=','Nguyễn Thế Cường','cuong.nguyenthe@dutchlady.com.vn',1,'ASM',NULL,NULL,3036,'ASM004'),(3198,'1857','FmMBvO967Ew=','Nguyễn Đăng Tùng','tung.nguyendang@dutchlady.com.vn',1,'SE',NULL,NULL,3197,'1857'),(3200,'100100','FmMBvO967Ew=','DŨNG TIẾN','100100@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100100'),(3211,'2908','FmMBvO967Ew=','Trịnh Thị Thu Hương ','huong.trinhthithu@dutchlady.com.vn',1,'SE',NULL,NULL,3197,'2908'),(3213,'100158','FmMBvO967Ew=','HOA VIỆT','100158@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100158'),(3218,'100114','FmMBvO967Ew=','NGHĨA HƯNG','100114@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100114'),(3220,'2757','FmMBvO967Ew=','Nguyễn Hoài Giang','giang.nguyenhoai@dutchlady.com.vn',1,'SE',NULL,NULL,3197,'2757'),(3222,'100112','FmMBvO967Ew=','SINH PHƯỢNG','100112@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100112'),(3227,'2502','FmMBvO967Ew=','Dương Đại Thắng','thang.duongdai@dutchlady.com.vn',1,'SE',NULL,NULL,3197,'2502'),(3229,'100102','FmMBvO967Ew=','TOÀN THẮNG','100102@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100102'),(3238,'102723','FmMBvO967Ew=','Tuấn Linh Phúc Hải','102723@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102723'),(3240,'1714','FmMBvO967Ew=','Trần Viết Cường','cuong.tranviet@dutchlady.com.vn',1,'SE',NULL,NULL,3197,'1714'),(3242,'100111','FmMBvO967Ew=','XNB THĂNG LONG','100111@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100111'),(3246,'1182','FmMBvO967Ew=','Nguyễn Viết Thành','thanh.nguyenviet@dutchlady.com.vn',1,'ASM',NULL,NULL,3036,'1182'),(3247,'3082','FmMBvO967Ew=','Đoàn Văn Điệp','diep.doanvan@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'3082'),(3249,'102698','FmMBvO967Ew=','AN THUẬN PHÁT','102698@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102698'),(3256,'3081','FmMBvO967Ew=','Hỏa Trung Tuyến','Tuyen.Hoatrung@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'3081'),(3258,'102699','FmMBvO967Ew=','ĐÔNG TIẾN','102699@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102699'),(3263,'2941','FmMBvO967Ew=','Chu Văn Thái','thai.chuvan@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'2941'),(3265,'100109','FmMBvO967Ew=','HÙNG HOÀNG','100109@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100109'),(3269,'599','FmMBvO967Ew=','Phan Quốc Hùng','hung.phanquoc@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'599'),(3271,'100107','FmMBvO967Ew=','NAM LONG','100107@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100107'),(3277,'2758','FmMBvO967Ew=','Hoàng Văn Phong','phong.hoangvan@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'2758'),(3279,'100118','FmMBvO967Ew=','QUANG CƯỜNG','100118@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100118'),(3289,'2899','FmMBvO967Ew=','Trần Văn Mẫn ','man.tranvan@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'2899'),(3291,'100085','FmMBvO967Ew=','THỦY CHÂU','100085@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100085'),(3298,'2874','FmMBvO967Ew=','Nguyễn Tiến Triển','trien.nguyentien@dutchlady.com.vn',1,'SE',NULL,NULL,3246,'2874'),(3300,'100108','FmMBvO967Ew=','VÂN HÙNG','100108@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100108'),(3306,'0575','FmMBvO967Ew=','Đỗ Huy Đức','duc.dohuy@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'0575'),(3307,'0364','FmMBvO967Ew=','Ngô Mạnh Thắng','thang.ngomanh@dutchlady.com.vn',1,'ASM',NULL,NULL,3306,'0364'),(3308,'2760','FmMBvO967Ew=','Nguyễn Tiến Duẩn','duan.nguyentien@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2760'),(3310,'100122','FmMBvO967Ew=','BINH VINH','100122@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100122'),(3318,'2894','FmMBvO967Ew=','Trần Văn Chiển','chien.tranvan@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2894'),(3320,'101994','FmMBvO967Ew=','HO GUOM','101994@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101994'),(3327,'2281','FmMBvO967Ew=','Lê Trung Ngọc','ngoc.letrung@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2281'),(3329,'100142','FmMBvO967Ew=','HOANG LAM','100142@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100142'),(3336,'1724','FmMBvO967Ew=','Lê Trường Nam','nam.letruong@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'1724'),(3338,'100139','FmMBvO967Ew=','HUY PHUONG','100139@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100139'),(3347,'2125','FmMBvO967Ew=','Nguyễn Văn Hà','ha.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2125'),(3349,'100138','FmMBvO967Ew=','PT FOOD','100138@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100138'),(3358,'2770','FmMBvO967Ew=','Trần Quang Tùng','tung,tranquang@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2770'),(3360,'100144','FmMBvO967Ew=','TIN NGHIA 1','100144@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100144'),(3369,'2607','FmMBvO967Ew=','Ngô Thành Vinh','vinh.lethanh@dutchlady.com.vn',1,'SE',NULL,NULL,3307,'2607'),(3371,'101528','FmMBvO967Ew=','TIN NGHIA 2','101528@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101528'),(3382,'1473','FmMBvO967Ew=','Nguyễn Thế Đức ','duc.nguyenthe@dutchlady.com.vn',1,'ASM',NULL,NULL,3306,'1473'),(3383,'3154','FmMBvO967Ew=','Đỗ Đình Thịnh','thinh.dodinh@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'3154'),(3385,'100137','FmMBvO967Ew=','CUONG THINH','100137@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100137'),(3387,'2723','FmMBvO967Ew=','Nguyễn Mai Anh','anh.nguyenmai@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'2723'),(3389,'101767','FmMBvO967Ew=','HA PHUONG','101767@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101767'),(3400,'1572','FmMBvO967Ew=','Vũ Hoài Phương','phuong.vuhoai@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'1572'),(3402,'100147','FmMBvO967Ew=','LAN CHI 1','100147@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100147'),(3412,'2052','FmMBvO967Ew=','Trần Việt Hà','ha.tranviet@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'2052'),(3418,'2623','FmMBvO967Ew=','Hồ Anh Dũng','dung.hoanh@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'2623'),(3420,'101663','FmMBvO967Ew=','THIEN AN','101663@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101663'),(3427,'2651','FmMBvO967Ew=','Ng T Lệ Minh','minh.nguyenthile@dutchlady.com.vn',1,'SE',NULL,NULL,3382,'2651'),(3429,'100140','FmMBvO967Ew=','XNK','100140@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100140'),(3437,'2615','FmMBvO967Ew=','Trần Công Thành acting','thanh.trancong@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'2615'),(3438,'2020','FmMBvO967Ew=','Lê Huy Quang','quang.lehuy@dutchlady.com.vn',1,'ASM',NULL,NULL,3437,'2020'),(3439,'3159','FmMBvO967Ew=','Lê Minh Vương','Vuong.leminh@dutchlady.com.vn',1,'SE',NULL,NULL,3438,'3159'),(3441,'101297','FmMBvO967Ew=','CN Trần Trương','101297@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101297'),(3451,'2324','FmMBvO967Ew=','Lê Nhật Tân','tan.lenhat@dutchlady.com.vn',1,'SE',NULL,NULL,3438,'2324'),(3453,'100099','FmMBvO967Ew=','Đức Lợi','100099@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100099'),(3461,'2846','FmMBvO967Ew=','Phan Gia Hưng','hung.phangia@dutchlady.com.vn',1,'SE',NULL,NULL,3438,'2846'),(3463,'100097','FmMBvO967Ew=','Thành Lợi','100097@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100097'),(3473,'2807','FmMBvO967Ew=','Nguyễn Anh Tâm','tam.nguyenanh@dutchlady.com.vn',1,'SE',NULL,NULL,3438,'2807'),(3475,'100092','FmMBvO967Ew=','Tuấn Việt','100092@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100092'),(3485,'1193','FmMBvO967Ew=','Lê Quang Đức','duc.lequang@frieslandcampina.com',1,'ASM',NULL,NULL,3437,'1193'),(3486,'2139','FmMBvO967Ew=','Phạm Thái Dũng','dung.phamthai@dutchlady.com.vn',1,'SE',NULL,NULL,3485,'2139'),(3488,'101649','FmMBvO967Ew=','CN Quốc Phong ','101649@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101649'),(3492,'0601','FmMBvO967Ew=','Võ Trường Thành','thanh.votruong@duthlady.com.vn',1,'SE',NULL,NULL,3485,'0601'),(3494,'100078','FmMBvO967Ew=','Hoàng B́nh','100078@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100078'),(3501,'2593','FmMBvO967Ew=','Võ Ngọc Sơn','son.vongoc@dutchlady.com.vn',1,'SE',NULL,NULL,3485,'2593'),(3503,'100088','FmMBvO967Ew=','Nam Tiến','100088@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100088'),(3508,'2070','FmMBvO967Ew=','Võ Văn Dưỡng','Duong.vovan@dutchlady.com.vn',1,'SE',NULL,NULL,3485,'2070'),(3510,'100086','FmMBvO967Ew=','Quốc Phong 1','100086@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100086'),(3521,'2679','FmMBvO967Ew=','Lê Minh Đạt','dat.leminh@ducthlady.com.vn',1,'SE',NULL,NULL,3485,'2679'),(3523,'101721','FmMBvO967Ew=','Thành Hưng','101721@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101721'),(3528,'102673','FmMBvO967Ew=','Thien Phuc','102673@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102673'),(3531,'1859','FmMBvO967Ew=','Võ Văn Dũng','dung.vovan@dutchlady.com.vn',1,'SE',NULL,NULL,3485,'1859'),(3533,'100079','FmMBvO967Ew=','Trung Tín','100079@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100079'),(3536,'3064','FmMBvO967Ew=','Võ Quang Vũ','vu.voquang@dutchlady.com.vn',1,'SE',NULL,NULL,3485,'3064'),(3538,'100091','FmMBvO967Ew=','Vạn Phúc','100091@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100091'),(3544,'1656','FmMBvO967Ew=','Trần Văn Giác','giac.tranvan@frieslandcampina.com',1,'ASM',NULL,NULL,3544,'1656'),(3545,'1912','FmMBvO967Ew=','Nguyễn Hữu Hải','hai.nguyenhuu@dutchlady.com.vn',1,'SE',NULL,NULL,3544,'1912'),(3547,'100018','FmMBvO967Ew=','Hạnh Đức 1','100018@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100018'),(3552,'2037','FmMBvO967Ew=','Hoàng Xuân Tú','tu.hoangxuan@dutchlady.com.vn',1,'SE',NULL,NULL,3544,'2037'),(3561,'1738','FmMBvO967Ew=','Nguyễn Linh','linh.nguyen@dutchlady.com.vn',1,'SE',NULL,NULL,3544,'1738'),(3563,'102704','FmMBvO967Ew=','Hoàng Yên','102704@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102704'),(3568,'100084','FmMBvO967Ew=','Hùng Nhân','100084@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100084'),(3574,'2060','FmMBvO967Ew=','Nguyễn Chí Tâm','tam.nguyenchi@dutchlady.com.vn',1,'SE',NULL,NULL,3544,'2060'),(3576,'101750','FmMBvO967Ew=','Kim Tấn Tài','101750@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101750'),(3581,'1488','FmMBvO967Ew=','Nguyễn Văn Yên','yen.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3544,'1488'),(3583,'100083','FmMBvO967Ew=','Nguyên Thành','100083@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100083'),(3586,'102727','FmMBvO967Ew=','Ninh Uyên','102727@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102727'),(3589,'100090','FmMBvO967Ew=','Pacific','100090@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100090'),(3592,'0817','FmMBvO967Ew=','Trịnh Thanh Thảo','thao.trinhthanh@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'0817'),(3593,'0552','FmMBvO967Ew=','Hồ Sỹ Thái','thai.hosy@dutchlady.com.vn',1,'ASM',NULL,NULL,3592,'0552'),(3595,'100015','FmMBvO967Ew=','Hoàng Hà','100015@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100015'),(3597,'2947','FmMBvO967Ew=','Võ Văn Quyền','quyen.vovan@dutchlady.com.vn',1,'SE',NULL,NULL,3593,'2947'),(3599,'100014','FmMBvO967Ew=','Hữu Toàn','100014@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100014'),(3603,'1051','FmMBvO967Ew=','Lê Hoài Nam','nam.lehoai@dutchlady.com.vn',1,'SE',NULL,NULL,3593,'1051'),(3605,'100003','FmMBvO967Ew=','Phương Ánh','100003@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100003'),(3613,'102714','FmMBvO967Ew=','Phương Ánh 3','102714@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102714'),(3617,'102434','FmMBvO967Ew=','Thành Nghĩa Thịnh','102434@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102434'),(3623,'0988','FmMBvO967Ew=','Nguyễn Đỗ Thanh Trúc','truc.nguyendothanh@dutchlady.com.vn',1,'SE',NULL,NULL,3593,'0988'),(3625,'100013','FmMBvO967Ew=','Trung Yến Hưng','100013@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100013'),(3632,'1086','FmMBvO967Ew=','Nguyễn Tấn Huy','huy.nguyentan@dutchlady.com.vn',1,'ASM',NULL,NULL,3592,'1086'),(3634,'100029','FmMBvO967Ew=','Hiệp Thành','100029@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100029'),(3643,'623','FmMBvO967Ew=','Nguyễn Thị Kim Loan','loan.nguyenthikim@dutchlady.com.vn',1,'SE',NULL,NULL,3632,'623'),(3645,'100027','FmMBvO967Ew=','Phượng Định','100027@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100027'),(3651,'2885','FmMBvO967Ew=','Nguyễn Huy Cường','cuong.nguyenhuy@dutchlady.com.vn',1,'SE',NULL,NULL,3632,'2885'),(3653,'100025','FmMBvO967Ew=','Quăng Thái 1','100025@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100025'),(3658,'2922','FmMBvO967Ew=','Nguyễn Hùng Cường','cuong.nguyenhung@dutchlady.com.vn',1,'SE',NULL,NULL,3632,'2922'),(3663,'0743','FmMBvO967Ew=','Cao Thị Nguyệt Ánh','anh.caothinguyet@dutchlady.com.vn',1,'SE',NULL,NULL,3632,'0743'),(3665,'100026','FmMBvO967Ew=','Tâm Đan','100026@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100026'),(3670,'1244','FmMBvO967Ew=','Nguyễn Thế Công','cong.nguyenthe@dutchlady.com.vn',1,'SE',NULL,NULL,3632,'1244'),(3672,'100028','FmMBvO967Ew=','Tân Bảo An','100028@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100028'),(3677,'0875','FmMBvO967Ew=','Trần Kim Toàn','toan.trankim@dutchlady.com.vn',1,'ASM',NULL,NULL,3592,'0875'),(3678,'2905','FmMBvO967Ew=','Đoàn Đức Kiên','kien.doanduc@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2905'),(3680,'102715','FmMBvO967Ew=','Anh Quân','102715@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102715'),(3684,'1278','FmMBvO967Ew=','Võ Phước Đức','duc.vophuoc@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'1278'),(3686,'100008','FmMBvO967Ew=','Hữu Lâm','100008@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100008'),(3692,'2736','FmMBvO967Ew=','Nguyễn Hồng Huy','huy.nguyenhong@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2736'),(3694,'100009','FmMBvO967Ew=','Huỳnh Thanh Sơn','100009@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100009'),(3698,'2194','FmMBvO967Ew=','Dương Văn Thường','thuong.duongvan@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2194'),(3700,'101752','FmMBvO967Ew=','NGỌC OANH','101752@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101752'),(3704,'2923','FmMBvO967Ew=','Lê Hoài Hoan','hoan.lehoai@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2923'),(3706,'102688','FmMBvO967Ew=','Nguyễn Hùng ','102688@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102688'),(3711,'2938','FmMBvO967Ew=','Nguyễn Đăng Quyền','quyen.nguyendang@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2938'),(3713,'101871','FmMBvO967Ew=','Phương Ánh 2','101871@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101871'),(3718,'2352','FmMBvO967Ew=','Nguyễn Quốc Thiện','thien.nguyenquoc@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'2352'),(3720,'101503','FmMBvO967Ew=','Thành Bước BL','101503@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101503'),(3725,'1647','FmMBvO967Ew=','Dương Thanh Thoại','thoai.duongthanh@dutchlady.com.vn',1,'SE',NULL,NULL,3677,'1647'),(3731,'101728','FmMBvO967Ew=','Vĩnh Phước 1','101728@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101728'),(3735,'1292','FmMBvO967Ew=','Vĩnh Bính','binh.vinh@dutchlady.com.vn',1,'ASM',NULL,NULL,3592,'1292'),(3737,'100790','FmMBvO967Ew=','Bắc Hà','100790@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100790'),(3745,'1581','FmMBvO967Ew=','Trần Văn Bằng','bang.tranvan@dutchlady.com.vn',1,'SE',NULL,NULL,3735,'1581'),(3747,'100022','FmMBvO967Ew=','Hạnh Huyền','100022@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100022'),(3757,'2896','FmMBvO967Ew=','Đào Đức Quốc ','quoc.daoduc@dutchlady.com.vn',1,'SE',NULL,NULL,3735,'2896'),(3759,'100024','FmMBvO967Ew=','KHÔI KHUYÊN','100024@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100024'),(3764,'2966','FmMBvO967Ew=','Trần Thị Cẩm Nhung','nhung.tranthicam@dutchlady.com.vn',1,'SE',NULL,NULL,3735,'2966'),(3766,'100019','FmMBvO967Ew=','Lâm Thuận 1','100019@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100019'),(3774,'1855','FmMBvO967Ew=','Nguyễn Văn Bình','binh.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3735,'1855'),(3783,'2921','FmMBvO967Ew=','Nguyễn Hoài Ân','an.nguyenhoai@dutchlady.com.vn',1,'SE',NULL,NULL,3735,'2921'),(3785,'102614','FmMBvO967Ew=','Lâm Thuận 3','102614@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102614'),(3790,'nguyenvietha','FmMBvO967Ew=','Nguyễn Việt Hà','ha.nguyenviet@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'1493'),(3791,'1013','FmMBvO967Ew=','Nguyễn Bảo Quốc','quoc.nguyenbao@dutchlady.com.vn',1,'ASM',NULL,NULL,3790,'1013'),(3792,'1710','FmMBvO967Ew=','Vương Hữu Lâm','lam.vuonghuu@dutchlady.com.vn',1,'SE',NULL,NULL,3791,'1710'),(3794,'100073','FmMBvO967Ew=','Hoàng Phong 01','100073@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100073'),(3807,'2658','FmMBvO967Ew=','Cổ Thị Mai Thảo','thao.cothimai@dutchlady.com.vn',1,'SE',NULL,NULL,3791,'2658'),(3814,'2421','FmMBvO967Ew=','Hàng Trừu Bình','binh.hangtruu@dutchlady.com.vn',1,'SE',NULL,NULL,3791,'2421'),(3816,'100070','FmMBvO967Ew=','Hồng Lĩnh 01','100070@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100070'),(3821,'1471','FmMBvO967Ew=','Danh Quốc Hùng','hung.danhquoc@dutchlady.com.vn',1,'SE',NULL,NULL,3791,'1471'),(3833,'100075','FmMBvO967Ew=','Hùng Quyên','100075@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100075'),(3840,'1568','FmMBvO967Ew=','Đỗ Thanh Việt','viet.dothanh@dutchlady.com.vn',1,'SE',NULL,NULL,3791,'1568'),(3842,'100063','FmMBvO967Ew=','NGỌC NHI','100063@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100063'),(3847,'1723','FmMBvO967Ew=','Tạ Thanh Tuấn','tuan.tathanh@frieslandcampina.com',1,'ASM',NULL,NULL,3790,'1723'),(3848,'1168','FmMBvO967Ew=','Trần Nguyễn Trí Đức','duc.trannguyentri@dutchlady.com.vn',1,'SE',NULL,NULL,3847,'1168'),(3850,'100062','FmMBvO967Ew=','Chín Nguyện','100062@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100062'),(3859,'0612','FmMBvO967Ew=','Trần Cao Nhựt','nhut.trancao@dutchlady.com.vn',1,'SE',NULL,NULL,3847,'0612'),(3861,'100057','FmMBvO967Ew=','Duyệt Hỷ','100057@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100057'),(3870,'2467','FmMBvO967Ew=','Phan Phú Đáng','dang.phanphu@dutchlady.com.vn',1,'SE',NULL,NULL,3847,'2467'),(3872,'100242','FmMBvO967Ew=','Nhất Trí Khang ','100242@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100242'),(3881,'0618','FmMBvO967Ew=','Nguyễn Thành Nam','nam.nguyenthanh@dutchlady.com.vn',1,'SE',NULL,NULL,3847,'0618'),(3883,'100059','FmMBvO967Ew=','Thảo Vy ','100059@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100059'),(3893,'2632','FmMBvO967Ew=','Cao Anh Kiệt','kiet.caoanh@dutchlady.com.vn',1,'SE',NULL,NULL,3847,'2632'),(3895,'100072','FmMBvO967Ew=','Trí Tín 01','100072@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100072'),(3910,'0250','FmMBvO967Ew=','Trần Chí Dũng','dung.tranchi@dutchlady.com.vn',1,'ASM',NULL,NULL,3790,'0250'),(3911,'0800','FmMBvO967Ew=','Lê Minh Mẫn','man.leminh@dutchlady.com.vn',1,'SE',NULL,NULL,3910,'0800'),(3913,'100523','FmMBvO967Ew=','Lâm Kim Loan 01','100523@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100523'),(3921,'0431','FmMBvO967Ew=','Hồ Tấn Phước','phuoc.hotan@dutchlady.com.vn',1,'SE',NULL,NULL,3910,'0431'),(3923,'100058','FmMBvO967Ew=','Nam Trung ','100058@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100058'),(3929,'1225','FmMBvO967Ew=','Pham Tri Hung','hung.phamtri@dutchlady.com.vn',1,'SE',NULL,NULL,3910,'1225'),(3931,'100064','FmMBvO967Ew=','Ngọc Duy ','100064@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100064'),(3938,'485','FmMBvO967Ew=','Ho Ngoc Lynh ','lynh.hongoc@dutchlady.com.vn',1,'SE',NULL,NULL,3910,'485'),(3940,'102716','FmMBvO967Ew=','Toàn Đức PH 1','102716@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102716'),(3943,'vominhhung','FmMBvO967Ew=','Võ Minh Hùng','hung.vominh@dutchlady.com.vn',1,'ASM',NULL,NULL,3790,'0021'),(3944,'2405','FmMBvO967Ew=','Nguyen Van Tam','tam.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'2405'),(3950,'1382','FmMBvO967Ew=','Lê Duy Quang','quang.leduy@dutchlady.com.vn',1,'SE',NULL,NULL,3910,'1382'),(3952,'102368','FmMBvO967Ew=','Vương Hà Phát','102368@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102368'),(3961,'ledangkhoa','FmMBvO967Ew=','Lê Đăng Khoa','khoa.ledang@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'0286'),(3963,'hongtrinh','FmMBvO967Ew=','Hồng Trinh','100071@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100071'),(3986,'luongthanhtuan','FmMBvO967Ew=','Lương Thanh Tuấn','tuan.luongthanh@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'1014'),(3988,'minhnguyet','FmMBvO967Ew=','Minh Nguyệt 02','100061@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100061'),(3998,'vodinhhoan','FmMBvO967Ew=','Võ Đình Hoan','hoan.vodinh@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'SE006'),(4000,'tanphuc','FmMBvO967Ew=','Tấn Phúc','truongminhtan1989@gmail.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100069'),(4008,'buiconglyem','FmMBvO967Ew=','Bùi Công Lý Em','e.buicongly@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'1170'),(4010,'thanhnga','FmMBvO967Ew=','Thanh Nga','tan.truong@banvien.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100060'),(4018,'0254','FmMBvO967Ew=','La Thanh Phú','phu.lathanh@frieslandcampina.com',1,'RSM',NULL,NULL,NULL,'0254'),(4019,'2137','FmMBvO967Ew=','Kha Ngọc Lộc','loc.khangoc@dutchlady.com.vn',1,'ASM',NULL,NULL,4018,'2137'),(4020,'2304','FmMBvO967Ew=','Nguyễn Văn Của','cua.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'2304'),(4022,'102464','FmMBvO967Ew=','Á Châu','102464@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102464'),(4030,'2663','FmMBvO967Ew=','Chiêm Thành Ất','at.chiemthanh@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'2663'),(4032,'100049','FmMBvO967Ew=','ĐẠI THÀNH PHÁT','100049@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100049'),(4043,'1750','FmMBvO967Ew=','Nguyễn Văn Hữu','huu.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'1750'),(4045,'102694','FmMBvO967Ew=','Hoàng Bửu','102694@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102694'),(4048,'2078','FmMBvO967Ew=','Ngũ Thế Khương','khuong.nguthe@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'2078'),(4050,'100036','FmMBvO967Ew=','NAM SƯƠNG','100036@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100036'),(4057,'1166','FmMBvO967Ew=','Trần Thành Thắm','tham.tranthanh@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'1166'),(4059,'102603','FmMBvO967Ew=','Ngọc Thu','102603@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102603'),(4067,'100271','FmMBvO967Ew=','Phát Đạt','100271@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100271'),(4072,'985','FmMBvO967Ew=','Phạm Văn Thắng','thang.phamvan@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'985'),(4074,'101201','FmMBvO967Ew=','TDK','101201@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101201'),(4083,'1858','FmMBvO967Ew=','Trịnh Thanh Thắng','thang.trinhthanh@dutchlady.com.vn',1,'SE',NULL,NULL,4019,'1858'),(4085,'100033','FmMBvO967Ew=','Trần Phong','100033@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100033'),(4092,'2406','FmMBvO967Ew=','Nguyễn Hòang Hiệp-Acting','hiep.nguyenhoang@dutchlady.com.vn',1,'ASM',NULL,NULL,4018,'2406'),(4093,'2799','FmMBvO967Ew=','Vưu Chí Vẹn','ven.vuuchi@dutchlady.com.vn',1,'SE',NULL,NULL,4092,'2799'),(4095,'100031','FmMBvO967Ew=','Hiệp Phong','100031@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100031'),(4102,'2684','FmMBvO967Ew=','Nguyễn Khắc Huy','huy.nguyenkhac@dutchlady.com.vn',1,'SE',NULL,NULL,4092,'2684'),(4104,'102601','FmMBvO967Ew=','Hồng Hải Ngân','102601@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102601'),(4107,'1748','FmMBvO967Ew=','Lê Thanh Toàn','toan.lethanh@dutchlady.com.vn',1,'SE',NULL,NULL,4092,'1748'),(4109,'100040','FmMBvO967Ew=','HƯNG HÒA','100040@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100040'),(4114,'2685','FmMBvO967Ew=','Diệp Minh Trí','tri.diepminh@dutchlady.com.vn',1,'SE',NULL,NULL,4092,'2685'),(4116,'100030','FmMBvO967Ew=','MAI HƯNG','100030@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100030'),(4128,'102534','FmMBvO967Ew=','PHUOC HIEP','102534@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102534'),(4133,'101769','FmMBvO967Ew=','Tân Thế Phát','101769@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101769'),(4143,'101779','FmMBvO967Ew=','THÁI PHONG','101779@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'101779'),(4146,'643','FmMBvO967Ew=','Phạm Minh Trí','tri.phamminh@dutchlady.com.vn',1,'ASM',NULL,NULL,4018,'643'),(4147,'1985','FmMBvO967Ew=','Lê Tường Ân','an.letuong@dutchlady.com.vn',1,'SE',NULL,NULL,4146,'1985'),(4149,'100054','FmMBvO967Ew=','Đức Hòa','100054@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100054'),(4157,'2603','FmMBvO967Ew=','Nguyễn Quốc Thái','thai.nguyenquoc@dutchlady.com.vn',1,'SE',NULL,NULL,4146,'2603'),(4159,'100042','FmMBvO967Ew=','Khoa Nam','100042@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100042'),(4165,'2027','FmMBvO967Ew=','Huỳnh Minh Khanh','khanh.huynhminh@dutchlady.com.vn',1,'SE',NULL,NULL,4146,'2027'),(4167,'100035','FmMBvO967Ew=','Lương Thái Cường','100035@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100035'),(4173,'102683','FmMBvO967Ew=','Nam Hồng','102683@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102683'),(4177,'887','FmMBvO967Ew=','La Văn Phú Ngọc','ngoc.lavanphu@dutchlady.com.vn',1,'SE',NULL,NULL,4146,'887'),(4179,'100055','FmMBvO967Ew=','Ngọc Phượng','100055@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100055'),(4191,'100034','FmMBvO967Ew=','Quang Minh','100034@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100034'),(4199,'2036','FmMBvO967Ew=','Đinh Công Tạo','tao.dinhcong@dutchlady.com.vn',1,'SE',NULL,NULL,4146,'2036'),(4201,'102064','FmMBvO967Ew=','Tân Bảo Phương','102064@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102064'),(4207,'102543','FmMBvO967Ew=','Thanh Thanh Tân','102543@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102543'),(4213,'1516','FmMBvO967Ew=','Vũ Văn Tuyên','tuyen.vuvan@dutchlady.com.vn',1,'ASM',NULL,NULL,4018,'1516'),(4214,'1023','FmMBvO967Ew=','Nguyễn Văn Luận','luan.nguyenvan@dutchlady.com.vn',1,'SE',NULL,NULL,4213,'1023'),(4216,'100048','FmMBvO967Ew=','CH KIM CHUNG','100048@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100048'),(4219,'100046','FmMBvO967Ew=','CH Số 3','100046@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100046'),(4228,'1830','FmMBvO967Ew=','Phan Thanh Vũ ','vu.phanthanh@dutchlady.com.vn',1,'SE',NULL,NULL,4213,'1830'),(4230,'100052','FmMBvO967Ew=','LAN QUÍ','100052@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100052'),(4234,'Sales Master - chưa có code','FmMBvO967Ew=','Lưu Hưng CHương','chuong.luuhung@dutchlady.com.vn',1,'SE',NULL,NULL,4213,'Sales Master - chưa có code'),(4236,'100050','FmMBvO967Ew=','My Loan ','100050@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100050'),(4244,'1499','FmMBvO967Ew=','Nguyễn Phước Tuấn','tuan.nguyenphuoc@dutchlady.com.vn',1,'SE',NULL,NULL,4213,'1499'),(4246,'100051','FmMBvO967Ew=','Ngọc Giàu','100051@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'100051'),(4256,'102602','FmMBvO967Ew=','Nguyễn Phước Chung','102602@frieslandcampina.com',1,'DISTRIBUTOR',NULL,NULL,NULL,'102602'),(4264,'KIPS001','FmMBvO967Ew=','Nguyễn Đình Quảng','KIPS001@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KIPS001'),(4265,'KIPS002','FmMBvO967Ew=','Nguyễn Văn Cảnh','KIPS002@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KIPS002'),(4266,'KIPS003','FmMBvO967Ew=','Nguyễn Văn Dũng','KIPS003@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KIPS003'),(4267,'KIPS004','FmMBvO967Ew=','Phan Văn Chương','KIPS004@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KIPS004'),(4268,'KIPS006','FmMBvO967Ew=','Nguyễn Văn Thông','KIPS006@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KIPS006'),(4269,'KNPS001','FmMBvO967Ew=','Phạm Thị Thu Hiền','KNPS001@frieslandcampina.com',1,'SM',NULL,NULL,3051,'KNPS001'),(4270,'KNPS002','FmMBvO967Ew=','Bùi Duy Nam','KNPS002@frieslandcampina.com',1,'SM',NULL,NULL,3051,'KNPS002'),(4271,'KNPS003','FmMBvO967Ew=','Nguyễn Văn Việt','KNPS003@frieslandcampina.com',1,'SM',NULL,NULL,3051,'KNPS003'),(4272,'KOPS001','FmMBvO967Ew=','Đặng Văn Phong','KOPS001@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS001'),(4273,'KOPS002','FmMBvO967Ew=','Nguyễn Thị Vinh','KOPS002@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS002'),(4274,'KOPS003','FmMBvO967Ew=','Phạm Văn Tuyến','KOPS003@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS003'),(4275,'KOPS004','FmMBvO967Ew=','Nguyễn Văn Giang','KOPS004@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS004'),(4276,'KOPS005','FmMBvO967Ew=','Đỗ Văn Đoàn','KOPS005@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS005'),(4277,'KOPS006','FmMBvO967Ew=','Hoàng Thị Bích Phượng','KOPS006@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS006'),(4278,'KOPS007','FmMBvO967Ew=','Nguyễn Duy Hiếu','KOPS007@frieslandcampina.com',1,'SM',NULL,NULL,3056,'KOPS007'),(4279,'KMPS001','FmMBvO967Ew=','Trần Trọng Thanh','KMPS001@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KMPS001'),(4280,'KMPS002','FmMBvO967Ew=','Nguyễn Văn Phương','KMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KMPS002'),(4281,'KMPS003','FmMBvO967Ew=','Phạm Thị Gịu','KMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3037,'KMPS003'),(4282,'KKPS001','FmMBvO967Ew=','Phạm Tuân','KKPS001@frieslandcampina.com',1,'SM',NULL,NULL,3069,'KKPS001'),(4283,'KKPS003','FmMBvO967Ew=',' Đào Văn Lượng ','KKPS003@frieslandcampina.com',1,'SM',NULL,NULL,3069,'KKPS003'),(4284,'KKPS004','FmMBvO967Ew=','Nguyễn Thị Thu Trang','KKPS004@frieslandcampina.com',1,'SM',NULL,NULL,3069,'KKPS004'),(4285,'KKPS005','FmMBvO967Ew=','Nguyễn Văn Hiếu','KKPS005@frieslandcampina.com',1,'SM',NULL,NULL,3069,'KKPS005'),(4286,'KKPS007','FmMBvO967Ew=','Đào Văn Tư','KKPS007@frieslandcampina.com',1,'SM',NULL,NULL,3069,'KKPS007'),(4287,'KHPS001','FmMBvO967Ew=','Nguyễn Quang Hưng','KHPS001@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS001'),(4288,'KHPS002','FmMBvO967Ew=','Nguyễn Đình Chỉnh','KHPS002@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS002'),(4289,'KHPS003','FmMBvO967Ew=','Bùi Văn Tuấn','KHPS003@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS003'),(4290,'KHPS004','FmMBvO967Ew=','Vũ Văn Hạnh','KHPS004@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS004'),(4291,'KHPS005','FmMBvO967Ew=','Đinh Tuấn Giang','KHPS005@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS005'),(4292,'KHPS006','FmMBvO967Ew=','Phạm Gia Võ','KHPS006@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS006'),(4293,'KHPS007','FmMBvO967Ew=','Ngô Quang Khải','KHPS007@frieslandcampina.com',1,'SM',NULL,NULL,3076,'KHPS007'),(4294,'KJPS001','FmMBvO967Ew=','Nguyễn Thị Thu Hà','KJPS001@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS001'),(4295,'KJPS002','FmMBvO967Ew=','Bùi Thế Hùng','KJPS002@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS002'),(4296,'KJPS003','FmMBvO967Ew=','Phạm Văn Hiếu','KJPS003@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS003'),(4297,'KJPS004','FmMBvO967Ew=','Nguyễn Đình Cương','KJPS004@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS004'),(4298,'KJPS005','FmMBvO967Ew=','Nguyễn Văn Thắng','KJPS005@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS005'),(4299,'KJPS007','FmMBvO967Ew=','Nguyễn văn Chiến','KJPS007@frieslandcampina.com',1,'SM',NULL,NULL,3085,'KJPS007'),(4300,'KTPS001','FmMBvO967Ew=','Đinh Thị Vân','KTPS001@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS001'),(4301,'KTPS002','FmMBvO967Ew=','Hồ Thị Nga','KTPS002@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS002'),(4302,'KTPS003','FmMBvO967Ew=','Phạm Hữu Nguyên','KTPS003@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS003'),(4303,'KTPS004','FmMBvO967Ew=','Nguyễn Thanh Bình','KTPS004@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS004'),(4304,'KTPS005','FmMBvO967Ew=','Nguyễn Thị Ngọc Mến','KTPS005@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS005'),(4305,'KTPS007','FmMBvO967Ew=','Lê Văn Thảo','KTPS007@frieslandcampina.com',1,'SM',NULL,NULL,3094,'KTPS007'),(4306,'KYPS001','FmMBvO967Ew=','Đào Đình Duyên','KYPS001@frieslandcampina.com',1,'SM',NULL,NULL,3093,'KYPS001'),(4307,'KYPS002','FmMBvO967Ew=','Nguyễn Thị Huyền','KYPS002@frieslandcampina.com',1,'SM',NULL,NULL,3093,'KYPS002'),(4308,'KYPS003','FmMBvO967Ew=','Lại Văn Đô','KYPS003@frieslandcampina.com',1,'SM',NULL,NULL,3093,'KYPS003'),(4309,'KYPS006','FmMBvO967Ew=','Dương Hoài Nam','KYPS006@frieslandcampina.com',1,'SM',NULL,NULL,3093,'KYPS006'),(4310,'KYPS011','FmMBvO967Ew=','Lại Việt Hòa','KYPS011@frieslandcampina.com',1,'SM',NULL,NULL,3093,'KYPS011'),(4311,'LMPS001','FmMBvO967Ew=','Vũ Viết  Lư','LMPS001@frieslandcampina.com',1,'SM',NULL,NULL,3108,'LMPS001'),(4312,'LMPS002','FmMBvO967Ew=','Nguyễn Ngọc Tân','LMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3108,'LMPS002'),(4313,'LMPS003','FmMBvO967Ew=','Nguyễn Trung Bộ','LMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3108,'LMPS003'),(4314,'LMPS004','FmMBvO967Ew=','Đinh Văn Bình','LMPS004@frieslandcampina.com',1,'SM',NULL,NULL,3108,'LMPS004'),(4315,'KUPS001','FmMBvO967Ew=','Vũ Minh Tiến','KUPS001@frieslandcampina.com',1,'SM',NULL,NULL,3114,'KUPS001'),(4316,'KUPS002','FmMBvO967Ew=','Phạm Văn Giang','KUPS002@frieslandcampina.com',1,'SM',NULL,NULL,3114,'KUPS002'),(4317,'KUPS003','FmMBvO967Ew=','Nguyễn Đức Công','KUPS003@frieslandcampina.com',1,'SM',NULL,NULL,3114,'KUPS003'),(4318,'KUPS004','FmMBvO967Ew=','Đinh Duy Lực','KUPS004@frieslandcampina.com',1,'SM',NULL,NULL,3114,'KUPS004'),(4319,'KUPS005','FmMBvO967Ew=','Phạm Văn Tùng','KUPS005@frieslandcampina.com',1,'SM',NULL,NULL,3114,'KUPS005'),(4320,'KVPS001','FmMBvO967Ew=','Dương Minh Quảng','KVPS001@frieslandcampina.com',1,'SM',NULL,NULL,3121,'KVPS001'),(4321,'KVPS002','FmMBvO967Ew=','Nguyễn Bá Kiên','KVPS002@frieslandcampina.com',1,'SM',NULL,NULL,3121,'KVPS002'),(4322,'KVPS003','FmMBvO967Ew=','Phạm Thị Nhung','KVPS003@frieslandcampina.com',1,'SM',NULL,NULL,3121,'KVPS003'),(4323,'KVPS004','FmMBvO967Ew=','Bùi Hải Quân','KVPS004@frieslandcampina.com',1,'SM',NULL,NULL,3121,'KVPS004'),(4324,'KVPS005','FmMBvO967Ew=','Lữ Duy Ngọc ','KVPS005@frieslandcampina.com',1,'SM',NULL,NULL,3121,'KVPS005'),(4325,'KWPS002','FmMBvO967Ew=','Nguyễn Mạnh Hào','KWPS002@frieslandcampina.com',1,'SM',NULL,NULL,3128,'KWPS002'),(4326,'KWPS003','FmMBvO967Ew=','Hoàng Văn Long','KWPS003@frieslandcampina.com',1,'SM',NULL,NULL,3128,'KWPS003'),(4327,'KWPS004','FmMBvO967Ew=','Trần Quyết Thắng','KWPS004@frieslandcampina.com',1,'SM',NULL,NULL,3128,'KWPS004'),(4328,'LDPS001','FmMBvO967Ew=','Nguyễn Thành Tâm','LDPS001@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS001'),(4329,'LDPS002','FmMBvO967Ew=','Vũ Việt Tiệp','LDPS002@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS002'),(4330,'LDPS003','FmMBvO967Ew=','Nguyễn Văn Dương','LDPS003@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS003'),(4331,'LDPS004','FmMBvO967Ew=','Vũ Hồng Khanh','LDPS004@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS004'),(4332,'LDPS005','FmMBvO967Ew=','Nguyễn Trí Chung','LDPS005@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS005'),(4333,'LDPS006','FmMBvO967Ew=','Thái Việt Hòa','LDPS006@frieslandcampina.com',1,'SM',NULL,NULL,3134,'LDPS006'),(4334,'LEPS001','FmMBvO967Ew=','Nguyễn Trọng Hưng','LEPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LEPS001'),(4335,'LEPS002','FmMBvO967Ew=','Nguyễn Thị Hằng','LEPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LEPS002'),(4336,'LHPS001','FmMBvO967Ew=','Trần Minh Quân','LHPS001@frieslandcampina.com',1,'SM',NULL,NULL,3145,'LHPS001'),(4337,'LHPS002','FmMBvO967Ew=','Nguyễn Văn Biên','LHPS002@frieslandcampina.com',1,'SM',NULL,NULL,3145,'LHPS002'),(4338,'LHPS003','FmMBvO967Ew=','Đinh Phú Khoa','LHPS003@frieslandcampina.com',1,'SM',NULL,NULL,3145,'LHPS003'),(4339,'LHPS004','FmMBvO967Ew=','Đỗ Kiều Hưng','LHPS004@frieslandcampina.com',1,'SM',NULL,NULL,3145,'LHPS004'),(4340,'LHPS005','FmMBvO967Ew=','Nguyễn Khánh Hòa','LHPS005@frieslandcampina.com',1,'SM',NULL,NULL,3145,'LHPS005'),(4341,'LFPS001','FmMBvO967Ew=','Triệu Văn Thuần ','LFPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LFPS001'),(4342,'LFPS002','FmMBvO967Ew=','Đào Văn Na ','LFPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LFPS002'),(4343,'LFPS003','FmMBvO967Ew=','Chu Văn Luân ','LFPS003@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LFPS003'),(4344,'LBPS001','FmMBvO967Ew=','Hoàng Mạnh Thắng','LBPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LBPS001'),(4345,'LBPS002','FmMBvO967Ew=','Trần Đình Lực','LBPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LBPS002'),(4346,'LBPS003','FmMBvO967Ew=','Nguyễn Ngọc Tuấn','LBPS003@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LBPS003'),(4347,'KZPS001','FmMBvO967Ew=','Quách Hữu Thương','KZPS001@frieslandcampina.com',1,'SM',NULL,NULL,3160,'KZPS001'),(4348,'KZPS002','FmMBvO967Ew=','Cao Bảo Ngọc','KZPS002@frieslandcampina.com',1,'SM',NULL,NULL,3160,'KZPS002'),(4349,'KZPS003','FmMBvO967Ew=','Cao Văn Sỹ','KZPS003@frieslandcampina.com',1,'SM',NULL,NULL,3160,'KZPS003'),(4350,'KZPS004','FmMBvO967Ew=','Nguyễn Khải Xuân','KZPS004@frieslandcampina.com',1,'SM',NULL,NULL,3160,'KZPS004'),(4351,'LIPS001','FmMBvO967Ew=','Đỗ Ngọc Cương','LIPS001@frieslandcampina.com',1,'SM',NULL,NULL,3166,'LIPS001'),(4352,'LIPS002','FmMBvO967Ew=','Nguyễn Tiến Dũng','LIPS002@frieslandcampina.com',1,'SM',NULL,NULL,3166,'LIPS002'),(4353,'LIPS003','FmMBvO967Ew=','Nguyễn Thanh Long','LIPS003@frieslandcampina.com',1,'SM',NULL,NULL,3166,'LIPS003'),(4354,'LAPS001','FmMBvO967Ew=','Nguyễn Văn Mến','LAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3171,'LAPS001'),(4355,'LAPS002','FmMBvO967Ew=','Trần Trung Du','LAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3171,'LAPS002'),(4356,'LAPS003','FmMBvO967Ew=','Vi Tiến Kiên','LAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3171,'LAPS003'),(4357,'LLPS001','FmMBvO967Ew=','Nguyễn Thị Mỹ Hạnh','LLPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LLPS001'),(4358,'LLPS002','FmMBvO967Ew=','Lại Văn Tuyền','LLPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LLPS002'),(4359,'LKPS001','FmMBvO967Ew=','Ngô Trung Đức','LKPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LKPS001'),(4360,'LKPS002','FmMBvO967Ew=','Cao Đăng Quân','LKPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LKPS002'),(4361,'LJPS001','FmMBvO967Ew=','Lê Trọng Thành','LJPS001@frieslandcampina.com',1,'SM',NULL,NULL,3182,'LJPS001'),(4362,'LJPS002','FmMBvO967Ew=','Nguyễn Thị Hằng','LJPS002@frieslandcampina.com',1,'SM',NULL,NULL,3182,'LJPS002'),(4363,'LJPS003','FmMBvO967Ew=','Nguyễn Văn Khánh','LJPS003@frieslandcampina.com',1,'SM',NULL,NULL,3182,'LJPS003'),(4364,'LJPS004','FmMBvO967Ew=','Trần Xuân Thưởng','LJPS004@frieslandcampina.com',1,'SM',NULL,NULL,3182,'LJPS004'),(4365,'LCPS001','FmMBvO967Ew=','Triệu Miền Trung','LCPS001@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LCPS001'),(4366,'LCPS002','FmMBvO967Ew=','Nguyễn Thị Dưa','LCPS002@frieslandcampina.com',1,'SM',NULL,NULL,3133,'LCPS002'),(4367,'LGPS001','FmMBvO967Ew=','Quách Công Thành','LGPS001@frieslandcampina.com',1,'SM',NULL,NULL,3191,'LGPS001'),(4368,'LGPS002','FmMBvO967Ew=','Trần Xuân Quang','LGPS002@frieslandcampina.com',1,'SM',NULL,NULL,3191,'LGPS002'),(4369,'LGPS003','FmMBvO967Ew=','Phùng Văn Đào','LGPS003@frieslandcampina.com',1,'SM',NULL,NULL,3191,'LGPS003'),(4370,'LGPS004','FmMBvO967Ew=','Lưu Mạnh Hùng','LGPS004@frieslandcampina.com',1,'SM',NULL,NULL,3191,'LGPS004'),(4371,'KAPS001','FmMBvO967Ew=','Nguyễn Đức Hiệp','KAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS001'),(4372,'KAPS002','FmMBvO967Ew=','Phạm Văn Khởi','KAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS002'),(4373,'KAPS003','FmMBvO967Ew=','Trịnh Văn Doanh','KAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS003'),(4374,'KAPS004','FmMBvO967Ew=','Đỗ Sỹ Hiệp','KAPS004@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS004'),(4375,'KAPS005','FmMBvO967Ew=','Giáp Văn Đáng','KAPS005@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS005'),(4376,'KAPS006','FmMBvO967Ew=','Trịnh Văn Duẩn','KAPS006@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS006'),(4377,'KAPS007','FmMBvO967Ew=','Nguyễn Văn Hòe','KAPS007@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS007'),(4378,'KAPS008','FmMBvO967Ew=','Lương Văn Huy','KAPS008@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS008'),(4379,'KAPS009','FmMBvO967Ew=','Nguyễn Công Tín','KAPS009@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS009'),(4380,'KAPS010','FmMBvO967Ew=','Trần Đăng Doanh','KAPS010@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS010'),(4381,'KAPS011','FmMBvO967Ew=','Đỗ Văn Điện','KAPS011@frieslandcampina.com',1,'SM',NULL,NULL,3198,'KAPS011'),(4382,'KCPS001','FmMBvO967Ew=','Đồng xuân Hùng','KCPS001@frieslandcampina.com',1,'SM',NULL,NULL,3211,'KCPS001'),(4383,'KCPS002','FmMBvO967Ew=','Nguyễn Đức Long','KCPS002@frieslandcampina.com',1,'SM',NULL,NULL,3211,'KCPS002'),(4384,'KCPS003','FmMBvO967Ew=','Lục Minh Chính','KCPS003@frieslandcampina.com',1,'SM',NULL,NULL,3211,'KCPS003'),(4385,'KCPS004','FmMBvO967Ew=','Đào Văn Tới','KCPS004@frieslandcampina.com',1,'SM',NULL,NULL,3211,'KCPS004'),(4386,'KFPS001','FmMBvO967Ew=','Đào Thị Hồng Cẩm','KFPS001@frieslandcampina.com',1,'SM',NULL,NULL,3197,'KFPS001'),(4387,'KFPS002','FmMBvO967Ew=','Đỗ Mạnh Hùng','KFPS002@frieslandcampina.com',1,'SM',NULL,NULL,3197,'KFPS002'),(4388,'KEPS001','FmMBvO967Ew=','Lê Văn Thể','KEPS001@frieslandcampina.com',1,'SM',NULL,NULL,3220,'KEPS001'),(4389,'KEPS002','FmMBvO967Ew=','Trần Thị Nga','KEPS002@frieslandcampina.com',1,'SM',NULL,NULL,3220,'KEPS002'),(4390,'KEPS003','FmMBvO967Ew=','Hoàng Thị Nga','KEPS003@frieslandcampina.com',1,'SM',NULL,NULL,3220,'KEPS003'),(4391,'KEPS004','FmMBvO967Ew=','Trần Thị Thu Yến','KEPS004@frieslandcampina.com',1,'SM',NULL,NULL,3220,'KEPS004'),(4392,'KEPS005','FmMBvO967Ew=','Vũ Thị Vân Hà','KEPS005@frieslandcampina.com',1,'SM',NULL,NULL,3220,'KEPS005'),(4393,'KBPS001','FmMBvO967Ew=','Nguyễn Sơn Trà','KBPS001@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS001'),(4394,'KBPS002','FmMBvO967Ew=','Đặng Sỹ Mạnh','KBPS002@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS002'),(4395,'KBPS003','FmMBvO967Ew=','Nguyễn Thị Hải','KBPS003@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS003'),(4396,'KBPS004','FmMBvO967Ew=','Nguyễn Thị Nga','KBPS004@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS004'),(4397,'KBPS005','FmMBvO967Ew=','Trần Văn Tiến','KBPS005@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS005'),(4398,'KBPS006','FmMBvO967Ew=','Đoàn Sỹ Nghị','KBPS006@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS006'),(4399,'KBPS007','FmMBvO967Ew=','Nguyễn Văn Tùng','KBPS007@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS007'),(4400,'KBPS008','FmMBvO967Ew=','Nguyễn Minh Tuấn','KBPS008@frieslandcampina.com',1,'SM',NULL,NULL,3227,'KBPS008'),(4401,'LQPS001','FmMBvO967Ew=','Vũ Đăng Tùng','LQPS001@frieslandcampina.com',1,'SM',NULL,NULL,3197,'LQPS001'),(4402,'LQPS002','FmMBvO967Ew=','Trần Đức Huy','LQPS002@frieslandcampina.com',1,'SM',NULL,NULL,3197,'LQPS002'),(4403,'KDPS001','FmMBvO967Ew=','Nguyễn Văn Chu','KDPS001@frieslandcampina.com',1,'SM',NULL,NULL,3240,'KDPS001'),(4404,'KDPS002','FmMBvO967Ew=','Bùi Trọng Lịch','KDPS002@frieslandcampina.com',1,'SM',NULL,NULL,3240,'KDPS002'),(4405,'KDPS003','FmMBvO967Ew=','Đinh Thị Thanh Hương','KDPS003@frieslandcampina.com',1,'SM',NULL,NULL,3240,'KDPS003'),(4406,'KDPS004','FmMBvO967Ew=','Bùi Thị Hồng','KDPS004@frieslandcampina.com',1,'SM',NULL,NULL,3240,'KDPS004'),(4407,'LNPS001','FmMBvO967Ew=','Nguyễn Thị Huệ','LNPS001@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS001'),(4408,'LNPS002','FmMBvO967Ew=','Đỗ Văn Thường','LNPS002@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS002'),(4409,'LNPS003','FmMBvO967Ew=','Lê Đình Tuấn','LNPS003@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS003'),(4410,'LNPS004','FmMBvO967Ew=','Nguyễn Quốc Trung','LNPS004@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS004'),(4411,'LNPS005','FmMBvO967Ew=','Bùi Tiến Tùng','LNPS005@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS005'),(4412,'LNPS006','FmMBvO967Ew=','Trịnh Văn Anh','LNPS006@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS006'),(4413,'LNPS007','FmMBvO967Ew=','Ngô Thị Thúy','LNPS007@frieslandcampina.com',1,'SM',NULL,NULL,3247,'LNPS007'),(4414,'LOPS001','FmMBvO967Ew=','Phạm Khắc Thịnh','LOPS001@frieslandcampina.com',1,'SM',NULL,NULL,3256,'LOPS001'),(4415,'LOPS002','FmMBvO967Ew=','Lương Hữu Sơn','LOPS002@frieslandcampina.com',1,'SM',NULL,NULL,3256,'LOPS002'),(4416,'LOPS003','FmMBvO967Ew=','Lê Thị Hạnh','LOPS003@frieslandcampina.com',1,'SM',NULL,NULL,3256,'LOPS003'),(4417,'LOPS004','FmMBvO967Ew=','Lê Anh Tuấn','LOPS004@frieslandcampina.com',1,'SM',NULL,NULL,3256,'LOPS004'),(4418,'LOPS005','FmMBvO967Ew=','Cao Văn Thắng','LOPS005@frieslandcampina.com',1,'SM',NULL,NULL,3256,'LOPS005'),(4419,'KQPS005','FmMBvO967Ew=','Nguyễn Đình Hùng','KQPS005@frieslandcampina.com',1,'SM',NULL,NULL,3263,'KQPS005'),(4420,'KQPS006','FmMBvO967Ew=','Đinh Hoàng Khoẻ','KQPS006@frieslandcampina.com',1,'SM',NULL,NULL,3263,'KQPS006'),(4421,'KQPS007','FmMBvO967Ew=','Nguyễn Đình Cường','KQPS007@frieslandcampina.com',1,'SM',NULL,NULL,3263,'KQPS007'),(4422,'KQPS008','FmMBvO967Ew=','Nguyễn Danh Nam','KQPS008@frieslandcampina.com',1,'SM',NULL,NULL,3263,'KQPS008'),(4423,'KPPS001','FmMBvO967Ew=','Ngô Thế Kỷ','KPPS001@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS001'),(4424,'KPPS002','FmMBvO967Ew=','Trần Kim Tuyến','KPPS002@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS002'),(4425,'KPPS003','FmMBvO967Ew=','Trần Đăng Hào','KPPS003@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS003'),(4426,'KPPS004','FmMBvO967Ew=','Lê Thị Nhung','KPPS004@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS004'),(4427,'KPPS005','FmMBvO967Ew=','Trần Thị Thủy Ngân','KPPS005@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS005'),(4428,'KPPS006','FmMBvO967Ew=','Đoàn Anh Đông','KPPS006@frieslandcampina.com',1,'SM',NULL,NULL,3269,'KPPS006'),(4429,'KXPS001','FmMBvO967Ew=','Nguyễn Thị Nga','KXPS001@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS001'),(4430,'KXPS002','FmMBvO967Ew=','Hà Thế Ngọc','KXPS002@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS002'),(4431,'KXPS003','FmMBvO967Ew=','Trịnh Thị Huyền Trang','KXPS003@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS003'),(4432,'KXPS004','FmMBvO967Ew=','Nguyễn Thị Thảo','KXPS004@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS004'),(4433,'KXPS005','FmMBvO967Ew=','Lê Văn Chiến','KXPS005@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS005'),(4434,'KXPS006','FmMBvO967Ew=','Lê Thị Ninh','KXPS006@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS006'),(4435,'KXPS008','FmMBvO967Ew=','Lê Văn Trí','KXPS008@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS008'),(4436,'KXPS009','FmMBvO967Ew=','Hồ Hoài Nam','KXPS009@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS009'),(4437,'KXPS010','FmMBvO967Ew=','Nguyễn Sỹ Lê','KXPS010@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS010'),(4438,'KXPS011','FmMBvO967Ew=','Nguyễn Thị Huyền','KXPS011@frieslandcampina.com',1,'SM',NULL,NULL,3277,'KXPS011'),(4439,'KSPS001','FmMBvO967Ew=','Đặng Đinh Hà','KSPS001@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS001'),(4440,'KSPS002','FmMBvO967Ew=','Lê Thị Thu','KSPS002@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS002'),(4441,'KSPS003','FmMBvO967Ew=','Nguyễn Văn Ước','KSPS003@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS003'),(4442,'KSPS004','FmMBvO967Ew=','Ngô Thị Hiền Lương','KSPS004@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS004'),(4443,'KSPS005','FmMBvO967Ew=','Lê Văn Hùng','KSPS005@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS005'),(4444,'KSPS006','FmMBvO967Ew=','Văn Hậu Tuấn','KSPS006@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS006'),(4445,'KSPS007','FmMBvO967Ew=','Dương Hữu Trúc','KSPS007@frieslandcampina.com',1,'SM',NULL,NULL,3289,'KSPS007'),(4446,'KRPS001','FmMBvO967Ew=','Hồ Xuân Thành','KRPS001@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS001'),(4447,'KRPS002','FmMBvO967Ew=','Nguyễn Hữu Bằng','KRPS002@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS002'),(4448,'KRPS003','FmMBvO967Ew=','Nguyễn Thiên Lý','KRPS003@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS003'),(4449,'KRPS004','FmMBvO967Ew=','Võ Quý Đồng','KRPS004@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS004'),(4450,'KRPS005','FmMBvO967Ew=','Vơ Quư Hoài','KRPS005@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS005'),(4451,'KRPS006','FmMBvO967Ew=','Nguyễn Ngọc Vĩnh','KRPS006@frieslandcampina.com',1,'SM',NULL,NULL,3298,'KRPS006'),(4452,'CKPS001','FmMBvO967Ew=','Phan Bá Hảo','CKPS001@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS001'),(4453,'CKPS002','FmMBvO967Ew=','Ngô Thành Tuấn','CKPS002@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS002'),(4454,'CKPS003','FmMBvO967Ew=','Đỗ Quốc Hưng','CKPS003@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS003'),(4455,'CKPS004','FmMBvO967Ew=','Phan Duy Hưng','CKPS004@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS004'),(4456,'CKPS005','FmMBvO967Ew=','Hoàng Thị Huyền','CKPS005@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS005'),(4457,'CKPS006','FmMBvO967Ew=','Nguyễn Văn Hải ','CKPS006@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS006'),(4458,'CKPS007','FmMBvO967Ew=','Vũ Thị Yến','CKPS007@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS007'),(4459,'CKPS008','FmMBvO967Ew=','Nguyễn Thị Tuyết','CKPS008@frieslandcampina.com',1,'SM',NULL,NULL,3308,'CKPS008'),(4460,'CMPS001','FmMBvO967Ew=','Trịnh Văn Thủy','CMPS001@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS001'),(4461,'CMPS002','FmMBvO967Ew=','Nguyễn Thành Nhân','CMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS002'),(4462,'CMPS003','FmMBvO967Ew=','Võ Thế Luyện','CMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS003'),(4463,'CMPS004','FmMBvO967Ew=','Lại Đình Lực','CMPS004@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS004'),(4464,'CMPS005','FmMBvO967Ew=','Phạm Tiến Đạt','CMPS005@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS005'),(4465,'CMPS008','FmMBvO967Ew=','Đoàn Văn Hội','CMPS008@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS008'),(4466,'CMPS009','FmMBvO967Ew=','Vũ Thị Diệu Huyền','CMPS009@frieslandcampina.com',1,'SM',NULL,NULL,3318,'CMPS009'),(4467,'CEPS001','FmMBvO967Ew=','Đinh Ngọc Phúc','CEPS001@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS001'),(4468,'CEPS002','FmMBvO967Ew=','Nguyễn Hữu Dũng','CEPS002@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS002'),(4469,'CEPS003','FmMBvO967Ew=','Nguyễn Tuấn Hải','CEPS003@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS003'),(4470,'CEPS004','FmMBvO967Ew=','Đoàn Văn Hòe','CEPS004@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS004'),(4471,'CEPS005','FmMBvO967Ew=','Vũ Đình Phong','CEPS005@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS005'),(4472,'CEPS006','FmMBvO967Ew=','Vũ Văn Tuyến','CEPS006@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS006'),(4473,'CEPS007','FmMBvO967Ew=','Nguyễn Mạnh Yên','CEPS007@frieslandcampina.com',1,'SM',NULL,NULL,3327,'CEPS007'),(4474,'CAPS001','FmMBvO967Ew=','Lương Văn Hoàng','CAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS001'),(4475,'CAPS002','FmMBvO967Ew=','Nguyễn Quang Định','CAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS002'),(4476,'CAPS003','FmMBvO967Ew=','Nguyễn Văn Ngân','CAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS003'),(4477,'CAPS004','FmMBvO967Ew=','Phạm Văn Thắng','CAPS004@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS004'),(4478,'CAPS005','FmMBvO967Ew=','Trần Văn Tuyên','CAPS005@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS005'),(4479,'CAPS006','FmMBvO967Ew=','Hoàng Văn Thắng','CAPS006@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS006'),(4480,'CAPS007','FmMBvO967Ew=','Nguyễn Công Côn','CAPS007@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS007'),(4481,'CAPS010','FmMBvO967Ew=','Nguyễn Trung Dũng','CAPS010@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS010'),(4482,'CAPS012','FmMBvO967Ew=','Phan Văn Duẩn','CAPS012@frieslandcampina.com',1,'SM',NULL,NULL,3336,'CAPS012'),(4483,'CHPS002','FmMBvO967Ew=','Bùi Văn Kiên ','CHPS002@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS002'),(4484,'CHPS003','FmMBvO967Ew=','Nguyễn Xuân Anh','CHPS003@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS003'),(4485,'CHPS004','FmMBvO967Ew=','Vũ Duy Khương','CHPS004@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS004'),(4486,'CHPS005','FmMBvO967Ew=','Vương Công Điệp','CHPS005@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS005'),(4487,'CHPS006','FmMBvO967Ew=','Phan Đình Quý','CHPS006@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS006'),(4488,'CHPS007','FmMBvO967Ew=','Nguyễn Tiến Long','CHPS007@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS007'),(4489,'CHPS008','FmMBvO967Ew=','Nguyễn Huy Thông','CHPS008@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS008'),(4490,'CHPS009','FmMBvO967Ew=','Bùi Hải Đăng','CHPS009@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS009'),(4491,'CHPS011','FmMBvO967Ew=','Nguyễn Thế Thảo','CHPS011@frieslandcampina.com',1,'SM',NULL,NULL,3347,'CHPS011'),(4492,'CBPS001','FmMBvO967Ew=','Trịnh Trọng Hiển','CBPS001@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS001'),(4493,'CBPS002','FmMBvO967Ew=','Vũ Tuấn Anh','CBPS002@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS002'),(4494,'CBPS003','FmMBvO967Ew=','Nguyễn Phú Cường','CBPS003@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS003'),(4495,'CBPS004','FmMBvO967Ew=','Trần Kiên Dũng','CBPS004@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS004'),(4496,'CBPS005','FmMBvO967Ew=','Nguyễn Tiến An','CBPS005@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS005'),(4497,'CBPS006','FmMBvO967Ew=','Nguyễn Văn Tuyên','CBPS006@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS006'),(4498,'CBPS007','FmMBvO967Ew=','Nguyễn Mậu Sơn','CBPS007@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS007'),(4499,'CBPS008','FmMBvO967Ew=','Đoàn Như Trung','CBPS008@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS008'),(4500,'CBPS009','FmMBvO967Ew=','Nguyễn Xuân Ba','CBPS009@frieslandcampina.com',1,'SM',NULL,NULL,3358,'CBPS009'),(4501,'CCPS001','FmMBvO967Ew=','Đặng Minh Lanh','CCPS001@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS001'),(4502,'CCPS002','FmMBvO967Ew=','Phan Thanh Luyện','CCPS002@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS002'),(4503,'CCPS003','FmMBvO967Ew=','Nguyễn Đình Sâm','CCPS003@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS003'),(4504,'CCPS004','FmMBvO967Ew=','Đỗ Văn Phúc','CCPS004@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS004'),(4505,'CCPS005','FmMBvO967Ew=','Hà Đình Thảo','CCPS005@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS005'),(4506,'CCPS006','FmMBvO967Ew=','Nguyễn Quang Huy','CCPS006@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS006'),(4507,'CCPS007','FmMBvO967Ew=','Đồng Đạo Hiếu','CCPS007@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS007'),(4508,'CCPS008','FmMBvO967Ew=','Bùi Thị Ngần','CCPS008@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS008'),(4509,'CCPS009','FmMBvO967Ew=','Vũ Đình Thanh ','CCPS009@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS009'),(4510,'CCPS010','FmMBvO967Ew=','Lê Văn Tuấn','CCPS010@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS010'),(4511,'CCPS011','FmMBvO967Ew=','Đinh Văn Ngọc','CCPS011@frieslandcampina.com',1,'SM',NULL,NULL,3369,'CCPS011'),(4512,'CDPS001','FmMBvO967Ew=','Nguyễn Anh Tuấn','CDPS001@frieslandcampina.com',1,'SM',NULL,NULL,3383,'CDPS001'),(4513,'CDPS002','FmMBvO967Ew=','Cao Thanh Hải','CDPS002@frieslandcampina.com',1,'SM',NULL,NULL,3383,'CDPS002'),(4514,'CIPS001','FmMBvO967Ew=','Nguyễn Huy Tâm','CIPS001@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS001'),(4515,'CIPS002','FmMBvO967Ew=','Phạm Ngọc Anh','CIPS002@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS002'),(4516,'CIPS003','FmMBvO967Ew=','Lê Quốc Cường','CIPS003@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS003'),(4517,'CIPS004','FmMBvO967Ew=','Hà Văn Chiến','CIPS004@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS004'),(4518,'CIPS005','FmMBvO967Ew=','Lê Văn Hưng','CIPS005@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS005'),(4519,'CIPS006','FmMBvO967Ew=','Lê Hải Châu','CIPS006@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS006'),(4520,'CIPS007','FmMBvO967Ew=','Nguyễn Quốc Thái','CIPS007@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS007'),(4521,'CIPS008','FmMBvO967Ew=','Trần Văn Cảnh','CIPS008@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS008'),(4522,'CIPS009','FmMBvO967Ew=','Đào Văn Trung','CIPS009@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS009'),(4523,'CIPS011','FmMBvO967Ew=','Phạm Văn Châu','CIPS011@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS011'),(4524,'CIPS012','FmMBvO967Ew=','Bùi Văn Hải','CIPS012@frieslandcampina.com',1,'SM',NULL,NULL,3387,'CIPS012'),(4525,'CLPS001','FmMBvO967Ew=','Nguyễn Thanh Thủy','CLPS001@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS001'),(4526,'CLPS002','FmMBvO967Ew=','Nguyễn Công Thiện','CLPS002@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS002'),(4527,'CLPS003','FmMBvO967Ew=','Bùi Văn Huấn','CLPS003@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS003'),(4528,'CLPS004','FmMBvO967Ew=','Lương Quang Trung','CLPS004@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS004'),(4529,'CLPS005','FmMBvO967Ew=','Hà Xuân Tuấn','CLPS005@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS005'),(4530,'CLPS006','FmMBvO967Ew=','Nguyễn Mạnh Hùng','CLPS006@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS006'),(4531,'CLPS007','FmMBvO967Ew=','Hoàng Tiến Dũng','CLPS007@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS007'),(4532,'CLPS008','FmMBvO967Ew=','Nguyễn Tiến Thành','CLPS008@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS008'),(4533,'CLPS009','FmMBvO967Ew=','Kiều Văn Quý','CLPS009@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS009'),(4534,'CLPS014','FmMBvO967Ew=','Nguyễn Trọng Bảy','CLPS014@frieslandcampina.com',1,'SM',NULL,NULL,3400,'CLPS014'),(4535,'CLPS010','FmMBvO967Ew=','Nguyễn Thị Dung','CLPS010@frieslandcampina.com',1,'SM',NULL,NULL,3412,'CLPS010'),(4536,'CLPS011','FmMBvO967Ew=','Nguyễn Văn Khanh','CLPS011@frieslandcampina.com',1,'SM',NULL,NULL,3412,'CLPS011'),(4537,'CLPS012','FmMBvO967Ew=','Trần Mạnh Hùng','CLPS012@frieslandcampina.com',1,'SM',NULL,NULL,3412,'CLPS012'),(4538,'CLPS013','FmMBvO967Ew=','Chu Văn Đường','CLPS013@frieslandcampina.com',1,'SM',NULL,NULL,3412,'CLPS013'),(4539,'CLPS015','FmMBvO967Ew=','Quách Trọng Quỳnh','CLPS015@frieslandcampina.com',1,'SM',NULL,NULL,3412,'CLPS015'),(4540,'CJPS001','FmMBvO967Ew=','Nguyễn Sỹ Toản','CJPS001@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS001'),(4541,'CJPS002','FmMBvO967Ew=','Nguyễn Tuấn Anh','CJPS002@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS002'),(4542,'CJPS003','FmMBvO967Ew=','Đinh Văn Cường','CJPS003@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS003'),(4543,'CJPS004','FmMBvO967Ew=','Đào Huy Thường','CJPS004@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS004'),(4544,'CJPS005','FmMBvO967Ew=','Tưởng văn Hiền','CJPS005@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS005'),(4545,'CJPS006','FmMBvO967Ew=','Nguyễn Văn Thơ','CJPS006@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS006'),(4546,'CJPS007','FmMBvO967Ew=','Bùi Văn Chung','CJPS007@frieslandcampina.com',1,'SM',NULL,NULL,3418,'CJPS007'),(4547,'CGPS002','FmMBvO967Ew=','Đinh Xuân Thái','CGPS002@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS002'),(4548,'CGPS003','FmMBvO967Ew=','Lê Ngọc Anh','CGPS003@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS003'),(4549,'CGPS004','FmMBvO967Ew=','Nguyễn Văn Hùng','CGPS004@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS004'),(4550,'CGPS005','FmMBvO967Ew=','Vũ Quang Minh','CGPS005@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS005'),(4551,'CGPS006','FmMBvO967Ew=','Phạm Văn Hùng','CGPS006@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS006'),(4552,'CGPS007','FmMBvO967Ew=','Trần Văn Bắc','CGPS007@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS007'),(4553,'CGPS008','FmMBvO967Ew=','Trần Văn Luận','CGPS008@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS008'),(4554,'CGPS009','FmMBvO967Ew=','Nguyễn Thanh Tuấn','CGPS009@frieslandcampina.com',1,'SM',NULL,NULL,3427,'CGPS009'),(4555,'IDPS001','FmMBvO967Ew=','Hoàng Quang','IDPS001@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS001'),(4556,'IDPS002','FmMBvO967Ew=','Nguyễn Võ Hòa','IDPS002@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS002'),(4557,'IDPS003','FmMBvO967Ew=','Lê Văn Quyền','IDPS003@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS003'),(4558,'IDPS004','FmMBvO967Ew=','Lê Văn Vinh','IDPS004@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS004'),(4559,'IDPS005','FmMBvO967Ew=','Lê Văn Ý','IDPS005@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS005'),(4560,'IDPS006','FmMBvO967Ew=','Nguyễn Quang Dũng','IDPS006@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS006'),(4561,'IDPS007','FmMBvO967Ew=','Nguyễn Văn Cường','IDPS007@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS007'),(4562,'IDPS008','FmMBvO967Ew=','Trần Văn Minh','IDPS008@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS008'),(4563,'IDPS009','FmMBvO967Ew=','Nguyễn Cột','IDPS009@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS009'),(4564,'IDPS010','FmMBvO967Ew=','Nguyễn Đắc Quân','IDPS010@frieslandcampina.com',1,'SM',NULL,NULL,3439,'IDPS010'),(4565,'IBPS001','FmMBvO967Ew=','Khổng Thanh Bình','IBPS001@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS001'),(4566,'IBPS002','FmMBvO967Ew=','Hoàng Văn Minh','IBPS002@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS002'),(4567,'IBPS003','FmMBvO967Ew=','Nguyễn Minh Đức','IBPS003@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS003'),(4568,'IBPS004','FmMBvO967Ew=','Phạm Văn Túc','IBPS004@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS004'),(4569,'IBPS005','FmMBvO967Ew=','Nguyễn Thị Xuân','IBPS005@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS005'),(4570,'IBPS007','FmMBvO967Ew=','Nguyễn Minh Linh','IBPS007@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS007'),(4571,'IBPS008','FmMBvO967Ew=','Trần Hướng','IBPS008@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS008'),(4572,'IBPS009','FmMBvO967Ew=','Phạm Văn Long','IBPS009@frieslandcampina.com',1,'SM',NULL,NULL,3451,'IBPS009'),(4573,'ICPS001','FmMBvO967Ew=','Nguyễn Thị Ngọc Ánh','ICPS001@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS001'),(4574,'ICPS002','FmMBvO967Ew=','Nguyễn Thanh  Hồng','ICPS002@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS002'),(4575,'ICPS003','FmMBvO967Ew=','Trần Lý Dũng','ICPS003@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS003'),(4576,'ICPS004','FmMBvO967Ew=','Bảo Trương Công Nhật','ICPS004@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS004'),(4577,'ICPS005','FmMBvO967Ew=','Trần Văn Chín','ICPS005@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS005'),(4578,'ICPS006','FmMBvO967Ew=','Trần Thị La Lam','ICPS006@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS006'),(4579,'ICPS007','FmMBvO967Ew=','Võ Thị Diễm Phúc','ICPS007@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS007'),(4580,'ICPS008','FmMBvO967Ew=','Lê Thị Như Mai','ICPS008@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS008'),(4581,'ICPS010','FmMBvO967Ew=','Nguyễn Đình Tuấn','ICPS010@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS010'),(4582,'ICPS011','FmMBvO967Ew=','Nguyễn Văn Ra','ICPS011@frieslandcampina.com',1,'SM',NULL,NULL,3461,'ICPS011'),(4583,'IAPS001','FmMBvO967Ew=','Hoàng Ngọc Cốp','IAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS001'),(4584,'IAPS002','FmMBvO967Ew=','Hoàng Thị Loan','IAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS002'),(4585,'IAPS003','FmMBvO967Ew=','Lê Văn Hùng','IAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS003'),(4586,'IAPS004','FmMBvO967Ew=','Lê Ngọc Thám','IAPS004@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS004'),(4587,'IAPS005','FmMBvO967Ew=','Phạm Anh Đức','IAPS005@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS005'),(4588,'IAPS006','FmMBvO967Ew=','Phạm Văn Minh','IAPS006@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS006'),(4589,'IAPS007','FmMBvO967Ew=','Phạm Mạnh Hùng','IAPS007@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS007'),(4590,'IAPS008','FmMBvO967Ew=','Nguyễn Đức Anh','IAPS008@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS008'),(4591,'IAPS009','FmMBvO967Ew=','Nguyễn Hồng Thái','IAPS009@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS009'),(4592,'IAPS010','FmMBvO967Ew=','Nguyễn Ánh Dương','IAPS010@frieslandcampina.com',1,'SM',NULL,NULL,3473,'IAPS010'),(4593,'IRPS001','FmMBvO967Ew=','Trương Đặng Duy','IRPS001@frieslandcampina.com',1,'SM',NULL,NULL,3486,'IRPS001'),(4594,'IRPS002','FmMBvO967Ew=','Trần Văn Đời','IRPS002@frieslandcampina.com',1,'SM',NULL,NULL,3486,'IRPS002'),(4595,'IRPS003','FmMBvO967Ew=','Huỳnh Thanh Phong ','IRPS003@frieslandcampina.com',1,'SM',NULL,NULL,3486,'IRPS003'),(4596,'IRPS004','FmMBvO967Ew=','Trần Quốc Thạch','IRPS004@frieslandcampina.com',1,'SM',NULL,NULL,3486,'IRPS004'),(4597,'IMPS001','FmMBvO967Ew=','Nguyễn Tấn Lực','IMPS001@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS001'),(4598,'IMPS002','FmMBvO967Ew=','Nguyễn Phan  Hinh','IMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS002'),(4599,'IMPS003','FmMBvO967Ew=','Đào Văn Út','IMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS003'),(4600,'IMPS004','FmMBvO967Ew=','Cao Văn Khoa','IMPS004@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS004'),(4601,'IMPS005','FmMBvO967Ew=','Lê Quang Vinh','IMPS005@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS005'),(4602,'IMPS006','FmMBvO967Ew=','Nguyễn Đình Anh','IMPS006@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS006'),(4603,'IMPS007','FmMBvO967Ew=','Phạm Trung Chiến','IMPS007@frieslandcampina.com',1,'SM',NULL,NULL,3492,'IMPS007'),(4604,'ISPS001','FmMBvO967Ew=','Nguyễn Tài','ISPS001@frieslandcampina.com',1,'SM',NULL,NULL,3501,'ISPS001'),(4605,'ISPS002','FmMBvO967Ew=','Nguyễn Minh Hậu','ISPS002@frieslandcampina.com',1,'SM',NULL,NULL,3501,'ISPS002'),(4606,'ISPS003','FmMBvO967Ew=','Hồ Lê Minh Thiện','ISPS003@frieslandcampina.com',1,'SM',NULL,NULL,3501,'ISPS003'),(4607,'ISPS004','FmMBvO967Ew=','Nguyễn Phúc Thành','ISPS004@frieslandcampina.com',1,'SM',NULL,NULL,3501,'ISPS004'),(4608,'ISPS005','FmMBvO967Ew=','Võ Thành Diệt','ISPS005@frieslandcampina.com',1,'SM',NULL,NULL,3501,'ISPS005'),(4609,'IPPS002','FmMBvO967Ew=','Trương Thanh Huy','IPPS002@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS002'),(4610,'IPPS003','FmMBvO967Ew=','Lê Thị Hằng Nga','IPPS003@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS003'),(4611,'IPPS004','FmMBvO967Ew=','Bùi Trúc Trâm','IPPS004@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS004'),(4612,'IPPS005','FmMBvO967Ew=','Lưu Quốc Nam','IPPS005@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS005'),(4613,'IPPS006','FmMBvO967Ew=','Phan Quốc Trung','IPPS006@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS006'),(4614,'IPPS007','FmMBvO967Ew=','Huỳnh Xuân Vinh','IPPS007@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS007'),(4615,'IPPS008','FmMBvO967Ew=','Phạm Bá Mậu','IPPS008@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS008'),(4616,'IPPS009','FmMBvO967Ew=','Nguyễn Công Triều','IPPS009@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS009'),(4617,'IPPS010','FmMBvO967Ew=','Lê Thanh Đông ','IPPS010@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS010'),(4618,'IPPS012','FmMBvO967Ew=','Nguyễn Đức Liêm ','IPPS012@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS012'),(4619,'IPPS013','FmMBvO967Ew=','Châu Đình Toàn','IPPS013@frieslandcampina.com',1,'SM',NULL,NULL,3508,'IPPS013'),(4620,'ILPS003','FmMBvO967Ew=','Nguyễn Thị Bích Liễu','ILPS003@frieslandcampina.com',1,'SM',NULL,NULL,3521,'ILPS003'),(4621,'ILPS004','FmMBvO967Ew=','Trần Thị Ân','ILPS004@frieslandcampina.com',1,'SM',NULL,NULL,3521,'ILPS004'),(4622,'ILPS005','FmMBvO967Ew=','Nguyễn Thị Mỹ Phương','ILPS005@frieslandcampina.com',1,'SM',NULL,NULL,3521,'ILPS005'),(4623,'ILPS006','FmMBvO967Ew=','Nguyễn Thị Xuân Lợi','ILPS006@frieslandcampina.com',1,'SM',NULL,NULL,3521,'ILPS006'),(4624,'FHPS001','FmMBvO967Ew=','Đào Mạnh Huy','FHPS001@frieslandcampina.com',1,'SM',NULL,NULL,3485,'FHPS001'),(4625,'FHPS002','FmMBvO967Ew=','Lê Văn Thãi','FHPS002@frieslandcampina.com',1,'SM',NULL,NULL,3485,'FHPS002'),(4626,'FHPS003','FmMBvO967Ew=','Nguyễn Văn Đông','FHPS003@frieslandcampina.com',1,'SM',NULL,NULL,3485,'FHPS003'),(4627,'INPS001','FmMBvO967Ew=','Tạ Ngọc Lâm','INPS001@frieslandcampina.com',1,'SM',NULL,NULL,3531,'INPS001'),(4628,'INPS002','FmMBvO967Ew=','Võ Văn Toàn','INPS002@frieslandcampina.com',1,'SM',NULL,NULL,3531,'INPS002'),(4629,'INPS003','FmMBvO967Ew=','Nguyễn Văn Thanh','INPS003@frieslandcampina.com',1,'SM',NULL,NULL,3531,'INPS003'),(4630,'IOPS001','FmMBvO967Ew=','Bùi Hữu Lập','IOPS001@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS001'),(4631,'IOPS003','FmMBvO967Ew=','Lê Thanh Tuệ','IOPS003@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS003'),(4632,'IOPS004','FmMBvO967Ew=','Nguyễn Ngọc Hoàng','IOPS004@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS004'),(4633,'IOPS005','FmMBvO967Ew=','Huỳnh Văn Chung','IOPS005@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS005'),(4634,'IOPS006','FmMBvO967Ew=','Phan Quốc Công','IOPS006@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS006'),(4635,'IOPS008','FmMBvO967Ew=','Trần Thị Kim Bình','IOPS008@frieslandcampina.com',1,'SM',NULL,NULL,3536,'IOPS008'),(4636,'IXPS008','FmMBvO967Ew=','Nguyễn Tú Hiếu','IXPS008@frieslandcampina.com',1,'SM',NULL,NULL,3545,'IXPS008'),(4637,'IXPS009','FmMBvO967Ew=','Phạm Quốc Tây','IXPS009@frieslandcampina.com',1,'SM',NULL,NULL,3545,'IXPS009'),(4638,'IXPS010','FmMBvO967Ew=','Võ Thị Thanh','IXPS010@frieslandcampina.com',1,'SM',NULL,NULL,3545,'IXPS010'),(4639,'IXPS011','FmMBvO967Ew=','Trần Ngọc Hiếu','IXPS011@frieslandcampina.com',1,'SM',NULL,NULL,3545,'IXPS011'),(4640,'IXPS012','FmMBvO967Ew=','Võ Đình Hoàng','IXPS012@frieslandcampina.com',1,'SM',NULL,NULL,3545,'IXPS012'),(4641,'IXPS001','FmMBvO967Ew=','Ngô Thị Mộng Lan','IXPS001@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS001'),(4642,'IXPS002','FmMBvO967Ew=','Bùi Thị Thu Hằng','IXPS002@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS002'),(4643,'IXPS003','FmMBvO967Ew=','Vũ Thị Kim Loan','IXPS003@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS003'),(4644,'IXPS004','FmMBvO967Ew=','Vũ Thị Minh Tâm','IXPS004@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS004'),(4645,'IXPS005','FmMBvO967Ew=','Nguyễn Thị Tuyết Loan','IXPS005@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS005'),(4646,'IXPS006','FmMBvO967Ew=','Trần Ngọc Phương','IXPS006@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS006'),(4647,'IXPS007','FmMBvO967Ew=','Vũ Văn Tuân','IXPS007@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS007'),(4648,'IXPS013','FmMBvO967Ew=','Nguyễn Đức Thắng','IXPS013@frieslandcampina.com',1,'SM',NULL,NULL,3552,'IXPS013'),(4649,'IYPS001','FmMBvO967Ew=','Mạc Thái Thịnh','IYPS001@frieslandcampina.com',1,'SM',NULL,NULL,3561,'IYPS001'),(4650,'IYPS002','FmMBvO967Ew=','Phan Văn Quang','IYPS002@frieslandcampina.com',1,'SM',NULL,NULL,3561,'IYPS002'),(4651,'IYPS003','FmMBvO967Ew=','Trần Thanh Quân','IYPS003@frieslandcampina.com',1,'SM',NULL,NULL,3561,'IYPS003'),(4652,'IYPS004','FmMBvO967Ew=','Võ Văn Hoàng','IYPS004@frieslandcampina.com',1,'SM',NULL,NULL,3561,'IYPS004'),(4653,'ITPS001','FmMBvO967Ew=','Trương Thứ Trưởng','ITPS001@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS001'),(4654,'ITPS002','FmMBvO967Ew=','Đỗ Thái Sinh','ITPS002@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS002'),(4655,'ITPS005','FmMBvO967Ew=','Bùi Hoàng Hiệp','ITPS005@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS005'),(4656,'ITPS006','FmMBvO967Ew=','Lê Văn Dương','ITPS006@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS006'),(4657,'ITPS007','FmMBvO967Ew=','Võ Chí Hiếu','ITPS007@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS007'),(4658,'ITPS008','FmMBvO967Ew=','Lê Quốc Hòa','ITPS008@frieslandcampina.com',1,'SM',NULL,NULL,3561,'ITPS008'),(4659,'IWPS001','FmMBvO967Ew=','Lê Thị Hân','IWPS001@frieslandcampina.com',1,'SM',NULL,NULL,3574,'IWPS001'),(4660,'IWPS002','FmMBvO967Ew=','Nguyễn Thị Phường','IWPS002@frieslandcampina.com',1,'SM',NULL,NULL,3574,'IWPS002'),(4661,'IWPS003','FmMBvO967Ew=','Võ Thị Như Quỳnh','IWPS003@frieslandcampina.com',1,'SM',NULL,NULL,3574,'IWPS003'),(4662,'IWPS004','FmMBvO967Ew=','Trần Thanh Thái','IWPS004@frieslandcampina.com',1,'SM',NULL,NULL,3574,'IWPS004'),(4663,'IWPS005','FmMBvO967Ew=','Nguyễn Văn Đại','IWPS005@frieslandcampina.com',1,'SM',NULL,NULL,3574,'IWPS005'),(4664,'IUPS001','FmMBvO967Ew=','Nguyễn Văn Toàn','IUPS001@frieslandcampina.com',1,'SM',NULL,NULL,3581,'IUPS001'),(4665,'IUPS002','FmMBvO967Ew=','Phạm Tấn Hưng','IUPS002@frieslandcampina.com',1,'SM',NULL,NULL,3581,'IUPS002'),(4666,'JAPS001','FmMBvO967Ew=','Nguyễn Chí Thiện','JAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3574,'JAPS001'),(4667,'JAPS002','FmMBvO967Ew=','Lê Thị Hân','JAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3574,'JAPS002'),(4668,'IVPS002','FmMBvO967Ew=','Nguyễn Thị Bích Phi','IVPS002@frieslandcampina.com',1,'SM',NULL,NULL,3544,'IVPS002'),(4669,'IVPS003','FmMBvO967Ew=','Lưu Thị Hằng','IVPS003@frieslandcampina.com',1,'SM',NULL,NULL,3544,'IVPS003'),(4670,'IVPS004','FmMBvO967Ew=','Nguyễn Văn Sang','IVPS004@frieslandcampina.com',1,'SM',NULL,NULL,3544,'IVPS004'),(4671,'GUPS001','FmMBvO967Ew=','Nguyễn Văn Thạch','GUPS001@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GUPS001'),(4672,'GUPS002','FmMBvO967Ew=','Le Vinh Nhan','GUPS002@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GUPS002'),(4673,'GTPS001','FmMBvO967Ew=','NGUYỄN THÁI HÙNG','GTPS001@frieslandcampina.com',1,'SM',NULL,NULL,3597,'GTPS001'),(4674,'GTPS002','FmMBvO967Ew=','NGUYỄN THẾ HUY','GTPS002@frieslandcampina.com',1,'SM',NULL,NULL,3597,'GTPS002'),(4675,'GTPS003','FmMBvO967Ew=','NGUYỄN QUANG MINH','GTPS003@frieslandcampina.com',1,'SM',NULL,NULL,3597,'GTPS003'),(4676,'GTPS004','FmMBvO967Ew=','NGUYỄN KHÁNH HUY','GTPS004@frieslandcampina.com',1,'SM',NULL,NULL,3597,'GTPS004'),(4677,'GQPS001','FmMBvO967Ew=','Võ Hửu Tâm','GQPS001@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS001'),(4678,'GQPS002','FmMBvO967Ew=','Trương Hoàng Long','GQPS002@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS002'),(4679,'GQPS003','FmMBvO967Ew=','Nguyễn Văn Dũng','GQPS003@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS003'),(4680,'GQPS004','FmMBvO967Ew=','Hoàng Minh Hiển','GQPS004@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS004'),(4681,'GQPS005','FmMBvO967Ew=','Trương Quang Thiệp','GQPS005@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS005'),(4682,'GQPS006','FmMBvO967Ew=','Vũ Thế Phong','GQPS006@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS006'),(4683,'GQPS010','FmMBvO967Ew=','Nguyễn Vũ Phương','GQPS010@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GQPS010'),(4684,'GXPS001','FmMBvO967Ew=','Nguyễn Minh Huyên','GXPS001@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GXPS001'),(4685,'GXPS002','FmMBvO967Ew=','Trần Viết Bửu Long','GXPS002@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GXPS002'),(4686,'GXPS003','FmMBvO967Ew=','Hoàng Duy','GXPS003@frieslandcampina.com',1,'SM',NULL,NULL,3603,'GXPS003'),(4687,'GRPS001','FmMBvO967Ew=','Nguyễn Tài  Bảy','GRPS001@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS001'),(4688,'GRPS002','FmMBvO967Ew=','Nguyễn văn Cường','GRPS002@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS002'),(4689,'GRPS003','FmMBvO967Ew=','Bùi Trung Kiên','GRPS003@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS003'),(4690,'GRPS004','FmMBvO967Ew=','Nguyễn Hữu Quýnh','GRPS004@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS004'),(4691,'GRPS005','FmMBvO967Ew=','Trần Hữu Phúc','GRPS005@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS005'),(4692,'GRPS006','FmMBvO967Ew=','Vũ Trọng Lẫy','GRPS006@frieslandcampina.com',1,'SM',NULL,NULL,3593,'GRPS006'),(4693,'GSPS001','FmMBvO967Ew=','Trương Văn Thanh','GSPS001@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS001'),(4694,'GSPS002','FmMBvO967Ew=','Lê Ngọc Dũng','GSPS002@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS002'),(4695,'GSPS003','FmMBvO967Ew=','Lê Thanh Danh','GSPS003@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS003'),(4696,'GSPS004','FmMBvO967Ew=','Nguyễn Văn Phê','GSPS004@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS004'),(4697,'GSPS005','FmMBvO967Ew=','Huỳnh Sĩ Vũ','GSPS005@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS005'),(4698,'GSPS006','FmMBvO967Ew=','Trần Thị Lan Chi','GSPS006@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS006'),(4699,'GSPS007','FmMBvO967Ew=','Nguyễn Văn Tiến','GSPS007@frieslandcampina.com',1,'SM',NULL,NULL,3623,'GSPS007'),(4700,'GOPS001','FmMBvO967Ew=','NGUYỄN THANH PHONG','GOPS001@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS001'),(4701,'GOPS002','FmMBvO967Ew=','TRẦN VĂN THÂN','GOPS002@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS002'),(4702,'GOPS003','FmMBvO967Ew=','TRẦN VĂN HẠNH','GOPS003@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS003'),(4703,'GOPS004','FmMBvO967Ew=','PHẠM HỮU THUẬN','GOPS004@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS004'),(4704,'GOPS005','FmMBvO967Ew=','NGUYỄN THÀNH HỮU HIỀN','GOPS005@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS005'),(4705,'GOPS006','FmMBvO967Ew=','HUỲNH VĂN HÒA','GOPS006@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS006'),(4706,'GOPS007','FmMBvO967Ew=','NGUYỄN THANH CHƯƠNG','GOPS007@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS007'),(4707,'GOPS008','FmMBvO967Ew=','LÊ HỮU HIỀN','GOPS008@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS008'),(4708,'GOPS009','FmMBvO967Ew=','PHAN PHÚC THỊNH','GOPS009@frieslandcampina.com',1,'SM',NULL,NULL,3632,'GOPS009'),(4709,'GLPS001','FmMBvO967Ew=','HỒ NHỰT TRIỀU ','GLPS001@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS001'),(4710,'GLPS002','FmMBvO967Ew=','Lê Văn Huy','GLPS002@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS002'),(4711,'GLPS003','FmMBvO967Ew=','Nguyen Anh Chi','GLPS003@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS003'),(4712,'GLPS004','FmMBvO967Ew=','Nguyễn Tư Thọ','GLPS004@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS004'),(4713,'GLPS005','FmMBvO967Ew=','Vũ Trọng Duy Minh','GLPS005@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS005'),(4714,'GLPS006','FmMBvO967Ew=','Nguyễn Ngọc Thuận','GLPS006@frieslandcampina.com',1,'SM',NULL,NULL,3643,'GLPS006'),(4715,'GMPS002','FmMBvO967Ew=','Lê Văn Anh','GMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3651,'GMPS002'),(4716,'GMPS003','FmMBvO967Ew=','Trần Đăng Thi','GMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3651,'GMPS003'),(4717,'GMPS004','FmMBvO967Ew=','Nguyễn Duy Khôi','GMPS004@frieslandcampina.com',1,'SM',NULL,NULL,3651,'GMPS004'),(4718,'GMPS005','FmMBvO967Ew=','Lý Ngọc Bảo','GMPS005@frieslandcampina.com',1,'SM',NULL,NULL,3651,'GMPS005'),(4719,'GMPS010','FmMBvO967Ew=','Trần Kiêm Nhật Trường','GMPS010@frieslandcampina.com',1,'SM',NULL,NULL,3651,'GMPS010'),(4720,'GMPS006','FmMBvO967Ew=','Nguyễn Thị Bích Thuận','GMPS006@frieslandcampina.com',1,'SM',NULL,NULL,3658,'GMPS006'),(4721,'GMPS007','FmMBvO967Ew=','CÀ THỊ BẢO NGUYÊN','GMPS007@frieslandcampina.com',1,'SM',NULL,NULL,3658,'GMPS007'),(4722,'GMPS008','FmMBvO967Ew=','Đàm Lộc Minh Quyên','GMPS008@frieslandcampina.com',1,'SM',NULL,NULL,3658,'GMPS008'),(4723,'GMPS009','FmMBvO967Ew=','Lê Văn Kim','GMPS009@frieslandcampina.com',1,'SM',NULL,NULL,3658,'GMPS009'),(4724,'GNPS001','FmMBvO967Ew=','Le Hong Hung','GNPS001@frieslandcampina.com',1,'SM',NULL,NULL,3663,'GNPS001'),(4725,'GNPS002','FmMBvO967Ew=','Tran Duy Đương','GNPS002@frieslandcampina.com',1,'SM',NULL,NULL,3663,'GNPS002'),(4726,'GNPS003','FmMBvO967Ew=','Nguyen Trong Tu','GNPS003@frieslandcampina.com',1,'SM',NULL,NULL,3663,'GNPS003'),(4727,'GNPS005','FmMBvO967Ew=','Tran Minh Cuong','GNPS005@frieslandcampina.com',1,'SM',NULL,NULL,3663,'GNPS005'),(4728,'GNPS006','FmMBvO967Ew=','CẤN VĂN THÀNH','GNPS006@frieslandcampina.com',1,'SM',NULL,NULL,3663,'GNPS006'),(4729,'GPPS001','FmMBvO967Ew=','Vơ Long Quân','GPPS001@frieslandcampina.com',1,'SM',NULL,NULL,3670,'GPPS001'),(4730,'GPPS002','FmMBvO967Ew=','Trần Quang Vinh','GPPS002@frieslandcampina.com',1,'SM',NULL,NULL,3670,'GPPS002'),(4731,'GPPS003','FmMBvO967Ew=','Nguyễn  Văn Thành','GPPS003@frieslandcampina.com',1,'SM',NULL,NULL,3670,'GPPS003'),(4732,'GPPS004','FmMBvO967Ew=','Nguyễn Ngọc An Tâm','GPPS004@frieslandcampina.com',1,'SM',NULL,NULL,3670,'GPPS004'),(4733,'GPPS005','FmMBvO967Ew=','Huỳnh Tấn Kim','GPPS005@frieslandcampina.com',1,'SM',NULL,NULL,3670,'GPPS005'),(4734,'GYPS001','FmMBvO967Ew=','NGUYỄN VĂN SỰ','GYPS001@frieslandcampina.com',1,'SM',NULL,NULL,3678,'GYPS001'),(4735,'GYPS002','FmMBvO967Ew=','Nguyen Tuan Anh','GYPS002@frieslandcampina.com',1,'SM',NULL,NULL,3678,'GYPS002'),(4736,'GYPS003','FmMBvO967Ew=','LƯƠNG HỮU TÌNH','GYPS003@frieslandcampina.com',1,'SM',NULL,NULL,3678,'GYPS003'),(4737,'GYPS004','FmMBvO967Ew=','VÕ VĂN VẠN','GYPS004@frieslandcampina.com',1,'SM',NULL,NULL,3678,'GYPS004'),(4738,'GCPS001','FmMBvO967Ew=','LÊ ĐÌNH HIẾU','GCPS001@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS001'),(4739,'GCPS002','FmMBvO967Ew=','Trần Văn Hà','GCPS002@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS002'),(4740,'GCPS003','FmMBvO967Ew=','Truong Anh Tuan','GCPS003@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS003'),(4741,'GCPS004','FmMBvO967Ew=','Nguyen Xuan Long','GCPS004@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS004'),(4742,'GCPS005','FmMBvO967Ew=','Nguyen Viet Hai','GCPS005@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS005'),(4743,'GCPS006','FmMBvO967Ew=','Nguyen Van Lien','GCPS006@frieslandcampina.com',1,'SM',NULL,NULL,3684,'GCPS006'),(4744,'GDPS001','FmMBvO967Ew=','Trần Hợp','GDPS001@frieslandcampina.com',1,'SM',NULL,NULL,3692,'GDPS001'),(4745,'GDPS002','FmMBvO967Ew=','Huynh Trung Hieu','GDPS002@frieslandcampina.com',1,'SM',NULL,NULL,3692,'GDPS002'),(4746,'GDPS003','FmMBvO967Ew=','Huỳnh Chí Thành','GDPS003@frieslandcampina.com',1,'SM',NULL,NULL,3692,'GDPS003'),(4747,'GDPS004','FmMBvO967Ew=','Tran Nam Trung','GDPS004@frieslandcampina.com',1,'SM',NULL,NULL,3692,'GDPS004'),(4748,'GAPS001','FmMBvO967Ew=','Nguyen Van  Cuong','GAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3698,'GAPS001'),(4749,'GAPS002','FmMBvO967Ew=','Tran Phu Lam','GAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3698,'GAPS002'),(4750,'GAPS003','FmMBvO967Ew=','Chau Van Tuan','GAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3698,'GAPS003'),(4751,'GAPS004','FmMBvO967Ew=','Trần Vũ Anh Khoa','GAPS004@frieslandcampina.com',1,'SM',NULL,NULL,3698,'GAPS004'),(4752,'GWPS001','FmMBvO967Ew=','Vũ Trọng Minh','GWPS001@frieslandcampina.com',1,'SM',NULL,NULL,3704,'GWPS001'),(4753,'GWPS002','FmMBvO967Ew=','Lê Hồng Lộc','GWPS002@frieslandcampina.com',1,'SM',NULL,NULL,3704,'GWPS002'),(4754,'GWPS003','FmMBvO967Ew=','Chế Long Phương','GWPS003@frieslandcampina.com',1,'SM',NULL,NULL,3704,'GWPS003'),(4755,'GWPS004','FmMBvO967Ew=','Thái Phải Cần ','GWPS004@frieslandcampina.com',1,'SM',NULL,NULL,3704,'GWPS004'),(4756,'GWPS005','FmMBvO967Ew=','Trần Hữu Lợi','GWPS005@frieslandcampina.com',1,'SM',NULL,NULL,3704,'GWPS005'),(4757,'GBPS001','FmMBvO967Ew=','Vo Thanh Sang','GBPS001@frieslandcampina.com',1,'SM',NULL,NULL,3711,'GBPS001'),(4758,'GBPS002','FmMBvO967Ew=','Vuong Thai Tam','GBPS002@frieslandcampina.com',1,'SM',NULL,NULL,3711,'GBPS002'),(4759,'GBPS003','FmMBvO967Ew=','Le Hoang Phung','GBPS003@frieslandcampina.com',1,'SM',NULL,NULL,3711,'GBPS003'),(4760,'GBPS004','FmMBvO967Ew=','Vo Thanh Dong','GBPS004@frieslandcampina.com',1,'SM',NULL,NULL,3711,'GBPS004'),(4761,'GBPS005','FmMBvO967Ew=','Nguyễn Thành Đạt','GBPS005@frieslandcampina.com',1,'SM',NULL,NULL,3711,'GBPS005'),(4762,'GFPS001','FmMBvO967Ew=','Nguyen Huu Thuan','GFPS001@frieslandcampina.com',1,'SM',NULL,NULL,3718,'GFPS001'),(4763,'GFPS002','FmMBvO967Ew=','Ho Quang Thi','GFPS002@frieslandcampina.com',1,'SM',NULL,NULL,3718,'GFPS002'),(4764,'GFPS003','FmMBvO967Ew=','Nguyen Thanh Duoc','GFPS003@frieslandcampina.com',1,'SM',NULL,NULL,3718,'GFPS003'),(4765,'GFPS004','FmMBvO967Ew=','Nguyen Ngoc Chau','GFPS004@frieslandcampina.com',1,'SM',NULL,NULL,3718,'GFPS004'),(4766,'GFPS010','FmMBvO967Ew=','Nguyễn Thành Hùng','GFPS010@frieslandcampina.com',1,'SM',NULL,NULL,3718,'GFPS010'),(4767,'GFPS005','FmMBvO967Ew=','Nguyễn Anh Tính','GFPS005@frieslandcampina.com',1,'SM',NULL,NULL,3725,'GFPS005'),(4768,'GFPS006','FmMBvO967Ew=','Phạm Minh Hiếu','GFPS006@frieslandcampina.com',1,'SM',NULL,NULL,3725,'GFPS006'),(4769,'GFPS007','FmMBvO967Ew=','Võ Văn Sâm','GFPS007@frieslandcampina.com',1,'SM',NULL,NULL,3725,'GFPS007'),(4770,'GFPS009','FmMBvO967Ew=','Đào Xuân Lực','GFPS009@frieslandcampina.com',1,'SM',NULL,NULL,3725,'GFPS009'),(4771,'GGPS001','FmMBvO967Ew=','Thai Thanh Tu','GGPS001@frieslandcampina.com',1,'SM',NULL,NULL,3677,'GGPS001'),(4772,'GGPS002','FmMBvO967Ew=','Duong Minh Thai','GGPS002@frieslandcampina.com',1,'SM',NULL,NULL,3677,'GGPS002'),(4773,'GGPS005','FmMBvO967Ew=','NGUYỄN HOÀNG BÁ CHƯƠNG','GGPS005@frieslandcampina.com',1,'SM',NULL,NULL,3677,'GGPS005'),(4774,'GGPS006','FmMBvO967Ew=','NGUYỄN BÁ HẬU','GGPS006@frieslandcampina.com',1,'SM',NULL,NULL,3677,'GGPS006'),(4775,'GIPS001','FmMBvO967Ew=','Do Minh Phuc','GIPS001@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS001'),(4776,'GIPS002','FmMBvO967Ew=','Do Tien Dat','GIPS002@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS002'),(4777,'GIPS003','FmMBvO967Ew=','Vuong Truong Xinh','GIPS003@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS003'),(4778,'GIPS006','FmMBvO967Ew=','Nguyen Thanh Minh','GIPS006@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS006'),(4779,'GIPS004','FmMBvO967Ew=','Nguyen Ngoc Chin','GIPS004@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS004'),(4780,'GIPS005','FmMBvO967Ew=','Nguyen Ngoc Muoi','GIPS005@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS005'),(4781,'GIPS007','FmMBvO967Ew=','Vu Nhat Hoang','GIPS007@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS007'),(4782,'GIPS008','FmMBvO967Ew=','Do Tien Trong','GIPS008@frieslandcampina.com',1,'SM',NULL,NULL,3735,'GIPS008'),(4783,'GJPS001','FmMBvO967Ew=','HOÀNG QUỐC AN','GJPS001@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS001'),(4784,'GJPS002','FmMBvO967Ew=','Nguyen Dong Phuong','GJPS002@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS002'),(4785,'GJPS003','FmMBvO967Ew=','Nguyen Ngoc Dung','GJPS003@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS003'),(4786,'GJPS004','FmMBvO967Ew=','Pham Huy Tung','GJPS004@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS004'),(4787,'GJPS005','FmMBvO967Ew=','Pham Thanh Dien','GJPS005@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS005'),(4788,'GJPS006','FmMBvO967Ew=','Nguyen Minh Tai','GJPS006@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS006'),(4789,'GJPS007','FmMBvO967Ew=','VŨ VĂN THANH','GJPS007@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS007'),(4790,'GJPS011','FmMBvO967Ew=','Nguyen Ngoc Huy','GJPS011@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS011'),(4791,'GJPS008','FmMBvO967Ew=','NGUYỂN QUANG PHƯỚC','GJPS008@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS008'),(4792,'GJPS010','FmMBvO967Ew=','PHẠM VĂN HỘI','GJPS010@frieslandcampina.com',1,'SM',NULL,NULL,3745,'GJPS010'),(4793,'GKPS001','FmMBvO967Ew=','Trần Quỳnh Đăng','GKPS001@frieslandcampina.com',1,'SM',NULL,NULL,3757,'GKPS001'),(4794,'GKPS002','FmMBvO967Ew=','Lê Đức Huân','GKPS002@frieslandcampina.com',1,'SM',NULL,NULL,3757,'GKPS002'),(4795,'GKPS003','FmMBvO967Ew=','Võ Anh Quốc','GKPS003@frieslandcampina.com',1,'SM',NULL,NULL,3757,'GKPS003'),(4796,'GKPS004','FmMBvO967Ew=','Phạm Đức Hùng','GKPS004@frieslandcampina.com',1,'SM',NULL,NULL,3757,'GKPS004'),(4797,'GKPS005','FmMBvO967Ew=','Trần Lê Đại Vinh','GKPS005@frieslandcampina.com',1,'SM',NULL,NULL,3757,'GKPS005'),(4798,'GHPS001','FmMBvO967Ew=','Chung Duy Hải','GHPS001@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS001'),(4799,'GHPS002','FmMBvO967Ew=','Võ Tấn Thành','GHPS002@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS002'),(4800,'GHPS003','FmMBvO967Ew=','Lê Võ Nguyên Khải','GHPS003@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS003'),(4801,'GHPS004','FmMBvO967Ew=','Kim Cao Thanh','GHPS004@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS004'),(4802,'GHPS005','FmMBvO967Ew=','Nguyễn Đức Trọng','GHPS005@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS005'),(4803,'GHPS006','FmMBvO967Ew=','Vũ Hoàng Thông','GHPS006@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS006'),(4804,'GHPS007','FmMBvO967Ew=','Vũ Đặng Cao Tài','GHPS007@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS007'),(4805,'GHPS009','FmMBvO967Ew=','Đinh Thị Cẩm Lệ','GHPS009@frieslandcampina.com',1,'SM',NULL,NULL,3764,'GHPS009'),(4806,'GHPS010','FmMBvO967Ew=','Huynh Anh Tuyen','GHPS010@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS010'),(4807,'GHPS011','FmMBvO967Ew=','TRƯƠNG NGỌC SANG','GHPS011@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS011'),(4808,'GHPS012','FmMBvO967Ew=','Huynh Dong Phuong','GHPS012@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS012'),(4809,'GHPS013','FmMBvO967Ew=','Ly Quoc Hung','GHPS013@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS013'),(4810,'GHPS014','FmMBvO967Ew=','Le Tri Dinh','GHPS014@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS014'),(4811,'GHPS015','FmMBvO967Ew=','NGUYỄN THANH THẢO','GHPS015@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS015'),(4812,'GHPS016','FmMBvO967Ew=','Nguyen Do Duy Thanh','GHPS016@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS016'),(4813,'GHPS017','FmMBvO967Ew=','Nguyễn Kim Toàn','GHPS017@frieslandcampina.com',1,'SM',NULL,NULL,3774,'GHPS017'),(4814,'GVPS001','FmMBvO967Ew=','Đặng Quang Dự','GVPS001@frieslandcampina.com',1,'SM',NULL,NULL,3783,'GVPS001'),(4815,'GVPS002','FmMBvO967Ew=','Phùng Văn Sơn','GVPS002@frieslandcampina.com',1,'SM',NULL,NULL,3783,'GVPS002'),(4816,'GVPS003','FmMBvO967Ew=','Nguyễn Thị Mộng Huyền','GVPS003@frieslandcampina.com',1,'SM',NULL,NULL,3783,'GVPS003'),(4817,'GVPS004','FmMBvO967Ew=','Vũ Bá Linh','GVPS004@frieslandcampina.com',1,'SM',NULL,NULL,3783,'GVPS004'),(4818,'GVPS005','FmMBvO967Ew=','Nguyễn Minh Hải','GVPS005@frieslandcampina.com',1,'SM',NULL,NULL,3783,'GVPS005'),(4819,'AAPS001','FmMBvO967Ew=','Lê Hoàn Vũ','AAPS001@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS001'),(4820,'AAPS002','FmMBvO967Ew=','Đặng Huy Đức ','AAPS002@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS002'),(4821,'AAPS003','FmMBvO967Ew=','Hùynh Bỉnh Thành','AAPS003@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS003'),(4822,'AAPS004','FmMBvO967Ew=','Lý Văn Giây','AAPS004@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS004'),(4823,'AAPS005','FmMBvO967Ew=','Nguyễn Bá Huy','AAPS005@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS005'),(4824,'AAPS006','FmMBvO967Ew=','Nguyễn Khắc Huy','AAPS006@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS006'),(4825,'AAPS007','FmMBvO967Ew=','Đoàn Xuân','AAPS007@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS007'),(4826,'AAPS008','FmMBvO967Ew=','Nguyễn Thanh Hùng','AAPS008@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS008'),(4827,'AAPS009','FmMBvO967Ew=','Trần Trung Quốc','AAPS009@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS009'),(4828,'AAPS010','FmMBvO967Ew=','Lê Minh Châu','AAPS010@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS010'),(4829,'AAPS011','FmMBvO967Ew=','Vũ Tố Nga','AAPS011@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS011'),(4830,'AAPS013','FmMBvO967Ew=','Nguyễn Hoàng Tú','AAPS013@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS013'),(4831,'AAPS023','FmMBvO967Ew=','Ngô Xuân Vinh','AAPS023@frieslandcampina.com',1,'SM',NULL,NULL,3792,'AAPS023'),(4832,'AAPS014','FmMBvO967Ew=','Lê Đức Trường Giang','AAPS014@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS014'),(4833,'AAPS015','FmMBvO967Ew=','Lê Hiếu Nghĩa','AAPS015@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS015'),(4834,'AAPS016','FmMBvO967Ew=','Lương Xuân Thiện','AAPS016@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS016'),(4835,'AAPS017','FmMBvO967Ew=','Nguyễn Khắc Điền','AAPS017@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS017'),(4836,'AAPS018','FmMBvO967Ew=','Nguyễn Thế Trung','AAPS018@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS018'),(4837,'AAPS021','FmMBvO967Ew=','Nguyễn Trung Tín ','AAPS021@frieslandcampina.com',1,'SM',NULL,NULL,3807,'AAPS021'),(4838,'AFPS001','FmMBvO967Ew=','Phạm Ngọc Tứ','AFPS001@frieslandcampina.com',1,'SM',NULL,NULL,3814,'AFPS001'),(4839,'AFPS002','FmMBvO967Ew=','Văn Tân','AFPS002@frieslandcampina.com',1,'SM',NULL,NULL,3814,'AFPS002'),(4840,'AFPS004','FmMBvO967Ew=','Trần Văn Phương','AFPS004@frieslandcampina.com',1,'SM',NULL,NULL,3814,'AFPS004'),(4841,'AFPS005','FmMBvO967Ew=','Huỳnh Hoàng Minh','AFPS005@frieslandcampina.com',1,'SM',NULL,NULL,3814,'AFPS005'),(4842,'AFPS006','FmMBvO967Ew=','Ngô Minh Cảnh','AFPS006@frieslandcampina.com',1,'SM',NULL,NULL,3814,'AFPS006'),(4843,'AFPS007','FmMBvO967Ew=','Phạm Thái Quốc','AFPS007@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS007'),(4844,'AFPS008','FmMBvO967Ew=','Lý Quý Phước','AFPS008@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS008'),(4845,'AFPS009','FmMBvO967Ew=','Đào Duy Khương','AFPS009@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS009'),(4846,'AFPS010','FmMBvO967Ew=','Nguyễn Trường Giang','AFPS010@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS010'),(4847,'AFPS011','FmMBvO967Ew=','Phạm Cự Long','AFPS011@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS011'),(4848,'AFPS013','FmMBvO967Ew=','Trần Văn Hiên','AFPS013@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS013'),(4849,'AFPS014','FmMBvO967Ew=','Lê Xuân Hạnh','AFPS014@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS014'),(4850,'AFPS015','FmMBvO967Ew=','Phạm Minh Tuấn','AFPS015@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS015'),(4851,'AFPS016','FmMBvO967Ew=','Đoàn Văn Tý','AFPS016@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS016'),(4852,'AFPS017','FmMBvO967Ew=','Nguyễn Quốc Cường ','AFPS017@frieslandcampina.com',1,'SM',NULL,NULL,3821,'AFPS017'),(4853,'ATPS002','FmMBvO967Ew=','Huỳnh Thanh Hoàng','ATPS002@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS002'),(4854,'ATPS003','FmMBvO967Ew=','Huỳnh Quốc Thái','ATPS003@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS003'),(4855,'ATPS004','FmMBvO967Ew=','Huỳnh Ngọc Sang','ATPS004@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS004'),(4856,'ATPS005','FmMBvO967Ew=','Lê Văn Phụng','ATPS005@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS005'),(4857,'ATPS006','FmMBvO967Ew=','Hứa Hoàng Nam ','ATPS006@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS006'),(4858,'ATPS008','FmMBvO967Ew=','Ngô Anh Vũ','ATPS008@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS008'),(4859,'ATPS009','FmMBvO967Ew=','Nguyễn Văn Giáp','ATPS009@frieslandcampina.com',1,'SM',NULL,NULL,3814,'ATPS009'),(4860,'ACPS001','FmMBvO967Ew=','Phan Quang Duy Nhân','ACPS001@frieslandcampina.com',1,'SM',NULL,NULL,3840,'ACPS001'),(4861,'ACPS002','FmMBvO967Ew=','Phan Van Nhut Ral','ACPS002@frieslandcampina.com',1,'SM',NULL,NULL,3840,'ACPS002'),(4862,'ACPS003','FmMBvO967Ew=','Nguyen Ngoc Huy','ACPS003@frieslandcampina.com',1,'SM',NULL,NULL,3840,'ACPS003'),(4863,'ACPS005','FmMBvO967Ew=','Danh Ngọc Giàu','ACPS005@frieslandcampina.com',1,'SM',NULL,NULL,3840,'ACPS005'),(4864,'ACPS007','FmMBvO967Ew=','Nguyễn Hoàng Vũ','ACPS007@frieslandcampina.com',1,'SM',NULL,NULL,3840,'ACPS007'),(4865,'AVPS001','FmMBvO967Ew=','Nguyễn Văn Đắc','AVPS001@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS001'),(4866,'AVPS002','FmMBvO967Ew=','Trần Văn Trí','AVPS002@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS002'),(4867,'AVPS003','FmMBvO967Ew=','Nguyễn Quốc Huy','AVPS003@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS003'),(4868,'AVPS004','FmMBvO967Ew=','Cao Đăng Khoa','AVPS004@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS004'),(4869,'AVPS005','FmMBvO967Ew=','Nguyễn Thị Mỹ Linh','AVPS005@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS005'),(4870,'AVPS006','FmMBvO967Ew=','Nguyễn Hoàng Minh Dũng','AVPS006@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS006'),(4871,'AVPS007','FmMBvO967Ew=','Phạm Hoàng Sang','AVPS007@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS007'),(4872,'AVPS008','FmMBvO967Ew=','Nguyễn Thành Luân','AVPS008@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS008'),(4873,'AVPS009','FmMBvO967Ew=','Nguyễn Thị Thanh','AVPS009@frieslandcampina.com',1,'SM',NULL,NULL,3848,'AVPS009'),(4874,'ASPS002','FmMBvO967Ew=','Mai Thành Tài','ASPS002@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS002'),(4875,'ASPS003','FmMBvO967Ew=','Bùi Thanh Tân','ASPS003@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS003'),(4876,'ASPS005','FmMBvO967Ew=','Trương Hưng Thành','ASPS005@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS005'),(4877,'ASPS006','FmMBvO967Ew=','Lâm Hữu Tài','ASPS006@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS006'),(4878,'ASPS008','FmMBvO967Ew=','Phạm Anh Dũng','ASPS008@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS008'),(4879,'ASPS011','FmMBvO967Ew=','Nguyễn Thái Bình','ASPS011@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS011'),(4880,'ASPS013','FmMBvO967Ew=','Bùi Xuân Nguyên','ASPS013@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS013'),(4881,'ASPS014','FmMBvO967Ew=','Trần Quốc Tuấn','ASPS014@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS014'),(4882,'AOPS001','FmMBvO967Ew=','Trần Ngọc Minh ','AOPS001@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS001'),(4883,'AOPS003','FmMBvO967Ew=','Mai Trung Xuy','AOPS003@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS003'),(4884,'AOPS004','FmMBvO967Ew=','Nguyễn Phú Trung ','AOPS004@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS004'),(4885,'AOPS005','FmMBvO967Ew=','Phạm Thị Ánh Ngọc ','AOPS005@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS005'),(4886,'AOPS007','FmMBvO967Ew=','Nguyễn Viết Sơn','AOPS007@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS007'),(4887,'AOPS008','FmMBvO967Ew=','Nguyễn Đức Trường ','AOPS008@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS008'),(4888,'AOPS011','FmMBvO967Ew=','Đỗ Trần Thanh Danh ','AOPS011@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS011'),(4889,'AOPS012','FmMBvO967Ew=','Văn Tấn Sĩ ','AOPS012@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS012'),(4890,'AOPS013','FmMBvO967Ew=','Trịnh Xuân Tứ ','AOPS013@frieslandcampina.com',1,'SM',NULL,NULL,3870,'AOPS013'),(4891,'AMPS002','FmMBvO967Ew=','Tạ Ngọc Long','AMPS002@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS002'),(4892,'AMPS003','FmMBvO967Ew=','Võ Tiến Dũng','AMPS003@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS003'),(4893,'AMPS004','FmMBvO967Ew=','Đào Tiến Lộc','AMPS004@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS004'),(4894,'AMPS005','FmMBvO967Ew=','Nguyễn Văn Bin','AMPS005@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS005'),(4895,'AMPS006','FmMBvO967Ew=','Hồ Quốc Việt','AMPS006@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS006'),(4896,'AMPS007','FmMBvO967Ew=','Nguyễn Hoàng Hải','AMPS007@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS007'),(4897,'AMPS008','FmMBvO967Ew=','Nguyễn Văn Bôn','AMPS008@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS008'),(4898,'AMPS009','FmMBvO967Ew=','Đông Trần Thanh Danh','AMPS009@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS009'),(4899,'AMPS010','FmMBvO967Ew=','Phạm Văn Hậu','AMPS010@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS010'),(4900,'AMPS012','FmMBvO967Ew=','Nguyễn Tất Thiện','AMPS012@frieslandcampina.com',1,'SM',NULL,NULL,3881,'AMPS012'),(4901,'ABPS001','FmMBvO967Ew=','Đặng Văn Quốc','ABPS001@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS001'),(4902,'ABPS002','FmMBvO967Ew=','Nguyễn Tuấn Anh','ABPS002@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS002'),(4903,'ABPS003','FmMBvO967Ew=','Nguyễn Sĩ Phú','ABPS003@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS003'),(4904,'ABPS004','FmMBvO967Ew=','Lê Văn Tiến','ABPS004@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS004'),(4905,'ABPS005','FmMBvO967Ew=','Lê Xuân Huy','ABPS005@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS005'),(4906,'ABPS006','FmMBvO967Ew=','Lê Hữu Dương','ABPS006@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS006'),(4907,'ABPS008','FmMBvO967Ew=','Phương Hướng Vinh','ABPS008@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS008'),(4908,'ABPS018','FmMBvO967Ew=','Phạm Công Thành','ABPS018@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS018'),(4909,'ABPS019','FmMBvO967Ew=','Phạm Hoàng','ABPS019@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS019'),(4910,'ABPS010','FmMBvO967Ew=','Nguyễn Thanh Phúc','ABPS010@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS010'),(4911,'ABPS011','FmMBvO967Ew=','Nguyễn Thanh Sang','ABPS011@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS011'),(4912,'ABPS012','FmMBvO967Ew=','Nguyễn Thanh Minh','ABPS012@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS012'),(4913,'ABPS013','FmMBvO967Ew=','Trương Hồng Phong','ABPS013@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS013'),(4914,'ABPS014','FmMBvO967Ew=','Trương Văn Hào','ABPS014@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS014'),(4915,'ABPS017','FmMBvO967Ew=','Nguyễn Đức Trọng ','ABPS017@frieslandcampina.com',1,'SM',NULL,NULL,3893,'ABPS017'),(4916,'AKPS001','FmMBvO967Ew=','Nguyễn Minh Luật','AKPS001@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS001'),(4917,'AKPS003','FmMBvO967Ew=','Phan Hoàng Thanh Phong','AKPS003@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS003'),(4918,'AKPS004','FmMBvO967Ew=','Hoàng Trọng Nghĩa','AKPS004@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS004'),(4919,'AKPS005','FmMBvO967Ew=','Lê Quang Vinh','AKPS005@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS005'),(4920,'AKPS006','FmMBvO967Ew=','Nguyễn Đặng Nhật Trường','AKPS006@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS006'),(4921,'AKPS007','FmMBvO967Ew=','Đặng Hồng Sơn','AKPS007@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS007'),(4922,'AKPS014','FmMBvO967Ew=','Nguyễn Tiến Huy','AKPS014@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS014'),(4923,'AKPS015','FmMBvO967Ew=','Lê Minh Hoàng','AKPS015@frieslandcampina.com',1,'SM',NULL,NULL,3911,'AKPS015'),(4924,'ANPS001','FmMBvO967Ew=','Trịnh Ngọc Bảo','ANPS001@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS001'),(4925,'ANPS002','FmMBvO967Ew=','Phan Tấn Thành ','ANPS002@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS002'),(4926,'ANPS003','FmMBvO967Ew=','Nguyễn Văn Thái','ANPS003@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS003'),(4927,'ANPS004','FmMBvO967Ew=','Phạm Văn Sang','ANPS004@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS004'),(4928,'ANPS005','FmMBvO967Ew=','Võ Khắc Tuấn Phi','ANPS005@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS005'),(4929,'ANPS006','FmMBvO967Ew=','Lê Mỹ Hoàng Vũ','ANPS006@frieslandcampina.com',1,'SM',NULL,NULL,3921,'ANPS006'),(4930,'AQPS001','FmMBvO967Ew=','Phạm Quốc Chiến','AQPS001@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS001'),(4931,'AQPS002','FmMBvO967Ew=','Hoàng Ngọc Minh','AQPS002@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS002'),(4932,'AQPS003','FmMBvO967Ew=','Hùynh Diệp Tuấn','AQPS003@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS003'),(4933,'AQPS005','FmMBvO967Ew=','Đặng Nguyên Bình','AQPS005@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS005'),(4934,'AQPS006','FmMBvO967Ew=','Chu Văn Đoàn','AQPS006@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS006'),(4935,'AQPS009','FmMBvO967Ew=','Võ Văn Phú','AQPS009@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS009'),(4936,'AQPS010','FmMBvO967Ew=','Trần Vũ Kim Long','AQPS010@frieslandcampina.com',1,'SM',NULL,NULL,3929,'AQPS010'),(4937,'AWPS001','FmMBvO967Ew=','Nguyễn Thành Châu','AWPS001@frieslandcampina.com',1,'SM',NULL,NULL,3938,'AWPS001'),(4938,'AWPS002','FmMBvO967Ew=','Lâm Thanh Hải','AWPS002@frieslandcampina.com',1,'SM',NULL,NULL,3938,'AWPS002'),(4939,'AWPS003','FmMBvO967Ew=','Nguyễn Nhựt Trường','AWPS003@frieslandcampina.com',1,'SM',NULL,NULL,3938,'AWPS003'),(4940,'AWPS004','FmMBvO967Ew=','Hoàng Quang Việt','AWPS004@frieslandcampina.com',1,'SM',NULL,NULL,3944,'AWPS004'),(4941,'AWPS005','FmMBvO967Ew=','Nguyễn Quang Trang','AWPS005@frieslandcampina.com',1,'SM',NULL,NULL,3944,'AWPS005'),(4942,'AWPS006','FmMBvO967Ew=','Võ Văn Phương','AWPS006@frieslandcampina.com',1,'SM',NULL,NULL,3944,'AWPS006'),(4943,'AWPS007','FmMBvO967Ew=','Huỳnh Ngọc Triển','AWPS007@frieslandcampina.com',1,'SM',NULL,NULL,3944,'AWPS007'),(4944,'AWPS008','FmMBvO967Ew=','Nguyễn Bình Phong','AWPS008@frieslandcampina.com',1,'SM',NULL,NULL,3944,'AWPS008'),(4945,'AUPS001','FmMBvO967Ew=','LE DI PHUONG','AUPS001@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS001'),(4946,'AUPS002','FmMBvO967Ew=','Nguyễn Trường Giang','AUPS002@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS002'),(4947,'AUPS003','FmMBvO967Ew=','NGUYỄN TUẤN GIANG','AUPS003@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS003'),(4948,'AUPS004','FmMBvO967Ew=','LE QUOC KHANH','AUPS004@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS004'),(4949,'AUPS005','FmMBvO967Ew=','NGUYỄN TUẤN ANH','AUPS005@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS005'),(4950,'AUPS006','FmMBvO967Ew=','Phạm Quốc Đạt','AUPS006@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS006'),(4951,'AUPS007','FmMBvO967Ew=','Nhan Trung Hiếu','AUPS007@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS007'),(4952,'AUPS008','FmMBvO967Ew=','Phan Quốc Anh ','AUPS008@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS008'),(4953,'AUPS010','FmMBvO967Ew=','PHAM VAN TUAN','AUPS010@frieslandcampina.com',1,'SM',NULL,NULL,3950,'AUPS010'),(4954,'APPS001','FmMBvO967Ew=','Lê Minh Tuấn','APPS001@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS001'),(4955,'APPS002','FmMBvO967Ew=','Hà Lành','APPS002@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS002'),(4956,'APPS003','FmMBvO967Ew=','Bùi Văn Mỹ','APPS003@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS003'),(4957,'APPS004','FmMBvO967Ew=','Nguyễn Tuấn Linh','APPS004@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS004'),(4958,'APPS005','FmMBvO967Ew=','Trương Cộng Hòa','APPS005@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS005'),(4959,'APPS006','FmMBvO967Ew=','Trương Tấn Thành','APPS006@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS006'),(4960,'APPS007','FmMBvO967Ew=','Võ Thị Thu Thanh','APPS007@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS007'),(4961,'APPS008','FmMBvO967Ew=','Phạm Ngọc Huy','APPS008@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS008'),(4962,'APPS009','FmMBvO967Ew=','Nguyễn Thái Hiền','APPS009@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS009'),(4963,'APPS011','FmMBvO967Ew=','Trần Lộc','APPS011@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS011'),(4964,'APPS012','FmMBvO967Ew=','Nguyễn Thị Bích Hà','APPS012@frieslandcampina.com',1,'SM',NULL,NULL,3961,'APPS012'),(4977,'AGPS012','FmMBvO967Ew=','Nguyễn Hữu Luận','AGPS012@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS012'),(4978,'AGPS013','FmMBvO967Ew=','Lê Trung Thuận','AGPS013@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS013'),(4979,'AGPS014','FmMBvO967Ew=','Nguyễn Ngọc Vũ','AGPS014@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS014'),(4980,'AGPS015','FmMBvO967Ew=','Nguyễn Văn Châu','AGPS015@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS015'),(4981,'AGPS016','FmMBvO967Ew=','Thiều Chí Tâm','AGPS016@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS016'),(4982,'AGPS017','FmMBvO967Ew=','Trương Quỳnh Giao','AGPS017@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS017'),(4983,'AGPS018','FmMBvO967Ew=','Hồ Quang Thuận','AGPS018@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS018'),(4984,'AGPS019','FmMBvO967Ew=','Trần Văn Thái','AGPS019@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS019'),(4985,'AGPS020','FmMBvO967Ew=','Nguyễn Tấn Trung','AGPS020@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS020'),(4986,'AGPS022','FmMBvO967Ew=','Nguyễn Văn Thành','AGPS022@frieslandcampina.com',1,'SM',NULL,NULL,3986,'AGPS022'),(4987,'AEPS001','FmMBvO967Ew=','Đỗ Hòang Lộc','AEPS001@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS001'),(4988,'AEPS003','FmMBvO967Ew=','Trần Quốc Khánh','AEPS003@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS003'),(4989,'AEPS004','FmMBvO967Ew=','Nguyễn Thanh Bình','AEPS004@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS004'),(4990,'AEPS005','FmMBvO967Ew=','Nguyễn Trường Chinh ','AEPS005@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS005'),(4991,'AEPS006','FmMBvO967Ew=','Phạm Hoàng Tân','AEPS006@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS006'),(4992,'AEPS007','FmMBvO967Ew=','Phạm Phương Trường','AEPS007@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS007'),(4993,'AEPS008','FmMBvO967Ew=','Phạm Văn Nam','AEPS008@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS008'),(4994,'AEPS009','FmMBvO967Ew=','Trần Thanh Tuấn','AEPS009@frieslandcampina.com',1,'SM',NULL,NULL,3998,'AEPS009'),(4995,'AHPS001','FmMBvO967Ew=','Lê Thị Tú Quyên','AHPS001@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS001'),(4996,'AHPS002','FmMBvO967Ew=','Lê Văn Giàu','AHPS002@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS002'),(4997,'AHPS003','FmMBvO967Ew=','Nguyễn Anh Phúc','AHPS003@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS003'),(4998,'AHPS004','FmMBvO967Ew=','Nguyễn Quốc Hùng','AHPS004@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS004'),(4999,'AHPS005','FmMBvO967Ew=','Nguyễn Thanh Tuấn','AHPS005@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS005'),(5000,'AHPS006','FmMBvO967Ew=','Đặng Hữu Hòang','AHPS006@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS006'),(5001,'AHPS007','FmMBvO967Ew=','Nguyễn Tấn Linh','AHPS007@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS007'),(5002,'AHPS009','FmMBvO967Ew=','Trịnh Văn Chính','AHPS009@frieslandcampina.com',1,'SM',NULL,NULL,4008,'AHPS009'),(5011,'EGPS001','FmMBvO967Ew=','Đặng Đức Vinh','EGPS001@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS001'),(5012,'EGPS002','FmMBvO967Ew=','Đỗ Quốc Dũng','EGPS002@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS002'),(5013,'EGPS003','FmMBvO967Ew=','Đoàn Kim Mạnh','EGPS003@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS003'),(5014,'EGPS004','FmMBvO967Ew=','Huỳnh Tấn Phát','EGPS004@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS004'),(5015,'EGPS005','FmMBvO967Ew=','Nguyễn Văn Điều','EGPS005@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS005'),(5016,'EGPS006','FmMBvO967Ew=','Sơn Hoách','EGPS006@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS006'),(5017,'EGPS007','FmMBvO967Ew=','Trang Hữu Lâm','EGPS007@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS007'),(5018,'EGPS008','FmMBvO967Ew=','Lâm Hoàng Diệp','EGPS008@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS008'),(5019,'EGPS010','FmMBvO967Ew=','Dư Trọng Hữu','EGPS010@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS010'),(5020,'EGPS011','FmMBvO967Ew=','Võ Quốc Thống','EGPS011@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS011'),(5021,'EGPS012','FmMBvO967Ew=','Sơn Thanh Quang','EGPS012@frieslandcampina.com',1,'SM',NULL,NULL,4030,'EGPS012'),(5022,'FJPS001','FmMBvO967Ew=','NguyỄn  Văn Đằng','FJPS001@frieslandcampina.com',1,'SM',NULL,NULL,4043,'FJPS001'),(5023,'FJPS002','FmMBvO967Ew=','Phạm Văn Quy','FJPS002@frieslandcampina.com',1,'SM',NULL,NULL,4043,'FJPS002'),(5024,'FJPS003','FmMBvO967Ew=','Đường Văn An','FJPS003@frieslandcampina.com',1,'SM',NULL,NULL,4043,'FJPS003'),(5025,'ETPS001','FmMBvO967Ew=','Trần Công Được','ETPS001@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS001'),(5026,'ETPS002','FmMBvO967Ew=','Trần Phương Bình','ETPS002@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS002'),(5027,'ETPS003','FmMBvO967Ew=','Trần Trung Kiên','ETPS003@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS003'),(5028,'ETPS004','FmMBvO967Ew=','Vơ Hoàng Khánh','ETPS004@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS004'),(5029,'ETPS005','FmMBvO967Ew=','Tào Nguyên Thảo','ETPS005@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS005'),(5030,'ETPS006','FmMBvO967Ew=','Nguyễn Ngọc Duy Khương','ETPS006@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS006'),(5031,'ETPS009','FmMBvO967Ew=','Phan Văn Cường','ETPS009@frieslandcampina.com',1,'SM',NULL,NULL,4048,'ETPS009'),(5032,'ECPS001','FmMBvO967Ew=','Trần Trọng Trí','ECPS001@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS001'),(5033,'ECPS002','FmMBvO967Ew=','Lê Ngọc Hưng','ECPS002@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS002'),(5034,'ECPS003','FmMBvO967Ew=','Nguyễn Thanh Hùng','ECPS003@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS003'),(5035,'ECPS004','FmMBvO967Ew=','Âu Minh Đường','ECPS004@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS004'),(5036,'ECPS005','FmMBvO967Ew=','Phạm Đăng Khoa','ECPS005@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS005'),(5037,'ECPS007','FmMBvO967Ew=','Nguyễn Hiếu Thuận','ECPS007@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS007'),(5038,'ECPS008','FmMBvO967Ew=','Hà Ngọc Anh','ECPS008@frieslandcampina.com',1,'SM',NULL,NULL,4057,'ECPS008'),(5039,'EUPS001','FmMBvO967Ew=','Nguyễn Trường An','EUPS001@frieslandcampina.com',1,'SM',NULL,NULL,4043,'EUPS001'),(5040,'EUPS003','FmMBvO967Ew=','Nguyễn Văn Tịnh','EUPS003@frieslandcampina.com',1,'SM',NULL,NULL,4043,'EUPS003'),(5041,'EUPS005','FmMBvO967Ew=','Nguyễn Lê Long','EUPS005@frieslandcampina.com',1,'SM',NULL,NULL,4043,'EUPS005'),(5042,'EUPS006','FmMBvO967Ew=','Lê Anh Bằng','EUPS006@frieslandcampina.com',1,'SM',NULL,NULL,4043,'EUPS006'),(5043,'EUPS007','FmMBvO967Ew=','Nguyễn Văn Dùng','EUPS007@frieslandcampina.com',1,'SM',NULL,NULL,4043,'EUPS007'),(5044,'EAPS001','FmMBvO967Ew=','Đặng Nguyên Nhung','EAPS001@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS001'),(5045,'EAPS002','FmMBvO967Ew=','Phạm Văn Tuân ','EAPS002@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS002'),(5046,'EAPS003','FmMBvO967Ew=','Lê Trường Xuân','EAPS003@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS003'),(5047,'EAPS004','FmMBvO967Ew=','Huỳnh Chí Nhân ','EAPS004@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS004'),(5048,'EAPS005','FmMBvO967Ew=','Võ Văn Hoàng','EAPS005@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS005'),(5049,'EAPS006','FmMBvO967Ew=','Nguyễn Thanh Bình','EAPS006@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS006'),(5050,'EAPS007','FmMBvO967Ew=','Đoàn Thanh  Trúc ','EAPS007@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS007'),(5051,'EAPS008','FmMBvO967Ew=',' Vo Vinh Duc ','EAPS008@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS008'),(5052,'EAPS009','FmMBvO967Ew=','Đặng Văn Thuận ','EAPS009@frieslandcampina.com',1,'SM',NULL,NULL,4072,'EAPS009'),(5053,'EVPS001','FmMBvO967Ew=','Ngô Tấn Tiền','EVPS001@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS001'),(5054,'EVPS002','FmMBvO967Ew=','Mạc Phước No Em','EVPS002@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS002'),(5055,'EVPS003','FmMBvO967Ew=','Chiêm Tuấn Cường','EVPS003@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS003'),(5056,'EVPS004','FmMBvO967Ew=','Quách Thiện Đức','EVPS004@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS004'),(5057,'EVPS005','FmMBvO967Ew=','Trần Đại Lộc','EVPS005@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS005'),(5058,'EVPS006','FmMBvO967Ew=','Trần Quốc Khánh','EVPS006@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS006'),(5059,'EVPS008','FmMBvO967Ew=','Liên Diển Toàn','EVPS008@frieslandcampina.com',1,'SM',NULL,NULL,4083,'EVPS008'),(5060,'EIPS001','FmMBvO967Ew=','Lư Thanh Tùng','EIPS001@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS001'),(5061,'EIPS002','FmMBvO967Ew=','Lư Văn Huệ','EIPS002@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS002'),(5062,'EIPS003','FmMBvO967Ew=','Huỳnh Văn Cường','EIPS003@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS003'),(5063,'EIPS004','FmMBvO967Ew=','Nguyễn Hoàng Hiệp','EIPS004@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS004'),(5064,'EIPS005','FmMBvO967Ew=','Nguyễn Hùng Đệ','EIPS005@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS005'),(5065,'EIPS006','FmMBvO967Ew=','Nguyễn Hùng','EIPS006@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS006'),(5066,'EIPS008','FmMBvO967Ew=','Nguyễn Huy','EIPS008@frieslandcampina.com',1,'SM',NULL,NULL,4093,'EIPS008'),(5067,'FGPS001','FmMBvO967Ew=','Đặng Thế ý','FGPS001@frieslandcampina.com',1,'SM',NULL,NULL,4102,'FGPS001'),(5068,'FGPS002','FmMBvO967Ew=','Nguyễn Kỳ Việt','FGPS002@frieslandcampina.com',1,'SM',NULL,NULL,4102,'FGPS002'),(5069,'FGPS003','FmMBvO967Ew=','Lê Tấn Đạt','FGPS003@frieslandcampina.com',1,'SM',NULL,NULL,4102,'FGPS003'),(5070,'EDPS001','FmMBvO967Ew=','NGÔ HOÀNG TUÂN','EDPS001@frieslandcampina.com',1,'SM',NULL,NULL,4107,'EDPS001'),(5071,'EDPS002','FmMBvO967Ew=','TRẦN VĂN DỄ','EDPS002@frieslandcampina.com',1,'SM',NULL,NULL,4107,'EDPS002'),(5072,'EDPS003','FmMBvO967Ew=','PHẠM TRUNG NGUYÊN','EDPS003@frieslandcampina.com',1,'SM',NULL,NULL,4107,'EDPS003'),(5073,'EDPS004','FmMBvO967Ew=','TRƯƠNG QuỐC THÁI','EDPS004@frieslandcampina.com',1,'SM',NULL,NULL,4107,'EDPS004'),(5074,'EDPS006','FmMBvO967Ew=','PHAN NGỌC THÂM','EDPS006@frieslandcampina.com',1,'SM',NULL,NULL,4107,'EDPS006'),(5075,'EHPS001','FmMBvO967Ew=','Từ Xuân Thanh','EHPS001@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS001'),(5076,'EHPS002','FmMBvO967Ew=','Phan Như Hảo','EHPS002@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS002'),(5077,'EHPS003','FmMBvO967Ew=','Nguyễn Thạnh Dư','EHPS003@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS003'),(5078,'EHPS004','FmMBvO967Ew=','Từ Xuân Phương','EHPS004@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS004'),(5079,'EHPS005','FmMBvO967Ew=','Nguyễn Văn Chí','EHPS005@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS005'),(5080,'EHPS006','FmMBvO967Ew=','Nguyễn Văn Mẫn','EHPS006@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS006'),(5081,'EHPS007','FmMBvO967Ew=','Trần Phước Thuận','EHPS007@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS007'),(5082,'EHPS008','FmMBvO967Ew=','Phan Tấn Đạt','EHPS008@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS008'),(5083,'EHPS009','FmMBvO967Ew=','Tô Ngọc Phước','EHPS009@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS009'),(5084,'EHPS010','FmMBvO967Ew=','Trần Phước Thọ','EHPS010@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS010'),(5085,'EHPS013','FmMBvO967Ew=','Dương Nguyễn Bảo Trung','EHPS013@frieslandcampina.com',1,'SM',NULL,NULL,4114,'EHPS013'),(5086,'FCPS001','FmMBvO967Ew=','Nguyễn Văn Nhơn','FCPS001@frieslandcampina.com',1,'SM',NULL,NULL,4093,'FCPS001'),(5087,'FCPS002','FmMBvO967Ew=','Lai Thanh Ḥa','FCPS002@frieslandcampina.com',1,'SM',NULL,NULL,4093,'FCPS002'),(5088,'FCPS003','FmMBvO967Ew=','Nguyễn Hoài Thái','FCPS003@frieslandcampina.com',1,'SM',NULL,NULL,4093,'FCPS003'),(5089,'FCPS005','FmMBvO967Ew=','Nguyễn Văn Tâm','FCPS005@frieslandcampina.com',1,'SM',NULL,NULL,4093,'FCPS005'),(5090,'EQPS001','FmMBvO967Ew=','Trần Thanh Điền','EQPS001@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS001'),(5091,'EQPS002','FmMBvO967Ew=','Lâm Văn Đặng','EQPS002@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS002'),(5092,'EQPS003','FmMBvO967Ew=','Lưu Thái Bình','EQPS003@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS003'),(5093,'EQPS004','FmMBvO967Ew=','Châu Hiền Lộc','EQPS004@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS004'),(5094,'EQPS005','FmMBvO967Ew=','Nguyễn Thiện Toàn','EQPS005@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS005'),(5095,'EQPS006','FmMBvO967Ew=','Phan Thanh Hải','EQPS006@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS006'),(5096,'EQPS007','FmMBvO967Ew=','Trần Công Châu Mỹ','EQPS007@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS007'),(5097,'EQPS008','FmMBvO967Ew=','Nguyễn Hoàng Anh','EQPS008@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS008'),(5098,'EQPS009','FmMBvO967Ew=','Bành Chí Trường','EQPS009@frieslandcampina.com',1,'SM',NULL,NULL,4102,'EQPS009'),(5099,'ESPS001','FmMBvO967Ew=','Nguyễn Văn Đức','ESPS001@frieslandcampina.com',1,'SM',NULL,NULL,4102,'ESPS001'),(5100,'ESPS002','FmMBvO967Ew=','Tăng Dục Bình','ESPS002@frieslandcampina.com',1,'SM',NULL,NULL,4102,'ESPS002'),(5101,'ESPS004','FmMBvO967Ew=','Tăng Dục Đức','ESPS004@frieslandcampina.com',1,'SM',NULL,NULL,4102,'ESPS004'),(5102,'EYPS001','FmMBvO967Ew=','Trần Huỳnh Bá Vũ Thiện','EYPS001@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS001'),(5103,'EYPS002','FmMBvO967Ew=','Chu Thắng Tú','EYPS002@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS002'),(5104,'EYPS003','FmMBvO967Ew=','Nguyễn Tấn Quốc','EYPS003@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS003'),(5105,'EYPS004','FmMBvO967Ew=','Trần Văn Sum','EYPS004@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS004'),(5106,'EYPS005','FmMBvO967Ew=','Bùi Văn Hiệp','EYPS005@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS005'),(5107,'EYPS006','FmMBvO967Ew=','Trần Đắc Đậm','EYPS006@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS006'),(5108,'EYPS007','FmMBvO967Ew=','Kim Hiền','EYPS007@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS007'),(5109,'EYPS008','FmMBvO967Ew=','Đỗ Duy Phước','EYPS008@frieslandcampina.com',1,'SM',NULL,NULL,4147,'EYPS008'),(5110,'EKPS001','FmMBvO967Ew=','Lê Văn So','EKPS001@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS001'),(5111,'EKPS002','FmMBvO967Ew=','Hồ Minh Trí','EKPS002@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS002'),(5112,'EKPS003','FmMBvO967Ew=','Nguyễn Hoàng Thọ','EKPS003@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS003'),(5113,'EKPS004','FmMBvO967Ew=','Lê Hồng Chương','EKPS004@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS004'),(5114,'EKPS006','FmMBvO967Ew=','Lê Văn Bình','EKPS006@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS006'),(5115,'EKPS008','FmMBvO967Ew=','Nguyễn Hóa Giàu','EKPS008@frieslandcampina.com',1,'SM',NULL,NULL,4157,'EKPS008'),(5116,'FAPS001','FmMBvO967Ew=','Bùi Văn Bảy','FAPS001@frieslandcampina.com',1,'SM',NULL,NULL,4165,'FAPS001'),(5117,'FAPS002','FmMBvO967Ew=','Nguyễn Xuân Duy','FAPS002@frieslandcampina.com',1,'SM',NULL,NULL,4165,'FAPS002'),(5118,'FAPS003','FmMBvO967Ew=','Nguyễn Quốc An','FAPS003@frieslandcampina.com',1,'SM',NULL,NULL,4165,'FAPS003'),(5119,'FAPS004','FmMBvO967Ew=','Nguyễn Trương Đại','FAPS004@frieslandcampina.com',1,'SM',NULL,NULL,4165,'FAPS004'),(5120,'FAPS007','FmMBvO967Ew=','Lâm Thọ Ngân','FAPS007@frieslandcampina.com',1,'SM',NULL,NULL,4165,'FAPS007'),(5121,'FIPS001','FmMBvO967Ew=','Trương Văn Tân','FIPS001@frieslandcampina.com',1,'SM',NULL,NULL,4147,'FIPS001'),(5122,'FIPS002','FmMBvO967Ew=','Tăng Văn Phát','FIPS002@frieslandcampina.com',1,'SM',NULL,NULL,4147,'FIPS002'),(5123,'FIPS003','FmMBvO967Ew=','Cao Thanh Tâm','FIPS003@frieslandcampina.com',1,'SM',NULL,NULL,4147,'FIPS003'),(5124,'FIPS004','FmMBvO967Ew=','Phạm Minh Hoàng','FIPS004@frieslandcampina.com',1,'SM',NULL,NULL,4147,'FIPS004'),(5125,'EEPS001','FmMBvO967Ew=','Bùi Minh Phú','EEPS001@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS001'),(5126,'EEPS002','FmMBvO967Ew=','Trần Nguyễn Thuận Phát','EEPS002@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS002'),(5127,'EEPS003','FmMBvO967Ew=','Bùi Minh Phong','EEPS003@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS003'),(5128,'EEPS004','FmMBvO967Ew=','Nguyễn Công Danh (New)','EEPS004@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS004'),(5129,'EEPS005','FmMBvO967Ew=','Phạm Văn Minh','EEPS005@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS005'),(5130,'EEPS006','FmMBvO967Ew=','Nguyễn Hữu Đức','EEPS006@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS006'),(5131,'EEPS007','FmMBvO967Ew=','Nguyễn Hữu Đức ( 007)','EEPS007@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS007'),(5132,'EEPS010','FmMBvO967Ew=','Nguyễn Hoàng Gia','EEPS010@frieslandcampina.com',1,'SM',NULL,NULL,4177,'EEPS010'),(5133,'FFPS001','FmMBvO967Ew=','MAI ĐƯƠNG EM','FFPS001@frieslandcampina.com',1,'SM',NULL,NULL,4146,'FFPS001'),(5134,'FFPS002','FmMBvO967Ew=','HUỲNH TẤN ĐẠT','FFPS002@frieslandcampina.com',1,'SM',NULL,NULL,4146,'FFPS002'),(5135,'FFPS003','FmMBvO967Ew=','LÊ QUANG MINH','FFPS003@frieslandcampina.com',1,'SM',NULL,NULL,4146,'FFPS003'),(5136,'EZPS001','FmMBvO967Ew=','Đỗ Sĩ Sơn','EZPS001@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS001'),(5137,'EZPS002','FmMBvO967Ew=','Nguyễn Minh Trí','EZPS002@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS002'),(5138,'EZPS003','FmMBvO967Ew=','Nguyễn Thanh Sơn','EZPS003@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS003'),(5139,'EZPS004','FmMBvO967Ew=','Nguyễn Xuân Hòa','EZPS004@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS004'),(5140,'EZPS005','FmMBvO967Ew=','Đặng Minh Tân','EZPS005@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS005'),(5141,'EZPS006','FmMBvO967Ew=','Cao Hòang Vũ','EZPS006@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS006'),(5142,'EZPS007','FmMBvO967Ew=','Nguyễn Trần Duy','EZPS007@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS007'),(5143,'EZPS010','FmMBvO967Ew=','Nguyễn Văn Vũ','EZPS010@frieslandcampina.com',1,'SM',NULL,NULL,4165,'EZPS010'),(5144,'ELPS001','FmMBvO967Ew=','Đỗ Quang Thành Thân','ELPS001@frieslandcampina.com',1,'SM',NULL,NULL,4199,'ELPS001'),(5145,'ELPS002','FmMBvO967Ew=','Phan Thanh Liêm','ELPS002@frieslandcampina.com',1,'SM',NULL,NULL,4199,'ELPS002'),(5146,'ELPS003','FmMBvO967Ew=','Lê Hoàng Vũ','ELPS003@frieslandcampina.com',1,'SM',NULL,NULL,4199,'ELPS003'),(5147,'ELPS004','FmMBvO967Ew=','Lâm Quang Thành ','ELPS004@frieslandcampina.com',1,'SM',NULL,NULL,4199,'ELPS004'),(5148,'ELPS007','FmMBvO967Ew=','Huỳnh Công Minh','ELPS007@frieslandcampina.com',1,'SM',NULL,NULL,4199,'ELPS007'),(5149,'FDPS001','FmMBvO967Ew=','Nguyễn Phước Thảo','FDPS001@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS001'),(5150,'FDPS002','FmMBvO967Ew=','Dương Văn Hải','FDPS002@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS002'),(5151,'FDPS003','FmMBvO967Ew=','Phạm Chí Tâm','FDPS003@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS003'),(5152,'FDPS004','FmMBvO967Ew=','Thái Hoa Lăng','FDPS004@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS004'),(5153,'FDPS005','FmMBvO967Ew=','Dương Văn Toàn','FDPS005@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS005'),(5154,'FDPS009','FmMBvO967Ew=','Trương Nguyễn Thanh Tân','FDPS009@frieslandcampina.com',1,'SM',NULL,NULL,4157,'FDPS009'),(5155,'EXPS001','FmMBvO967Ew=','Huỳnh Việt Anh','EXPS001@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EXPS001'),(5156,'EXPS002','FmMBvO967Ew=','Vơ Minh Trung','EXPS002@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EXPS002'),(5157,'EWPS002','FmMBvO967Ew=','Hồ Tấn Hưởng','EWPS002@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS002'),(5158,'EWPS003','FmMBvO967Ew=','Lê Phú Hiệp','EWPS003@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS003'),(5159,'EWPS004','FmMBvO967Ew=','Ngô Tuấn Dũng','EWPS004@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS004'),(5160,'EWPS005','FmMBvO967Ew=','Nguyễn Văn Dương','EWPS005@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS005'),(5161,'EWPS006','FmMBvO967Ew=','Nguyễn Văn Xuân','EWPS006@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS006'),(5162,'EWPS007','FmMBvO967Ew=','Nguyễn Thanh Sử','EWPS007@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS007'),(5163,'EWPS008','FmMBvO967Ew=','Nguyễn Minh Trực','EWPS008@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS008'),(5164,'EWPS009','FmMBvO967Ew=','Trần Thanh Tịnh','EWPS009@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS009'),(5165,'EWPS013','FmMBvO967Ew=','Trần Duy Linh','EWPS013@frieslandcampina.com',1,'SM',NULL,NULL,4214,'EWPS013'),(5166,'ENPS001','FmMBvO967Ew=','Nguyễn Bửu Ngọc Phong','ENPS001@frieslandcampina.com',1,'SM',NULL,NULL,4228,'ENPS001'),(5167,'ENPS002','FmMBvO967Ew=','Nguyễn Minh Luân','ENPS002@frieslandcampina.com',1,'SM',NULL,NULL,4228,'ENPS002'),(5168,'ENPS003','FmMBvO967Ew=','Nguyễn Hoàng Giang','ENPS003@frieslandcampina.com',1,'SM',NULL,NULL,4228,'ENPS003'),(5169,'ENPS004','FmMBvO967Ew=','Dương Nhật Trường','ENPS004@frieslandcampina.com',1,'SM',NULL,NULL,4228,'ENPS004'),(5170,'EMPS001','FmMBvO967Ew=','Lữ Hoàng Gia ','EMPS001@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS001'),(5171,'EMPS002','FmMBvO967Ew=','Phan Thành Nhơn','EMPS002@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS002'),(5172,'EMPS003','FmMBvO967Ew=','La Mười Dân ','EMPS003@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS003'),(5173,'EMPS004','FmMBvO967Ew=','Nguyễn Tấn Tiến','EMPS004@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS004'),(5174,'EMPS005','FmMBvO967Ew=','Lý Trọng Chinh','EMPS005@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS005'),(5175,'EMPS006','FmMBvO967Ew=','Võ Văn Tiệp ','EMPS006@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS006'),(5176,'EMPS007','FmMBvO967Ew=','Nguyển  Phúc  Nhựt','EMPS007@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS007'),(5177,'EMPS008','FmMBvO967Ew=','Nguyễn Thanh Liêm','EMPS008@frieslandcampina.com',1,'SM',NULL,NULL,4234,'EMPS008'),(5178,'EOPS001','FmMBvO967Ew=','Nguyễn Văn Mến','EOPS001@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS001'),(5179,'EOPS002','FmMBvO967Ew=','Lê Thanh Phụng','EOPS002@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS002'),(5180,'EOPS003','FmMBvO967Ew=','Nguyễn Văn Nhớ','EOPS003@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS003'),(5181,'EOPS004','FmMBvO967Ew=','Nguyễn Văn Sánh','EOPS004@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS004'),(5182,'EOPS005','FmMBvO967Ew=','Hồ Phan Trung Tấn','EOPS005@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS005'),(5183,'EOPS006','FmMBvO967Ew=','Huỳnh Minh Phụng','EOPS006@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS006'),(5184,'EOPS010','FmMBvO967Ew=','Nguyễn Thanh Ngà','EOPS010@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS010'),(5185,'EOPS011','FmMBvO967Ew=','Nguyễn văn Danh','EOPS011@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS011'),(5186,'EOPS012','FmMBvO967Ew=','Huỳnh Lý trung Nguyên','EOPS012@frieslandcampina.com',1,'SM',NULL,NULL,4244,'EOPS012'),(5187,'FEPS001','FmMBvO967Ew=','Lưu Bá Toàn','FEPS001@frieslandcampina.com',1,'SM',NULL,NULL,4214,'FEPS001'),(5188,'FEPS002','FmMBvO967Ew=','Lê Thái Quang','FEPS002@frieslandcampina.com',1,'SM',NULL,NULL,4214,'FEPS002'),(5189,'FEPS003','FmMBvO967Ew=','Lưu Bá Phúc','FEPS003@frieslandcampina.com',1,'SM',NULL,NULL,4214,'FEPS003'),(5209,'KLPS001','FmMBvO967Ew=','Nguyễn Văn Ngọc','KLPS001@frieslandcampina.com',1,'SM',NULL,NULL,3038,'KLPS001'),(5210,'KLPS002','FmMBvO967Ew=','Lương Thị Việt  ','hieu.le@hoanghacgroup.com',1,'SM',NULL,NULL,3038,'KLPS002'),(5211,'KLPS003','FmMBvO967Ew=','Phạm Văn Tuấn','KLPS003@frieslandcampina.com',1,'SM',NULL,NULL,3038,'KLPS003'),(5212,'KLPS004','FmMBvO967Ew=','Nguyễn Hồng Thanh','KLPS004@frieslandcampina.com',1,'SM',NULL,NULL,3038,'KLPS004'),(5213,'ASPS015','FmMBvO967Ew=','Nguyễn Hợp Hưng','ASPS015@frieslandcampina.com',1,'SM',NULL,NULL,3859,'ASPS015'),(5214,'nguyenvietthanh','FmMBvO967Ew=','Nguyễn Viết Thanh','thanh.nguyenviet.0619@dutchlady.com.vn',1,'SE',NULL,NULL,3943,'0619'),(5215,'AGPS002','FmMBvO967Ew=','Nguyễn Chí Bảo','AGPS002@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS002'),(5216,'AGPS003','FmMBvO967Ew=','Lê Văn Huy','AGPS003@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS003'),(5217,'AGPS004','FmMBvO967Ew=','Đào Tấn Đại','AGPS004@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS004'),(5218,'AGPS005','FmMBvO967Ew=','Lý Ngọc Trai','AGPS005@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS005'),(5219,'AGPS006','FmMBvO967Ew=','Lê Minh Tân','AGPS006@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS006'),(5220,'AGPS007','FmMBvO967Ew=','Nguyễn Văn Trưởng','AGPS007@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS007'),(5221,'AGPS008','FmMBvO967Ew=','Quyền Minh Khôi','AGPS008@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS008'),(5222,'AGPS009','FmMBvO967Ew=','Trần Thanh Thoảng','AGPS009@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS009'),(5223,'AGPS010','FmMBvO967Ew=','Huỳnh Quốc Minh ','AGPS010@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS010'),(5224,'AGPS011','FmMBvO967Ew=','Đào Anh Kiệt','AGPS011@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS011'),(5225,'AGPS021','FmMBvO967Ew=','Khâu Kiều Kim','AGPS021@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS021'),(5226,'AGPS023','FmMBvO967Ew=','Huỳnh Thanh Toàn','AGPS023@frieslandcampina.com',1,'SM',NULL,NULL,5214,'AGPS023'),(5227,'FBPS001','FmMBvO967Ew=','Hồ Tấn Hoàng Tâm','FBPS001@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS001'),(5228,'FBPS002','FmMBvO967Ew=','Lê Hoàng Dũng','FBPS002@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS002'),(5229,'FBPS003','FmMBvO967Ew=','Lư Thanh Tùng','FBPS003@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS003'),(5230,'FBPS004','FmMBvO967Ew=','Nguyễn Hoàng Tiến','FBPS004@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS004'),(5231,'FBPS005','FmMBvO967Ew=','Nguyễn Trường Minh','FBPS005@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS005'),(5232,'FBPS006','FmMBvO967Ew=','Trịnh Thị Mai','FBPS006@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS006'),(5233,'FBPS008','FmMBvO967Ew=','Âu Ngọc Phương','FBPS008@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS008'),(5234,'FBPS009','FmMBvO967Ew=','Văn Cẩm Sinh','FBPS009@frieslandcampina.com',1,'SM',NULL,NULL,4020,'FBPS009'),(5235,'admin2','FmMBvO967Ew=','Hieu Le','unclehieu@yahoo.com',1,'ADMIN',NULL,NULL,NULL,'ADMIN');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDistributor`
--

DROP TABLE IF EXISTS `UserDistributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDistributor` (
  `UserDistributorID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) DEFAULT NULL,
  `DistributorID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`UserDistributorID`),
  KEY `FK_UserDistributor_User` (`UserID`),
  KEY `FK_UserDistributor_Distributor` (`DistributorID`),
  CONSTRAINT `FK_UserDistributor_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserDistributor_User` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5194 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDistributor`
--

LOCK TABLES `UserDistributor` WRITE;
/*!40000 ALTER TABLE `UserDistributor` DISABLE KEYS */;
INSERT INTO `UserDistributor` VALUES (2443,3046,3612),(2452,3053,3613),(2454,3051,3613),(2459,3058,3614),(2461,3056,3614),(2470,3066,3615),(2477,3071,3616),(2479,3069,3616),(2486,3078,3617),(2488,3076,3617),(2497,3087,3618),(2499,3085,3618),(2507,3096,3619),(2509,3094,3619),(2510,3093,3619),(2517,3103,3620),(2520,3093,3620),(2526,3110,3621),(2528,3108,3621),(2529,3093,3621),(2534,3116,3622),(2536,3114,3622),(2537,3093,3622),(2543,3123,3623),(2545,3121,3623),(2546,3093,3623),(2552,3130,3624),(2554,3128,3624),(2555,3093,3624),(2559,3136,3625),(2561,3134,3625),(2562,3133,3625),(2569,3143,3626),(2572,3133,3626),(2575,3147,3627),(2577,3145,3627),(2578,3133,3627),(2584,3153,3628),(2587,3133,3628),(2591,3157,3629),(2594,3133,3629),(2598,3162,3630),(2600,3160,3630),(2601,3133,3630),(2606,3168,3631),(2608,3166,3631),(2609,3133,3631),(2610,3036,3631),(2613,3173,3632),(2615,3171,3632),(2616,3133,3632),(2617,3036,3632),(2620,3177,3633),(2623,3133,3633),(2624,3036,3633),(2626,3180,3634),(2629,3133,3634),(2630,3036,3634),(2632,3184,3635),(2634,3182,3635),(2635,3133,3635),(2636,3036,3635),(2640,3189,3636),(2643,3133,3636),(2644,3036,3636),(2646,3193,3637),(2648,3191,3637),(2649,3133,3637),(2650,3036,3637),(2654,3200,3638),(2656,3198,3638),(2657,3197,3638),(2658,3036,3638),(2669,3213,3639),(2671,3211,3639),(2672,3197,3639),(2673,3036,3639),(2677,3218,3640),(2680,3197,3640),(2681,3036,3640),(2683,3222,3641),(2685,3220,3641),(2686,3197,3641),(2687,3036,3641),(2692,3229,3642),(2694,3227,3642),(2695,3197,3642),(2696,3036,3642),(2704,3238,3643),(2707,3197,3643),(2708,3036,3643),(2710,3242,3644),(2712,3240,3644),(2713,3197,3644),(2714,3036,3644),(2718,3249,3645),(2720,3247,3645),(2721,3246,3645),(2722,3036,3645),(2729,3258,3646),(2731,3256,3646),(2732,3246,3646),(2733,3036,3646),(2738,3265,3647),(2740,3263,3647),(2741,3246,3647),(2742,3036,3647),(2746,3271,3648),(2748,3269,3648),(2749,3246,3648),(2750,3036,3648),(2756,3279,3649),(2758,3277,3649),(2759,3246,3649),(2760,3036,3649),(2770,3291,3650),(2772,3289,3650),(2773,3246,3650),(2774,3036,3650),(2781,3300,3651),(2783,3298,3651),(2784,3246,3651),(2785,3036,3651),(2791,3310,3652),(2793,3308,3652),(2794,3307,3652),(2795,3306,3652),(2803,3320,3653),(2805,3318,3653),(2806,3307,3653),(2807,3306,3653),(2814,3329,3654),(2816,3327,3654),(2817,3307,3654),(2818,3306,3654),(2825,3338,3655),(2827,3336,3655),(2828,3307,3655),(2829,3306,3655),(2838,3349,3656),(2840,3347,3656),(2841,3307,3656),(2842,3306,3656),(2851,3360,3657),(2853,3358,3657),(2854,3307,3657),(2855,3306,3657),(2864,3371,3658),(2866,3369,3658),(2867,3307,3658),(2868,3306,3658),(2879,3385,3659),(2881,3383,3659),(2882,3382,3659),(2883,3306,3659),(2885,3389,3660),(2887,3387,3660),(2888,3382,3660),(2889,3306,3660),(2900,3402,3661),(2902,3400,3661),(2903,3382,3661),(2904,3306,3661),(2914,3402,3662),(2916,3412,3662),(2917,3382,3662),(2918,3306,3662),(2923,3420,3663),(2925,3418,3663),(2926,3382,3663),(2927,3306,3663),(2934,3429,3664),(2936,3427,3664),(2937,3382,3664),(2938,3306,3664),(2946,3441,3665),(2948,3439,3665),(2949,3438,3665),(2950,3437,3665),(2960,3453,3666),(2962,3451,3666),(2963,3438,3666),(2964,3437,3666),(2972,3463,3667),(2974,3461,3667),(2975,3438,3667),(2976,3437,3667),(2986,3475,3668),(2988,3473,3668),(2989,3438,3668),(2990,3437,3668),(3000,3488,3669),(3002,3486,3669),(3003,3485,3669),(3004,3437,3669),(3008,3494,3670),(3010,3492,3670),(3011,3485,3670),(3012,3437,3670),(3019,3503,3671),(3021,3501,3671),(3022,3485,3671),(3023,3437,3671),(3028,3510,3672),(3030,3508,3672),(3031,3485,3672),(3032,3437,3672),(3036,3510,3673),(3038,3508,3673),(3039,3485,3673),(3040,3437,3673),(3047,3523,3674),(3049,3521,3674),(3050,3485,3674),(3051,3437,3674),(3055,3528,3675),(3057,3485,3675),(3058,3437,3675),(3061,3533,3676),(3063,3531,3676),(3064,3485,3676),(3065,3437,3676),(3068,3538,3677),(3070,3536,3677),(3071,3485,3677),(3072,3437,3677),(3078,3547,3678),(3080,3545,3678),(3081,3544,3678),(3082,3437,3678),(3087,3547,3679),(3089,3552,3679),(3090,3544,3679),(3091,3437,3679),(3099,3563,3680),(3101,3561,3680),(3102,3544,3680),(3103,3437,3680),(3107,3568,3681),(3109,3561,3681),(3110,3544,3681),(3111,3437,3681),(3117,3576,3682),(3119,3574,3682),(3120,3544,3682),(3121,3437,3682),(3126,3583,3683),(3128,3581,3683),(3129,3544,3683),(3130,3437,3683),(3132,3586,3684),(3134,3574,3684),(3135,3544,3684),(3136,3437,3684),(3138,3589,3685),(3140,3544,3685),(3141,3437,3685),(3144,3595,3686),(3147,3593,3686),(3148,3592,3686),(3150,3599,3687),(3152,3597,3687),(3153,3593,3687),(3154,3592,3687),(3158,3605,3688),(3160,3603,3688),(3161,3593,3688),(3162,3592,3688),(3169,3613,3689),(3171,3603,3689),(3172,3593,3689),(3173,3592,3689),(3176,3617,3690),(3179,3593,3690),(3180,3592,3690),(3186,3625,3691),(3188,3623,3691),(3189,3593,3691),(3190,3592,3691),(3197,3634,3692),(3200,3632,3692),(3201,3592,3692),(3210,3645,3693),(3212,3643,3693),(3213,3632,3693),(3214,3592,3693),(3220,3653,3694),(3222,3651,3694),(3223,3632,3694),(3224,3592,3694),(3229,3653,3695),(3231,3658,3695),(3232,3632,3695),(3233,3592,3695),(3237,3665,3696),(3239,3663,3696),(3240,3632,3696),(3241,3592,3696),(3246,3672,3697),(3248,3670,3697),(3249,3632,3697),(3250,3592,3697),(3255,3680,3698),(3257,3678,3698),(3258,3677,3698),(3259,3592,3698),(3263,3686,3699),(3265,3684,3699),(3266,3677,3699),(3267,3592,3699),(3273,3694,3700),(3275,3692,3700),(3276,3677,3700),(3277,3592,3700),(3281,3700,3701),(3283,3698,3701),(3284,3677,3701),(3285,3592,3701),(3289,3706,3702),(3291,3704,3702),(3292,3677,3702),(3293,3592,3702),(3298,3713,3703),(3300,3711,3703),(3301,3677,3703),(3302,3592,3703),(3307,3720,3704),(3309,3718,3704),(3310,3677,3704),(3311,3592,3704),(3316,3720,3705),(3318,3725,3705),(3319,3677,3705),(3320,3592,3705),(3324,3731,3706),(3327,3677,3706),(3328,3592,3706),(3332,3737,3707),(3335,3735,3707),(3336,3592,3707),(3340,3737,3708),(3343,3735,3708),(3344,3592,3708),(3348,3747,3709),(3350,3745,3709),(3351,3735,3709),(3352,3592,3709),(3360,3747,3710),(3362,3745,3710),(3363,3735,3710),(3364,3592,3710),(3366,3759,3711),(3368,3757,3711),(3369,3735,3711),(3370,3592,3711),(3375,3766,3712),(3377,3764,3712),(3378,3735,3712),(3379,3592,3712),(3387,3766,3713),(3389,3774,3713),(3390,3735,3713),(3391,3592,3713),(3399,3785,3714),(3401,3783,3714),(3402,3735,3714),(3403,3592,3714),(3408,3794,3715),(3410,3792,3715),(3411,3791,3715),(3412,3790,3715),(3425,3794,3716),(3427,3807,3716),(3428,3791,3716),(3429,3790,3716),(3435,3816,3717),(3437,3814,3717),(3438,3791,3717),(3439,3790,3717),(3444,3816,3718),(3446,3821,3718),(3447,3791,3718),(3448,3790,3718),(3458,3833,3719),(3460,3814,3719),(3461,3791,3719),(3462,3790,3719),(3469,3842,3720),(3471,3840,3720),(3472,3791,3720),(3473,3790,3720),(3478,3850,3721),(3480,3848,3721),(3481,3847,3721),(3482,3790,3721),(3491,3861,3722),(3493,3859,3722),(3494,3847,3722),(3495,3790,3722),(3503,3872,3723),(3505,3870,3723),(3506,3847,3723),(3507,3790,3723),(3516,3883,3724),(3518,3881,3724),(3519,3847,3724),(3520,3790,3724),(3530,3895,3725),(3532,3893,3725),(3533,3847,3725),(3534,3790,3725),(3543,3895,3726),(3545,3893,3726),(3546,3847,3726),(3547,3790,3726),(3553,3913,3727),(3555,3911,3727),(3556,3910,3727),(3557,3790,3727),(3565,3923,3728),(3567,3921,3728),(3568,3910,3728),(3569,3790,3728),(3575,3931,3729),(3577,3929,3729),(3578,3910,3729),(3579,3790,3729),(3586,3940,3730),(3588,3938,3730),(3589,3910,3730),(3590,3790,3730),(3593,3940,3731),(3595,3944,3731),(3596,3943,3731),(3597,3790,3731),(3602,3952,3732),(3604,3950,3732),(3605,3910,3732),(3606,3790,3732),(3615,3963,3733),(3617,3961,3733),(3618,3943,3733),(3619,3790,3733),(3630,3988,3746),(3632,3986,3746),(3633,3943,3746),(3634,3790,3746),(3644,4000,3747),(3646,3998,3747),(3647,3943,3747),(3648,3790,3747),(3656,4010,3748),(3658,4008,3748),(3659,3943,3748),(3660,3790,3748),(3668,4022,3749),(3670,4020,3749),(3671,4019,3749),(3672,4018,3749),(3680,4032,3750),(3682,4030,3750),(3683,4019,3750),(3684,4018,3750),(3695,4045,3751),(3697,4043,3751),(3698,4019,3751),(3699,4018,3751),(3702,4050,3752),(3704,4048,3752),(3705,4019,3752),(3706,4018,3752),(3713,4059,3753),(3715,4057,3753),(3716,4019,3753),(3717,4018,3753),(3724,4067,3754),(3726,4043,3754),(3727,4019,3754),(3728,4018,3754),(3733,4074,3755),(3735,4072,3755),(3736,4019,3755),(3737,4018,3755),(3746,4085,3756),(3748,4083,3756),(3749,4019,3756),(3750,4018,3756),(3757,4095,3757),(3759,4093,3757),(3760,4092,3757),(3761,4018,3757),(3768,4104,3758),(3770,4102,3758),(3771,4092,3758),(3772,4018,3758),(3775,4109,3759),(3777,4107,3759),(3778,4092,3759),(3779,4018,3759),(3784,4116,3760),(3786,4114,3760),(3787,4092,3760),(3788,4018,3760),(3799,4128,3761),(3801,4093,3761),(3802,4092,3761),(3803,4018,3761),(3807,4133,3762),(3809,4102,3762),(3810,4092,3762),(3811,4018,3762),(3820,4143,3763),(3822,4102,3763),(3823,4092,3763),(3824,4018,3763),(3827,4149,3764),(3829,4147,3764),(3830,4146,3764),(3831,4018,3764),(3839,4159,3765),(3841,4157,3765),(3842,4146,3765),(3843,4018,3765),(3849,4167,3766),(3851,4165,3766),(3852,4146,3766),(3853,4018,3766),(3858,4173,3767),(3860,4147,3767),(3861,4146,3767),(3862,4018,3767),(3866,4179,3768),(3868,4177,3768),(3869,4146,3768),(3870,4018,3768),(3878,4059,3769),(3880,4146,3769),(3881,4018,3769),(3884,4191,3770),(3886,4165,3770),(3887,4146,3770),(3888,4018,3770),(3896,4201,3771),(3898,4199,3771),(3899,4146,3771),(3900,4018,3771),(3905,4207,3772),(3907,4157,3772),(3908,4146,3772),(3909,4018,3772),(3915,4216,3773),(3917,4214,3773),(3918,4213,3773),(3919,4018,3773),(3921,4219,3774),(3923,4214,3774),(3924,4213,3774),(3925,4018,3774),(3934,4230,3775),(3936,4228,3775),(3937,4213,3775),(3938,4018,3775),(3942,4236,3776),(3944,4234,3776),(3945,4213,3776),(3946,4018,3776),(3954,4246,3777),(3956,4244,3777),(3957,4213,3777),(3958,4018,3777),(3967,4256,3778),(3969,4214,3778),(3970,4213,3778),(3971,4018,3778),(3978,4264,3612),(3980,4265,3612),(3981,4266,3612),(3982,4267,3612),(3983,4268,3612),(3984,4269,3613),(3985,4270,3613),(3986,4271,3613),(3987,4272,3614),(3988,4273,3614),(3989,4274,3614),(3990,4275,3614),(3991,4276,3614),(3992,4277,3614),(3993,4278,3614),(3994,4279,3615),(3996,4280,3615),(3997,4281,3615),(3998,4282,3616),(3999,4283,3616),(4000,4284,3616),(4001,4285,3616),(4002,4286,3616),(4003,4287,3617),(4004,4288,3617),(4005,4289,3617),(4006,4290,3617),(4007,4291,3617),(4008,4292,3617),(4009,4293,3617),(4010,4294,3618),(4011,4295,3618),(4012,4296,3618),(4013,4297,3618),(4014,4298,3618),(4015,4299,3618),(4016,4300,3619),(4017,4301,3619),(4018,4302,3619),(4019,4303,3619),(4020,4304,3619),(4021,4305,3619),(4022,4306,3620),(4024,4307,3620),(4025,4308,3620),(4026,4309,3620),(4027,4310,3620),(4028,4311,3621),(4029,4312,3621),(4030,4313,3621),(4031,4314,3621),(4032,4315,3622),(4033,4316,3622),(4034,4317,3622),(4035,4318,3622),(4036,4319,3622),(4037,4320,3623),(4038,4321,3623),(4039,4322,3623),(4040,4323,3623),(4041,4324,3623),(4042,4325,3624),(4043,4326,3624),(4044,4327,3624),(4045,4328,3625),(4046,4329,3625),(4047,4330,3625),(4048,4331,3625),(4049,4332,3625),(4050,4333,3625),(4051,4334,3626),(4053,4335,3626),(4054,4336,3627),(4055,4337,3627),(4056,4338,3627),(4057,4339,3627),(4058,4340,3627),(4059,4341,3628),(4061,4342,3628),(4062,4343,3628),(4063,4344,3629),(4065,4345,3629),(4066,4346,3629),(4067,4347,3630),(4068,4348,3630),(4069,4349,3630),(4070,4350,3630),(4071,4351,3631),(4072,4352,3631),(4073,4353,3631),(4074,4354,3632),(4075,4355,3632),(4076,4356,3632),(4077,4357,3633),(4079,4358,3633),(4080,4359,3634),(4082,4360,3634),(4083,4361,3635),(4084,4362,3635),(4085,4363,3635),(4086,4364,3635),(4087,4365,3636),(4089,4366,3636),(4090,4367,3637),(4091,4368,3637),(4092,4369,3637),(4093,4370,3637),(4094,4371,3638),(4095,4372,3638),(4096,4373,3638),(4097,4374,3638),(4098,4375,3638),(4099,4376,3638),(4100,4377,3638),(4101,4378,3638),(4102,4379,3638),(4103,4380,3638),(4104,4381,3638),(4105,4382,3639),(4106,4383,3639),(4107,4384,3639),(4108,4385,3639),(4109,4386,3640),(4111,4387,3640),(4112,4388,3641),(4113,4389,3641),(4114,4390,3641),(4115,4391,3641),(4116,4392,3641),(4117,4393,3642),(4118,4394,3642),(4119,4395,3642),(4120,4396,3642),(4121,4397,3642),(4122,4398,3642),(4123,4399,3642),(4124,4400,3642),(4125,4401,3643),(4127,4402,3643),(4128,4403,3644),(4129,4404,3644),(4130,4405,3644),(4131,4406,3644),(4132,4407,3645),(4133,4408,3645),(4134,4409,3645),(4135,4410,3645),(4136,4411,3645),(4137,4412,3645),(4138,4413,3645),(4139,4414,3646),(4140,4415,3646),(4141,4416,3646),(4142,4417,3646),(4143,4418,3646),(4144,4419,3647),(4145,4420,3647),(4146,4421,3647),(4147,4422,3647),(4148,4423,3648),(4149,4424,3648),(4150,4425,3648),(4151,4426,3648),(4152,4427,3648),(4153,4428,3648),(4154,4429,3649),(4155,4430,3649),(4156,4431,3649),(4157,4432,3649),(4158,4433,3649),(4159,4434,3649),(4160,4435,3649),(4161,4436,3649),(4162,4437,3649),(4163,4438,3649),(4164,4439,3650),(4165,4440,3650),(4166,4441,3650),(4167,4442,3650),(4168,4443,3650),(4169,4444,3650),(4170,4445,3650),(4171,4446,3651),(4172,4447,3651),(4173,4448,3651),(4174,4449,3651),(4175,4450,3651),(4176,4451,3651),(4177,4452,3652),(4178,4453,3652),(4179,4454,3652),(4180,4455,3652),(4181,4456,3652),(4182,4457,3652),(4183,4458,3652),(4184,4459,3652),(4185,4460,3653),(4186,4461,3653),(4187,4462,3653),(4188,4463,3653),(4189,4464,3653),(4190,4465,3653),(4191,4466,3653),(4192,4467,3654),(4193,4468,3654),(4194,4469,3654),(4195,4470,3654),(4196,4471,3654),(4197,4472,3654),(4198,4473,3654),(4199,4474,3655),(4200,4475,3655),(4201,4476,3655),(4202,4477,3655),(4203,4478,3655),(4204,4479,3655),(4205,4480,3655),(4206,4481,3655),(4207,4482,3655),(4208,4483,3656),(4209,4484,3656),(4210,4485,3656),(4211,4486,3656),(4212,4487,3656),(4213,4488,3656),(4214,4489,3656),(4215,4490,3656),(4216,4491,3656),(4217,4492,3657),(4218,4493,3657),(4219,4494,3657),(4220,4495,3657),(4221,4496,3657),(4222,4497,3657),(4223,4498,3657),(4224,4499,3657),(4225,4500,3657),(4226,4501,3658),(4227,4502,3658),(4228,4503,3658),(4229,4504,3658),(4230,4505,3658),(4231,4506,3658),(4232,4507,3658),(4233,4508,3658),(4234,4509,3658),(4235,4510,3658),(4236,4511,3658),(4237,4512,3659),(4238,4513,3659),(4239,4514,3660),(4240,4515,3660),(4241,4516,3660),(4242,4517,3660),(4243,4518,3660),(4244,4519,3660),(4245,4520,3660),(4246,4521,3660),(4247,4522,3660),(4248,4523,3660),(4249,4524,3660),(4250,4525,3661),(4251,4526,3661),(4252,4527,3661),(4253,4528,3661),(4254,4529,3661),(4255,4530,3661),(4256,4531,3661),(4257,4532,3661),(4258,4533,3661),(4259,4534,3661),(4260,4535,3662),(4261,4536,3662),(4262,4537,3662),(4263,4538,3662),(4264,4539,3662),(4265,4540,3663),(4266,4541,3663),(4267,4542,3663),(4268,4543,3663),(4269,4544,3663),(4270,4545,3663),(4271,4546,3663),(4272,4547,3664),(4273,4548,3664),(4274,4549,3664),(4275,4550,3664),(4276,4551,3664),(4277,4552,3664),(4278,4553,3664),(4279,4554,3664),(4280,4555,3665),(4281,4556,3665),(4282,4557,3665),(4283,4558,3665),(4284,4559,3665),(4285,4560,3665),(4286,4561,3665),(4287,4562,3665),(4288,4563,3665),(4289,4564,3665),(4290,4565,3666),(4291,4566,3666),(4292,4567,3666),(4293,4568,3666),(4294,4569,3666),(4295,4570,3666),(4296,4571,3666),(4297,4572,3666),(4298,4573,3667),(4299,4574,3667),(4300,4575,3667),(4301,4576,3667),(4302,4577,3667),(4303,4578,3667),(4304,4579,3667),(4305,4580,3667),(4306,4581,3667),(4307,4582,3667),(4308,4583,3668),(4309,4584,3668),(4310,4585,3668),(4311,4586,3668),(4312,4587,3668),(4313,4588,3668),(4314,4589,3668),(4315,4590,3668),(4316,4591,3668),(4317,4592,3668),(4318,4593,3669),(4319,4594,3669),(4320,4595,3669),(4321,4596,3669),(4322,4597,3670),(4323,4598,3670),(4324,4599,3670),(4325,4600,3670),(4326,4601,3670),(4327,4602,3670),(4328,4603,3670),(4329,4604,3671),(4330,4605,3671),(4331,4606,3671),(4332,4607,3671),(4333,4608,3671),(4334,4609,3672),(4335,4610,3672),(4336,4611,3672),(4337,4612,3672),(4338,4613,3673),(4339,4614,3673),(4340,4615,3673),(4341,4616,3673),(4342,4617,3673),(4343,4618,3673),(4344,4619,3673),(4345,4620,3674),(4346,4621,3674),(4347,4622,3674),(4348,4623,3674),(4349,4624,3675),(4350,4625,3675),(4351,4626,3675),(4352,4627,3676),(4353,4628,3676),(4354,4629,3676),(4355,4630,3677),(4356,4631,3677),(4357,4632,3677),(4358,4633,3677),(4359,4634,3677),(4360,4635,3677),(4361,4636,3678),(4362,4637,3678),(4363,4638,3678),(4364,4639,3678),(4365,4640,3678),(4366,4641,3679),(4367,4642,3679),(4368,4643,3679),(4369,4644,3679),(4370,4645,3679),(4371,4646,3679),(4372,4647,3679),(4373,4648,3679),(4374,4649,3680),(4375,4650,3680),(4376,4651,3680),(4377,4652,3680),(4378,4653,3681),(4379,4654,3681),(4380,4655,3681),(4381,4656,3681),(4382,4657,3681),(4383,4658,3681),(4384,4659,3682),(4385,4660,3682),(4386,4661,3682),(4387,4662,3682),(4388,4663,3682),(4389,4664,3683),(4390,4665,3683),(4391,4666,3684),(4392,4667,3684),(4393,4668,3685),(4394,4669,3685),(4395,4670,3685),(4396,4671,3686),(4398,4672,3686),(4399,4673,3687),(4400,4674,3687),(4401,4675,3687),(4402,4676,3687),(4403,4677,3688),(4404,4678,3688),(4405,4679,3688),(4406,4680,3688),(4407,4681,3688),(4408,4682,3688),(4409,4683,3688),(4410,4684,3689),(4411,4685,3689),(4412,4686,3689),(4413,4687,3690),(4415,4688,3690),(4416,4689,3690),(4417,4690,3690),(4418,4691,3690),(4419,4692,3690),(4420,4693,3691),(4421,4694,3691),(4422,4695,3691),(4423,4696,3691),(4424,4697,3691),(4425,4698,3691),(4426,4699,3691),(4427,4700,3692),(4429,4701,3692),(4430,4702,3692),(4431,4703,3692),(4432,4704,3692),(4433,4705,3692),(4434,4706,3692),(4435,4707,3692),(4436,4708,3692),(4437,4709,3693),(4438,4710,3693),(4439,4711,3693),(4440,4712,3693),(4441,4713,3693),(4442,4714,3693),(4443,4715,3694),(4444,4716,3694),(4445,4717,3694),(4446,4718,3694),(4447,4719,3694),(4448,4720,3695),(4449,4721,3695),(4450,4722,3695),(4451,4723,3695),(4452,4724,3696),(4453,4725,3696),(4454,4726,3696),(4455,4727,3696),(4456,4728,3696),(4457,4729,3697),(4458,4730,3697),(4459,4731,3697),(4460,4732,3697),(4461,4733,3697),(4462,4734,3698),(4463,4735,3698),(4464,4736,3698),(4465,4737,3698),(4466,4738,3699),(4467,4739,3699),(4468,4740,3699),(4469,4741,3699),(4470,4742,3699),(4471,4743,3699),(4472,4744,3700),(4473,4745,3700),(4474,4746,3700),(4475,4747,3700),(4476,4748,3701),(4477,4749,3701),(4478,4750,3701),(4479,4751,3701),(4480,4752,3702),(4481,4753,3702),(4482,4754,3702),(4483,4755,3702),(4484,4756,3702),(4485,4757,3703),(4486,4758,3703),(4487,4759,3703),(4488,4760,3703),(4489,4761,3703),(4490,4762,3704),(4491,4763,3704),(4492,4764,3704),(4493,4765,3704),(4494,4766,3704),(4495,4767,3705),(4496,4768,3705),(4497,4769,3705),(4498,4770,3705),(4499,4771,3706),(4501,4772,3706),(4502,4773,3706),(4503,4774,3706),(4504,4775,3707),(4506,4776,3707),(4507,4777,3707),(4508,4778,3707),(4509,4779,3708),(4511,4780,3708),(4512,4781,3708),(4513,4782,3708),(4514,4783,3709),(4515,4784,3709),(4516,4785,3709),(4517,4786,3709),(4518,4787,3709),(4519,4788,3709),(4520,4789,3709),(4521,4790,3709),(4522,4791,3710),(4523,4792,3710),(4524,4793,3711),(4525,4794,3711),(4526,4795,3711),(4527,4796,3711),(4528,4797,3711),(4529,4798,3712),(4530,4799,3712),(4531,4800,3712),(4532,4801,3712),(4533,4802,3712),(4534,4803,3712),(4535,4804,3712),(4536,4805,3712),(4537,4806,3713),(4538,4807,3713),(4539,4808,3713),(4540,4809,3713),(4541,4810,3713),(4542,4811,3713),(4543,4812,3713),(4544,4813,3713),(4545,4814,3714),(4546,4815,3714),(4547,4816,3714),(4548,4817,3714),(4549,4818,3714),(4550,4819,3715),(4551,4820,3715),(4552,4821,3715),(4553,4822,3715),(4554,4823,3715),(4555,4824,3715),(4556,4825,3715),(4557,4826,3715),(4558,4827,3715),(4559,4828,3715),(4560,4829,3715),(4561,4830,3715),(4562,4831,3715),(4563,4832,3716),(4564,4833,3716),(4565,4834,3716),(4566,4835,3716),(4567,4836,3716),(4568,4837,3716),(4569,4838,3717),(4570,4839,3717),(4571,4840,3717),(4572,4841,3717),(4573,4842,3717),(4574,4843,3718),(4575,4844,3718),(4576,4845,3718),(4577,4846,3718),(4578,4847,3718),(4579,4848,3718),(4580,4849,3718),(4581,4850,3718),(4582,4851,3718),(4583,4852,3718),(4584,4853,3719),(4585,4854,3719),(4586,4855,3719),(4587,4856,3719),(4588,4857,3719),(4589,4858,3719),(4590,4859,3719),(4591,4860,3720),(4592,4861,3720),(4593,4862,3720),(4594,4863,3720),(4595,4864,3720),(4596,4865,3721),(4597,4866,3721),(4598,4867,3721),(4599,4868,3721),(4600,4869,3721),(4601,4870,3721),(4602,4871,3721),(4603,4872,3721),(4604,4873,3721),(4605,4874,3722),(4606,4875,3722),(4607,4876,3722),(4608,4877,3722),(4609,4878,3722),(4610,4879,3722),(4611,4880,3722),(4612,4881,3722),(4613,4882,3723),(4614,4883,3723),(4615,4884,3723),(4616,4885,3723),(4617,4886,3723),(4618,4887,3723),(4619,4888,3723),(4620,4889,3723),(4621,4890,3723),(4622,4891,3724),(4623,4892,3724),(4624,4893,3724),(4625,4894,3724),(4626,4895,3724),(4627,4896,3724),(4628,4897,3724),(4629,4898,3724),(4630,4899,3724),(4631,4900,3724),(4632,4901,3725),(4633,4902,3725),(4634,4903,3725),(4635,4904,3725),(4636,4905,3725),(4637,4906,3725),(4638,4907,3725),(4639,4908,3725),(4640,4909,3725),(4641,4910,3726),(4642,4911,3726),(4643,4912,3726),(4644,4913,3726),(4645,4914,3726),(4646,4915,3726),(4647,4916,3727),(4648,4917,3727),(4649,4918,3727),(4650,4919,3727),(4651,4920,3727),(4652,4921,3727),(4653,4922,3727),(4654,4923,3727),(4655,4924,3728),(4656,4925,3728),(4657,4926,3728),(4658,4927,3728),(4659,4928,3728),(4660,4929,3728),(4661,4930,3729),(4662,4931,3729),(4663,4932,3729),(4664,4933,3729),(4665,4934,3729),(4666,4935,3729),(4667,4936,3729),(4668,4937,3730),(4669,4938,3730),(4670,4939,3730),(4671,4940,3731),(4672,4941,3731),(4673,4942,3731),(4674,4943,3731),(4675,4944,3731),(4676,4945,3732),(4677,4946,3732),(4678,4947,3732),(4679,4948,3732),(4680,4949,3732),(4681,4950,3732),(4682,4951,3732),(4683,4952,3732),(4684,4953,3732),(4685,4954,3733),(4686,4955,3733),(4687,4956,3733),(4688,4957,3733),(4689,4958,3733),(4690,4959,3733),(4691,4960,3733),(4692,4961,3733),(4693,4962,3733),(4694,4963,3733),(4695,4964,3733),(4696,4977,3746),(4697,4978,3746),(4698,4979,3746),(4699,4980,3746),(4700,4981,3746),(4701,4982,3746),(4702,4983,3746),(4703,4984,3746),(4704,4985,3746),(4705,4986,3746),(4706,4987,3747),(4707,4988,3747),(4708,4989,3747),(4709,4990,3747),(4710,4991,3747),(4711,4992,3747),(4712,4993,3747),(4713,4994,3747),(4714,4995,3748),(4715,4996,3748),(4716,4997,3748),(4717,4998,3748),(4718,4999,3748),(4719,5000,3748),(4720,5001,3748),(4721,5002,3748),(4722,5011,3750),(4723,5012,3750),(4724,5013,3750),(4725,5014,3750),(4726,5015,3750),(4727,5016,3750),(4728,5017,3750),(4729,5018,3750),(4730,5019,3750),(4731,5020,3750),(4732,5021,3750),(4733,5022,3751),(4734,5023,3751),(4735,5024,3751),(4736,5025,3752),(4737,5026,3752),(4738,5027,3752),(4739,5028,3752),(4740,5029,3752),(4741,5030,3752),(4742,5031,3752),(4743,5032,3753),(4744,5033,3753),(4745,5034,3753),(4746,5035,3753),(4747,5036,3753),(4748,5037,3753),(4749,5038,3753),(4750,5039,3754),(4751,5040,3754),(4752,5041,3754),(4753,5042,3754),(4754,5043,3754),(4755,5044,3755),(4756,5045,3755),(4757,5046,3755),(4758,5047,3755),(4759,5048,3755),(4760,5049,3755),(4761,5050,3755),(4762,5051,3755),(4763,5052,3755),(4764,5053,3756),(4765,5054,3756),(4766,5055,3756),(4767,5056,3756),(4768,5057,3756),(4769,5058,3756),(4770,5059,3756),(4771,5060,3757),(4772,5061,3757),(4773,5062,3757),(4774,5063,3757),(4775,5064,3757),(4776,5065,3757),(4777,5066,3757),(4778,5067,3758),(4779,5068,3758),(4780,5069,3758),(4781,5070,3759),(4782,5071,3759),(4783,5072,3759),(4784,5073,3759),(4785,5074,3759),(4786,5075,3760),(4787,5076,3760),(4788,5077,3760),(4789,5078,3760),(4790,5079,3760),(4791,5080,3760),(4792,5081,3760),(4793,5082,3760),(4794,5083,3760),(4795,5084,3760),(4796,5085,3760),(4797,5086,3761),(4798,5087,3761),(4799,5088,3761),(4800,5089,3761),(4801,5090,3762),(4802,5091,3762),(4803,5092,3762),(4804,5093,3762),(4805,5094,3762),(4806,5095,3762),(4807,5096,3762),(4808,5097,3762),(4809,5098,3762),(4810,5099,3763),(4811,5100,3763),(4812,5101,3763),(4813,5102,3764),(4814,5103,3764),(4815,5104,3764),(4816,5105,3764),(4817,5106,3764),(4818,5107,3764),(4819,5108,3764),(4820,5109,3764),(4821,5110,3765),(4822,5111,3765),(4823,5112,3765),(4824,5113,3765),(4825,5114,3765),(4826,5115,3765),(4827,5116,3766),(4828,5117,3766),(4829,5118,3766),(4830,5119,3766),(4831,5120,3766),(4832,5121,3767),(4833,5122,3767),(4834,5123,3767),(4835,5124,3767),(4836,5125,3768),(4837,5126,3768),(4838,5127,3768),(4839,5128,3768),(4840,5129,3768),(4841,5130,3768),(4842,5131,3768),(4843,5132,3768),(4844,5133,3769),(4845,5134,3769),(4846,5135,3769),(4847,5136,3770),(4848,5137,3770),(4849,5138,3770),(4850,5139,3770),(4851,5140,3770),(4852,5141,3770),(4853,5142,3770),(4854,5143,3770),(4855,5144,3771),(4856,5145,3771),(4857,5146,3771),(4858,5147,3771),(4859,5148,3771),(4860,5149,3772),(4861,5150,3772),(4862,5151,3772),(4863,5152,3772),(4864,5153,3772),(4865,5154,3772),(4866,5155,3773),(4867,5156,3773),(4868,5157,3774),(4869,5158,3774),(4870,5159,3774),(4871,5160,3774),(4872,5161,3774),(4873,5162,3774),(4874,5163,3774),(4875,5164,3774),(4876,5165,3774),(4877,5166,3775),(4878,5167,3775),(4879,5168,3775),(4880,5169,3775),(4881,5170,3776),(4882,5171,3776),(4883,5172,3776),(4884,5173,3776),(4885,5174,3776),(4886,5175,3776),(4887,5176,3776),(4888,5177,3776),(4889,5178,3777),(4890,5179,3777),(4891,5180,3777),(4892,5181,3777),(4893,5182,3777),(4894,5183,3777),(4895,5184,3777),(4896,5185,3777),(4897,5186,3777),(4898,5187,3778),(4899,5188,3778),(4900,5189,3778),(4901,3038,3611),(4902,3038,3612),(4903,3038,3613),(4904,3038,3614),(5015,5209,3611),(5016,5210,3611),(5017,5211,3611),(5018,5212,3611),(5019,4535,3661),(5020,3412,3661),(5021,4536,3661),(5022,4537,3661),(5023,4538,3661),(5024,4539,3661),(5025,4613,3672),(5026,4614,3672),(5027,4615,3672),(5028,4616,3672),(5029,4617,3672),(5030,4618,3672),(5031,4619,3672),(5032,4641,3678),(5033,3552,3678),(5034,4642,3678),(5035,4643,3678),(5036,4644,3678),(5037,4645,3678),(5038,4646,3678),(5039,4647,3678),(5040,4648,3678),(5041,4720,3694),(5042,3658,3694),(5043,4721,3694),(5044,4722,3694),(5045,4723,3694),(5046,4767,3704),(5047,3725,3704),(5048,4768,3704),(5049,4769,3704),(5050,4770,3704),(5051,4779,3707),(5052,4780,3707),(5053,4781,3707),(5054,4782,3707),(5055,4791,3709),(5056,4792,3709),(5057,4806,3712),(5058,3774,3712),(5059,4807,3712),(5060,4808,3712),(5061,4809,3712),(5062,4810,3712),(5063,4811,3712),(5064,4812,3712),(5065,4813,3712),(5066,4832,3715),(5067,3807,3715),(5068,4833,3715),(5069,4834,3715),(5070,4835,3715),(5071,4836,3715),(5072,4837,3715),(5073,4843,3717),(5074,3821,3717),(5075,4844,3717),(5076,4845,3717),(5077,4846,3717),(5078,4847,3717),(5079,4848,3717),(5080,4849,3717),(5081,4850,3717),(5082,4851,3717),(5083,4852,3717),(5084,5213,3722),(5085,4910,3725),(5086,4911,3725),(5087,4912,3725),(5088,4913,3725),(5089,4914,3725),(5090,4915,3725),(5091,4940,3730),(5092,3944,3730),(5093,3943,3730),(5094,4941,3730),(5095,4942,3730),(5096,4943,3730),(5097,4944,3730),(5098,3988,3792),(5099,5215,3792),(5100,5214,3792),(5101,3943,3792),(5102,3790,3792),(5103,5216,3792),(5104,5217,3792),(5105,5218,3792),(5106,5219,3792),(5107,5220,3792),(5108,5221,3792),(5109,5222,3792),(5110,5223,3792),(5111,5224,3792),(5112,5225,3792),(5113,5226,3792),(5114,4977,3792),(5115,3986,3792),(5116,4978,3792),(5117,4979,3792),(5118,4980,3792),(5119,4981,3792),(5120,4982,3792),(5121,4983,3792),(5122,4984,3792),(5123,4985,3792),(5124,4986,3792),(5125,5227,3749),(5126,5228,3749),(5127,5229,3749),(5128,5230,3749),(5129,5231,3749),(5130,5232,3749),(5131,5233,3749),(5132,5234,3749),(5133,5133,3753),(5134,4146,3753),(5135,5134,3753),(5136,5135,3753),(5138,4000,3748),(5148,3037,3631),(5163,3040,3612),(5164,3040,3613),(5165,3040,3614),(5166,3040,3615),(5167,3040,3616),(5168,3037,3612),(5169,3037,3613),(5170,3037,3614),(5171,3037,3615),(5172,3037,3616),(5173,3037,3631),(5174,3036,3611),(5175,3036,3612),(5176,3036,3613),(5177,3036,3614),(5178,3036,3615),(5179,3036,3616),(5180,3036,3617),(5181,3036,3618),(5182,3036,3619),(5183,3036,3620),(5184,3036,3621),(5185,3036,3622),(5186,3036,3623),(5187,3036,3624),(5188,3036,3625),(5189,3036,3626),(5190,3036,3627),(5191,3036,3628),(5192,3036,3629),(5193,3036,3630);
/*!40000 ALTER TABLE `UserDistributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRegion`
--

DROP TABLE IF EXISTS `UserRegion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRegion` (
  `UserRegionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`UserRegionID`),
  UNIQUE KEY `UQ_UserRegion` (`UserID`,`RegionID`),
  KEY `FK_UserRegion_Region` (`RegionID`),
  CONSTRAINT `FK_UserRegion_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserRegion_User` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4229 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRegion`
--

LOCK TABLES `UserRegion` WRITE;
/*!40000 ALTER TABLE `UserRegion` DISABLE KEYS */;
INSERT INTO `UserRegion` VALUES (4228,3036,7),(4227,3037,7),(2977,3038,7),(4226,3040,7),(2984,3046,7),(2989,3051,7),(2991,3053,7),(2994,3056,7),(2996,3058,7),(3004,3066,7),(3007,3069,7),(3009,3071,7),(3014,3076,7),(3016,3078,7),(3023,3085,7),(3025,3087,7),(3031,3093,7),(3032,3094,7),(3034,3096,7),(3041,3103,7),(3046,3108,7),(3048,3110,7),(3052,3114,7),(3054,3116,7),(3059,3121,7),(3061,3123,7),(3066,3128,7),(3068,3130,7),(3071,3133,7),(3072,3134,7),(3074,3136,7),(3081,3143,7),(3083,3145,7),(3085,3147,7),(3091,3153,7),(3095,3157,7),(3098,3160,7),(3100,3162,7),(3104,3166,7),(3106,3168,7),(3109,3171,7),(3111,3173,7),(3115,3177,7),(3118,3180,7),(3120,3182,7),(3122,3184,7),(3127,3189,7),(3129,3191,7),(3131,3193,7),(3135,3197,7),(3136,3198,7),(3138,3200,7),(3149,3211,7),(3151,3213,7),(3156,3218,7),(3158,3220,7),(3160,3222,7),(3165,3227,7),(3167,3229,7),(3176,3238,7),(3178,3240,7),(3180,3242,7),(3184,3246,7),(3185,3247,7),(3187,3249,7),(3194,3256,7),(3196,3258,7),(3201,3263,7),(3203,3265,7),(3207,3269,7),(3209,3271,7),(3215,3277,7),(3217,3279,7),(3227,3289,7),(3229,3291,7),(3236,3298,7),(3238,3300,7),(3244,3306,3),(3245,3307,3),(3246,3308,3),(3248,3310,3),(3256,3318,3),(3258,3320,3),(3265,3327,3),(3267,3329,3),(3274,3336,3),(3276,3338,3),(3285,3347,3),(3287,3349,3),(3296,3358,3),(3298,3360,3),(3307,3369,3),(3309,3371,3),(3320,3382,3),(3321,3383,3),(3323,3385,3),(3325,3387,3),(3327,3389,3),(3338,3400,3),(3340,3402,3),(3350,3412,3),(3356,3418,3),(3358,3420,3),(3365,3427,3),(3367,3429,3),(3375,3437,4),(3376,3438,4),(3377,3439,4),(3379,3441,4),(3389,3451,4),(3391,3453,4),(3399,3461,4),(3401,3463,4),(3411,3473,4),(3413,3475,4),(3423,3485,4),(3424,3486,4),(3426,3488,4),(3430,3492,4),(3432,3494,4),(3439,3501,4),(3441,3503,4),(3446,3508,4),(3448,3510,4),(3459,3521,4),(3461,3523,4),(3466,3528,4),(3469,3531,4),(3471,3533,4),(3474,3536,4),(3476,3538,4),(3482,3544,4),(3483,3545,4),(3485,3547,4),(3490,3552,4),(3499,3561,4),(3501,3563,4),(3506,3568,4),(3512,3574,4),(3514,3576,4),(3519,3581,4),(3521,3583,4),(3524,3586,4),(3527,3589,4),(3530,3592,5),(3531,3593,5),(3533,3595,5),(3535,3597,5),(3537,3599,5),(3541,3603,5),(3543,3605,5),(3551,3613,5),(3555,3617,5),(3561,3623,5),(3563,3625,5),(3570,3632,5),(3572,3634,5),(3581,3643,5),(3583,3645,5),(3589,3651,5),(3591,3653,5),(3596,3658,5),(3601,3663,5),(3603,3665,5),(3608,3670,5),(3610,3672,5),(3615,3677,5),(3616,3678,5),(3618,3680,5),(3622,3684,5),(3624,3686,5),(3630,3692,5),(3632,3694,5),(3636,3698,5),(3638,3700,5),(3642,3704,5),(3644,3706,5),(3649,3711,5),(3651,3713,5),(3656,3718,5),(3658,3720,5),(3663,3725,5),(3669,3731,5),(3673,3735,5),(3675,3737,5),(3683,3745,5),(3685,3747,5),(3695,3757,5),(3697,3759,5),(3702,3764,5),(3704,3766,5),(3712,3774,5),(3721,3783,5),(3723,3785,5),(4205,3790,1),(3729,3791,1),(3730,3792,1),(3732,3794,1),(3745,3807,1),(3752,3814,1),(3754,3816,1),(3759,3821,1),(3771,3833,1),(3778,3840,1),(3780,3842,1),(3785,3847,1),(3786,3848,1),(3788,3850,1),(3797,3859,1),(3799,3861,1),(3808,3870,1),(3810,3872,1),(3819,3881,1),(3821,3883,1),(3831,3893,1),(3833,3895,1),(3848,3910,1),(3849,3911,1),(3851,3913,1),(3859,3921,1),(3861,3923,1),(3867,3929,1),(3869,3931,1),(3876,3938,1),(3878,3940,1),(4210,3943,1),(3882,3944,1),(3888,3950,1),(3890,3952,1),(4211,3961,1),(4217,3963,1),(4209,3986,1),(4216,3988,1),(4208,3998,1),(4202,4000,1),(4214,4008,1),(4215,4010,1),(3957,4018,6),(3958,4019,6),(3959,4020,6),(3961,4022,6),(3969,4030,6),(3971,4032,6),(3982,4043,6),(3984,4045,6),(3987,4048,6),(3989,4050,6),(3996,4057,6),(3998,4059,6),(4006,4067,6),(4011,4072,6),(4013,4074,6),(4022,4083,6),(4024,4085,6),(4031,4092,6),(4032,4093,6),(4034,4095,6),(4041,4102,6),(4043,4104,6),(4046,4107,6),(4048,4109,6),(4053,4114,6),(4055,4116,6),(4067,4128,6),(4072,4133,6),(4082,4143,6),(4085,4146,6),(4086,4147,6),(4088,4149,6),(4096,4157,6),(4098,4159,6),(4104,4165,6),(4106,4167,6),(4112,4173,6),(4116,4177,6),(4118,4179,6),(4130,4191,6),(4138,4199,6),(4140,4201,6),(4146,4207,6),(4152,4213,6),(4153,4214,6),(4155,4216,6),(4158,4219,6),(4167,4228,6),(4169,4230,6),(4173,4234,6),(4175,4236,6),(4183,4244,6),(4185,4246,6),(4195,4256,6),(2983,4264,7),(2985,4265,7),(2986,4266,7),(2987,4267,7),(2988,4268,7),(2990,4269,7),(2992,4270,7),(2993,4271,7),(2995,4272,7),(2997,4273,7),(2998,4274,7),(2999,4275,7),(3000,4276,7),(3001,4277,7),(3002,4278,7),(3003,4279,7),(3005,4280,7),(3006,4281,7),(3008,4282,7),(3010,4283,7),(3011,4284,7),(3012,4285,7),(3013,4286,7),(3015,4287,7),(3017,4288,7),(3018,4289,7),(3019,4290,7),(3020,4291,7),(3021,4292,7),(3022,4293,7),(3024,4294,7),(3026,4295,7),(3027,4296,7),(3028,4297,7),(3029,4298,7),(3030,4299,7),(3033,4300,7),(3035,4301,7),(3036,4302,7),(3037,4303,7),(3038,4304,7),(3039,4305,7),(3040,4306,7),(3042,4307,7),(3043,4308,7),(3044,4309,7),(3045,4310,7),(3047,4311,7),(3049,4312,7),(3050,4313,7),(3051,4314,7),(3053,4315,7),(3055,4316,7),(3056,4317,7),(3057,4318,7),(3058,4319,7),(3060,4320,7),(3062,4321,7),(3063,4322,7),(3064,4323,7),(3065,4324,7),(3067,4325,7),(3069,4326,7),(3070,4327,7),(3073,4328,7),(3075,4329,7),(3076,4330,7),(3077,4331,7),(3078,4332,7),(3079,4333,7),(3080,4334,7),(3082,4335,7),(3084,4336,7),(3086,4337,7),(3087,4338,7),(3088,4339,7),(3089,4340,7),(3090,4341,7),(3092,4342,7),(3093,4343,7),(3094,4344,7),(3096,4345,7),(3097,4346,7),(3099,4347,7),(3101,4348,7),(3102,4349,7),(3103,4350,7),(3105,4351,7),(3107,4352,7),(3108,4353,7),(3110,4354,7),(3112,4355,7),(3113,4356,7),(3114,4357,7),(3116,4358,7),(3117,4359,7),(3119,4360,7),(3121,4361,7),(3123,4362,7),(3124,4363,7),(3125,4364,7),(3126,4365,7),(3128,4366,7),(3130,4367,7),(3132,4368,7),(3133,4369,7),(3134,4370,7),(3137,4371,7),(3139,4372,7),(3140,4373,7),(3141,4374,7),(3142,4375,7),(3143,4376,7),(3144,4377,7),(3145,4378,7),(3146,4379,7),(3147,4380,7),(3148,4381,7),(3150,4382,7),(3152,4383,7),(3153,4384,7),(3154,4385,7),(3155,4386,7),(3157,4387,7),(3159,4388,7),(3161,4389,7),(3162,4390,7),(3163,4391,7),(3164,4392,7),(3166,4393,7),(3168,4394,7),(3169,4395,7),(3170,4396,7),(3171,4397,7),(3172,4398,7),(3173,4399,7),(3174,4400,7),(3175,4401,7),(3177,4402,7),(3179,4403,7),(3181,4404,7),(3182,4405,7),(3183,4406,7),(3186,4407,7),(3188,4408,7),(3189,4409,7),(3190,4410,7),(3191,4411,7),(3192,4412,7),(3193,4413,7),(3195,4414,7),(3197,4415,7),(3198,4416,7),(3199,4417,7),(3200,4418,7),(3202,4419,7),(3204,4420,7),(3205,4421,7),(3206,4422,7),(3208,4423,7),(3210,4424,7),(3211,4425,7),(3212,4426,7),(3213,4427,7),(3214,4428,7),(3216,4429,7),(3218,4430,7),(3219,4431,7),(3220,4432,7),(3221,4433,7),(3222,4434,7),(3223,4435,7),(3224,4436,7),(3225,4437,7),(3226,4438,7),(3228,4439,7),(3230,4440,7),(3231,4441,7),(3232,4442,7),(3233,4443,7),(3234,4444,7),(3235,4445,7),(3237,4446,7),(3239,4447,7),(3240,4448,7),(3241,4449,7),(3242,4450,7),(3243,4451,7),(3247,4452,3),(3249,4453,3),(3250,4454,3),(3251,4455,3),(3252,4456,3),(3253,4457,3),(3254,4458,3),(3255,4459,3),(3257,4460,3),(3259,4461,3),(3260,4462,3),(3261,4463,3),(3262,4464,3),(3263,4465,3),(3264,4466,3),(3266,4467,3),(3268,4468,3),(3269,4469,3),(3270,4470,3),(3271,4471,3),(3272,4472,3),(3273,4473,3),(3275,4474,3),(3277,4475,3),(3278,4476,3),(3279,4477,3),(3280,4478,3),(3281,4479,3),(3282,4480,3),(3283,4481,3),(3284,4482,3),(3286,4483,3),(3288,4484,3),(3289,4485,3),(3290,4486,3),(3291,4487,3),(3292,4488,3),(3293,4489,3),(3294,4490,3),(3295,4491,3),(3297,4492,3),(3299,4493,3),(3300,4494,3),(3301,4495,3),(3302,4496,3),(3303,4497,3),(3304,4498,3),(3305,4499,3),(3306,4500,3),(3308,4501,3),(3310,4502,3),(3311,4503,3),(3312,4504,3),(3313,4505,3),(3314,4506,3),(3315,4507,3),(3316,4508,3),(3317,4509,3),(3318,4510,3),(3319,4511,3),(3322,4512,3),(3324,4513,3),(3326,4514,3),(3328,4515,3),(3329,4516,3),(3330,4517,3),(3331,4518,3),(3332,4519,3),(3333,4520,3),(3334,4521,3),(3335,4522,3),(3336,4523,3),(3337,4524,3),(3339,4525,3),(3341,4526,3),(3342,4527,3),(3343,4528,3),(3344,4529,3),(3345,4530,3),(3346,4531,3),(3347,4532,3),(3348,4533,3),(3349,4534,3),(3351,4535,3),(3352,4536,3),(3353,4537,3),(3354,4538,3),(3355,4539,3),(3357,4540,3),(3359,4541,3),(3360,4542,3),(3361,4543,3),(3362,4544,3),(3363,4545,3),(3364,4546,3),(3366,4547,3),(3368,4548,3),(3369,4549,3),(3370,4550,3),(3371,4551,3),(3372,4552,3),(3373,4553,3),(3374,4554,3),(3378,4555,4),(3380,4556,4),(3381,4557,4),(3382,4558,4),(3383,4559,4),(3384,4560,4),(3385,4561,4),(3386,4562,4),(3387,4563,4),(3388,4564,4),(3390,4565,4),(3392,4566,4),(3393,4567,4),(3394,4568,4),(3395,4569,4),(3396,4570,4),(3397,4571,4),(3398,4572,4),(3400,4573,4),(3402,4574,4),(3403,4575,4),(3404,4576,4),(3405,4577,4),(3406,4578,4),(3407,4579,4),(3408,4580,4),(3409,4581,4),(3410,4582,4),(3412,4583,4),(3414,4584,4),(3415,4585,4),(3416,4586,4),(3417,4587,4),(3418,4588,4),(3419,4589,4),(3420,4590,4),(3421,4591,4),(3422,4592,4),(3425,4593,4),(3427,4594,4),(3428,4595,4),(3429,4596,4),(3431,4597,4),(3433,4598,4),(3434,4599,4),(3435,4600,4),(3436,4601,4),(3437,4602,4),(3438,4603,4),(3440,4604,4),(3442,4605,4),(3443,4606,4),(3444,4607,4),(3445,4608,4),(3447,4609,4),(3449,4610,4),(3450,4611,4),(3451,4612,4),(3452,4613,4),(3453,4614,4),(3454,4615,4),(3455,4616,4),(3456,4617,4),(3457,4618,4),(3458,4619,4),(3460,4620,4),(3462,4621,4),(3463,4622,4),(3464,4623,4),(3465,4624,4),(3467,4625,4),(3468,4626,4),(3470,4627,4),(3472,4628,4),(3473,4629,4),(3475,4630,4),(3477,4631,4),(3478,4632,4),(3479,4633,4),(3480,4634,4),(3481,4635,4),(3484,4636,4),(3486,4637,4),(3487,4638,4),(3488,4639,4),(3489,4640,4),(3491,4641,4),(3492,4642,4),(3493,4643,4),(3494,4644,4),(3495,4645,4),(3496,4646,4),(3497,4647,4),(3498,4648,4),(3500,4649,4),(3502,4650,4),(3503,4651,4),(3504,4652,4),(3505,4653,4),(3507,4654,4),(3508,4655,4),(3509,4656,4),(3510,4657,4),(3511,4658,4),(3513,4659,4),(3515,4660,4),(3516,4661,4),(3517,4662,4),(3518,4663,4),(3520,4664,4),(3522,4665,4),(3523,4666,4),(3525,4667,4),(3526,4668,4),(3528,4669,4),(3529,4670,4),(3532,4671,5),(3534,4672,5),(3536,4673,5),(3538,4674,5),(3539,4675,5),(3540,4676,5),(3542,4677,5),(3544,4678,5),(3545,4679,5),(3546,4680,5),(3547,4681,5),(3548,4682,5),(3549,4683,5),(3550,4684,5),(3552,4685,5),(3553,4686,5),(3554,4687,5),(3556,4688,5),(3557,4689,5),(3558,4690,5),(3559,4691,5),(3560,4692,5),(3562,4693,5),(3564,4694,5),(3565,4695,5),(3566,4696,5),(3567,4697,5),(3568,4698,5),(3569,4699,5),(3571,4700,5),(3573,4701,5),(3574,4702,5),(3575,4703,5),(3576,4704,5),(3577,4705,5),(3578,4706,5),(3579,4707,5),(3580,4708,5),(3582,4709,5),(3584,4710,5),(3585,4711,5),(3586,4712,5),(3587,4713,5),(3588,4714,5),(3590,4715,5),(3592,4716,5),(3593,4717,5),(3594,4718,5),(3595,4719,5),(3597,4720,5),(3598,4721,5),(3599,4722,5),(3600,4723,5),(3602,4724,5),(3604,4725,5),(3605,4726,5),(3606,4727,5),(3607,4728,5),(3609,4729,5),(3611,4730,5),(3612,4731,5),(3613,4732,5),(3614,4733,5),(3617,4734,5),(3619,4735,5),(3620,4736,5),(3621,4737,5),(3623,4738,5),(3625,4739,5),(3626,4740,5),(3627,4741,5),(3628,4742,5),(3629,4743,5),(3631,4744,5),(3633,4745,5),(3634,4746,5),(3635,4747,5),(3637,4748,5),(3639,4749,5),(3640,4750,5),(3641,4751,5),(3643,4752,5),(3645,4753,5),(3646,4754,5),(3647,4755,5),(3648,4756,5),(3650,4757,5),(3652,4758,5),(3653,4759,5),(3654,4760,5),(3655,4761,5),(3657,4762,5),(3659,4763,5),(3660,4764,5),(3661,4765,5),(3662,4766,5),(3664,4767,5),(3665,4768,5),(3666,4769,5),(3667,4770,5),(3668,4771,5),(3670,4772,5),(3671,4773,5),(3672,4774,5),(3674,4775,5),(3676,4776,5),(3677,4777,5),(3678,4778,5),(3679,4779,5),(3680,4780,5),(3681,4781,5),(3682,4782,5),(3684,4783,5),(3686,4784,5),(3687,4785,5),(3688,4786,5),(3689,4787,5),(3690,4788,5),(3691,4789,5),(3692,4790,5),(3693,4791,5),(3694,4792,5),(3696,4793,5),(3698,4794,5),(3699,4795,5),(3700,4796,5),(3701,4797,5),(3703,4798,5),(3705,4799,5),(3706,4800,5),(3707,4801,5),(3708,4802,5),(3709,4803,5),(3710,4804,5),(3711,4805,5),(3713,4806,5),(3714,4807,5),(3715,4808,5),(3716,4809,5),(3717,4810,5),(3718,4811,5),(3719,4812,5),(3720,4813,5),(3722,4814,5),(3724,4815,5),(3725,4816,5),(3726,4817,5),(3727,4818,5),(3731,4819,1),(3733,4820,1),(3734,4821,1),(3735,4822,1),(3736,4823,1),(3737,4824,1),(3738,4825,1),(3739,4826,1),(3740,4827,1),(3741,4828,1),(3742,4829,1),(3743,4830,1),(3744,4831,1),(3746,4832,1),(3747,4833,1),(3748,4834,1),(3749,4835,1),(3750,4836,1),(3751,4837,1),(3753,4838,1),(3755,4839,1),(3756,4840,1),(3757,4841,1),(3758,4842,1),(3760,4843,1),(3761,4844,1),(3762,4845,1),(3763,4846,1),(3764,4847,1),(3765,4848,1),(3766,4849,1),(3767,4850,1),(3768,4851,1),(3769,4852,1),(3770,4853,1),(3772,4854,1),(3773,4855,1),(3774,4856,1),(3775,4857,1),(3776,4858,1),(3777,4859,1),(3779,4860,1),(3781,4861,1),(3782,4862,1),(3783,4863,1),(3784,4864,1),(3787,4865,1),(3789,4866,1),(3790,4867,1),(3791,4868,1),(3792,4869,1),(3793,4870,1),(3794,4871,1),(3795,4872,1),(3796,4873,1),(3798,4874,1),(3800,4875,1),(3801,4876,1),(3802,4877,1),(3803,4878,1),(3804,4879,1),(3805,4880,1),(3806,4881,1),(3809,4882,1),(3811,4883,1),(3812,4884,1),(3813,4885,1),(3814,4886,1),(3815,4887,1),(3816,4888,1),(3817,4889,1),(3818,4890,1),(3820,4891,1),(3822,4892,1),(3823,4893,1),(3824,4894,1),(3825,4895,1),(3826,4896,1),(3827,4897,1),(3828,4898,1),(3829,4899,1),(3830,4900,1),(3832,4901,1),(3834,4902,1),(3835,4903,1),(3836,4904,1),(3837,4905,1),(3838,4906,1),(3839,4907,1),(3840,4908,1),(3841,4909,1),(3842,4910,1),(3843,4911,1),(3844,4912,1),(3845,4913,1),(3846,4914,1),(3847,4915,1),(3850,4916,1),(3852,4917,1),(3853,4918,1),(3854,4919,1),(3855,4920,1),(3856,4921,1),(3857,4922,1),(3858,4923,1),(3860,4924,1),(3862,4925,1),(3863,4926,1),(3864,4927,1),(3865,4928,1),(3866,4929,1),(3868,4930,1),(3870,4931,1),(3871,4932,1),(3872,4933,1),(3873,4934,1),(3874,4935,1),(3875,4936,1),(3877,4937,1),(3879,4938,1),(3880,4939,1),(3883,4940,1),(3884,4941,1),(3885,4942,1),(3886,4943,1),(3887,4944,1),(3889,4945,1),(3891,4946,1),(3892,4947,1),(3893,4948,1),(3894,4949,1),(3895,4950,1),(3896,4951,1),(3897,4952,1),(3898,4953,1),(3900,4954,1),(3902,4955,1),(3903,4956,1),(3904,4957,1),(3905,4958,1),(3906,4959,1),(3907,4960,1),(3908,4961,1),(3909,4962,1),(3910,4963,1),(3911,4964,1),(3927,4977,1),(3928,4978,1),(3929,4979,1),(3930,4980,1),(3931,4981,1),(3932,4982,1),(3933,4983,1),(3934,4984,1),(3935,4985,1),(3936,4986,1),(3938,4987,1),(3940,4988,1),(3941,4989,1),(3942,4990,1),(3943,4991,1),(3944,4992,1),(3945,4993,1),(4206,4994,1),(3948,4995,1),(3950,4996,1),(3951,4997,1),(3952,4998,1),(3953,4999,1),(3954,5000,1),(3955,5001,1),(3956,5002,1),(3970,5011,6),(3972,5012,6),(3973,5013,6),(3974,5014,6),(3975,5015,6),(3976,5016,6),(3977,5017,6),(3978,5018,6),(3979,5019,6),(3980,5020,6),(3981,5021,6),(3983,5022,6),(3985,5023,6),(3986,5024,6),(3988,5025,6),(3990,5026,6),(3991,5027,6),(3992,5028,6),(3993,5029,6),(3994,5030,6),(3995,5031,6),(3997,5032,6),(3999,5033,6),(4000,5034,6),(4001,5035,6),(4002,5036,6),(4003,5037,6),(4004,5038,6),(4005,5039,6),(4007,5040,6),(4008,5041,6),(4009,5042,6),(4010,5043,6),(4012,5044,6),(4014,5045,6),(4015,5046,6),(4016,5047,6),(4017,5048,6),(4018,5049,6),(4019,5050,6),(4020,5051,6),(4021,5052,6),(4023,5053,6),(4025,5054,6),(4026,5055,6),(4027,5056,6),(4028,5057,6),(4029,5058,6),(4030,5059,6),(4033,5060,6),(4035,5061,6),(4036,5062,6),(4037,5063,6),(4038,5064,6),(4039,5065,6),(4040,5066,6),(4042,5067,6),(4044,5068,6),(4045,5069,6),(4047,5070,6),(4049,5071,6),(4050,5072,6),(4051,5073,6),(4052,5074,6),(4054,5075,6),(4056,5076,6),(4057,5077,6),(4058,5078,6),(4059,5079,6),(4060,5080,6),(4061,5081,6),(4062,5082,6),(4063,5083,6),(4064,5084,6),(4065,5085,6),(4066,5086,6),(4068,5087,6),(4069,5088,6),(4070,5089,6),(4071,5090,6),(4073,5091,6),(4074,5092,6),(4075,5093,6),(4076,5094,6),(4077,5095,6),(4078,5096,6),(4079,5097,6),(4080,5098,6),(4081,5099,6),(4083,5100,6),(4084,5101,6),(4087,5102,6),(4089,5103,6),(4090,5104,6),(4091,5105,6),(4092,5106,6),(4093,5107,6),(4094,5108,6),(4095,5109,6),(4097,5110,6),(4099,5111,6),(4100,5112,6),(4101,5113,6),(4102,5114,6),(4103,5115,6),(4105,5116,6),(4107,5117,6),(4108,5118,6),(4109,5119,6),(4110,5120,6),(4111,5121,6),(4113,5122,6),(4114,5123,6),(4115,5124,6),(4117,5125,6),(4119,5126,6),(4120,5127,6),(4121,5128,6),(4122,5129,6),(4123,5130,6),(4124,5131,6),(4125,5132,6),(4126,5133,6),(4127,5134,6),(4128,5135,6),(4129,5136,6),(4131,5137,6),(4132,5138,6),(4133,5139,6),(4134,5140,6),(4135,5141,6),(4136,5142,6),(4137,5143,6),(4139,5144,6),(4141,5145,6),(4142,5146,6),(4143,5147,6),(4144,5148,6),(4145,5149,6),(4147,5150,6),(4148,5151,6),(4149,5152,6),(4150,5153,6),(4151,5154,6),(4154,5155,6),(4156,5156,6),(4157,5157,6),(4159,5158,6),(4160,5159,6),(4161,5160,6),(4162,5161,6),(4163,5162,6),(4164,5163,6),(4165,5164,6),(4166,5165,6),(4168,5166,6),(4170,5167,6),(4171,5168,6),(4172,5169,6),(4174,5170,6),(4176,5171,6),(4177,5172,6),(4178,5173,6),(4179,5174,6),(4180,5175,6),(4181,5176,6),(4182,5177,6),(4184,5178,6),(4186,5179,6),(4187,5180,6),(4188,5181,6),(4189,5182,6),(4190,5183,6),(4191,5184,6),(4192,5185,6),(4193,5186,6),(4194,5187,6),(4196,5188,6),(4197,5189,6),(2978,5209,7),(2980,5210,7),(2981,5211,7),(2982,5212,7),(3807,5213,1),(4212,5214,1),(3913,5215,1),(3915,5216,1),(3916,5217,1),(3917,5218,1),(3918,5219,1),(3919,5220,1),(3920,5221,1),(3921,5222,1),(3922,5223,1),(3923,5224,1),(3924,5225,1),(3925,5226,1),(3960,5227,6),(3962,5228,6),(3963,5229,6),(3964,5230,6),(3965,5231,6),(3966,5232,6),(3967,5233,6),(3968,5234,6);
/*!40000 ALTER TABLE `UserRegion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRole`
--

DROP TABLE IF EXISTS `UserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRole` (
  `UserRoleID` bigint(11) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(11) DEFAULT NULL,
  `RoleAnswer` tinyint(4) DEFAULT NULL,
  `TradeLevelID` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`UserRoleID`),
  UNIQUE KEY `UserID_UNIQUE` (`UserID`),
  KEY `FK_UserRole_TradeLevel` (`TradeLevelID`),
  CONSTRAINT `FK_UserRole_TradeLevel` FOREIGN KEY (`TradeLevelID`) REFERENCES `TradeLevel` (`TradeLevelID`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_USERROLE_UserID` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRole`
--

LOCK TABLES `UserRole` WRITE;
/*!40000 ALTER TABLE `UserRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ward`
--

DROP TABLE IF EXISTS `Ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ward` (
  `WardID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DistrictID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`WardID`),
  KEY `FK_Ward_District` (`DistrictID`),
  CONSTRAINT `FK_Ward_District` FOREIGN KEY (`DistrictID`) REFERENCES `District` (`DistrictID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ward`
--

LOCK TABLES `Ward` WRITE;
/*!40000 ALTER TABLE `Ward` DISABLE KEYS */;
INSERT INTO `Ward` VALUES (1,3992,'1'),(2,3993,'2'),(3,3994,'3'),(4,3995,'4'),(5,3996,'5'),(6,3997,'6'),(7,3998,'7'),(8,3999,'8'),(9,4000,'9'),(10,4001,'10'),(11,4002,'1'),(12,4003,'2'),(13,4004,'3'),(14,4005,'4'),(15,4006,'5'),(16,4007,'6'),(17,4008,'7'),(18,4004,'8'),(19,4005,'9'),(20,4006,'10'),(21,4007,'1'),(22,4008,'2'),(23,4008,'10'),(24,4004,'1'),(25,4005,'2'),(26,4006,'3'),(27,4007,'4'),(28,4008,'5'),(29,4004,'6'),(30,4005,'7'),(31,4006,'8'),(32,4007,'9'),(33,4005,'1'),(34,4006,'2'),(35,4007,'3'),(36,4008,'4'),(37,4004,'5'),(38,4005,'6'),(39,4006,'7'),(40,4007,'8'),(41,4008,'9'),(42,4004,'10'),(43,3992,'9'),(44,3993,'10'),(45,3994,'1'),(46,3995,'2'),(47,3996,'3'),(48,3997,'4'),(49,3998,'5'),(50,3999,'6'),(51,4000,'7'),(52,4001,'8'),(53,4002,'9'),(54,4003,'10'),(55,3993,'1'),(56,3994,'2'),(57,3995,'3'),(58,3996,'4'),(59,3997,'5'),(60,3998,'6'),(61,3999,'7'),(62,4000,'8'),(63,4001,'9'),(64,4002,'10'),(65,4003,'1'),(66,3992,'2'),(67,3993,'3'),(68,3994,'4'),(69,3995,'5'),(70,3996,'6'),(71,3997,'7'),(72,3998,'8'),(73,3999,'9'),(74,4000,'10'),(75,4001,'1'),(76,4004,'2'),(77,4005,'3'),(78,4006,'4'),(79,4007,'5'),(80,4008,'6'),(81,4004,'7'),(82,4005,'8'),(83,4006,'9'),(84,4007,'10'),(85,4008,'1'),(86,4009,'1'),(87,4010,'2'),(88,4011,'3'),(89,4012,'4'),(90,4013,'5'),(91,4014,'6'),(92,4015,'7'),(93,4016,'8'),(94,4017,'9'),(95,4018,'10'),(96,4019,'1'),(97,4020,'2'),(98,4021,'3'),(99,4022,'4'),(100,4023,'5'),(101,4024,'6'),(102,4025,'7'),(103,4026,'8'),(104,4021,'9'),(105,4022,'10'),(106,4023,'1'),(107,4024,'2'),(108,4025,'3'),(109,4026,'4'),(110,4021,'5'),(111,4022,'6'),(112,4023,'7'),(113,4024,'8'),(114,4025,'9'),(115,4026,'10'),(116,4024,'10'),(117,4025,'1'),(118,4026,'2'),(119,4009,'9'),(120,4010,'10'),(121,4011,'1'),(122,4012,'2'),(123,4013,'3'),(124,4014,'4'),(125,4015,'5'),(126,4016,'6'),(127,4017,'7'),(128,4018,'8'),(129,4019,'9'),(130,4020,'10'),(131,4021,'1'),(132,4022,'2'),(133,4023,'3'),(134,4024,'4'),(135,4025,'5'),(136,4026,'6'),(137,4021,'7'),(138,4022,'8'),(139,4023,'9'),(140,4026,'1'),(141,4021,'2'),(142,4022,'3'),(143,4023,'4'),(144,4024,'5'),(145,4025,'6'),(146,4026,'7'),(147,4009,'8'),(148,4010,'9'),(149,4011,'10'),(150,4012,'1'),(151,4013,'2'),(152,4014,'3'),(153,4015,'4'),(154,4016,'5'),(155,4017,'6'),(156,4018,'7'),(157,4019,'8'),(158,4020,'9'),(159,4021,'10'),(160,4022,'1'),(161,4023,'10'),(162,4024,'1'),(163,4025,'2'),(164,4026,'3'),(165,4021,'4'),(166,4022,'5'),(167,4023,'6'),(168,4024,'7'),(169,4025,'8'),(170,4026,'9'),(171,4023,'2'),(172,4024,'3'),(173,4025,'4'),(174,4026,'5'),(175,4009,'6'),(176,4010,'7'),(177,4011,'8'),(178,4012,'9'),(179,4013,'10'),(180,4014,'1'),(181,4015,'2'),(182,4016,'3'),(183,4017,'4'),(184,4018,'5'),(185,4019,'6'),(186,4020,'7'),(187,4021,'8'),(188,4022,'9'),(189,4009,'5'),(190,4010,'6'),(191,4011,'7'),(192,4012,'8'),(193,4013,'9'),(194,4014,'10'),(195,4015,'1'),(196,4016,'10'),(197,4017,'1'),(198,4018,'2'),(199,4019,'3'),(200,4020,'4'),(201,4009,'3'),(202,4010,'4'),(203,4011,'5'),(204,4012,'6'),(205,4013,'7'),(206,4014,'8'),(207,4015,'9'),(208,4018,'1'),(209,4019,'2'),(210,4020,'3'),(211,4021,'6'),(212,4022,'7'),(213,4023,'8'),(214,4024,'9'),(215,4025,'10'),(216,4027,'1'),(217,4028,'2'),(218,4029,'3'),(219,4030,'4'),(220,4031,'5'),(221,4032,'6'),(222,4033,'7'),(223,4034,'8'),(224,4035,'9'),(225,4036,'10'),(226,4037,'1'),(227,4038,'2'),(228,4039,'3'),(229,4040,'4'),(230,4041,'5'),(231,4042,'6'),(232,4043,'7'),(233,4044,'8'),(234,4045,'9'),(235,4046,'10'),(236,4047,'1'),(237,4048,'2'),(238,4049,'3'),(239,4050,'4'),(240,4051,'5'),(241,4052,'6'),(242,4053,'7'),(243,4054,'8'),(244,4049,'9'),(245,4050,'10'),(246,4051,'1'),(247,4052,'2'),(248,4053,'3'),(249,4054,'4'),(250,4049,'5'),(251,4050,'6'),(252,4051,'7'),(253,4052,'8'),(254,4053,'9'),(255,4054,'10'),(256,4052,'10'),(257,4053,'1'),(258,4054,'2'),(259,4037,'9'),(260,4038,'10'),(261,4039,'1'),(262,4040,'2'),(263,4041,'3'),(264,4042,'4'),(265,4043,'5'),(266,4044,'6'),(267,4045,'7'),(268,4046,'8'),(269,4047,'9'),(270,4048,'10'),(271,4049,'1'),(272,4050,'2'),(273,4051,'3'),(274,4052,'4'),(275,4053,'5'),(276,4054,'6'),(277,4049,'7'),(278,4050,'8'),(279,4051,'9'),(280,4054,'1'),(281,4049,'2'),(282,4050,'3'),(283,4051,'4'),(284,4052,'5'),(285,4053,'6'),(286,4054,'7'),(287,4037,'8'),(288,4038,'9'),(289,4039,'10'),(290,4040,'1'),(291,4041,'2'),(292,4042,'3'),(293,4043,'4'),(294,4044,'5'),(295,4045,'6'),(296,4046,'7'),(297,4047,'8'),(298,4048,'9'),(299,4049,'10'),(300,4050,'1'),(301,4051,'10'),(302,4052,'1'),(303,4053,'2'),(304,4054,'3'),(305,4049,'4'),(306,4050,'5'),(307,4051,'6'),(308,4052,'7'),(309,4053,'8'),(310,4054,'9'),(311,4051,'2'),(312,4052,'3'),(313,4053,'4'),(314,4054,'5'),(315,4037,'6'),(316,4038,'7'),(317,4039,'8'),(318,4040,'9'),(319,4041,'10'),(320,4042,'1'),(321,4043,'2'),(322,4044,'3'),(323,4045,'4'),(324,4046,'5'),(325,4047,'6'),(326,4048,'7'),(327,4049,'8'),(328,4050,'9'),(329,4037,'5'),(330,4038,'6'),(331,4039,'7'),(332,4040,'8'),(333,4041,'9'),(334,4042,'10'),(335,4043,'1'),(336,4044,'10'),(337,4045,'1'),(338,4046,'2'),(339,4047,'3'),(340,4048,'4'),(341,4037,'3'),(342,4038,'4'),(343,4039,'5'),(344,4040,'6'),(345,4041,'7'),(346,4042,'8'),(347,4043,'9'),(348,4046,'1'),(349,4047,'2'),(350,4048,'3'),(351,4049,'6'),(352,4050,'7'),(353,4051,'8'),(354,4052,'9'),(355,4053,'10'),(356,4055,'1'),(357,4056,'2'),(358,4057,'3'),(359,4058,'4'),(360,4059,'5'),(361,4060,'6'),(362,4061,'7'),(363,4062,'8'),(364,4063,'9'),(365,4064,'10'),(366,4065,'1'),(367,4066,'2'),(368,4067,'3'),(369,4068,'4'),(370,4069,'5'),(371,4070,'6'),(372,4071,'7'),(373,4072,'8'),(374,4067,'9'),(375,4068,'10'),(376,4069,'1'),(377,4070,'2'),(378,4071,'3'),(379,4072,'4'),(380,4067,'5'),(381,4068,'6'),(382,4069,'7'),(383,4070,'8'),(384,4071,'9'),(385,4072,'10'),(386,4070,'10'),(387,4071,'1'),(388,4072,'2'),(389,4055,'9'),(390,4056,'10'),(391,4057,'1'),(392,4058,'2'),(393,4059,'3'),(394,4060,'4'),(395,4061,'5'),(396,4062,'6'),(397,4063,'7'),(398,4064,'8'),(399,4065,'9'),(400,4066,'10'),(401,4067,'1'),(402,4068,'2'),(403,4069,'3'),(404,4070,'4'),(405,4071,'5'),(406,4072,'6'),(407,4067,'7'),(408,4068,'8'),(409,4069,'9'),(410,4072,'1'),(411,4067,'2'),(412,4068,'3'),(413,4069,'4'),(414,4070,'5'),(415,4071,'6'),(416,4072,'7'),(417,4055,'8'),(418,4056,'9'),(419,4057,'10'),(420,4058,'1'),(421,4059,'2'),(422,4060,'3'),(423,4061,'4'),(424,4062,'5'),(425,4063,'6'),(426,4064,'7'),(427,4065,'8'),(428,4066,'9'),(429,4067,'10'),(430,4068,'1'),(431,4069,'10'),(432,4070,'1'),(433,4071,'2'),(434,4072,'3'),(435,4067,'4'),(436,4068,'5'),(437,4069,'6'),(438,4070,'7'),(439,4071,'8'),(440,4072,'9'),(441,4069,'2'),(442,4070,'3'),(443,4071,'4'),(444,4072,'5'),(445,4055,'6'),(446,4056,'7'),(447,4057,'8'),(448,4058,'9'),(449,4059,'10'),(450,4060,'1'),(451,4061,'2'),(452,4062,'3'),(453,4063,'4'),(454,4064,'5'),(455,4065,'6'),(456,4066,'7'),(457,4067,'8'),(458,4068,'9'),(459,4055,'5'),(460,4056,'6'),(461,4057,'7'),(462,4058,'8'),(463,4059,'9'),(464,4060,'10'),(465,4061,'1'),(466,4062,'10'),(467,4063,'1'),(468,4064,'2'),(469,4065,'3'),(470,4066,'4'),(471,4055,'3'),(472,4056,'4'),(473,4057,'5'),(474,4058,'6'),(475,4059,'7'),(476,4060,'8'),(477,4061,'9'),(478,4064,'1'),(479,4065,'2'),(480,4066,'3'),(481,4067,'6'),(482,4068,'7'),(483,4069,'8'),(484,4070,'9'),(485,4071,'10'),(486,4073,'1'),(487,4074,'2'),(488,4075,'3'),(489,4076,'4'),(490,4077,'5'),(491,4078,'6'),(492,4079,'7'),(493,4080,'8'),(494,4081,'9'),(495,4082,'10'),(496,4083,'1'),(497,4084,'2'),(498,4085,'3'),(499,4086,'4'),(500,4087,'5'),(501,4088,'6'),(502,4089,'7'),(503,4090,'8'),(504,4085,'9'),(505,4086,'10'),(506,4087,'1'),(507,4088,'2'),(508,4089,'3'),(509,4090,'4'),(510,4085,'5'),(511,4086,'6'),(512,4087,'7'),(513,4088,'8'),(514,4089,'9'),(515,4090,'10'),(516,4088,'10'),(517,4089,'1'),(518,4090,'2'),(519,4073,'9'),(520,4074,'10'),(521,4075,'1'),(522,4076,'2'),(523,4077,'3'),(524,4078,'4'),(525,4079,'5'),(526,4080,'6'),(527,4081,'7'),(528,4082,'8'),(529,4083,'9'),(530,4084,'10'),(531,4085,'1'),(532,4086,'2'),(533,4087,'3'),(534,4088,'4'),(535,4089,'5'),(536,4090,'6'),(537,4085,'7'),(538,4086,'8'),(539,4087,'9'),(540,4090,'1'),(541,4085,'2'),(542,4086,'3'),(543,4087,'4'),(544,4088,'5'),(545,4089,'6'),(546,4090,'7'),(547,4073,'8'),(548,4074,'9'),(549,4075,'10'),(550,4076,'1'),(551,4077,'2'),(552,4078,'3'),(553,4079,'4'),(554,4080,'5'),(555,4081,'6'),(556,4082,'7'),(557,4083,'8'),(558,4084,'9'),(559,4085,'10'),(560,4086,'1'),(561,4087,'10'),(562,4088,'1'),(563,4089,'2'),(564,4090,'3'),(565,4085,'4'),(566,4086,'5'),(567,4087,'6'),(568,4088,'7'),(569,4089,'8'),(570,4090,'9'),(571,4087,'2'),(572,4088,'3'),(573,4089,'4'),(574,4090,'5'),(575,4073,'6'),(576,4074,'7'),(577,4075,'8'),(578,4076,'9'),(579,4077,'10'),(580,4078,'1'),(581,4079,'2'),(582,4080,'3'),(583,4081,'4'),(584,4082,'5'),(585,4083,'6'),(586,4084,'7'),(587,4085,'8'),(588,4086,'9'),(589,4073,'5'),(590,4074,'6'),(591,4075,'7'),(592,4076,'8'),(593,4077,'9'),(594,4078,'10'),(595,4079,'1'),(596,4080,'10'),(597,4081,'1'),(598,4082,'2'),(599,4083,'3'),(600,4084,'4'),(601,4073,'3'),(602,4074,'4'),(603,4075,'5'),(604,4076,'6'),(605,4077,'7'),(606,4078,'8'),(607,4079,'9'),(608,4082,'1'),(609,4083,'2'),(610,4084,'3'),(611,4085,'6'),(612,4086,'7'),(613,4087,'8'),(614,4088,'9'),(615,4089,'10'),(616,4091,'1'),(617,4092,'2'),(618,4093,'3'),(619,4094,'4'),(620,4095,'5'),(621,4096,'6'),(622,4097,'7'),(623,4098,'8'),(624,4099,'9'),(625,4100,'10'),(626,4101,'1'),(627,4102,'2'),(628,4103,'3'),(629,4104,'4'),(630,4105,'5'),(631,4106,'6'),(632,4107,'7'),(633,4108,'8'),(634,4103,'9'),(635,4104,'10'),(636,4105,'1'),(637,4106,'2'),(638,4107,'3'),(639,4108,'4'),(640,4103,'5'),(641,4104,'6'),(642,4105,'7'),(643,4106,'8'),(644,4107,'9'),(645,4108,'10'),(646,4106,'10'),(647,4107,'1'),(648,4108,'2'),(649,4091,'9'),(650,4092,'10'),(651,4093,'1'),(652,4094,'2'),(653,4095,'3'),(654,4096,'4'),(655,4097,'5'),(656,4098,'6'),(657,4099,'7'),(658,4100,'8'),(659,4101,'9'),(660,4102,'10'),(661,4103,'1'),(662,4104,'2'),(663,4105,'3'),(664,4106,'4'),(665,4107,'5'),(666,4108,'6'),(667,4103,'7'),(668,4104,'8'),(669,4105,'9'),(670,4108,'1'),(671,4103,'2'),(672,4104,'3'),(673,4105,'4'),(674,4106,'5'),(675,4107,'6'),(676,4108,'7'),(677,4091,'8'),(678,4092,'9'),(679,4093,'10'),(680,4094,'1'),(681,4095,'2'),(682,4096,'3'),(683,4097,'4'),(684,4098,'5'),(685,4099,'6'),(686,4100,'7'),(687,4101,'8'),(688,4102,'9'),(689,4103,'10'),(690,4104,'1'),(691,4105,'10'),(692,4106,'1'),(693,4107,'2'),(694,4108,'3'),(695,4103,'4'),(696,4104,'5'),(697,4105,'6'),(698,4106,'7'),(699,4107,'8'),(700,4108,'9'),(701,4105,'2'),(702,4106,'3'),(703,4107,'4'),(704,4108,'5'),(705,4091,'6'),(706,4092,'7'),(707,4093,'8'),(708,4094,'9'),(709,4095,'10'),(710,4096,'1'),(711,4097,'2'),(712,4098,'3'),(713,4099,'4'),(714,4100,'5'),(715,4101,'6'),(716,4102,'7'),(717,4103,'8'),(718,4104,'9'),(719,4091,'5'),(720,4092,'6'),(721,4093,'7'),(722,4094,'8'),(723,4095,'9'),(724,4096,'10'),(725,4097,'1'),(726,4098,'10'),(727,4099,'1'),(728,4100,'2'),(729,4101,'3'),(730,4102,'4'),(731,4091,'3'),(732,4092,'4'),(733,4093,'5'),(734,4094,'6'),(735,4095,'7'),(736,4096,'8'),(737,4097,'9'),(738,4100,'1'),(739,4101,'2'),(740,4102,'3'),(741,4103,'6'),(742,4104,'7'),(743,4105,'8'),(744,4106,'9'),(745,4107,'10'),(746,4092,'1'),(747,4092,'3'),(748,4092,'5'),(749,4092,'8'),(750,4093,'11'),(751,4094,'12'),(752,4095,'13'),(753,4096,'14'),(754,4092,'15'),(755,4092,'16'),(756,4092,'17'),(757,4092,'18'),(758,4092,'19'),(759,4092,'20'),(760,4092,'21'),(761,4092,'22'),(762,4092,'23'),(763,4092,'24'),(764,4093,'25'),(765,4094,'26'),(766,4095,'27'),(767,4096,'28'),(768,4092,'29'),(769,4092,'30'),(770,4092,'31'),(771,4092,'32'),(772,4092,'33'),(773,4092,'34'),(774,4092,'35'),(775,4092,'36'),(776,4092,'37'),(777,4092,'38'),(778,4093,'39'),(779,4094,'40'),(780,4095,'41'),(781,4096,'42'),(782,4092,'43'),(783,4092,'44'),(784,4092,'45'),(785,4092,'46'),(786,4092,'47'),(787,4092,'48'),(788,4092,'49'),(789,4092,'50'),(790,4092,'51'),(791,4092,'52'),(792,4093,'53'),(793,4094,'54'),(794,4095,'55'),(795,4096,'56'),(796,4092,'57'),(797,4092,'58'),(798,4092,'59'),(799,4092,'60'),(800,4092,'61'),(801,4092,'62'),(802,4092,'63'),(803,4092,'64'),(804,4092,'65'),(805,4092,'66'),(806,4093,'67'),(807,4094,'68'),(808,4095,'69'),(809,4096,'70'),(810,4092,'71'),(811,4092,'72'),(812,4092,'73'),(813,4092,'74'),(814,4092,'75'),(815,4092,'76'),(816,4092,'77'),(817,4092,'78'),(818,4092,'79'),(819,4092,'80'),(820,4093,'81'),(821,4094,'82'),(822,4095,'83'),(823,4096,'84'),(824,4092,'85'),(825,4092,'86'),(826,4092,'87'),(827,4092,'88'),(828,4092,'89'),(829,4092,'90'),(830,4092,'91'),(831,4092,'92'),(832,4092,'93'),(833,4092,'94'),(834,4093,'95'),(835,4094,'96'),(836,4095,'97'),(837,4096,'98'),(838,4092,'99'),(839,4092,'100'),(840,4092,'101'),(841,4092,'102'),(842,4092,'103'),(843,4092,'104'),(844,4092,'105'),(845,4092,'106'),(846,4092,'107'),(847,4092,'108'),(848,4093,'109'),(849,4094,'110'),(850,4095,'111'),(851,4096,'112'),(852,4092,'113'),(853,4092,'114'),(854,4092,'115'),(855,4092,'116'),(856,4092,'117'),(857,4092,'118'),(858,4092,'119'),(859,4092,'120'),(860,4092,'121'),(861,4092,'122'),(862,4093,'123'),(863,4094,'124'),(864,4095,'125'),(865,4096,'126'),(866,4092,'127'),(867,4092,'128'),(868,4092,'129'),(869,4092,'130'),(870,4092,'131'),(871,4092,'132'),(872,4092,'133'),(873,4092,'134'),(874,4092,'135'),(875,4092,'136'),(876,4093,'137'),(877,4094,'138'),(878,4095,'139'),(879,4096,'140'),(880,4092,'141'),(881,4092,'142'),(882,4092,'143'),(883,4092,'144'),(884,4092,'145'),(885,4092,'146'),(886,4092,'147'),(887,4092,'148'),(888,4092,'149'),(889,4092,'150'),(890,4093,'151'),(891,4094,'152'),(892,4095,'153'),(893,4096,'154'),(894,4092,'155'),(895,4092,'156'),(896,4092,'157'),(897,4092,'158'),(898,4092,'159'),(899,4092,'160'),(900,4092,'161'),(901,4092,'162'),(902,4092,'163'),(903,4092,'164'),(904,4093,'165'),(905,4094,'166'),(906,4095,'167'),(907,4096,'168'),(908,4092,'169'),(909,4092,'170'),(910,4092,'171'),(911,4092,'172'),(912,4092,'173'),(913,4092,'174'),(914,4092,'175'),(915,4092,'176'),(916,4092,'177'),(917,4092,'178'),(918,4093,'179'),(919,4094,'180'),(920,4095,'181'),(921,4096,'182'),(922,4092,'183'),(923,4092,'184'),(924,4092,'185'),(925,4092,'186'),(926,4092,'187'),(927,4092,'188'),(928,4092,'189'),(929,4092,'190'),(930,4092,'191'),(931,4092,'192'),(932,4038,'296'),(933,4038,'297'),(934,4038,'298'),(935,4038,'299'),(936,4038,'300'),(937,4038,'301'),(938,4038,'302'),(939,4038,'303'),(940,4038,'304'),(941,4039,'305'),(942,4040,'306'),(943,4041,'307'),(944,4042,'308'),(945,4038,'309'),(946,4038,'310'),(947,4038,'311'),(948,4038,'312'),(949,4038,'313'),(950,4038,'314'),(951,4038,'315'),(952,4038,'316'),(953,4038,'317'),(954,4038,'318'),(955,4039,'319'),(956,4040,'320'),(957,4041,'321'),(958,4042,'322'),(959,4038,'323'),(960,4038,'324'),(961,4038,'325'),(962,4038,'326'),(963,4038,'327'),(964,4038,'328'),(965,4038,'329'),(966,4038,'330'),(967,4038,'331'),(968,4038,'332'),(969,4039,'333'),(970,4040,'334'),(971,4041,'335'),(972,4042,'336'),(973,4038,'337'),(974,4038,'338'),(975,4038,'339'),(976,4038,'340'),(977,4038,'341'),(978,4038,'342'),(979,4038,'343'),(980,4038,'344'),(981,4038,'345'),(982,4038,'346'),(983,4039,'347'),(984,4040,'348'),(985,4041,'349'),(986,4042,'350'),(987,4038,'351'),(988,4038,'352'),(989,4038,'353'),(990,4038,'354'),(991,4038,'355'),(992,4038,'356'),(993,4038,'357'),(994,4038,'358'),(995,4038,'359'),(996,4038,'360'),(997,4039,'361'),(998,4040,'362'),(999,4041,'363'),(1000,4042,'364'),(1001,4038,'365'),(1002,4038,'366'),(1003,4038,'367'),(1004,4038,'368'),(1005,4038,'369'),(1006,4038,'370'),(1007,4038,'371'),(1008,4038,'372'),(1009,4038,'373'),(1010,4038,'374'),(1011,4039,'375'),(1012,4040,'376'),(1013,4041,'377'),(1014,4042,'378'),(1015,4038,'379'),(1016,4038,'380'),(1017,4038,'381'),(1018,4038,'382'),(1019,4038,'383'),(1020,4038,'384'),(1021,4038,'385'),(1022,4038,'386'),(1023,4038,'387'),(1024,4038,'388'),(1025,4039,'389'),(1026,4040,'390'),(1027,4041,'391'),(1028,4042,'392'),(1029,4038,'393'),(1030,4038,'394'),(1031,4038,'395'),(1032,4038,'396'),(1033,4038,'397'),(1034,4038,'398'),(1035,4038,'399'),(1036,4038,'400'),(1037,4038,'401'),(1038,4038,'402'),(1039,4039,'403'),(1040,4040,'404'),(1041,4041,'405'),(1042,4042,'406'),(1043,4038,'407'),(1044,4038,'408'),(1045,4038,'409'),(1046,4038,'410'),(1047,4038,'411'),(1048,4038,'412'),(1049,4038,'413'),(1050,4038,'414'),(1051,4038,'415'),(1052,4038,'416'),(1053,4039,'417'),(1054,4040,'418'),(1055,4041,'419'),(1056,4042,'420'),(1057,4038,'421'),(1058,4038,'422'),(1059,4038,'423'),(1060,4038,'424'),(1061,4038,'425'),(1062,4038,'426'),(1063,4038,'427'),(1064,4038,'428'),(1065,4038,'429'),(1066,4038,'430'),(1067,4109,'193'),(1068,4110,'194'),(1069,4111,'195'),(1070,4112,'196'),(1071,4113,'197'),(1072,4113,'198'),(1073,4113,'199'),(1074,4113,'200'),(1075,4113,'201'),(1076,4113,'202'),(1077,4113,'203'),(1078,4113,'204'),(1079,4113,'205'),(1080,4113,'206'),(1081,4109,'207'),(1082,4110,'208'),(1083,4111,'209'),(1084,4112,'210'),(1085,4113,'211'),(1086,4113,'212'),(1087,4113,'213'),(1088,4113,'214'),(1089,4113,'215'),(1090,4113,'216'),(1091,4113,'217'),(1092,4113,'218'),(1093,4113,'219'),(1094,4113,'220'),(1095,4109,'221'),(1096,4110,'222'),(1097,4111,'223'),(1098,4112,'224'),(1099,4113,'225'),(1100,4113,'226'),(1101,4113,'227'),(1102,4113,'228'),(1103,4113,'229'),(1104,4113,'230'),(1105,4113,'231'),(1106,4113,'232'),(1107,4113,'233'),(1108,4113,'234'),(1109,4109,'235'),(1110,4110,'236'),(1111,4111,'237'),(1112,4112,'238'),(1113,4113,'239'),(1114,4113,'240'),(1115,4113,'241'),(1116,4113,'242'),(1117,4113,'243'),(1118,4113,'244'),(1119,4113,'245'),(1120,4113,'246'),(1121,4113,'247'),(1122,4113,'248'),(1123,4109,'249'),(1124,4110,'250'),(1125,4111,'251'),(1126,4112,'252'),(1127,4113,'253'),(1128,4113,'254'),(1129,4113,'255'),(1130,4113,'256'),(1131,4113,'257'),(1132,4113,'258'),(1133,4113,'259'),(1134,4113,'260'),(1135,4113,'261'),(1136,4113,'262'),(1137,4109,'263'),(1138,4110,'264'),(1139,4111,'265'),(1140,4112,'266'),(1141,4113,'267'),(1142,4113,'268'),(1143,4113,'269'),(1144,4113,'270'),(1145,4113,'271'),(1146,4113,'272'),(1147,4113,'273'),(1148,4113,'274'),(1149,4113,'275'),(1150,4113,'276'),(1151,4109,'277'),(1152,4110,'278'),(1153,4111,'279'),(1154,4112,'280'),(1155,4113,'281'),(1156,4113,'282'),(1157,4113,'283'),(1158,4113,'284'),(1159,4113,'285'),(1160,4113,'286'),(1161,4113,'287'),(1162,4113,'288'),(1163,4113,'289'),(1164,4113,'290'),(1165,4109,'291'),(1166,4110,'292'),(1167,4111,'293'),(1168,4112,'294'),(1169,4113,'295');
/*!40000 ALTER TABLE `Ward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlan`
--

DROP TABLE IF EXISTS `WorkingPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlan` (
  `WorkingPlanID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OwnerID` bigint(20) NOT NULL,
  `Month` int(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ApprovedBy` bigint(20) DEFAULT NULL,
  `ApprovedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`WorkingPlanID`),
  UNIQUE KEY `UQ_WorkingPlan` (`OwnerID`,`Month`,`Year`),
  KEY `FK_WorkingPlan_Approved` (`ApprovedBy`),
  CONSTRAINT `FK_WorkingPlan_Approved` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlan_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlan`
--

LOCK TABLES `WorkingPlan` WRITE;
/*!40000 ALTER TABLE `WorkingPlan` DISABLE KEYS */;
INSERT INTO `WorkingPlan` VALUES (286,3093,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 07:13:49','2013-09-16 07:13:49',NULL,'2013-09-16 07:13:49'),(287,3093,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',3,'2013-09-16 07:14:31','2013-09-16 07:14:31',3036,'2013-09-16 09:00:07'),(288,3093,6,2013,'Kế hoạch làm việc trong tháng 7','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 08:11:40','2013-09-16 08:11:40',NULL,'2013-09-16 08:11:40'),(289,3093,9,2013,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 08:11:45','2013-09-16 08:11:45',NULL,'2013-09-16 08:11:45'),(290,3036,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:00:49','2013-09-16 09:00:49',NULL,'2013-09-16 09:00:49'),(291,3038,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',3,'2013-09-16 09:05:21','2013-09-16 09:05:21',3037,'2013-09-16 09:30:04'),(292,3108,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:08:31','2013-09-16 09:08:31',NULL,'2013-09-16 09:08:31'),(293,3038,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',2,'2013-09-16 09:08:39','2013-09-16 09:08:39',NULL,'2013-09-16 09:08:39'),(294,3108,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',3,'2013-09-16 09:08:49','2013-09-16 09:08:49',3093,'2013-09-16 09:26:35'),(295,3038,9,2013,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:12:38','2013-09-16 09:12:38',NULL,'2013-09-16 09:12:38'),(296,3037,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:16:21','2013-09-16 09:16:21',NULL,'2013-09-16 09:16:21'),(297,3093,10,2013,'Kế hoạch làm việc trong tháng 11','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:29:51','2013-09-16 09:29:51',NULL,'2013-09-16 09:29:51'),(298,3093,11,2013,'Kế hoạch làm việc trong tháng 12','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:29:52','2013-09-16 09:29:52',NULL,'2013-09-16 09:29:52'),(299,3037,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:31:05','2013-09-16 09:31:05',NULL,'2013-09-16 09:31:05'),(300,3998,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',3,'2013-09-16 12:55:22','2013-09-16 12:55:22',3943,'2013-09-17 02:53:13'),(301,3998,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 12:55:42','2013-09-16 12:55:42',NULL,'2013-09-16 12:55:42'),(302,3108,NULL,NULL,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 01:10:58','2013-09-17 01:10:58',NULL,'2013-09-17 01:10:58'),(303,3108,NULL,NULL,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 01:10:58','2013-09-17 01:10:58',NULL,'2013-09-17 01:10:58'),(304,3998,9,2013,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 02:15:03','2013-09-17 02:15:03',NULL,'2013-09-17 02:15:03'),(305,3998,6,2013,'Kế hoạch làm việc trong tháng 7','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 02:58:11','2013-09-17 02:58:11',NULL,'2013-09-17 02:58:11'),(306,3998,5,2013,'Kế hoạch làm việc trong tháng 6','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 02:58:11','2013-09-17 02:58:11',NULL,'2013-09-17 02:58:11'),(307,3998,4,2013,'Kế hoạch làm việc trong tháng 5','Tất cả chi tiết kế hoạch làm việc trong tháng này.',2,'2013-09-17 02:58:13','2013-09-17 02:58:13',NULL,'2013-09-17 02:58:13'),(308,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 11','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:41','2013-09-17 03:48:41',NULL,'2013-09-17 03:48:41'),(309,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 11','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:41','2013-09-17 03:48:41',NULL,'2013-09-17 03:48:41'),(310,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 12','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:45','2013-09-17 03:48:45',NULL,'2013-09-17 03:48:45'),(311,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 12','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:45','2013-09-17 03:48:45',NULL,'2013-09-17 03:48:45'),(312,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 1','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:45','2013-09-17 03:48:45',NULL,'2013-09-17 03:48:45'),(313,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 1','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:46','2013-09-17 03:48:46',NULL,'2013-09-17 03:48:46'),(314,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 2','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:46','2013-09-17 03:48:46',NULL,'2013-09-17 03:48:46'),(315,3038,NULL,NULL,'Kế hoạch làm việc trong tháng 2','Tất cả chi tiết kế hoạch làm việc trong tháng này.',NULL,'2013-09-17 03:48:47','2013-09-17 03:48:47',NULL,'2013-09-17 03:48:47'),(316,3038,2,2014,'','',0,'2013-09-17 03:49:08','2013-09-17 03:49:08',NULL,'2013-09-17 03:49:08');
/*!40000 ALTER TABLE `WorkingPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanConstant`
--

DROP TABLE IF EXISTS `WorkingPlanConstant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanConstant` (
  `WorkingPlanConstantID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Code` varchar(100) NOT NULL,
  `Value` bigint(20) NOT NULL,
  PRIMARY KEY (`WorkingPlanConstantID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanConstant`
--

LOCK TABLES `WorkingPlanConstant` WRITE;
/*!40000 ALTER TABLE `WorkingPlanConstant` DISABLE KEYS */;
INSERT INTO `WorkingPlanConstant` VALUES (1,'Số ngày đi field đạt','SNF',5);
/*!40000 ALTER TABLE `WorkingPlanConstant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanDetail`
--

DROP TABLE IF EXISTS `WorkingPlanDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanDetail` (
  `WorkingPlanDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WorkingPlanID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `StartTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `IsFieldDate` int(11) DEFAULT NULL,
  `AccompanyUserID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`WorkingPlanDetailID`),
  KEY `FK_WorkingPlanDetail_WP` (`WorkingPlanID`),
  KEY `FK_WorkingPlanDetail_Acc` (`AccompanyUserID`),
  CONSTRAINT `FK_WorkingPlanDetail_Acc` FOREIGN KEY (`AccompanyUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanDetail_WP` FOREIGN KEY (`WorkingPlanID`) REFERENCES `WorkingPlan` (`WorkingPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=384 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanDetail`
--

LOCK TABLES `WorkingPlanDetail` WRITE;
/*!40000 ALTER TABLE `WorkingPlanDetail` DISABLE KEYS */;
INSERT INTO `WorkingPlanDetail` VALUES (315,287,'đánh giá thị trường NPP Hưng Phát','Di chuyển,kiểm tra và đánh giá thị trường NPP Hưng Phát,tổng kết cuối ngày cùng NPP.','2013-09-03 01:30:00','2013-09-03 10:30:00',0,NULL),(316,287,'Di field NPP Thanh Dat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt','2013-09-05 01:30:00','2013-09-05 10:30:00',1,3121),(317,287,'di Field NPP Thanh Dat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt\r\n\r\n\r\n\r\n\r\n','2013-09-06 01:30:00','2013-09-06 10:30:00',1,3121),(318,287,'Di field NPP Thanh Dat','Họp giao ban,đánh giá, NPP,ĐHKD NPP Thành Đạt,di chuyển','2013-09-07 01:30:00','2013-09-07 10:30:00',1,3121),(319,287,'Hop Van phong','Họp VP,tổng kết tuần trước và triển khai các công việc tuần tiếp theo với NPP và ĐHKD.','2013-09-09 01:30:00','2013-09-09 10:30:00',0,NULL),(320,287,'di field NPP Tung Hoa','Di chuyển,kiểm tra và đánh giá thị trường NPP Tùng Hoa,tổng kết cuối ngày cùng NPP.','2013-09-10 01:30:00','2013-09-10 10:30:00',1,3128),(321,287,'Di field NPP Nam Thai','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Nam Thái','2013-09-12 01:30:00','2013-09-12 10:30:00',1,3108),(322,287,'Di field NPP Tung Hoa','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Tùng Hoa,di chuyển.','2013-09-11 01:30:00','2013-09-11 10:30:00',1,3128),(323,287,'Di field NPP Nam Thai','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Nam Thái','2013-09-13 01:30:00','2013-09-13 10:30:00',1,3108),(324,287,'Di field NPP Nam Thai','Họp giao ban,đánh giá, NPP,ĐHKD NPP Nam Thái,di chuyển','2013-09-14 01:30:00','2013-09-14 10:30:00',1,3108),(325,287,'Di field NPP Hung Phat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP Hưng Phát,di chuyển','2013-09-04 01:30:00','2013-09-04 10:30:00',0,NULL),(331,287,'Hop vung North','Hop vung North','2013-09-17 01:30:00','2013-09-17 10:30:00',0,NULL),(334,287,'Hop North','Hop North','2013-09-16 01:30:00','2013-09-16 10:30:00',0,NULL),(335,287,'di fiels NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.\r\n','2013-09-18 01:30:00','2013-09-18 10:30:00',1,3121),(336,287,'Di fiels NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-19 01:30:00','2013-09-19 10:30:00',1,3121),(337,287,'di field NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-20 01:30:00','2013-09-20 10:30:00',1,3121),(338,287,'Di field NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-21 01:30:00','2013-09-21 10:30:00',1,3121),(341,287,'Hop Van Phong','Hop Van Phong','2013-09-23 01:30:00','2013-09-23 10:30:00',0,NULL),(342,287,'Di thi truong NPP Hai Yen','Di chuyển,kiểm tra và đánh giá thị trường NPP Hải Yến,tổng kết cuối ngày cùng NPP.','2013-09-24 01:30:00','2013-09-24 10:30:00',1,3094),(343,287,'di thi truong NPP Hai Yen','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Hải Yến,di chuyển.','2013-09-25 01:30:00','2013-09-25 10:30:00',1,3094),(344,287,'Di thi truong NPP Ngoc Son','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Ngọc Sơn.','2013-09-26 01:30:00','2013-09-26 10:30:00',1,3114),(345,287,'di thi truong NPP Ngoc Son','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Ngọc Sơn.','2013-09-27 01:30:00','2013-09-27 10:30:00',1,3114),(346,287,'Hop SE/NPP Ngoc Son','Họp giao ban,đánh giá, NPP,ĐHKD NPP Ngọc Sơn,di chuyển','2013-09-28 01:30:00','2013-09-28 10:30:00',0,NULL),(347,287,'Hop Van Phong','Hop Van Phong','2013-09-30 01:30:00','2013-09-30 10:30:00',0,NULL),(348,294,'di field voi SM Binh','S1 : 22\r\nS2 :13\r\nIFT :1.5\r\nDBB : 70\r\nS4:8\r\n','2013-09-03 01:30:00','2013-09-03 10:30:00',1,4314),(349,294,'di thi truong voi SM Binh','S1 : 23\r\nS2 :14\r\nIFT :2\r\nDBB :70\r\nS4:5\r\n','2013-09-04 01:30:00','2013-09-04 10:30:00',1,4314),(350,291,'Di field NPP ','Di field NPP ','2013-08-07 01:30:00','2013-08-07 10:30:00',1,5210),(351,291,'Di field NPP ','Di field NPP ','2013-08-09 01:30:00','2013-08-09 10:30:00',1,5211),(352,294,'di thi truong voi SM Binh','S1 : 23\r\nS2 : 14\r\nIFT :2\r\nDBB :75\r\nS4:9\r\n','2013-09-05 01:30:00','2013-09-05 10:30:00',1,4314),(353,291,'Di field NPP ','Di field NPP ','2013-08-13 01:30:00','2013-08-13 10:30:00',1,5212),(354,291,'Di field NPP ','Di field NPP ','2013-08-06 01:30:00','2013-08-06 10:30:00',1,5210),(355,291,'Hop dau tuan','Hop dau tuan','2013-08-05 01:30:00','2013-08-05 10:30:00',0,NULL),(356,291,'Hop dau tuan','Hop dau tuan','2013-08-12 01:30:00','2013-08-12 10:30:00',0,NULL),(357,294,'di thi truong voi SM Binh','S1 : 21\r\nS2 :13\r\nIFT :1.5\r\nDBB :80\r\nS4:8\r\n','2013-09-06 01:30:00','2013-09-06 10:30:00',1,4314),(358,294,'Hop SE/ NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-07 01:30:00','2013-09-07 10:30:00',0,NULL),(359,294,'lam voi SE/NPP','Làm việc tại NPP Tổng kết đánh giá tuần trước và mục tiêu tuần này','2013-09-09 01:30:00','2013-09-09 10:30:00',0,NULL),(360,294,'Di thi truong voi SM Lu','S1 : 22\r\nS2 :14\r\nIFT :4\r\nDBB :120\r\nS4:12\r\n','2013-09-10 01:30:00','2013-09-10 10:30:00',1,4311),(361,294,'Di thi truong voi Lu','S1 : 23\r\nS2 :14\r\nIFT :4.5\r\nDBB :120\r\nS4:10\r\n','2013-09-11 01:30:00','2013-09-11 10:30:00',1,4311),(362,294,'di thi truong voi SM Lu','S1 : 22\r\nS2 :14\r\nIFT :5\r\nDBB :125\r\nS4:14\r\n','2013-09-12 01:30:00','2013-09-12 10:30:00',1,4311),(363,294,'Di thi truong voi Lu','S1 : 24\r\nS2 :14\r\nIFT :4\r\nDBB :110\r\nS4:8','2013-09-13 01:30:00','2013-09-13 10:30:00',1,4311),(364,294,'Hop voi SE/NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-14 01:30:00','2013-09-14 10:30:00',0,NULL),(365,294,'Hop vung','Hop vung','2013-09-16 01:30:00','2013-09-16 10:30:00',0,NULL),(366,294,'Hop vung','Hop vung','2013-09-17 01:30:00','2013-09-17 10:30:00',0,NULL),(367,294,'Di thi truong voi Tan','S1 : 23\r\nS2 :14\r\nIFT :2.5\r\nDBB :110\r\nS4:10\r\n','2013-09-18 01:30:00','2013-09-18 10:30:00',1,4312),(368,294,'Di thi truong voi Tan','S1 : 24\r\nS2 :15\r\nIFT :4\r\nDBB :130\r\nS4:13\r\n','2013-09-19 01:30:00','2013-09-19 10:30:00',1,4312),(369,294,'Di thi truong voi Tan','S1 : 21\r\nS2 :12\r\nIFT :2\r\nDBB :100\r\nS4:5\r\n','2013-09-20 01:30:00','2013-09-20 10:30:00',1,4312),(370,294,'Hop voi NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-21 01:30:00','2013-09-21 10:30:00',0,NULL),(371,294,'lam viec voi NPP','Làm việc tại NPP Tổng kết đánh giá tuần trước và mục tiêu tuần này\r\n\r\n\r\n\r\n\r\n\r\n','2013-09-23 01:30:00','2013-09-23 10:30:00',0,NULL),(372,294,'Di thi truong voi Bo','S1 : 23\r\nS2 :14\r\nIFT :3\r\nDBB :100\r\nS4:7\r\n','2013-09-24 01:30:00','2013-09-24 10:30:00',1,4313),(373,294,'Di thi truong voi SM: Bo','S1 :24\r\nS2 :14\r\nIFT :3\r\nDBB :110\r\nS4:9\r\n','2013-09-25 01:30:00','2013-09-25 10:30:00',1,4313),(374,294,'di thi truong voi SM Bo','S1 : 23\r\nS2 :13\r\nIFT :4\r\nDBB :120\r\nS4:12\r\n','2013-09-26 01:30:00','2013-09-26 10:30:00',1,4313),(375,294,'Di thi truong voi SM: Bo','S1 : 23\r\nS2 :14\r\nIFT :4\r\nDBB :130\r\nS4:11\r\n','2013-09-27 01:30:00','2013-09-27 10:30:00',1,4313),(376,294,'Hop voi NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính\r\n','2013-09-28 01:30:00','2013-09-28 10:30:00',0,NULL),(377,293,'Di field NPP','Di field NPP','2013-09-06 01:30:00','2013-09-06 10:30:00',1,5212),(378,294,'Hop voi NPP','Làm việc tại NPP Tổng kết đánh giá tháng 09\r\n','2013-09-30 01:30:00','2013-09-30 10:30:00',0,NULL),(379,293,'di field npp','di field npp','2013-09-11 01:30:00','2013-09-11 10:30:00',1,5211),(380,293,'hop cuoi tuan','hop cuoi tuan','2013-09-14 01:30:00','2013-09-14 10:30:00',0,NULL),(381,300,'ecece','ecec','2013-08-08 01:30:00','2013-08-08 10:30:00',1,4990),(382,300,'erffe','erffer','2013-08-09 01:30:00','2013-08-09 10:30:00',1,4989),(383,307,'Công việc hôm nay','Công việc hôm nay','2013-05-08 01:30:00','2013-05-08 10:30:00',1,4991);
/*!40000 ALTER TABLE `WorkingPlanDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanDetailFinal`
--

DROP TABLE IF EXISTS `WorkingPlanDetailFinal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanDetailFinal` (
  `WorkingPlanDetailFinalID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WorkingPlanFinalID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `StartTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `IsFieldDate` tinyint(4) DEFAULT NULL,
  `IsChange` tinyint(4) DEFAULT NULL,
  `AccompanyUserID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`WorkingPlanDetailFinalID`),
  KEY `FK_WorkingPlanDetailFinal_WP` (`WorkingPlanFinalID`),
  KEY `FK_WorkingPlanDetailFinal_Acc` (`AccompanyUserID`),
  CONSTRAINT `FK_WorkingPlanDetailFinal_Acc` FOREIGN KEY (`AccompanyUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanDetailFinal_WP` FOREIGN KEY (`WorkingPlanFinalID`) REFERENCES `WorkingPlanFinal` (`WorkingPlanFinalID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanDetailFinal`
--

LOCK TABLES `WorkingPlanDetailFinal` WRITE;
/*!40000 ALTER TABLE `WorkingPlanDetailFinal` DISABLE KEYS */;
INSERT INTO `WorkingPlanDetailFinal` VALUES (228,109,'Di field NPP ','Di field NPP ','2013-08-07 01:30:00','2013-08-07 10:30:00',1,0,5210),(229,109,'Di field NPP ','Di field NPP ','2013-08-09 01:30:00','2013-08-09 10:30:00',1,0,5211),(230,109,'Di field NPP ','Di field NPP ','2013-08-13 01:30:00','2013-08-13 10:30:00',1,0,5212),(231,109,'Di field NPP ','Di field NPP ','2013-08-06 01:30:00','2013-08-06 10:30:00',1,0,5210),(232,109,'Hop dau tuan','Hop dau tuan','2013-08-05 01:30:00','2013-08-05 10:30:00',0,0,NULL),(233,109,'Hop dau tuan','Hop dau tuan','2013-08-12 01:30:00','2013-08-12 10:30:00',0,0,NULL),(234,114,'di field voi SM Binh','S1 : 22\r\nS2 :13\r\nIFT :1.5\r\nDBB : 70\r\nS4:8\r\n','2013-09-03 01:30:00','2013-09-03 10:30:00',1,0,4314),(235,114,'di thi truong voi SM Binh','S1 : 23\r\nS2 :14\r\nIFT :2\r\nDBB :70\r\nS4:5\r\n','2013-09-04 01:30:00','2013-09-04 10:30:00',1,0,4314),(236,114,'di thi truong voi SM Binh','S1 : 23\r\nS2 : 14\r\nIFT :2\r\nDBB :75\r\nS4:9\r\n','2013-09-05 01:30:00','2013-09-05 10:30:00',1,0,4314),(237,114,'di thi truong voi SM Binh','S1 : 21\r\nS2 :13\r\nIFT :1.5\r\nDBB :80\r\nS4:8\r\n','2013-09-06 01:30:00','2013-09-06 10:30:00',1,0,4314),(238,114,'Hop SE/ NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-07 01:30:00','2013-09-07 10:30:00',0,0,NULL),(239,114,'lam voi SE/NPP','Làm việc tại NPP Tổng kết đánh giá tuần trước và mục tiêu tuần này','2013-09-09 01:30:00','2013-09-09 10:30:00',0,0,NULL),(240,114,'Di thi truong voi SM Lu','S1 : 22\r\nS2 :14\r\nIFT :4\r\nDBB :120\r\nS4:12\r\n','2013-09-10 01:30:00','2013-09-10 10:30:00',1,0,4311),(241,114,'Di thi truong voi Lu','S1 : 23\r\nS2 :14\r\nIFT :4.5\r\nDBB :120\r\nS4:10\r\n','2013-09-11 01:30:00','2013-09-11 10:30:00',1,0,4311),(242,114,'di thi truong voi SM Lu','S1 : 22\r\nS2 :14\r\nIFT :5\r\nDBB :125\r\nS4:14\r\n','2013-09-12 01:30:00','2013-09-12 10:30:00',1,0,4311),(243,114,'Di thi truong voi Lu','S1 : 24\r\nS2 :14\r\nIFT :4\r\nDBB :110\r\nS4:8','2013-09-13 01:30:00','2013-09-13 10:30:00',1,0,4311),(244,114,'Hop voi SE/NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-14 01:30:00','2013-09-14 10:30:00',0,0,NULL),(245,114,'Hop vung','Hop vung','2013-09-16 01:30:00','2013-09-16 10:30:00',0,0,NULL),(246,114,'Hop vung','Hop vung','2013-09-17 01:30:00','2013-09-17 10:30:00',0,0,NULL),(247,114,'Di thi truong voi Tan','S1 : 23\r\nS2 :14\r\nIFT :2.5\r\nDBB :110\r\nS4:10\r\n','2013-09-18 01:30:00','2013-09-18 10:30:00',1,0,4312),(248,114,'Di thi truong voi Tan','S1 : 24\r\nS2 :15\r\nIFT :4\r\nDBB :130\r\nS4:13\r\n','2013-09-19 01:30:00','2013-09-19 10:30:00',1,0,4312),(249,114,'Di thi truong voi Tan','S1 : 21\r\nS2 :12\r\nIFT :2\r\nDBB :100\r\nS4:5\r\n','2013-09-20 01:30:00','2013-09-20 10:30:00',1,0,4312),(250,114,'Hop voi NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính','2013-09-21 01:30:00','2013-09-21 10:30:00',0,0,NULL),(251,114,'lam viec voi NPP','Làm việc tại NPP Tổng kết đánh giá tuần trước và mục tiêu tuần này\r\n\r\n\r\n\r\n\r\n\r\n','2013-09-23 01:30:00','2013-09-23 10:30:00',0,0,NULL),(252,114,'Di thi truong voi Bo','S1 : 23\r\nS2 :14\r\nIFT :3\r\nDBB :100\r\nS4:7\r\n','2013-09-24 01:30:00','2013-09-24 10:30:00',1,0,4313),(253,114,'Di thi truong voi SM: Bo','S1 :24\r\nS2 :14\r\nIFT :3\r\nDBB :110\r\nS4:9\r\n','2013-09-25 01:30:00','2013-09-25 10:30:00',1,0,4313),(254,114,'di thi truong voi SM Bo','S1 : 23\r\nS2 :13\r\nIFT :4\r\nDBB :120\r\nS4:12\r\n','2013-09-26 01:30:00','2013-09-26 10:30:00',1,0,4313),(255,114,'Di thi truong voi SM: Bo','S1 : 23\r\nS2 :14\r\nIFT :4\r\nDBB :130\r\nS4:11\r\n','2013-09-27 01:30:00','2013-09-27 10:30:00',1,0,4313),(256,114,'Hop voi NPP','Làm Việc Tại NPP Làm Việc Với NPP Hàng Hóa Nhập Và Tài Chính\r\n','2013-09-28 01:30:00','2013-09-28 10:30:00',0,0,NULL),(257,114,'Hop voi NPP','Làm việc tại NPP Tổng kết đánh giá tháng 09\r\n','2013-09-30 01:30:00','2013-09-30 10:30:00',0,0,NULL),(258,107,'đánh giá thị trường NPP Hưng Phát','Di chuyển,kiểm tra và đánh giá thị trường NPP Hưng Phát,tổng kết cuối ngày cùng NPP.','2013-09-03 01:30:00','2013-09-03 10:30:00',0,0,NULL),(259,107,'Di field NPP Thanh Dat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt','2013-09-05 01:30:00','2013-09-05 10:30:00',1,0,3121),(260,107,'di Field NPP Thanh Dat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt\r\n\r\n\r\n\r\n\r\n','2013-09-06 01:30:00','2013-09-06 10:30:00',1,0,3121),(261,107,'Di field NPP Thanh Dat','Họp giao ban,đánh giá, NPP,ĐHKD NPP Thành Đạt,di chuyển','2013-09-07 01:30:00','2013-09-07 10:30:00',1,0,3121),(262,107,'Hop Van phong','Họp VP,tổng kết tuần trước và triển khai các công việc tuần tiếp theo với NPP và ĐHKD.','2013-09-09 01:30:00','2013-09-09 10:30:00',0,0,NULL),(263,107,'di field NPP Tung Hoa','Di chuyển,kiểm tra và đánh giá thị trường NPP Tùng Hoa,tổng kết cuối ngày cùng NPP.','2013-09-10 01:30:00','2013-09-10 10:30:00',1,0,3128),(264,107,'Di field NPP Nam Thai','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Nam Thái','2013-09-12 01:30:00','2013-09-12 10:30:00',1,0,3108),(265,107,'Di field NPP Tung Hoa','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Tùng Hoa,di chuyển.','2013-09-11 01:30:00','2013-09-11 10:30:00',1,0,3128),(266,107,'Di field NPP Nam Thai','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Nam Thái','2013-09-13 01:30:00','2013-09-13 10:30:00',1,0,3108),(267,107,'Di field NPP Nam Thai','Họp giao ban,đánh giá, NPP,ĐHKD NPP Nam Thái,di chuyển','2013-09-14 01:30:00','2013-09-14 10:30:00',1,0,3108),(268,107,'Di field NPP Hung Phat','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP Hưng Phát,di chuyển','2013-09-04 01:30:00','2013-09-04 10:30:00',0,0,NULL),(269,107,'Hop vung North','Hop vung North','2013-09-17 01:30:00','2013-09-17 10:30:00',0,0,NULL),(270,107,'Hop North','Hop North','2013-09-16 01:30:00','2013-09-16 10:30:00',0,0,NULL),(271,107,'di fiels NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.\r\n','2013-09-18 01:30:00','2013-09-18 10:30:00',1,0,3121),(272,107,'Di fiels NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-19 01:30:00','2013-09-19 10:30:00',1,0,3121),(273,107,'di field NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-20 01:30:00','2013-09-20 10:30:00',1,0,3121),(274,107,'Di field NPP Thanh Dat','Di chuyển,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Thành Đạt.','2013-09-21 01:30:00','2013-09-21 10:30:00',1,0,3121),(275,107,'Hop Van Phong','Hop Van Phong','2013-09-23 01:30:00','2013-09-23 10:30:00',0,0,NULL),(276,107,'Di thi truong NPP Hai Yen','Di chuyển,kiểm tra và đánh giá thị trường NPP Hải Yến,tổng kết cuối ngày cùng NPP.','2013-09-24 01:30:00','2013-09-24 10:30:00',1,0,3094),(277,107,'di thi truong NPP Hai Yen','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Hải Yến,di chuyển.','2013-09-25 01:30:00','2013-09-25 10:30:00',1,0,3094),(278,107,'Di thi truong NPP Ngoc Son','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Ngọc Sơn.','2013-09-26 01:30:00','2013-09-26 10:30:00',1,0,3114),(279,107,'di thi truong NPP Ngoc Son','Họp giao ban,kiểm tra thị trường,tổng kết cuối ngày,đánh giá NVBH, NPP,ĐHKD NPP Ngọc Sơn.','2013-09-27 01:30:00','2013-09-27 10:30:00',1,0,3114),(280,107,'Hop SE/NPP Ngoc Son','Họp giao ban,đánh giá, NPP,ĐHKD NPP Ngọc Sơn,di chuyển','2013-09-28 01:30:00','2013-09-28 10:30:00',0,0,NULL),(281,107,'Hop Van Phong','Hop Van Phong','2013-09-30 01:30:00','2013-09-30 10:30:00',0,0,NULL),(282,113,'ecece','ecec','2013-08-08 01:30:00','2013-08-08 10:30:00',1,0,4990);
/*!40000 ALTER TABLE `WorkingPlanDetailFinal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanFinal`
--

DROP TABLE IF EXISTS `WorkingPlanFinal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanFinal` (
  `WorkingPlanFinalID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WorkingPlanID` bigint(20) NOT NULL,
  `OwnerID` bigint(20) NOT NULL,
  `Month` int(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(512) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ApprovedBy` bigint(20) DEFAULT NULL,
  `ApprovedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`WorkingPlanFinalID`),
  UNIQUE KEY `UQ_WorkingPlanFinal` (`OwnerID`,`Month`,`Year`),
  KEY `FK_WorkingPlanFinal_Approved` (`ApprovedBy`),
  KEY `FK_WorkingPlanFinal_WP` (`WorkingPlanID`),
  CONSTRAINT `FK_WorkingPlanFinal_Approved` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanFinal_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanFinal_WP` FOREIGN KEY (`WorkingPlanID`) REFERENCES `WorkingPlan` (`WorkingPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanFinal`
--

LOCK TABLES `WorkingPlanFinal` WRITE;
/*!40000 ALTER TABLE `WorkingPlanFinal` DISABLE KEYS */;
INSERT INTO `WorkingPlanFinal` VALUES (106,286,3093,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',2,'2013-09-16 07:13:58','2013-09-16 07:13:58',NULL,'2013-09-16 07:13:58'),(107,287,3093,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',2,'2013-09-16 08:19:17','2013-09-16 08:19:17',NULL,'2013-09-16 08:19:17'),(108,290,3036,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:00:53','2013-09-16 09:00:53',NULL,'2013-09-16 09:00:53'),(109,291,3038,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',2,'2013-09-16 09:05:21','2013-09-16 09:05:21',NULL,'2013-09-16 09:05:21'),(110,292,3108,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:08:34','2013-09-16 09:08:34',NULL,'2013-09-16 09:08:34'),(111,293,3038,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:12:23','2013-09-16 09:12:23',NULL,'2013-09-16 09:12:23'),(112,296,3037,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 09:16:21','2013-09-16 09:16:21',NULL,'2013-09-16 09:16:21'),(113,300,3998,7,2013,'Kế hoạch làm việc trong tháng 8','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-16 12:55:23','2013-09-16 12:55:23',NULL,'2013-09-16 12:55:23'),(114,294,3108,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 01:10:50','2013-09-17 01:10:50',NULL,'2013-09-17 01:10:50'),(115,302,3108,9,2013,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 01:10:58','2013-09-17 01:10:58',NULL,'2013-09-17 01:10:58'),(116,301,3998,8,2013,'Kế hoạch làm việc trong tháng 9','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 02:14:37','2013-09-17 02:14:37',NULL,'2013-09-17 02:14:37'),(117,295,3038,9,2013,'Kế hoạch làm việc trong tháng 10','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 03:48:40','2013-09-17 03:48:40',NULL,'2013-09-17 03:48:40'),(118,308,3038,10,2013,'Kế hoạch làm việc trong tháng 11','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 03:48:41','2013-09-17 03:48:41',NULL,'2013-09-17 03:48:41'),(119,310,3038,11,2013,'Kế hoạch làm việc trong tháng 12','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 03:48:45','2013-09-17 03:48:45',NULL,'2013-09-17 03:48:45'),(120,312,3038,0,2014,'Kế hoạch làm việc trong tháng 1','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 03:48:46','2013-09-17 03:48:46',NULL,'2013-09-17 03:48:46'),(121,314,3038,1,2014,'Kế hoạch làm việc trong tháng 2','Tất cả chi tiết kế hoạch làm việc trong tháng này.',1,'2013-09-17 03:48:46','2013-09-17 03:48:46',NULL,'2013-09-17 03:48:46');
/*!40000 ALTER TABLE `WorkingPlanFinal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanLineManager`
--

DROP TABLE IF EXISTS `WorkingPlanLineManager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanLineManager` (
  `WorkingPlanLineManagerID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Content` varchar(512) DEFAULT NULL,
  `StartTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CreatedBy` bigint(20) NOT NULL,
  PRIMARY KEY (`WorkingPlanLineManagerID`),
  KEY `FK_WorkingPlanLineManager_User` (`CreatedBy`),
  CONSTRAINT `FK_WorkingPlanLineManager_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanLineManager`
--

LOCK TABLES `WorkingPlanLineManager` WRITE;
/*!40000 ALTER TABLE `WorkingPlanLineManager` DISABLE KEYS */;
INSERT INTO `WorkingPlanLineManager` VALUES (1,'Tieu de','fadf','2013-09-09 17:00:00','2013-09-26 17:00:00',1);
/*!40000 ALTER TABLE `WorkingPlanLineManager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingPlanLineManagerAttendance`
--

DROP TABLE IF EXISTS `WorkingPlanLineManagerAttendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPlanLineManagerAttendance` (
  `WorkingPlanLineManagerAttendanceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `InvitedUserID` bigint(20) NOT NULL,
  `WorkingPlanLineManagerID` bigint(20) NOT NULL,
  PRIMARY KEY (`WorkingPlanLineManagerAttendanceID`),
  UNIQUE KEY `UQ_WorkingPlanLineManagerAttendance` (`InvitedUserID`,`WorkingPlanLineManagerAttendanceID`),
  KEY `FK_WPLMA_WPL` (`WorkingPlanLineManagerID`),
  CONSTRAINT `FK_WPLMA_WPL` FOREIGN KEY (`WorkingPlanLineManagerID`) REFERENCES `WorkingPlanLineManager` (`WorkingPlanLineManagerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WPLMA_User` FOREIGN KEY (`InvitedUserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPlanLineManagerAttendance`
--

LOCK TABLES `WorkingPlanLineManagerAttendance` WRITE;
/*!40000 ALTER TABLE `WorkingPlanLineManagerAttendance` DISABLE KEYS */;
INSERT INTO `WorkingPlanLineManagerAttendance` VALUES (79,3037,1),(80,3093,1),(81,3133,1),(82,3197,1),(83,3246,1),(84,3307,1),(85,3382,1),(86,3438,1),(87,3485,1),(88,3544,1),(89,3593,1),(90,3632,1),(91,3677,1),(92,3735,1),(93,3791,1),(94,3847,1),(95,3910,1),(96,3943,1),(97,4019,1),(98,4092,1),(99,4146,1),(100,4213,1);
/*!40000 ALTER TABLE `WorkingPlanLineManagerAttendance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-20 14:33:01

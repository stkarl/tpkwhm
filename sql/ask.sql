/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50530
Source Host           : localhost:3306
Source Database       : fcvnew

Target Server Type    : MYSQL
Target Server Version : 50530
File Encoding         : 65001

Date: 2013-11-12 10:09:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ask`
-- ----------------------------
DROP TABLE IF EXISTS `ask`;
CREATE TABLE `ask` (
  `AskID` bigint(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(125) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AskContent` longtext COLLATE utf8_unicode_ci,
  `AskerID` bigint(11) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT NULL,
  `AskDate` datetime DEFAULT NULL,
  `ClassRosterID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AskID`),
  KEY `FK_Ask_ClassRoster_idx` (`ClassRosterID`),
  KEY `FK_Ask_AskerID` (`AskerID`),
  CONSTRAINT `FK_Ask_AskerID` FOREIGN KEY (`AskerID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Ask_ClassRoster` FOREIGN KEY (`ClassRosterID`) REFERENCES `classroster` (`ClassRosterID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ask
-- ----------------------------

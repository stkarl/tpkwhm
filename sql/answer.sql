/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50530
Source Host           : localhost:3306
Source Database       : fcvnew

Target Server Type    : MYSQL
Target Server Version : 50530
File Encoding         : 65001

Date: 2013-11-12 10:21:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `AnswerID` bigint(11) NOT NULL AUTO_INCREMENT,
  `AskID` bigint(11) DEFAULT NULL,
  `AnswerContent` longtext COLLATE utf8_unicode_ci,
  `RespondentID` bigint(11) DEFAULT NULL,
  `AnswerDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AnswerID`),
  KEY `FK_Answer_RespondentID` (`RespondentID`),
  KEY `FK_Answer_AskID` (`AskID`),
  CONSTRAINT `FK_Answer_AskID` FOREIGN KEY (`AskID`) REFERENCES `ask` (`AskID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Answer_RespondentID` FOREIGN KEY (`RespondentID`) REFERENCES `user` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of answer
-- ----------------------------

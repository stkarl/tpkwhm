ALTER TABLE `FullRangeSKU`
ADD Ratio INT NOT NULL DEFAULT 1;

INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('11', '1', 'Friso Regular 1', '5');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('12', '1', 'Friso Regular 2', '6');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('13', '1', 'Friso Regular 3', '7');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('14', '1', 'Dutch Lady Gold Step 1', '5');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('15', '1', 'Dutch Lady Gold Step 2', '6');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('16', '1', 'Dutch Lady Gold Step 123', '7');
INSERT INTO `PowerSKU`(PowerSKUID,OutletBrandID,Name,DisplayOrder) VALUES ('17', '1', 'Dutch Lady Gold Step 456', '8');



INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('1', '1', 'Friso Gold  Mum 900g', '1', '1', '1');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('2', '1', 'Friso Gold 1 900g', '2', '1', '2');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('3', '1', 'Friso Gold 2 900g', '3', '1', '2');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('4', '1', 'Friso Gold 3 900g', '4', '1', '4');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('5', '1', 'Friso Gold 4 900g', '5', '1', '10');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('6', '2', 'Dutch Lady Mum 900g', '1', '1', '5');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('7', '2', 'Dutch Lady Regular Step 1 900g', '2', '1', '6');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('8', '2', 'Dutch Lady Regular Step 2 900g', '3', '1', '7');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('9', '2', 'Dutch Lady Regular 123 900g', '4', '1', '9');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('10', '2', 'Dutch Lady Regular 456 900g', '5', '1', '8');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('12', '1', 'Friso Regular 1 400g', '6', '2', '11');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('13', '1', 'Friso Regular 1 900g', '7', '1', '11');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('14', '1', 'Friso Regular 2 900g', '8', '1', '12');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('15', '1', 'Friso Regular 3 900g', '9', '1', '13');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('16', '1', 'Friso Regular 3 1500g', '10', '1', '13');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('18', '1', 'Friso Gold  Mum 400g', '12', '2', '1');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('19', '1', 'Friso Gold 1 400g', '13', '2', '2');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('20', '1', 'Friso Gold 2 400g', '14', '2', '3');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('21', '1', 'Friso Gold 3 400g', '15', '2', '4');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('22', '1', 'Friso Gold 3 1500g', '16', '1', '4');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('23', '1', 'Friso Gold 4 1500g', '17', '1', '10');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('24', '2', 'Dutch Lady Gold Step 1 400g', '6', '2', '14');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('25', '2', 'Dutch Lady Gold Step 1 900g', '7', '1', '14');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('26', '2', 'Dutch Lady Gold Step 2 400g', '8', '2', '15');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('27', '2', 'Dutch Lady Gold Step 2 900g', '9', '1', '15');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('28', '2', 'Dutch Lady Gold Step 123 400g', '10', '2', '16');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('29', '2', 'Dutch Lady Gold Step 123 900g', '11', '1', '16');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('30', '2', 'Dutch Lady Gold Step 123 1500g', '12', '1', '16');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('31', '2', 'Dutch Lady Gold Step 456 400g', '13', '2', '17');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('32', '2', 'Dutch Lady Gold Step 456 900g', '14', '1', '17');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('33', '2', 'Dutch Lady Gold Step 456 1500g', '15', '1', '17');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('34', '2', 'Dutch Lady Mum 400g', '16', '2', '5');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('35', '2', 'Dutch Lady Regular Step 1G 400g', '17', '2', '6');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('36', '2', 'Dutch Lady Regular Step 1 400g', '18', '2', '6');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('37', '2', 'Dutch Lady Regular Step 2G 400g', '19', '2', '7');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('38', '2', 'Dutch Lady Regular Step 2 400g', '20', '2', '7');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('39', '2', 'Dutch Lady Regular Step 123G 400g', '21', '2', '9');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('40', '2', 'Dutch Lady Regular Step 123 400g', '22', '2', '9');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('41', '2', 'Dutch Lady Regular Step 123 1500g', '23', '1', '9');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('42', '2', 'Dutch Lady Regular Step 456G 400g', '24', '2', '8');
INSERT INTO `FullRangeSKU`(FullRangeSKUID,OutletBrandID,Name,DisplayOrder,Ratio,PowerSKUID) VALUES ('43', '2', 'Dutch Lady Regular Step 456 1500g', '25', '1', '8');


-- ----------------------------
-- Table structure for `agent`
-- ----------------------------
DROP TABLE IF EXISTS `Agent`;
CREATE TABLE `Agent` (
  `AgentID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AgentID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------

ALTER TABLE User
ADD
(
	AgentID int NULL
);

ALTER TABLE User
ADD CONSTRAINT `FK_User_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE SET NULL ON UPDATE NO ACTION;


ALTER TABLE Outlet
ADD
(
	AgentID int NULL
);

ALTER TABLE Outlet
ADD CONSTRAINT `FK_Outlet_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- ----------------------------
-- Table structure for `agentregion`
-- ----------------------------
DROP TABLE IF EXISTS `AgentRegion`;
CREATE TABLE `AgentRegion` (
  `AgentRegionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AgentID` int(20) DEFAULT NULL,
  `RegionID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AgentRegionID`),
  KEY `FK_AgentRegion_Region` (`RegionID`),
  KEY `FK_AgentRegion_Agent` (`AgentID`),
  CONSTRAINT `FK_AgentRegion_Agent` FOREIGN KEY (`AgentID`) REFERENCES `Agent` (`AgentID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AgentRegion_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- ----------------------------
-- Table structure for `levelregister`
-- ----------------------------
DROP TABLE IF EXISTS `LevelRegister`;
CREATE TABLE `LevelRegister` (
  `LevelID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LevelName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  Register INT,
  PRIMARY KEY (`LevelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

Insert  Into `LevelRegister`(`LevelID`,`LevelName`,`Register`) values (1,'2',12),(2,'3',24),(3,'4',50),(4,'5',100);

-- ----------------------------
-- Table structure for `location`
-- ----------------------------
DROP TABLE IF EXISTS `Location`;

-- ----------------------------
-- Table structure for `outletlocationregister`
-- ----------------------------
DROP TABLE IF EXISTS `OutletLocationRegister`;
CREATE TABLE `OutletLocationRegister` (
  `OutletLocationRegisterID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `IFTDisplayLocationID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OutletLocationRegisterID`),
  KEY `FK_TO_Location` (`IFTDisplayLocationID`),
  KEY `FK_TO_Oulet` (`OutletID`),
  KEY `FK_TO_OuletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_TO_Oulet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TO_OuletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TO_Location` FOREIGN KEY (`IFTDisplayLocationID`) REFERENCES `IFTDisplayLocation` (`IFTDisplayLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `OutletDistributionRegistered`
ADD ( LevelRegister BIGINT(20) NULL );

ALTER TABLE `OutletDistributionRegistered`
ADD CONSTRAINT `FK_OuletDistributor_LevelRegister` FOREIGN KEY (`LevelRegister`) REFERENCES `LevelRegister` (`LevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE OutletAuditResult
ADD FrisoLevelRegister BIGINT NULL,
ADD DlLevelRegister BIGINT NULL,
ADD CONSTRAINT FK_Outletauditresult_LevelRegister_Friso FOREIGN KEY (FrisoLevelRegister) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION,
ADD CONSTRAINT FK_Outletauditresult_LevelRegister_Dl FOREIGN KEY (DlLevelRegister) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION;


ALTER TABLE OutletDistributionRegisteredHistory
ADD FrisoLevelID BIGINT NULL,
ADD DlLevelID BIGINT NULL,
ADD CONSTRAINT FK_OutletDistributionRegisteredHistory_LevelRegister_Friso FOREIGN KEY (FrisoLevelID) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION,
ADD CONSTRAINT FK_OutletDistributionRegisteredHistory_LevelRegister_Dl FOREIGN KEY (DlLevelID) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION;


ALTER TABLE OutletDistributionRegistered
ADD FrisoLevelID BIGINT NULL,
ADD DlLevelID BIGINT NULL,
ADD CONSTRAINT FK_OutletDistributionRegistered_LevelRegister_Friso FOREIGN KEY (FrisoLevelID) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION,
ADD CONSTRAINT FK_OutletDistributionRegistered_LevelRegister_Dl FOREIGN KEY (DlLevelID) REFERENCES LevelRegister (LevelID) ON DELETE SET NULL ON UPDATE NO ACTION;


DELETE  FROM OutletAuditPicture;

DELETE FROM OARFacingIFTDisplay;

DELETE FROM OARFullRangeFacing;

DELETE FROM OARFullRangeSKU;

DELETE FROM OARNoFacing;

DELETE FROM OARPosm;

DELETE FROM OARPowerSKU;                                                                       

DELETE FROM OARPromotion;

DELETE FROM OARLatestbonus;

DELETE FROM OARLatestbonus;

DELETE FROM OARLocationRegistered;

DELETE FROM oarminivalueposm;

DELETE FROM oardbbposmregistered;

DELETE FROM OarAuditSummary;

DELETE FROM OutletAuditResult;

-- Alter table User add attribute Moderator
ALTER TABLE User
ADD Moderator INT NULL;


-- Add table Saleman -----------------------------

DROP TABLE IF EXISTS `Saleman`;
CREATE TABLE `Saleman` (
  `SalemanID` BIGINT(11) NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Name` VARCHAR(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` VARCHAR(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Telephone` VARCHAR(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Type` VARCHAR(2) COMMENT 'The type of sale man NA, MR, SA',
  `ManageID` BIGINT(11) DEFAULT NULL,
  PRIMARY KEY (`SalemanID`),
  KEY `FK_Manage` (`ManageID`),
  CONSTRAINT `FK_Manage` FOREIGN KEY (`ManageID`) REFERENCES `Saleman` (`SalemanID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Add table OutletSaleman ----------------------------------
DROP TABLE IF EXISTS `OutletSaleman`;
CREATE TABLE `OutletSaleman` (
  `OutletSalemanID` BIGINT(11) NOT NULL AUTO_INCREMENT,
  `OutletID` BIGINT(11) NOT NULL,
  `SalemanID` BIGINT(11) NOT NULL,
  `OutletBrandID` BIGINT(11) NOT NULL,
  `FromDate` DATETIME NOT NULL,
  `ToDate` DATETIME NULL,
  `Status` INT NULL,
  PRIMARY KEY (`OutletSalemanID`),
  KEY `FK_OutletSaleman_Saleman` (`SalemanID`),
  KEY `FK_OutletSaleman_Outlet` (`OutletID`),
  KEY `FK_OutletSaleman_OutletBrand` (`OutletBrandID`),
  CONSTRAINT UQ_ UNIQUE (OutletID,SalemanID,OutletBrandID),
  CONSTRAINT `FK_OutletSaleman_Saleman` FOREIGN KEY (`SalemanID`) REFERENCES `Saleman` (`SalemanID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletSaleman_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OutletSaleman_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `Outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE OutletBrandGroup (
  OutletBrandGroupID BIGINT(20) NOT NULL AUTO_INCREMENT,
  Code VARCHAR(255) NOT NULL,
  Name VARCHAR(255) NOT NULL,
  UNIQUE INDEX UQ_OutletBrandGroup(Code ASC),
   PRIMARY KEY(OutletBrandGroupID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO OutletBrandGroup(OutletBrandGroupID, Code, Name) VALUES(1, 'IFT', 'IFT');
INSERT INTO OutletBrandGroup(OutletBrandGroupID, Code, Name) VALUES(2, 'DBB', 'DBB');

ALTER TABLE OutletBrand ADD COLUMN OutletBrandGroupID BIGINT NOT NULL DEFAULT 1;
ALTER TABLE OutletBrand ADD CONSTRAINT FK_OutletBrand_Group FOREIGN KEY (OutletBrandGroupID) REFERENCES OutletBrandGroup(OutletBrandGroupID) ON DELETE NO ACTION ON UPDATE NO ACTION;


DROP TABLE OutletDistributionRegisteredHistory;
DELETE FROM OutletDistributionRegistered;

ALTER TABLE OutletDistributionRegistered ADD COLUMN OutletBrandID BIGINT NOT NULL DEFAULT 1;
ALTER TABLE OutletDistributionRegistered ADD COLUMN Facing INT;
ALTER TABLE OutletDistributionRegistered ADD CONSTRAINT FK_OutletDistReg_OutletBrand FOREIGN KEY (OutletBrandID) REFERENCES OutletBrand(OutletBrandID) ON DELETE NO ACTION ON UPDATE NO ACTION;

UPDATE OutletDistributionRegistered SET Facing = Friso;

INSERT INTO OutletDistributionRegistered (OutletID, Facing, OutletBrandID) (SELECT OutletID, DutchLady, 2 FROM OutletDistributionRegistered WHERE DutchLady > 0);

ALTER TABLE OutletDistributionRegistered DROP COLUMN Friso;
ALTER TABLE OutletDistributionRegistered DROP COLUMN DutchLady;
ALTER TABLE OutletDistributionRegistered DROP FOREIGN KEY FK_OutletDistributionRegistered_LevelRegister_Dl;
ALTER TABLE OutletDistributionRegistered DROP FOREIGN KEY FK_OutletDistributionRegistered_LevelRegister_Friso;
ALTER TABLE OutletDistributionRegistered DROP FOREIGN KEY FK_OuletDistributor_LevelRegister;
ALTER TABLE OutletDistributionRegistered DROP COLUMN DlLevelID;
ALTER TABLE OutletDistributionRegistered DROP COLUMN FrisoLevelID;
ALTER TABLE OutletDistributionRegistered DROP COLUMN LevelRegister;
ALTER TABLE OutletDistributionRegistered ADD COLUMN LevelRegisterID BIGINT;
ALTER TABLE OutletDistributionRegistered ADD CONSTRAINT FK_OutletDistReg_LevelRegister FOREIGN KEY (LevelRegisterID) REFERENCES LevelRegister(LevelID) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE FullRangeSKU ADD COLUMN PowerSKUID BIGINT;
ALTER TABLE FullRangeSKU ADD CONSTRAINT FK_FullRange_PowerSKU FOREIGN KEY (PowerSKUID) REFERENCES PowerSKU(PowerSKUID) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE OARFacingRegistered (
  OARFacingRegisteredID BIGINT NOT NULL AUTO_INCREMENT,
  OutletAuditResultID BIGINT NOT NULL,
  OutletBrandID BIGINT NOT NULL,
  Facing INT,
  LevelRegisterID BIGINT,
  PRIMARY KEY (OARFacingRegisteredID),
  CONSTRAINT FK_OARFacingRegistered_OAR FOREIGN KEY (OutletAuditResultID) REFERENCES OutletAuditResult(OutletAuditResultID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT FK_OARFacingRegistered_OutletBrand FOREIGN KEY (OutletBrandID) REFERENCES OutletBrand(OutletBrandID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_OARFacingRegistered_LevelRegister FOREIGN KEY (LevelRegisterID) REFERENCES LevelRegister(LevelID) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE OARFullRangeSKU ADD COLUMN Facing INT;

ALTER TABLE OARFullRangeSKU DROP COLUMN DisplayOrder;

ALTER TABLE OutletAuditResult ADD COLUMN Notes VARCHAR(512);

ALTER TABLE OutletAuditResult drop Friso ;
ALTER TABLE OutletAuditResult drop DutchLady ;
ALTER TABLE OutletAuditResult drop FrisoLevelRegister ;
ALTER TABLE OutletAuditResult drop DlLevelRegister ;

DROP TABLE IF EXISTS `OARLocationRegistered`;
CREATE TABLE `OARLocationRegistered` (
  `OARLocationRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `IFTDisplayLocationID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OARLocationRegisteredID`),
  CONSTRAINT `FK_OARLocReg_OAR` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARLocReg_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARLocReg_Location` FOREIGN KEY (`IFTDisplayLocationID`) REFERENCES `IFTDisplayLocation` (`IFTDisplayLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `OarLatestBonus`;
CREATE TABLE `OarLatestBonus` (
  `OarLatestBonusID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` BIGINT(20) DEFAULT NULL,
  `OutletBrandID` BIGINT(20) DEFAULT NULL,
  `Correct` INT(20) DEFAULT NULL,
  `EffectiveDate` DATETIME  NULL,
  PRIMARY KEY (`OarLatestBonusID`),
  KEY `FK_OarLastedBonus_OutletAuditResult` (`OutletAuditResultID`),
  KEY `FK_OarLastedBonus_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_OarLastedBonus_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `OutletAuditResult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OarLastedBonus_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `OutletBrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DELETE FROM AuditorOutletTask;
DELETE FROM AuditSchedule;

INSERT INTO Agent (AgentID, Name) VALUES(1, 'IMA');
INSERT INTO Agent (AgentID, Name) VALUES(2, 'Focus Asia');
UPDATE Outlet SET AgentID = 1 WHERE CreatedBy = 2;
UPDATE Outlet SET AgentID = 2 WHERE CreatedBy = 4;

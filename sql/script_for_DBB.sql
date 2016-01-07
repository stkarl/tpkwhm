ALTER TABLE oarfullrangesku
ADD
(
  POSMID bigint(11) DEFAULT NULL
);

ALTER TABLE oarposm
ADD
(
  StatusPosm Text DEFAULT NULL
);

ALTER TABLE iftdisplaylocation
ADD
(
  OutletBrandID bigint(11) DEFAULT NULL,
  KEY `FK_IFTDisplayLocation_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_IFTDisplayLocation_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `outletbrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS `posmminivalue`;
CREATE TABLE `posmminivalue` (
  `POSMMiniValueID` int(11) NOT NULL AUTO_INCREMENT,
  POSMID bigint(11) DEFAULT NULL,
  Value int DEFAULT  NULL,
  PRIMARY KEY (`POSMMiniValueID`),
  KEY `FK_POSMMiniValue_OutletPOSM` (`POSMID`),
  CONSTRAINT `FK_POSMMiniValue_OutletPOSM` FOREIGN KEY (`POSMID`) REFERENCES `outletposm` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `oarminivalueposm`;
CREATE TABLE `oarminivalueposm` (
  `OarMiniValuePosmID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  PRIMARY KEY (`OarMiniValuePosmID`),
  KEY `FK_1` (`OutletAuditResultID`),
  KEY `FK_2` (`PosmID`),
  CONSTRAINT `FK_1` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `outletauditresult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_2` FOREIGN KEY (`PosmID`) REFERENCES `outletposm` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `oarposmminivalue`;

CREATE TABLE `oarposmminivalue` (
  `OARPOSMMiniValueID` bigint(20) NOT NULL AUTO_INCREMENT,
  `POSMID` bigint(20) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  `Values` int(11) DEFAULT NULL,
  PRIMARY KEY (`OARPOSMMiniValueID`),
  KEY `FK_POSMMiniValue_OutletPosm` (`POSMID`) USING BTREE,
  KEY `FK_OARPOSMMiniValue_OutletAuditResult` (`OutletAuditResultID`),
  CONSTRAINT `FK_OARPOSMMiniValue_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `outletauditresult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARPOSMMiniValue_OutletPosm` FOREIGN KEY (`POSMID`) REFERENCES `outletposm` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `dbbposmregistered`;
CREATE TABLE `dbbposmregistered` (
  `DBBPosmRegisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBBPosmRegisteredID`),
  UNIQUE KEY `UQ_OutletID_PosmID_OutletPosmID_DBBRegistered` (`OutletID`,`OutletBrandID`,`PosmID`),
  KEY `FK_DBBRegister_OutletBrand` (`OutletBrandID`),
  KEY `FK_DBBRegister_OutletPosm` (`PosmID`),
  CONSTRAINT `FK_DBBRegister_OutletPosm` FOREIGN KEY (`PosmID`) REFERENCES `outletposm` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DBBRegister_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DBBRegister_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `outletbrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `oardbbposmregistered`;
CREATE TABLE `oardbbposmregistered` (
  `oardbbposmregisteredID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OutletID` bigint(20) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  `PosmID` bigint(20) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`oardbbposmregisteredID`),
  UNIQUE KEY `UQ_OutletID_PosmID_OutletPosmID_OARDBBRegistered` (`OutletID`,`OutletBrandID`,`PosmID`),
  KEY `FK_OARDBBRegister_OutletBrand` (`OutletBrandID`),
  KEY `FK_OARDBBRegister_OutletPosm` (`PosmID`),
  CONSTRAINT `FK_OARDBBRegister_OutletPosm` FOREIGN KEY (`PosmID`) REFERENCES `outletposm` (`OutletPOSMID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_Outlet` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `outletbrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARDBBRegister_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `outletauditresult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

Update iftdisplaylocation set OutletBrandID = 1 where IFTDisplayLocationID = 1;
Update iftdisplaylocation set OutletBrandID = 1 where IFTDisplayLocationID = 2;
Update iftdisplaylocation set OutletBrandID = 1 where IFTDisplayLocationID = 3;
Update iftdisplaylocation set OutletBrandID = 2 where IFTDisplayLocationID = 4;
Update iftdisplaylocation set OutletBrandID = 2 where IFTDisplayLocationID = 5;
Update iftdisplaylocation set OutletBrandID = 2 where IFTDisplayLocationID = 6;
Update iftdisplaylocation set OutletBrandID = 2 where IFTDisplayLocationID = 7;



-- ///////////////////////////////////////////

ALTER TABLE oarpowersku
ADD
(
  OutletPosmID bigint DEFAULT NULL
);
ALTER TABLE oarpowersku DROP Index UQ_OARPowerSKU;
ALTER TABLE oarpowersku ADD CONSTRAINT UQ_OARPowerSKU UNIQUE (OutletAuditResultID,PowerSKUID,OutletPosmID);


DROP TABLE IF EXISTS `oarrival`;
CREATE TABLE `oarrival` (
  `OarRivalID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Rival` int(11) DEFAULT NULL,
  `OutletAuditResultID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`OarRivalID`),
  UNIQUE KEY `UQ_OutletAuditResultID` (OutletAuditResultID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;




INSERT INTO `outletbrand` VALUES ('3', N'Sữa Đặc', 'SD_DBB', '2');


INSERT INTO `outletposm` VALUES ('21', 'U_FE', N'Ụ Sắt', '1', '3');
INSERT INTO `outletposm` VALUES ('22', 'KE_FE', N'Kệ Sắt', '1', '3');


INSERT INTO `iftdisplaylocation` VALUES ('8', '8', N'Chính diện', '8', '3');
INSERT INTO `iftdisplaylocation` VALUES ('9', '9', N'Bên phải cửa hàng', '9', '3');



INSERT INTO `powersku` VALUES ('13', '3', 'DL UHT 180', '1');
INSERT INTO `powersku` VALUES ('14', '3', 'DL UHT 110', '2');
INSERT INTO `powersku` VALUES ('15', '3', 'Yomost 170', '3');
INSERT INTO `powersku` VALUES ('16', '3', 'Yomost 110', '4');
INSERT INTO `powersku` VALUES ('17', '3', 'DKY 110', '5');
INSERT INTO `powersku` VALUES ('18', '3', N'Sữa Đặc', '7');
INSERT INTO `powersku` VALUES ('19', '3', 'Fristi', '6');


INSERT INTO `subfullrangebrand` VALUES ('24', 'DL UHT 180', '3');
INSERT INTO `subfullrangebrand` VALUES ('25', 'DL UHT 110', '3');
INSERT INTO `subfullrangebrand` VALUES ('26', 'Yomost 170', '3');
INSERT INTO `subfullrangebrand` VALUES ('27', 'Yomost 110', '3');
INSERT INTO `subfullrangebrand` VALUES ('28', 'DKY 110', '3');
INSERT INTO `subfullrangebrand` VALUES ('29', 'Fristi', '3');
INSERT INTO `subfullrangebrand` VALUES ('30', 'Sua Dac', '3');



INSERT INTO `fullrangesku` VALUES ('48', '3', 'DL UHT 180', '1', '1', '13', '24', '0');
INSERT INTO `fullrangesku` VALUES ('49', '3', 'DL UHT 110', '2', '1', '14', '25', '0');
INSERT INTO `fullrangesku` VALUES ('50', '3', 'Yomost 170', '3', '1', '15', '26', '0');
INSERT INTO `fullrangesku` VALUES ('51', '3', 'Yomost 110', '4', '1', '16', '27', '0');
INSERT INTO `fullrangesku` VALUES ('52', '3', 'DKY 110', '5', '1', '17', '28', '0');
INSERT INTO `fullrangesku` VALUES ('53', '3', 'Fristi', '6', '1', '19', '29', '0');
INSERT INTO `fullrangesku` VALUES ('54', '3', N'Sữa Đặc', '7', '1', '18', '30', '0');


INSERT INTO `posmminivalue` VALUES ('1', '21', '126');
INSERT INTO `posmminivalue` VALUES ('2', '22', '57');









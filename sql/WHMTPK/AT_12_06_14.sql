CREATE TABLE `LocationHistory` (
  `LocationHistoryID` bigint(20) NOT NULL AUTO_INCREMENT,     
  `ImportMaterialID` bigint(20) DEFAULT NULL,
  `ImportProductID` bigint(20) DEFAULT NULL,
  `OldLocationID` bigint(20) DEFAULT NULL,
  `NewLocationID` bigint(20) DEFAULT NULL,
    `WarehouseID` bigint(20) DEFAULT NULL,

  `CreatedBy` bigint(20) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`LocationHistoryID`),
  KEY `FK_LH_M` (`ImportMaterialID`),
  CONSTRAINT `FK_LH_M` FOREIGN KEY (`ImportMaterialID`) REFERENCES `ImportMaterial` (`ImportMaterialID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_LH_P` (`ImportProductID`),
  CONSTRAINT `FK_LH_P` FOREIGN KEY (`ImportProductID`) REFERENCES `ImportProduct` (`ImportProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_LH_OL` (`OldLocationID`),
  CONSTRAINT `FK_LH_OL` FOREIGN KEY (`OldLocationID`) REFERENCES `WarehouseMap` (`WarehouseMapID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_LH_NL` (`NewLocationID`),
  CONSTRAINT `FK_LH_NL` FOREIGN KEY (`NewLocationID`) REFERENCES `WarehouseMap` (`WarehouseMapID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_LH_CB` (`CreatedBy`),
  CONSTRAINT `FK_LH_CB` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    KEY `FK_LH_WH` (`WarehouseID`),
  CONSTRAINT `FK_LH_WH` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
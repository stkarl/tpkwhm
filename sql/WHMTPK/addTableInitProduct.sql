CREATE TABLE `InitProduct` (
  `InitProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WarehouseID` bigint(20) DEFAULT NULL,
  `InitDate` TIMESTAMP NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NULL,
  PRIMARY KEY (`InitProductID`),
  KEY `FK_InitProduct_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_InitProduct_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_InitProduct_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_InitProduct_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `InitProductDetail` (
  `InitProductDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `InitProductID` bigint(20) DEFAULT NULL,
  `ImportProductID` bigint(20) NOT NULL,
  PRIMARY KEY (`InitProductDetailID`),
  UNIQUE KEY `InitProductDetail_UNIQUE` (`InitProductID`,`ImportProductID`),
  KEY `FK_InitProductDetail_InitProductID` (`InitProductID`),
  CONSTRAINT `FK_InitProductDetail_InitProductID` FOREIGN KEY (`InitProductID`) REFERENCES `InitProduct` (`InitProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_InitProductDetail_ImportProductID` (`ImportProductID`),
  CONSTRAINT `FK_InitProductDetail_ImportProductID` FOREIGN KEY (`ImportProductID`) REFERENCES `ImportProduct` (`ImportProductID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

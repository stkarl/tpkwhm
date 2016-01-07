CREATE TABLE `BookProductBill` (
  `BookProductBillID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CustomerID` bigint(20) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` int DEFAULT NULL,
  `UpdatedBy` bigint (20) DEFAULT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Note` text DEFAULT NULL,
  PRIMARY KEY (`BookProductBillID`),
  KEY `FK_BookProductBill_Customer` (`CustomerID`),
  CONSTRAINT `FK_BookProductBill_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_BookProductBill_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_BookProductBill_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_BookProductBill_UpdatedBy` (`UpdatedBy`),
  CONSTRAINT `FK_BookProductBill_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `BookProduct` (
  `BookProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `BookProductBillID` bigint(20) NOT NULL,
  `ImportProductID` bigint(20) NOT NULL,
  `Note` text DEFAULT NULL,
  PRIMARY KEY (`BookProductID`),
  UNIQUE KEY `Book_Product_UNIQUE` (`ImportProductID`,`BookProductBillID`),
  KEY `FK_BookProduct_Bill` (`BookProductBillID`),
  CONSTRAINT `FK_BookProduct_Bill` FOREIGN KEY (`BookProductBillID`) REFERENCES `BookProductBill` (`BookProductBillID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_BookProduct_Product` (`ImportProductID`),
  CONSTRAINT `FK_BookProduct_Product` FOREIGN KEY (`ImportProductID`) REFERENCES `ImportProduct` (`ImportProductID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE `FixExpense` (
  `FixExpenseID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar (255) NOT NULL,
  `DisplayOrder` int DEFAULT NULL,
  PRIMARY KEY (`FixExpenseID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Arrangement` (
  `ArrangementID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FromDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ToDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Average` double not null,
  `TotalBlack` double not null,
  PRIMARY KEY (`ArrangementID`),
  UNIQUE KEY `Book_Product_UNIQUE` (`FromDate`,`ToDate`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ArrangementDetail` (
  `ArrangementDetailID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ArrangementID` bigint(20) NOT NULL,
  `FixExpenseID` bigint(20) NOT NULL,
  `Value` double not null,
  PRIMARY KEY (`ArrangementDetailID`),
  UNIQUE KEY `Book_Product_UNIQUE` (`ArrangementID`,`FixExpenseID`),
  KEY `FK_ArrangementDetail_Expense` (`FixExpenseID`),
  CONSTRAINT `FK_ArrangementDetail_Expense` FOREIGN KEY (`FixExpenseID`) REFERENCES `FixExpense` (`FixExpenseID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_ArrangementDetail_Arrangement` (`ArrangementID`),
  CONSTRAINT `FK_ArrangementDetail_Arrangement` FOREIGN KEY (`ArrangementID`) REFERENCES `Arrangement` (`ArrangementID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
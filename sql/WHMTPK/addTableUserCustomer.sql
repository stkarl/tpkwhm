
CREATE TABLE `UserCustomer` (
  `UserCustomerID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `CustomerID` bigint(20) NOT NULL,
  PRIMARY KEY (`UserCustomerID`),
  UNIQUE KEY `User_Customer_UNIQUE` (`UserID`,`CustomerID`),
  KEY `FK_UserCustomer_User` (`UserID`),
  CONSTRAINT `FK_UserCustomer_User` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_UserCustomer_Customer` (`CustomerID`),
  CONSTRAINT `FK_UserCustomer_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `UserMaterialCate` (
  `UserMaterialCateID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `MaterialCategoryID` bigint(20) NOT NULL,
  PRIMARY KEY (`UserMaterialCateID`),
  UNIQUE KEY `User_MaterialCategory_UNIQUE` (`UserID`,`MaterialCategoryID`),
  KEY `FK_UserMaterialCate_User` (`UserID`),
  CONSTRAINT `FK_UserMaterialCate_User` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_UserMaterialCate_MaterialCategory` (`MaterialCategoryID`),
  CONSTRAINT `FK_UserMaterialCate_MaterialCategory` FOREIGN KEY (`MaterialCategoryID`) REFERENCES `MaterialCategory` (`MaterialCategoryID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Module` (
  `ModuleID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar (255) NOT NULL,
  `Description` text DEFAULT NULL,
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `UserModule` (
  `UserModuleID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `ModuleID` bigint(20) NOT NULL,
  PRIMARY KEY (`UserModuleID`),
  UNIQUE KEY `User_Module_UNIQUE` (`UserID`,`ModuleID`),
  KEY `FK_UserModule_User` (`UserID`),
  CONSTRAINT `FK_UserModule_User` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_UserModule_Module` (`ModuleID`),
  CONSTRAINT `FK_UserModule_Module` FOREIGN KEY (`ModuleID`) REFERENCES `Module` (`ModuleID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
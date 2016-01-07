
CREATE TABLE `MaterialAndCategory` (
  `MaterialAndCategoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MaterialID` bigint(20) NOT NULL,
  `MaterialCategoryID` bigint(20) NOT NULL,
  PRIMARY KEY (`MaterialAndCategoryID`),
  UNIQUE KEY `Material_MaterialAndCategory_UNIQUE` (`MaterialID`,`MaterialCategoryID`),
  KEY `FK_MaterialAndCategory_Material` (`MaterialID`),
  CONSTRAINT `FK_MaterialAndCategory_Material` FOREIGN KEY (`MaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_MaterialAndCategory_Category` (`MaterialCategoryID`),
  CONSTRAINT `FK_MaterialAndCategory_Category` FOREIGN KEY (`MaterialCategoryID`) REFERENCES `MaterialCategory` (`MaterialCategoryID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
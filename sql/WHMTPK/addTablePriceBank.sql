CREATE TABLE `PriceBank` (
  `PriceBankID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProductNameID` bigint(20) NOT NULL,
  `SizeID` bigint (20) NOT NULL,
  `ColourID` bigint (20) DEFAULT NULL,
  `ThicknessID` bigint (20) DEFAULT NULL,
  `EffectedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Price` DOUBLE DEFAULT NULL,
  `FixedFee` DOUBLE DEFAULT NULL,
  PRIMARY KEY (`PriceBankID`),
  KEY `FK_PriceBank_ProductName` (`ProductNameID`),
  CONSTRAINT `FK_PriceBank_ProductName` FOREIGN KEY (`ProductNameID`) REFERENCES `ProductName` (`ProductNameID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_PriceBank_Size` (`SizeID`),
  CONSTRAINT `FK_PriceBank_Size` FOREIGN KEY (`SizeID`) REFERENCES `Size` (`SizeID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_PriceBank_Thickness` (`ThicknessID`),
  CONSTRAINT `FK_PriceBank_Thickness` FOREIGN KEY (`ThicknessID`) REFERENCES `Thickness` (`ThicknessID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_PriceBank_Colour` (`ColourID`),
  CONSTRAINT `FK_PriceBank_Colour` FOREIGN KEY (`ColourID`) REFERENCES `Colour` (`ColourID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `tpkwhm`.`pricebank` ADD COLUMN `QualityID` BIGINT(20) NULL  AFTER `ThicknessID` ;
ALTER TABLE `tpkwhm`.`pricebank`
ADD CONSTRAINT `FK_PriceBank_Quality`
FOREIGN KEY (`QualityID` )
REFERENCES `tpkwhm`.`quality` (`QualityID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `FK_PriceBank_Quality_idx` (`QualityID` ASC) ;


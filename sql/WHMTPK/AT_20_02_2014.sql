ALTER TABLE `tpkwhm`.`importmaterialbill` ADD COLUMN `MarketID` BIGINT(20) NULL DEFAULT NULL  AFTER `Note` , 
  ADD CONSTRAINT `FK_ImportMaterBill_Market`
  FOREIGN KEY (`MarketID` )
  REFERENCES `tpkwhm`.`market` (`MarketID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION
, ADD INDEX `FK_ImportMaterBill_Market_idx` (`MarketID` ASC) ;

ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `ExportDate` TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `SizeID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Size` FOREIGN KEY (`SizeID`)REFERENCES `tpkwhm`.`size` (`SizeID`)
  ON DELETE RESTRICT ON UPDATE NO ACTION,  ADD INDEX `FK_exportproduct_Size_idx` (`SizeID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `ThicknessID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Thick` FOREIGN KEY (`ThicknessID`)REFERENCES `tpkwhm`.`thickness` (`ThicknessID`)
  ON DELETE RESTRICT ON UPDATE NO ACTION,  ADD INDEX `FK_exportproduct_Thick_idx` (`ThicknessID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `StiffnessID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Stiff` FOREIGN KEY (`StiffnessID`)REFERENCES `tpkwhm`.`stiffness` (`StiffnessID`)
  ON DELETE RESTRICT ON UPDATE NO ACTION,  ADD INDEX `FK_exportproduct_Stiff_idx` (`StiffnessID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `ColourID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Colour` FOREIGN KEY (`ColourID`)REFERENCES `tpkwhm`.`colour` (`ColourID`)
  ON DELETE RESTRICT ON UPDATE NO ACTION,  ADD INDEX `FK_exportproduct_Colour_idx` (`ColourID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `OverlayTypeID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Overlay` FOREIGN KEY (`OverlayTypeID`)REFERENCES `tpkwhm`.`overlaytype` (`OverlayTypeID`)
  ON DELETE RESTRICT ON UPDATE NO ACTION ,  ADD INDEX `FK_exportproduct_Overlay_idx` (`OverlayTypeID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct` ADD COLUMN `MarketID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_exportproduct_Market` FOREIGN KEY (`MarketID`)REFERENCES `tpkwhm`.`market` (`MarketID`)
 ON DELETE RESTRICT ON UPDATE NO ACTION, ADD INDEX `FK_exportproduct_Market_idx` (`MarketID` ASC);

CREATE TABLE `ProductionPlan` (
  `ProductionPlanID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `WarehouseID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProductionPlanID`),
  UNIQUE KEY `ProductionPlan_Name_UNIQUE` (`Name`),
  KEY `FK_ProductionPlan_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_ProductionPlan_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `WarehouseMap` (
  `WarehouseMapID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Code` varchar(100) DEFAULT NULL,
  `WarehouseID` bigint(20) NOT NULL,
  `ImageName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`WarehouseMapID`),
  UNIQUE KEY `WH_Code_UNIQUE` (`Code`),
  UNIQUE KEY `WH_Name_UNIQUE` (`Name`),
  KEY `FK_ProductionPlan_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_WarehouseMap_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `ImportProductBillLog` (
  `ImportProductBillLogID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Note` text DEFAULT NULL,
  `Status` INT(11) DEFAULT NULL,
  `ImportProductBillID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL,
  PRIMARY KEY (`ImportProductBillLogID`),
  KEY `FK_ImportProductBillLog_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ImportProductBillLog_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `USER` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_ImportProductBillLog_Bill` (`ImportProductBillID`),
  CONSTRAINT `FK_ImportProductBillLog_Bill` FOREIGN KEY (`ImportProductBillID`) REFERENCES `importproductbill` (`ImportProductBillID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ImportMaterialBillLog` (
  `ImportMaterialBillLogID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Note` text DEFAULT NULL,
  `Status` INT(11) DEFAULT NULL,
  `ImportMaterialBillID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL,
  PRIMARY KEY (`ImportMaterialBillLogID`),
  KEY `FK_ImportMaterialBillLog_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ImportMaterialBillLog_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `USER` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_ImportMaterialBillLog_Bill` (`ImportMaterialBillID`),
  CONSTRAINT `FK_ImportMaterialBillLog_Bill` FOREIGN KEY (`ImportMaterialBillID`) REFERENCES `importmaterialbill` (`ImportMaterialBillID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportProductBillLog` (
  `ExportProductBillLogID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Note` text DEFAULT NULL,
  `Status` INT(11) DEFAULT NULL,
  `ExportProductBillID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL,
  PRIMARY KEY (`ExportProductBillLogID`),
  KEY `FK_ExportProductBillLog_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ExportProductBillLog_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `USER` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_ExportProductBillLog_Bill` (`ExportProductBillID`),
  CONSTRAINT `FK_ExportProductBillLog_Bill` FOREIGN KEY (`ExportProductBillID`) REFERENCES `exportproductbill` (`ExportProductBillID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportMaterialBillLog` (
  `ExportMaterialBillLogID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Note` text DEFAULT NULL,
  `Status` INT(11) DEFAULT NULL,
  `ExportMaterialBillID` bigint(20) NOT NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NOT NULL,
  PRIMARY KEY (`ExportMaterialBillLogID`),
  KEY `FK_ExportMaterialBillLog_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ExportMaterialBillLog_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `USER` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_ExportMaterialBillLog_Bill` (`ExportMaterialBillID`),
  CONSTRAINT `FK_ExportMaterialBillLog_Bill` FOREIGN KEY (`ExportMaterialBillID`) REFERENCES `exportmaterialbill` (`ExportMaterialBillID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `MaterialMeasurement` (
  `MaterialMeasurementID` BIGINT(11) NOT NULL AUTO_INCREMENT,
  `MaterialID` BIGINT(11) NOT NULL,
  `WarehouseID` BIGINT(11) NOT NULL,
  `Value` double DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaterialMeasurementID`),
  CONSTRAINT `FK_MaterialMeasure_Material` FOREIGN KEY (`MaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  CONSTRAINT `FK_MaterialMeasure_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  CONSTRAINT `FK_MaterialMeasure_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

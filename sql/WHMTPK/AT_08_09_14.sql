ALTER TABLE `tpkwhm`.`user` ADD COLUMN `Phone` VARCHAR(45) NULL DEFAULT NULL  AFTER `WarehouseID` ;

CREATE TABLE `SaleReason` (
  `SaleReasonID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Reason` varchar (255) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`SaleReasonID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `BookBillSaleReason` (
  `BookBillSaleReasonID` bigint(20) NOT NULL AUTO_INCREMENT,
  `BookProductBillID` bigint(20) NOT NULL,
  `SaleReasonID` bigint(20) NOT NULL,
  `Money` double NOT NULL,
  PRIMARY KEY (`BookBillSaleReasonID`),
  UNIQUE KEY `BookBillSaleReason_UNIQUE` (`BookProductBillID`,`SaleReasonID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `tpkwhm`.`bookbillsalereason`
ADD CONSTRAINT `FK_BookBillSaleReason_Bill`
FOREIGN KEY (`BookProductBillID` )
REFERENCES `tpkwhm`.`bookproductbill` (`BookProductBillID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION
, ADD INDEX `FK_BookBillSaleReason_Bill_idx` (`BookProductBillID` ASC) ;

ALTER TABLE `tpkwhm`.`bookbillsalereason`
ADD CONSTRAINT `FK_BookBillSaleReason_Reason`
FOREIGN KEY (`SaleReasonID` )
REFERENCES `tpkwhm`.`salereason` (`SaleReasonID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `FK_BookBillSaleReason_Reason_idx` (`SaleReasonID` ASC) ;

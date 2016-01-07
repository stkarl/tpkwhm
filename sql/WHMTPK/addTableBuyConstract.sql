CREATE TABLE `BuyContract` (
  `BuyContractID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(20) default null,
  `Date` timestamp default null,
  `CustomerID` bigint(20) DEFAULT NULL,
  `Weight` double default null,
  `NoRoll` int DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BuyContractID`),
  KEY `FK_BuyContract_Customer` (`CustomerID`),
  CONSTRAINT `FK_BuyContract_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  KEY `FK_BuyContract_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_BuyContract_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `tpkwhm`.`importproductbill` ADD COLUMN `BuyContract` BIGINT(20) NULL DEFAULT NULL  AFTER `ParentBillID` ;
ALTER TABLE `tpkwhm`.`importproductbill`
ADD CONSTRAINT `FK_IPB_BuyContract`
FOREIGN KEY (`BuyContract` )
REFERENCES `tpkwhm`.`buycontract` (`BuyContractID` )
  ON DELETE SET NULL
  ON UPDATE NO ACTION
, ADD INDEX `FK_IPB_BuyContract_idx` (`BuyContract` ASC) ;

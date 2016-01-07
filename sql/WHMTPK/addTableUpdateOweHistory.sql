CREATE TABLE `OweLog` (
  `OweLogID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CustomerID` bigint(20) NOT NULL,
  `PrePay` Double,
  `Pay` Double,
  `PayDate` TIMESTAMP NULL,
  `CreatedBy` bigint(20) NOT NULL,
  `CreatedDate` timestamp NULL,
  PRIMARY KEY (`OweLogID`),
  KEY `FK_OweLog_Customer` (`CustomerID`),
  CONSTRAINT `FK_OweLog_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_OweLog_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_OweLog_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


ALTER TABLE `tpkwhm`.`customer`
ADD COLUMN `Phone` VARCHAR(255) NULL DEFAULT NULL  AFTER `CreatedBy` ,
ADD COLUMN `Fax` VARCHAR(255) NULL DEFAULT NULL  AFTER `Phone` ;

ALTER TABLE `tpkwhm`.`owelog`
ADD UNIQUE INDEX `UNIQUE_CUS_PAYDATE` (`CustomerID` ASC, `PayDate` ASC) ;


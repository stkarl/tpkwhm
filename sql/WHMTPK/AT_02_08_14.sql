ALTER TABLE `tpkwhm`.`exportproductbill` ADD COLUMN `SellStatus` INT(11) NULL DEFAULT NULL  AFTER `BookProductBillID` ;
ALTER TABLE `tpkwhm`.`owelog` ADD COLUMN `DayAllow` INT(11) NULL DEFAULT NULL  AFTER `CreatedDate` ,
ADD COLUMN `Type` VARCHAR(45) NOT NULL  AFTER `DayAllow` ;
ALTER TABLE `tpkwhm`.`owelog` ADD COLUMN `OweDate` TIMESTAMP NULL  AFTER `Type` ;
ALTER TABLE `tpkwhm`.`owelog` ADD COLUMN `Note` TEXT NULL DEFAULT NULL  AFTER `OweDate` ;



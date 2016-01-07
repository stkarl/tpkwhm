ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `Destination` TEXT NULL DEFAULT NULL  AFTER `ConfirmedDate` , ADD COLUMN `Reduce` DOUBLE NULL DEFAULT NULL  AFTER `Destination` ;

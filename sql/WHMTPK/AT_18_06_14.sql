ALTER TABLE `tpkwhm`.`materialmeasurement` CHANGE COLUMN `Value` `Value` DOUBLE NOT NULL  ,
ADD COLUMN `Date` TIMESTAMP NOT NULL  AFTER `CreatedDate` , ADD COLUMN `Note` TEXT NULL  AFTER `Date` ;
ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `DeliveryDate` TIMESTAMP NULL DEFAULT NULL  AFTER `Note` ;

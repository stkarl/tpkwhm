ALTER TABLE `tpkwhm`.`importproduct` ADD COLUMN `SaleQuantity` DOUBLE NULL DEFAULT NULL  AFTER `UsedMet` ,
ADD COLUMN `SalePrice` DOUBLE NULL DEFAULT NULL  AFTER `SaleQuantity` ;
ALTER TABLE `tpkwhm`.`productquality` ADD COLUMN `SaleQuantity` DOUBLE NULL DEFAULT NULL  AFTER `Price` ,
ADD COLUMN `SalePrice` DOUBLE NULL DEFAULT NULL  AFTER `SaleQuantity` ;


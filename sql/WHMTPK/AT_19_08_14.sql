ALTER TABLE `tpkwhm`.`productquality` ADD COLUMN `Price` DOUBLE NULL DEFAULT NULL  AFTER `Quantity2` ;
ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `Money` DOUBLE NULL DEFAULT NULL  AFTER `Reduce` ;
ALTER TABLE `tpkwhm`.`owelog` ADD COLUMN `BookProductBillID` BIGINT(20) NULL DEFAULT NULL  AFTER `Note` ;
ALTER TABLE `tpkwhm`.`owelog`
  ADD CONSTRAINT `FK_OWELOG_BOOKBILL`
  FOREIGN KEY (`BookProductBillID` )
  REFERENCES `tpkwhm`.`bookproductbill` (`BookProductBillID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION
, ADD INDEX `FK_OWELOG_BOOKBILL_idx` (`BookProductBillID` ASC) ;

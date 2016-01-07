ALTER TABLE `tpkwhm`.`bookbillsalereason` ADD COLUMN `Date` TIMESTAMP NULL DEFAULT NULL  AFTER `Money` ;
ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `BillDate` TIMESTAMP NULL DEFAULT NULL  AFTER `Money` ;
ALTER TABLE `tpkwhm`.`bookproductbill` CHANGE COLUMN `BillDate` `BillDate` TIMESTAMP NOT NULL  ;
ALTER TABLE `tpkwhm`.`importproductbill` ADD COLUMN `ExportProductBillID` BIGINT(20) NULL DEFAULT NULL  AFTER `BuyContract` ;
ALTER TABLE `tpkwhm`.`importproductbill`
ADD CONSTRAINT `FK_IPB_EPB`
FOREIGN KEY (`ExportProductBillID` )
REFERENCES `tpkwhm`.`exportproductbill` (`ExportProductBillID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION
, ADD INDEX `FK_IPB_EPB_idx` (`ExportProductBillID` ASC) ;
ALTER TABLE `tpkwhm`.`exportproduct`
DROP INDEX `Export_Product_UNIQUE`
, ADD UNIQUE INDEX `Export_Product_UNIQUE` (`ImportProductID` ASC, `ExportProductBillID` ASC) ;


# remain
UPDATE `tpkwhm`.`exportproductbill` SET `Status`='4' WHERE `Status`='2' AND `ReceiveWarehouseID` IS NOT NULL;






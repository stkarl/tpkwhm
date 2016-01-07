ALTER TABLE `tpkwhm`.`exportproductbill` ADD COLUMN `BookProductBillID` BIGINT(20) NULL DEFAULT NULL  AFTER `ProductionPlanID` ;
ALTER TABLE `tpkwhm`.`exportproductbill`
  ADD CONSTRAINT `KF_EPB_BPB`
  FOREIGN KEY (`BookProductBillID` )
  REFERENCES `tpkwhm`.`bookproductbill` (`BookProductBillID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `KF_EPB_BPB_idx` (`BookProductBillID` ASC) ;

ALTER TABLE `tpkwhm`.`exportproduct`
DROP INDEX `Export_Product_UNIQUE`
, ADD UNIQUE INDEX `Export_Product_UNIQUE` (`ImportProductID` ASC) ;



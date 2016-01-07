ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `ConfirmedBy` BIGINT(20) NULL DEFAULT NULL  AFTER `DeliveryDate` ,
ADD COLUMN `ConfirmedDate` TIMESTAMP NULL DEFAULT NULL  AFTER `ConfirmedBy` ;

ALTER TABLE `tpkwhm`.`bookproductbill`
  ADD CONSTRAINT `FK_BP_CU`
  FOREIGN KEY (`ConfirmedBy` )
  REFERENCES `tpkwhm`.`user` (`UserID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `FK_BP_CU_idx` (`ConfirmedBy` ASC) ;


ALTER TABLE `tpkwhm`.`importproduct` ADD COLUMN `OriginalProduct` BIGINT(20) NULL DEFAULT NULL  AFTER `SuggestedBy` ,
ADD COLUMN `ImportBack` DOUBLE NULL DEFAULT NULL  AFTER `OriginalProduct` ,
ADD COLUMN `UsedMet` DOUBLE NULL DEFAULT NULL  AFTER `ImportBack` ;

ALTER TABLE `tpkwhm`.`importproduct`
  ADD CONSTRAINT `KF_IP_OP`
  FOREIGN KEY (`OriginalProduct` )
  REFERENCES `tpkwhm`.`importproduct` (`ImportProductID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `KF_IP_OP_idx` (`OriginalProduct` ASC) ;

ALTER TABLE `tpkwhm`.`importproductbill` ADD COLUMN `ParentBillID` BIGINT(20) NULL DEFAULT NULL  AFTER `LocationID` ;
ALTER TABLE `tpkwhm`.`importproductbill`
  ADD CONSTRAINT `FK_IPB_PB`
  FOREIGN KEY (`ParentBillID` )
  REFERENCES `tpkwhm`.`importproductbill` (`ImportProductBillID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION
, ADD INDEX `FK_IPB_PB_idx` (`ParentBillID` ASC) ;

ALTER TABLE `tpkwhm`.`importproductbill`
ADD UNIQUE INDEX `UQ_PARENTBILL` (`ParentBillID` ASC) ;



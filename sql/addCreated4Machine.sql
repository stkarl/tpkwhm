ALTER TABLE `tpkwhm`.`machine` ADD COLUMN `CreatedBy` BIGINT(20) NULL DEFAULT NULL  AFTER `Chief` ;
ALTER TABLE `tpkwhm`.`machine`
  ADD CONSTRAINT `FK_Created_machine`
  FOREIGN KEY (`CreatedBy` )
  REFERENCES `tpkwhm`.`user` (`UserID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `FK_Created_machine_idx` (`CreatedBy` ASC) ;


ALTER TABLE `tpkwhm`.`machinecomponent` ADD COLUMN `CreatedBy` BIGINT(20) NULL DEFAULT NULL  AFTER `Chief` ;
ALTER TABLE `tpkwhm`.`machinecomponent`
ADD CONSTRAINT `FK_Created_component`
FOREIGN KEY (`CreatedBy` )
REFERENCES `tpkwhm`.`user` (`UserID` )
  ON DELETE RESTRICT
  ON UPDATE NO ACTION
, ADD INDEX `FK_Created_component_idx` (`CreatedBy` ASC) ;


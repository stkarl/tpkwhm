ALTER TABLE `tpkwhm`.`machinecomponent` ADD COLUMN `Count` INT(11) NULL  AFTER `Reserve` ;
ALTER TABLE `tpkwhm`.`machinecomponent` CHANGE COLUMN `Count` `GroupCode` VARCHAR(20) NULL DEFAULT NULL  ;
ALTER TABLE `tpkwhm`.`machinecomponent` CHANGE COLUMN `LastMaintenanceDate` `LastMaintenanceDate` TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00'  ;




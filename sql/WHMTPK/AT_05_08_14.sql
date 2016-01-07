ALTER TABLE `tpkwhm`.`customer` ADD COLUMN `Company` VARCHAR(255) NULL  AFTER `Fax`
, ADD COLUMN `Contact` VARCHAR(255) NULL  AFTER `Company`
, ADD COLUMN `ContactPhone` VARCHAR(255) NULL  AFTER `Contact` ;

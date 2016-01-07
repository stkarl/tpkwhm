ALTER TABLE `tpkwhm`.`exportmaterial` ADD COLUMN `Previous` DOUBLE NULL DEFAULT NULL  AFTER `Note` ;

CREATE TABLE `Shift` (
  `ShiftID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ShiftID`),
  UNIQUE KEY `Shift_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `Team` (
  `TeamID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`TeamID`),
  UNIQUE KEY `Team_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

ALTER TABLE `tpkwhm`.`productionplan` ADD COLUMN `ShiftID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_productionplan_Shift` FOREIGN KEY (`ShiftID`)REFERENCES `tpkwhm`.`Shift` (`ShiftID`)
 ON DELETE RESTRICT ON UPDATE NO ACTION, ADD INDEX `FK_productionplan_Shift_idx` (`ShiftID` ASC);

 ALTER TABLE `tpkwhm`.`productionplan` ADD COLUMN `TeamID` BIGINT(20) NULL DEFAULT NULL,
ADD CONSTRAINT `FK_productionplan_Team` FOREIGN KEY (`TeamID`)REFERENCES `tpkwhm`.`Team` (`TeamID`)
 ON DELETE RESTRICT ON UPDATE NO ACTION, ADD INDEX `FK_productionplan_Team_idx` (`TeamID` ASC);

  ALTER TABLE `tpkwhm`.`productionplan` ADD COLUMN `Date` TIMESTAMP NULL DEFAULT NULL;



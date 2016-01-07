CREATE TABLE `MachinePicture` (
  `MachinePictureID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MachineID` bigint(20) NOT NULL,
  `Path` VARCHAR(255) NOT NULL ,
  `Des` LONGTEXT DEFAULT NULL,
  PRIMARY KEY (`MachinePictureID`),
  UNIQUE KEY `Ma_Pic_UNI` (`MachineID`,`Path`),
  KEY `FK_Machine_Picture` (`MachineID`),
  CONSTRAINT `FK_Machine_Picture` FOREIGN KEY (`MachineID`) REFERENCES `Machine` (`MachineID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `MachineComponentPicture` (
  `MachineComponentPictureID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MachineComponentID` bigint(20) NOT NULL,
  `Path` VARCHAR(255) NOT NULL ,
  `Des` LONGTEXT DEFAULT NULL,
  PRIMARY KEY (`MachineComponentPictureID`),
  UNIQUE KEY `Ma_Pic_UNI` (`MachineComponentID`,`Path`),
  KEY `FK_MachineComponent_Picture` (`MachineComponentID`),
  CONSTRAINT `FK_MachineComponent_Picture` FOREIGN KEY (`MachineComponentID`) REFERENCES `machinecomponent` (`MachineComponentID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

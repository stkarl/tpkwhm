--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `UserID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Fullname` varchar(255) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Status` int(11) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `UserCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `UQ_UserCode` (`UserCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'admin','FmMBvO967Ew=','Administrator','cquockhanh@gmail.com',1,'ADMIN','ADMIN01');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `Setting`
--

DROP TABLE IF EXISTS `Setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Setting` (
  `SettingID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(45) NOT NULL,
  `FieldValue` varchar(45) NOT NULL,
  `Label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SettingID`),
  UNIQUE KEY `FieldName_UNIQUE` (`FieldName`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Setting`
--

LOCK TABLES `Setting` WRITE;
/*!40000 ALTER TABLE `Setting` DISABLE KEYS */;
INSERT INTO `Setting` VALUES (1,'Password','123456',NULL),(2,'SE_SFD','18',NULL),(3,'dcdt.assessment.deadline.se','1-5',NULL),(4,'dcdt.assessment.deadline.asm','1-5',NULL),(5,'dcdt.assessment.deadline.rsm','1-5',NULL),(6,'dcdt.assessment.deadline.alert1','2',NULL),(7,'dcdt.assessment.deadline.alert2','4',NULL),(8,'dcdt.workingplan.fielddate.se','18',NULL),(9,'dcdt.workingplan.fielddate.asm','18',NULL),(10,'dcdt.workingplan.fielddate.rsm','18',NULL),(11,'dcdt.workingplan.deadline.plan.se','1-5',NULL),(12,'dcdt.workingplan.deadline.plan.asm','2-6',NULL),(13,'dcdt.workingplan.deadline.plan.rsm','3-7',NULL),(14,'dcdt.workingplan.deadline.report.se','1-5',NULL),(15,'dcdt.workingplan.deadline.report.asm','2-6',NULL),(16,'dcdt.workingplan.deadline.report.rsm','3-7',NULL),(17,'dcdt.workingplan.deadline.plan.alert1','4',NULL),(18,'dcdt.workingplan.deadline.plan.alert2','2',NULL),(19,'dcdt.workingplan.deadline.report.alert1','4',NULL),(20,'dcdt.workingplan.deadline.report.alert2','2',NULL);
/*!40000 ALTER TABLE `Setting` ENABLE KEYS */;
UNLOCK TABLES;



CREATE TABLE `Warehouse` (
  `WarehouseID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Status` int(11) NOT NULL,
  `Code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`WarehouseID`),
  UNIQUE KEY `WH_Code_UNIQUE` (`Code`),
  UNIQUE KEY `WH_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101  */;


--
-- Table structure for table `Region`
--

DROP TABLE IF EXISTS `Region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Region` (
  `RegionID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`RegionID`),
  UNIQUE KEY `Region_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101  */;

--
-- Dumping data for table `Region`
--

LOCK TABLES `Region` WRITE;
/*!40000 ALTER TABLE `Region` DISABLE KEYS */;
INSERT INTO `Region` VALUES (4,'Central'),(5,'East'),(3,'Ha Noi'),(1,'HCM'),(6,'Mekong'),(7,'North'),(2,'Đà Nẵng');
/*!40000 ALTER TABLE `Region` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `Province` (
  `ProvinceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProvinceID`),
  KEY `FK_Province_Region` (`RegionID`),
  CONSTRAINT `FK_Province_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3983 DEFAULT CHARSET=utf8;
/*!40101  */;

--
-- Dumping data for table `Province`
--

LOCK TABLES `Province` WRITE;
/*!40000 ALTER TABLE `Province` DISABLE KEYS */;
INSERT INTO `Province` VALUES (3896,'Vũng tàu',1),(3897,'Nam cát tiên',1),(3898,'Miền Tây',1),(3899,'Tây Ninh',1),(3900,'Phụ cận HCM',1),(3901,'Trung tâm HCM',1),(3902,'Ngoại thành HCM',1),(3903,'Hồ chí minh',1),(3904,'Đồng nai',1),(3905,'Biên hòa',1),(3906,'NGHỆ AN',1),(3907,'HẢI PHÒNG',1),(3908,'VINH',1),(3909,'ĐiỆN BIÊN',1),(3910,'Chưa biết',7),(3911,'Hội An',2),(3912,'Quảng Ngãi',2),(3913,'Huế',2),(3914,'Phố Cổ',2),(3915,'Quảng Nam',2),(3916,'Quảng Quảng',2),(3917,'Mi Quảng',2),(3918,'Ngũ Hành Sơn',2),(3919,'Nội Chính',2),(3920,'Đà Nẵng',2),(3921,'Hà Đông',3),(3922,'Hà Hà',3),(3923,'Hà Hải',3),(3924,'Hà Mã',3),(3925,'Hà Ngoại',3),(3926,'Hà Nội',3),(3927,'Hà Trung',3),(3928,'Hà Nam',3),(3929,'Hà Bắc',3),(3930,'Hà Tây',3),(3931,'Tây Nguyên',4),(3932,'Đà Lạt',4),(3933,'Bảo Lọc',4),(3934,'Lâm Đông',4),(3935,'ĐakNong',4),(3936,'ĐakLak',4),(3937,'Gia Lai',4),(3938,'Playku',4),(3939,'Nha Trang',4),(3940,'Phan Rang',4),(3941,'Phan Thiết',4),(3942,'Tháp Chàm',4),(3943,'NGHỆ AN',5),(3944,'HẢI PHÒNG',5),(3945,'VINH',5),(3946,'ĐiỆN BIÊN',5),(3947,'TRUNG DU',5),(3948,'MiỀN NÚI',5),(3949,'BIÊN GIÓI',5),(3950,'HẢI DAO',5),(3951,'LẠNG SƠN',5),(3952,'MÓNG CÁI',5),(3953,'CAO BẰNG',5),(3954,'SƠN LA',5),(3955,'HẢI DƯƠNG',5),(3956,'TÂY BẮC',5),(3957,'ĐÔNG BẮC',5),(3958,'Cần Thơ',6),(3959,'Sóc Trăng',6),(3960,'Long An',6),(3961,'Cồn Phụng',6),(3962,'Cửu Long',6),(3963,'Tiền Giang',6),(3964,'Hậu Giang',6),(3965,'Mỹ Tho',6),(3966,'Mỹ Nhân',6),(3967,'Tâm Kế',6),(3968,'LẠNG SƠN',7),(3969,'MÓNG CÁI',7),(3970,'CAO BẰNG',7),(3971,'ĐiỆN BIÊN',7),(3972,'SƠN LA',7),(3973,'HẢI DƯƠNG',7),(3974,'TÂY BẮC',7),(3975,'ĐÔNG BẮC',7),(3976,'TRUNG DU',7),(3977,'MiỀN NÚI',7),(3978,'BIÊN GIÓI',7),(3979,'HẢI DAO',7),(3980,'Hồ Chí Minh',7),(3981,'Hồ Chí Minh',4),(3982,'Hồ Chí Minh',3);
/*!40000 ALTER TABLE `Province` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `Customer` (
  `CustomerID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `RegionID` bigint(20) DEFAULT NULL,
  `ProvinceID` bigint(20) DEFAULT NULL,
  `Birthday` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Owe` double DEFAULT NULL,
  `Limit` double DEFAULT NULL,
  `LastPayDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DayAllow` int (11) DEFAULT NULL,
  `Status` int(11) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `Cust_Name_UNIQUE` (`Name`,`Address`,`Birthday`),
  KEY `FK_Cust_Region` (`RegionID`),
  CONSTRAINT `FK_Cust_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_Cust_Province` (`ProvinceID`),
  CONSTRAINT `FK_Cust_Province` FOREIGN KEY (`ProvinceID`) REFERENCES `Province` (`ProvinceID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101  */;

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Unit` (
  `UnitID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`UnitID`),
  UNIQUE KEY `Unit_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101  */;

--
-- Dumping data for table `Unit`
--

LOCK TABLES `Unit` WRITE;
/*!40000 ALTER TABLE `Unit` DISABLE KEYS */;
INSERT INTO `Unit` VALUES (1,'Kg'),(2,'Cuộn'),(3,'Mét');
/*!40000 ALTER TABLE `Unit` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `Machine` (
  `MachineID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `LastMaintenanceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `NextMaintenance` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `WarehouseID` bigint (20) NOT NULL,
  PRIMARY KEY (`MachineID`),
  UNIQUE KEY `Machine_Warehouse_NameCode_UNIQUE` (`Name`,`Code`,`WarehouseID`),
  KEY `FK_Machine_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_Machine_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `MachineComponent` (
  `MachineComponentID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `LastMaintenanceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `NextMaintenance` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `MachineID` bigint(20) NOT NULL,
  PRIMARY KEY (`MachineComponentID`),
  UNIQUE KEY `Component_Machine_NameCode_UNIQUE` (`Name`,`Code`,`MachineID`),
  KEY `FK_Component_Machine` (`MachineID`),
  CONSTRAINT `FK_Component_Machine` FOREIGN KEY (`MachineID`) REFERENCES `Machine` (`MachineID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `MaintenanceHistory` (
  `MaintenanceHistoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Botcher` varchar(255) NOT NULL,
  `MachineID` bigint(20) DEFAULT NULL,
  `MachineComponentID` bigint(20) DEFAULT NULL,
  `Note` text NOT NULL,
  `MaintenanceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`MaintenanceHistoryID`),
  KEY `FK_Maintenance_Machine` (`MachineID`),
  CONSTRAINT `FK_Maintenance_Machine` FOREIGN KEY (`MachineID`) REFERENCES `Machine` (`MachineID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_Maintenance_Component` (`MachineComponentID`),
  CONSTRAINT `FK_Maintenance_Component` FOREIGN KEY (`MachineComponentID`) REFERENCES `MachineComponent` (`MachineComponentID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `MaterialCategory` (
  `MaterialCategoryID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MaterialCategoryID`),
  UNIQUE KEY `MaterialCategory_Name_UNIQUE` (`Name`),
  UNIQUE KEY `MaterialCategory_Code_UNIQUE` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Material` (
  `MaterialID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `MaterialCategoryID` bigint(20) NOT NULL,
  PRIMARY KEY (`MaterialID`),
  UNIQUE KEY `Material_Name_UNIQUE` (`Name`),
  UNIQUE KEY `Material_Code_UNIQUE` (`Code`),
  KEY `FK_Material_Category` (`MaterialCategoryID`),
  CONSTRAINT `FK_Material_Category` FOREIGN KEY (`MaterialCategoryID`) REFERENCES `MaterialCategory` (`MaterialCategoryID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `Origin` (
  `OriginID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`OriginID`),
  UNIQUE KEY `Origin_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Quality` (
  `QualityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`QualityID`),
  UNIQUE KEY `Quality_Name_UNIQUE` (`Name`),
  UNIQUE KEY `Quality_Code_UNIQUE` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `OverlayType` (
  `OverlayTypeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`OverlayTypeID`),
  UNIQUE KEY `OverlayType_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Thickness` (
  `ThicknessID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ThicknessID`),
  UNIQUE KEY `Thickness_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Stiffness` (
  `StiffnessID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`StiffnessID`),
  UNIQUE KEY `Stiffness_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Colour` (
  `ColourID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Sign` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ColourID`),
  UNIQUE KEY `Colour_Name_UNIQUE` (`Name`),
  UNIQUE KEY `Colour_Code_UNIQUE` (`Code`),
  UNIQUE KEY `Colour_Sign_UNIQUE` (`Sign`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Size` (
  `SizeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SizeID`),
  UNIQUE KEY `Stiffness_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ProductName` (
  `ProductNameID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ProductNameID`),
  UNIQUE KEY `ProductName_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Product` (
  `ProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `ProductNameID` bigint(20) DEFAULT NULL,
  `SizeID` bigint(20) DEFAULT NULL,
  `ColourID` bigint(20) DEFAULT NULL,
  `ThicknessID` bigint(20) DEFAULT NULL,
  `StiffnessID` bigint(20) DEFAULT NULL,
  `OverlayTypeID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `FK_Product_ProductName` (`ProductNameID`),
  CONSTRAINT `FK_Product_ProductName` FOREIGN KEY (`ProductNameID`) REFERENCES `ProductName` (`ProductNameID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_Product_Size` (`SizeID`),
  CONSTRAINT `FK_Product_Size` FOREIGN KEY (`SizeID`) REFERENCES `Size` (`SizeID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_Product_Colour` (`ColourID`),
  CONSTRAINT `FK_Product_Colour` FOREIGN KEY (`ColourID`) REFERENCES `Colour` (`ColourID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    KEY `FK_Product_Thickness` (`ThicknessID`),
  CONSTRAINT `FK_Product_Thickness` FOREIGN KEY (`ThicknessID`) REFERENCES `Thickness` (`ThicknessID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    KEY `FK_Product_Stiffness` (`StiffnessID`),
  CONSTRAINT `FK_Product_Stiffness` FOREIGN KEY (`StiffnessID`) REFERENCES `Stiffness` (`StiffnessID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    KEY `FK_Product_OverlayType` (`OverlayTypeID`),
  CONSTRAINT `FK_Product_OverlayType` FOREIGN KEY (`OverlayTypeID`) REFERENCES `OverlayType` (`OverlayTypeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Market` (
  `MarketID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MarketID`),
  UNIQUE KEY `Market_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ImportMaterialBill` (
  `ImportMaterialBillID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CustomerID` bigint(20) DEFAULT NULL,
  `WarehouseID` bigint(20) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `ImportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` int DEFAULT NULL,
  `UpdatedBy` bigint (20) DEFAULT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TotalMoney` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  PRIMARY KEY (`ImportMaterialBillID`),
  KEY `FK_ImportMaterialBill_Customer` (`CustomerID`),
  CONSTRAINT `FK_ImportMaterialBill_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterialBill_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_ImportMaterialBill_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterialBill_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ImportMaterialBill_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterialBill_UpdatedBy` (`UpdatedBy`),
  CONSTRAINT `FK_ImportMaterialBill_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ImportMaterial` (
  `ImportMaterialID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ImportMaterialBillID` bigint(20) NOT NULL,
  `MaterialID` bigint(20) NOT NULL,
  `OriginID` bigint(20) DEFAULT NULL,
  `ExpiredDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Money` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `MarketID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ImportMaterialID`),
  UNIQUE KEY `Import_Material_Origin_UNIQUE` (`ImportMaterialBillID`,`MaterialID`,`OriginID`,`ExpiredDate`,`Money`),
  KEY `FK_ImportMaterial_Bill` (`ImportMaterialBillID`),
  CONSTRAINT `FK_ImportMaterial_Bill` FOREIGN KEY (`ImportMaterialBillID`) REFERENCES `ImportMaterialBill` (`ImportMaterialBillID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterial_Material` (`MaterialID`),
  CONSTRAINT `FK_ImportMaterial_Material` FOREIGN KEY (`MaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterial_Origin` (`OriginID`),
  CONSTRAINT `FK_ImportMaterial_Origin` FOREIGN KEY (`OriginID`) REFERENCES `Origin` (`OriginID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterial_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_ImportMaterial_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterial_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_ImportMaterial_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportMaterial_Market` (`MarketID`),
  CONSTRAINT `FK_ImportMaterial_Market` FOREIGN KEY (`MarketID`) REFERENCES `Market` (`MarketID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportType` (
  `ExportTypeID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ExportTypeID`),
  UNIQUE KEY `ExportType_Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `ExportMaterialBill` (
  `ExportMaterialBillID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Receiver` varchar(255) DEFAULT NULL,
  `ExportTypeID` bigint(20) NOT NULL,
  `ExportWarehouseID` bigint(20) NOT NULL,
  `ReceiveWarehouseID` bigint(20) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ExportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` int DEFAULT NULL,
  `UpdatedBy` bigint (20) DEFAULT NULL,
  `UpdatedDate` timestamp NULL DEFAULT NULL,
  `Note` text DEFAULT NULL,
  PRIMARY KEY (`ExportMaterialBillID`),
  KEY `FK_ExportMaterialBill_ExportType` (`ExportTypeID`),
  CONSTRAINT `FK_ExportMaterialBill_ExportType` FOREIGN KEY (`ExportTypeID`) REFERENCES `ExportType` (`ExportTypeID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterialBill_ExportWarehouse` (`ExportWarehouseID`),
  CONSTRAINT `FK_ExportMaterialBill_ExportWarehouse` FOREIGN KEY (`ExportWarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterialBill_ReceiveWarehouse` (`ReceiveWarehouseID`),
  CONSTRAINT `FK_ExportMaterialBill_ReceiveWarehouse` FOREIGN KEY (`ReceiveWarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterialBill_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ExportMaterialBill_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterialBill_UpdatedBy` (`UpdatedBy`),
  CONSTRAINT `FK_ExportMaterialBill_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `User` (`UserID`) ON DELETE restrict ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportMaterial` (
  `ExportMaterialID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ExportMaterialBillID` bigint(20) NOT NULL,
  `MaterialID` bigint(20) NOT NULL,
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  PRIMARY KEY (`ExportMaterialID`),
  UNIQUE KEY `Export_Material_Origin_UNIQUE` (`ExportMaterialBillID`,`MaterialID`),
  KEY `FK_ExportMaterial_Bill` (`ExportMaterialBillID`),
  CONSTRAINT `FK_ExportMaterial_Bill` FOREIGN KEY (`ExportMaterialBillID`) REFERENCES `ExportMaterialBill` (`ExportMaterialBillID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportMaterial_Material` (`MaterialID`),
  CONSTRAINT `FK_ExportMaterial_Material` FOREIGN KEY (`MaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterial_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_ExportMaterial_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE restrict ON UPDATE NO ACTION,
  KEY `FK_ExportMaterial_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_ExportMaterial_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE restrict ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ImportProductBill` (
  `ImportProductBillID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WarehouseID` bigint(20) NOT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ProduceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ImportDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Status` int DEFAULT NULL,
  `UpdatedBy` bigint (20) DEFAULT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TotalMoney` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `ProduceGroup` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ImportProductBillID`),
  KEY `FK_ImportProductBill_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_ImportProductBill_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProductBill_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ImportProductBill_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProductBill_UpdatedBy` (`UpdatedBy`),
  CONSTRAINT `FK_ImportProductBill_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `ImportProduct` (
  `ImportProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ImportProductBillID` bigint(20) NOT NULL,
  `ProductID` bigint(20) NOT NULL,
  `ProductCode` varchar (255) DEFAULT NULL,
  `OriginID` bigint(20) DEFAULT NULL,
  `ProduceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `MainUsedMaterialID`bigint(20) DEFAULT NULL,
  `MainUsedMaterialCode`varchar (255) DEFAULT NULL,
  `MainUsedProductID`bigint(20) DEFAULT NULL,
  `MainUsedProductCode`varchar (255) DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Money` double DEFAULT NULL,
  `MarketID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ImportProductID`),
  UNIQUE KEY `Import_Product_Origin_UNIQUE` (`ImportProductBillID`,`ProductID`,`Money`),
  KEY `FK_ImportProduct_Bill` (`ImportProductBillID`),
  CONSTRAINT `FK_ImportProduct_Bill` FOREIGN KEY (`ImportProductBillID`) REFERENCES `ImportProductBill` (`ImportProductBillID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_Product` (`ProductID`),
  CONSTRAINT `FK_ImportProduct_Product` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_Origin` (`OriginID`),
  CONSTRAINT `FK_ImportProduct_Origin` FOREIGN KEY (`OriginID`) REFERENCES `Origin` (`OriginID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_UsedProduct` (`MainUsedProductID`),
  CONSTRAINT `FK_ImportProduct_UsedProduct` FOREIGN KEY (`MainUsedProductID`) REFERENCES `Product` (`ProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_UsedMaterial` (`MainUsedMaterialID`),
  CONSTRAINT `FK_ImportProduct_UsedMaterial` FOREIGN KEY (`MainUsedMaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_ImportProduct_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_ImportProduct_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ImportProduct_Market` (`MarketID`),
  CONSTRAINT `FK_ImportProduct_Market` FOREIGN KEY (`MarketID`) REFERENCES `Market` (`MarketID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ProductQuality` (
  `ProductQualityID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ImportProductID` bigint(20) NOT NULL,
  `QualityID` bigint(20) NOT NULL,
  `Unit1ID` bigint(20) NOT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) NOT NULL,
  `Quantity2` double DEFAULT NULL,
  PRIMARY KEY (`ProductQualityID`),
  UNIQUE KEY `ProductQuality_UNIQUE` (`ImportProductID`,`QualityID`),
  KEY `FK_ProductQuality_ImportProduct` (`ImportProductID`),
  CONSTRAINT `FK_ProductQuality_ImportProduct` FOREIGN KEY (`ImportProductID`) REFERENCES `ImportProduct` (`ImportProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ProductQuality_Quality` (`QualityID`),
  CONSTRAINT `FK_ProductQuality_Quality` FOREIGN KEY (`QualityID`) REFERENCES `Quality` (`QualityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ProductQuality_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_ProductQuality_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ProductQuality_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_ProductQuality_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportProductBill` (
  `ExportProductBillID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Receiver` varchar(255) DEFAULT NULL,
  `CustomerID` bigint(20) DEFAULT NULL,
  `ExportTypeID` bigint(20) NOT NULL,
  `ExportWarehouseID` bigint(20) NOT NULL,
  `ReceiveWarehouseID` bigint(20) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedBy` bigint (20) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ExportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` int DEFAULT NULL,
  `UpdatedBy` bigint (20) DEFAULT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Note` text DEFAULT NULL,
  `TotalMoney` double DEFAULT NULL ,
  PRIMARY KEY (`ExportProductBillID`),
  KEY `FK_ExportProductBill_Customer` (`CustomerID`),
  CONSTRAINT `FK_ExportProductBill_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProductBill_ExportType` (`ExportTypeID`),
  CONSTRAINT `FK_ExportProductBill_ExportType` FOREIGN KEY (`ExportTypeID`) REFERENCES `ExportType` (`ExportTypeID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProductBill_ExportWarehouse` (`ExportWarehouseID`),
  CONSTRAINT `FK_ExportProductBill_ExportWarehouse` FOREIGN KEY (`ExportWarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProductBill_ReceiveWarehouse` (`ReceiveWarehouseID`),
  CONSTRAINT `FK_ExportProductBill_ReceiveWarehouse` FOREIGN KEY (`ReceiveWarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProductBill_CreatedBy` (`CreatedBy`),
  CONSTRAINT `FK_ExportProductBill_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProductBill_UpdatedBy` (`UpdatedBy`),
  CONSTRAINT `FK_ExportProductBill_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `ExportProduct` (
  `ExportProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ExportProductBillID` bigint(20) NOT NULL,
  `ProductNameID` bigint(20) NOT NULL,
  `ProductCode` varchar(255) NOT NULL,
  `OriginID` bigint(20) DEFAULT NULL,
  `ClassifyCode` varchar(255) NOT NULL,
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `Money` double DEFAULT NULL ,
  PRIMARY KEY (`ExportProductID`),
  UNIQUE KEY `Export_Product_UNIQUE` (`ExportProductBillID`,`ProductCode`),
  KEY `FK_ExportProduct_Bill` (`ExportProductBillID`),
  CONSTRAINT `FK_ExportProduct_Bill` FOREIGN KEY (`ExportProductBillID`) REFERENCES `ExportProductBill` (`ExportProductBillID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProduct_ProductName` (`ProductNameID`),
  CONSTRAINT `FK_ExportProduct_ProductName` FOREIGN KEY (`ProductNameID`) REFERENCES `ProductName` (`ProductNameID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProduct_Origin` (`OriginID`),
  CONSTRAINT `FK_ExportProduct_Origin` FOREIGN KEY (`OriginID`) REFERENCES `Origin` (`OriginID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProduct_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_ExportProduct_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_ExportProduct_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_ExportProduct_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `WarehouseMaterial` (
  `WarehouseMaterialID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WarehouseID` bigint(20) NOT NULL,
  `MaterialID` bigint(20) NOT NULL,
  `OriginID` bigint(20) DEFAULT NULL,
  `ExpiredDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Money` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `MarketID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`WarehouseMaterialID`),
  UNIQUE KEY `WarehouseMaterial_Material_Origin_UNIQUE` (`WarehouseID`,`MaterialID`,`OriginID`,`ExpiredDate`,`Money`),
  KEY `FK_WarehouseMaterial_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_WarehouseMaterial_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseMaterial_Material` (`MaterialID`),
  CONSTRAINT `FK_WarehouseMaterial_Material` FOREIGN KEY (`MaterialID`) REFERENCES `Material` (`MaterialID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseMaterial_Origin` (`OriginID`),
  CONSTRAINT `FK_WarehouseMaterial_Origin` FOREIGN KEY (`OriginID`) REFERENCES `Origin` (`OriginID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseMaterial_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_WarehouseMaterial_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseMaterial_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_WarehouseMaterial_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseMaterial_Market` (`MarketID`),
  CONSTRAINT `FK_WarehouseMaterial_Market` FOREIGN KEY (`MarketID`) REFERENCES `Market` (`MarketID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `WarehouseMachineComponent` (
  `WarehouseMachineComponentID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WarehouseID` bigint(20) NOT NULL,
  `MachineComponentID` bigint(20) NOT NULL,
  `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`WarehouseMachineComponentID`),
  UNIQUE KEY `WarehouseComponent_Machine_Name_UNIQUE` (`WarehouseID`,`MachineComponentID`),
  KEY `FK_WarehouseComponent_Machine` (`MachineComponentID`),
  CONSTRAINT `FK_WarehouseComponent_Machine` FOREIGN KEY (`MachineComponentID`) REFERENCES `MachineComponent` (`MachineComponentID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseComponent_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_WarehouseComponent_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `WarehouseProduct` (
  `WarehouseProductID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WarehouseID` bigint(20) NOT NULL,
  `ProductID` bigint(20) NOT NULL,
  `ProductCode` varchar (255) DEFAULT NULL,
  `OriginID` bigint(20) DEFAULT NULL,
  `ExpiredDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ProduceDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Unit1ID` bigint(20) DEFAULT NULL,
  `Quantity1` double DEFAULT NULL,
  `Unit2ID` bigint(20) DEFAULT NULL,
  `Quantity2` double DEFAULT NULL,
  `Money` double DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `MarketID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`WarehouseProductID`),
  UNIQUE KEY `Warehouse_Product_Origin_UNIQUE` (`WarehouseID`,`ProductID`,`OriginID`,`ExpiredDate`),
  KEY `FK_WarehouseProduct_Warehouse` (`WarehouseID`),
  CONSTRAINT `FK_WarehouseProduct_Warehouse` FOREIGN KEY (`WarehouseID`) REFERENCES `Warehouse` (`WarehouseID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseProduct_Product` (`ProductID`),
  CONSTRAINT `FK_WarehouseProduct_Product` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseProduct_Origin` (`OriginID`),
  CONSTRAINT `FK_WarehouseProduct_Origin` FOREIGN KEY (`OriginID`) REFERENCES `Origin` (`OriginID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseProduct_Unit1` (`Unit1ID`),
  CONSTRAINT `FK_WarehouseProduct_Unit1` FOREIGN KEY (`Unit1ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseProduct_Unit2` (`Unit2ID`),
  CONSTRAINT `FK_WarehouseProduct_Unit2` FOREIGN KEY (`Unit2ID`) REFERENCES `Unit` (`UnitID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `FK_WarehouseProduct_Market` (`MarketID`),
  CONSTRAINT `FK_WarehouseProduct_Market` FOREIGN KEY (`MarketID`) REFERENCES `Market` (`MarketID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



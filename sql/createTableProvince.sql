cDROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province` (
  `ProvinceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `RegionID` bigint(20) NOT NULL,
  PRIMARY KEY (`ProvinceID`),
  KEY `FK_Province_Region` (`RegionID`),
  CONSTRAINT `FK_Province_Region` FOREIGN KEY (`RegionID`) REFERENCES `region` (`RegionID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3817 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `subfullrangebrand`
-- ----------------------------
DROP TABLE IF EXISTS `subfullrangebrand`;
CREATE TABLE `subfullrangebrand` (
  `SubFullRangeBrandID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `OutletBrandID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`SubFullRangeBrandID`),
  UNIQUE KEY `UQ_Name_FullrangeSKU` (`Name`),
  KEY `FK_SubBrand_OutletBrand` (`OutletBrandID`),
  CONSTRAINT `FK_SubBrand_OutletBrand` FOREIGN KEY (`OutletBrandID`) REFERENCES `outletbrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of subfullrangebrand
-- ----------------------------
INSERT INTO `subfullrangebrand` VALUES ('1', 'Friso Gold Mum', '1');
INSERT INTO `subfullrangebrand` VALUES ('2', 'Friso Gold 1', '1');
INSERT INTO `subfullrangebrand` VALUES ('3', 'Friso Gold 2', '1');
INSERT INTO `subfullrangebrand` VALUES ('4', 'Friso Gold 3', '1');
INSERT INTO `subfullrangebrand` VALUES ('5', 'Friso Gold 4', '1');
INSERT INTO `subfullrangebrand` VALUES ('6', 'Friso Regular 1', '1');
INSERT INTO `subfullrangebrand` VALUES ('7', 'Friso Regular 2', '1');
INSERT INTO `subfullrangebrand` VALUES ('8', 'Friso Regular 3', '1');
INSERT INTO `subfullrangebrand` VALUES ('9', 'Friso Regular 4', '1');
INSERT INTO `subfullrangebrand` VALUES ('10', 'Dutch Lady Regular Step 1', '2');
INSERT INTO `subfullrangebrand` VALUES ('11', 'Dutch Lady Regular Step 2', '2');
INSERT INTO `subfullrangebrand` VALUES ('12', 'Dutch Lady Regular 123', '2');
INSERT INTO `subfullrangebrand` VALUES ('13', 'Dutch Lady Regular 456', '2');
INSERT INTO `subfullrangebrand` VALUES ('14', 'Dutch Lady Gold 1', '2');
INSERT INTO `subfullrangebrand` VALUES ('15', 'Dutch Lady Gold 2', '2');
INSERT INTO `subfullrangebrand` VALUES ('16', 'Dutch Lady Gold 123', '2');
INSERT INTO `subfullrangebrand` VALUES ('17', 'Dutch Lady Gold 456', '2');
INSERT INTO `subfullrangebrand` VALUES ('18', 'Dutch Lady Regular Mum', '2');
INSERT INTO `subfullrangebrand` VALUES ('19', 'Dutch Lady Regular Step 1G', '2');
INSERT INTO `subfullrangebrand` VALUES ('20', 'Dutch Lady Regular Step 2G', '2');
INSERT INTO `subfullrangebrand` VALUES ('21', 'Dutch Lady Regular 123G', '2');
INSERT INTO `subfullrangebrand` VALUES ('22', 'Dutch Lady Regular 456G', '2');



ALTER TABLE FullRangeSKU
ADD
(
  `Subbrand` bigint(11) DEFAULT NULL,
  `Mensural` int(11) DEFAULT NULL,
  UNIQUE KEY `UQ_FullRangeSKU` (`Subbrand`,`Name`,`Mensural`),
  FOREIGN KEY (`Subbrand`) REFERENCES `subfullrangebrand`(`SubfullrangebrandID`)
);

Update FullRangeSKU SET Subbrand = 1, Mensural = 2 Where FullRangeSKUID = 1;
Update FullRangeSKU SET Subbrand = 2, Mensural = 2 Where FullRangeSKUID = 2;
Update FullRangeSKU SET Subbrand = 3, Mensural = 2 Where FullRangeSKUID = 3;
Update FullRangeSKU SET Subbrand = 4, Mensural = 2 Where FullRangeSKUID = 4;
Update FullRangeSKU SET Subbrand = 5, Mensural = 2 Where FullRangeSKUID = 5;
Update FullRangeSKU SET Subbrand = 10, Mensural = 2 Where FullRangeSKUID = 7;
Update FullRangeSKU SET Subbrand = 11, Mensural = 2 Where FullRangeSKUID = 8;
Update FullRangeSKU SET Subbrand = 12, Mensural = 2 Where FullRangeSKUID = 9;
Update FullRangeSKU SET Subbrand = 13, Mensural = 2 Where FullRangeSKUID = 10;
Update FullRangeSKU SET Subbrand = 5, Mensural = 3 Where FullRangeSKUID = 11;
Update FullRangeSKU SET Subbrand = 1, Mensural = 1 Where FullRangeSKUID = 12;
Update FullRangeSKU SET Subbrand = 2, Mensural = 1 Where FullRangeSKUID = 13;
Update FullRangeSKU SET Subbrand = 3, Mensural = 1 Where FullRangeSKUID = 14;
Update FullRangeSKU SET Subbrand = 4, Mensural = 3 Where FullRangeSKUID = 15;
Update FullRangeSKU SET Subbrand = 4, Mensural = 1 Where FullRangeSKUID = 16;
Update FullRangeSKU SET Subbrand = 14, Mensural = 1 Where FullRangeSKUID = 17;
Update FullRangeSKU SET Subbrand = 14, Mensural = 2 Where FullRangeSKUID = 18;
Update FullRangeSKU SET Subbrand = 15, Mensural = 1 Where FullRangeSKUID = 19;
Update FullRangeSKU SET Subbrand = 15, Mensural = 2 Where FullRangeSKUID = 20;
Update FullRangeSKU SET Subbrand = 16, Mensural = 1 Where FullRangeSKUID = 21;
Update FullRangeSKU SET Subbrand = 16, Mensural = 2 Where FullRangeSKUID = 22;
Update FullRangeSKU SET Subbrand = 16, Mensural = 3 Where FullRangeSKUID = 23;
Update FullRangeSKU SET Subbrand = 17, Mensural = 1 Where FullRangeSKUID = 24;
Update FullRangeSKU SET Subbrand = 17, Mensural = 2 Where FullRangeSKUID = 25;
Update FullRangeSKU SET Subbrand = 17, Mensural = 3 Where FullRangeSKUID = 26;
Update FullRangeSKU SET Subbrand = 6, Mensural = 1 Where FullRangeSKUID = 27;
Update FullRangeSKU SET Subbrand = 6, Mensural = 2 Where FullRangeSKUID = 28;
Update FullRangeSKU SET Subbrand = 7, Mensural = 2 Where FullRangeSKUID = 29;
Update FullRangeSKU SET Subbrand = 8, Mensural = 2 Where FullRangeSKUID = 30;
Update FullRangeSKU SET Subbrand = 8, Mensural = 3 Where FullRangeSKUID = 31;
Update FullRangeSKU SET Subbrand = 7, Mensural = 1 Where FullRangeSKUID = 32;
Update FullRangeSKU SET Subbrand = 9, Mensural = 2 Where FullRangeSKUID = 33;
Update FullRangeSKU SET Subbrand = 18, Mensural = 2 Where FullRangeSKUID = 34;
Update FullRangeSKU SET Subbrand = 19, Mensural = 1 Where FullRangeSKUID = 35;
Update FullRangeSKU SET Subbrand = 10, Mensural = 1 Where FullRangeSKUID = 36;
Update FullRangeSKU SET Subbrand = 20, Mensural = 1 Where FullRangeSKUID = 37;
Update FullRangeSKU SET Subbrand = 11, Mensural = 1 Where FullRangeSKUID = 38;
Update FullRangeSKU SET Subbrand = 12, Mensural = 1 Where FullRangeSKUID = 39;
Update FullRangeSKU SET Subbrand = 22, Mensural = 1 Where FullRangeSKUID = 40;
Update FullRangeSKU SET Subbrand = 13, Mensural = 3 Where FullRangeSKUID = 41;
Update FullRangeSKU SET Subbrand = 18, Mensural = 1 Where FullRangeSKUID = 42;
Update FullRangeSKU SET Subbrand = 13, Mensural = 1 Where FullRangeSKUID = 43;
Update FullRangeSKU SET Subbrand = 12, Mensural = 3 Where FullRangeSKUID = 44;
Update FullRangeSKU SET Subbrand = 21, Mensural = 1 Where FullRangeSKUID = 45;


ALTER TABLE LevelRegister
ADD
(
  MinimumValue INT NULL,
  CompleteMinimumValue INT NULL
);




DROP TABLE IF EXISTS `oarauditsummary`;

CREATE TABLE `oarauditsummary` (
  `OARAuditSummaryID` bigint(11) NOT NULL AUTO_INCREMENT,
  `OutletbrandID` bigint(11) NOT NULL,
  `OutletAuditResultID` bigint(11) NOT NULL,
  `LocationMeet` int(11) DEFAULT NULL,
  `PowerSKUMeet` int(11) DEFAULT NULL,
  `FullRangeSKUMeet` int(11) DEFAULT NULL,
  `NoFacingMeet` int(11) DEFAULT NULL,
  `POSMMeet` int(11) DEFAULT NULL,
  `CommissionMeet` int(11) DEFAULT NULL,
  PRIMARY KEY (`OARAuditSummaryID`),
  UNIQUE KEY `UQ_` (`OARAuditSummaryID`,`OutletbrandID`),
  KEY `FK_OARAuditSummary_Outletrbrand` (`OutletbrandID`),
  KEY `FK_OARAuditSummary_OutletAuditResult` (`OutletAuditResultID`),
  CONSTRAINT `FK_OARAuditSummary_OutletAuditResult` FOREIGN KEY (`OutletAuditResultID`) REFERENCES `outletauditresult` (`OutletAuditResultID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OARAuditSummary_Outletrbrand` FOREIGN KEY (`OutletbrandID`) REFERENCES `outletbrand` (`OutletBrandID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `OutletAuditResult`
ADD ( isImport INT NULL );
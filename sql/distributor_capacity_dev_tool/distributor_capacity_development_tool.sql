CREATE TABLE DistributorLevel (
  DistributorLevelID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512) NULL,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP NULL,
  UNIQUE UQ_DistributorLevel(Name ASC),
  PRIMARY KEY(DistributorLevelID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE AssessmentKPICategory (
  AssessmentKPICategoryID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512) NULL,
  DisplayOrder INT,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP NULL,
  UNIQUE UQ_AssessmentKPICategory(Name ASC),
  PRIMARY KEY(AssessmentKPICategoryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE AssessmentKPI (
  AssessmentKPIID BIGINT NOT NULL AUTO_INCREMENT,
  Code VARCHAR(100) NULL,
  Name VARCHAR(255) NOT NULL,
  DisplayOrder INT,
  Weight FLOAT,
  LogisticCommitmentScore FLOAT,
  ValueAddedCommitmentScore FLOAT,
  StrategicCommitmentScore FLOAT,
  Description VARCHAR(512) NULL,
  MaxPlan INT DEFAULT 3,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP NULL,
  AssessmentKPICategoryID BIGINT NOT NULL,
  UNIQUE UQ_AssessmentKPI(AssessmentKPICategoryID, Name),
  PRIMARY KEY(AssessmentKPIID),
  CONSTRAINT `FK_AssessmentKPI_Category` FOREIGN KEY (`AssessmentKPICategoryID`) REFERENCES `AssessmentKPICategory` (`AssessmentKPICategoryID`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AssessmentKPIScore` (
  `AssessmentKPIScoreID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Score` int(11) DEFAULT NULL,
  `Description` text,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedDate` timestamp NULL DEFAULT NULL,
  `AssessmentKPIID` bigint(20) NOT NULL,
  PRIMARY KEY (`AssessmentKPIScoreID`),
  UNIQUE KEY `UQ_AssessmentKPIScore` (`AssessmentKPIID`,`Name`),
  CONSTRAINT `FK_AssessmentKPIScore_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE AssessmentCapacity (
  AssessmentCapacityID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NULL,
  Description TEXT,
  DistributorLevelID BIGINT NOT NULL,
  CreatedDate TIMESTAMP  NOT NULL,
  Year INT,
  Month INT,
  ModifiedDate TIMESTAMP NULL,
  DistributorID BIGINT NOT NULL,
  DistributorUserID BIGINT NOT NULL,
  PRIMARY KEY(AssessmentCapacityID),
  UNIQUE UQ_AssessmentCapacity(DistributorID, Year, Month),
  CONSTRAINT `FK_AssessmentCapacity_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacity_User` FOREIGN KEY (`DistributorUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacity_DL` FOREIGN KEY (`DistributorLevelID`) REFERENCES `DistributorLevel` (`DistributorLevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION


)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE AssessmentCapacityUser (
  AssessmentCapacityUserID BIGINT NOT NULL AUTO_INCREMENT,
  AssessmentCapacityID BIGINT NOT NULL,
  FCVUserID BIGINT NOT NULL,
  UNIQUE(FCVUserID, AssessmentCapacityID),
  PRIMARY KEY(AssessmentCapacityUserID),
  CONSTRAINT `FK_AssessmentCapacityUser_Ass` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityUser_User` FOREIGN KEY (`FCVUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE AssessmentCapacityKPI (
  AssessmentCapacityKPIID BIGINT NOT NULL AUTO_INCREMENT,
  AssessmentCapacityID BIGINT NOT NULL,
  AssessmentKPIID BIGINT NOT NULL,
  AssessmentKPIScoreID BIGINT NOT NULL,
  Score FLOAT,
  Weight FLOAT,
  LogisticCommitmentScore FLOAT,
  ValueAddedCommitmentScore FLOAT,
  StrategicCommitmentScore FLOAT,

  Note TEXT,
  UNIQUE(AssessmentKPIID, AssessmentCapacityID),
  PRIMARY KEY(AssessmentCapacityKPIID),
  CONSTRAINT `FK_AssessmentCapacityKPI_KPIScore` FOREIGN KEY (`AssessmentKPIScoreID`) REFERENCES `AssessmentKPIScore` (`AssessmentKPIScoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityKPI_Ass` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_AssessmentCapacityKPI_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE DistributorCapacityPlan (
  DistributorCapacityPlanID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  DistributorID BIGINT NULL,
  OwnerUserID BIGINT NOT NULL,
  DistributorUserID BIGINT  NULL,
  AsmAdd BIGINT  NULL,
  DistributorLevelRegisterID BIGINT NOT NULL,
  PlanYear INT,
  Status INT,
  Reason VARCHAR(255) NULL,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP NULL,
  ApprovedBy BIGINT NULL,
  ApprovedDate TIMESTAMP,
  PRIMARY KEY (DistributorCapacityPlanID),
  UNIQUE UQ_DistributorCapacityPlan(OwnerUserID, DistributorID, PlanYear),
  CONSTRAINT `FK_DistributorCapacityPlan_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_Owner` FOREIGN KEY (`OwnerUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_Approve` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_AsmAdd` FOREIGN KEY (`AsmAdd`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlan_DL` FOREIGN KEY (`DistributorLevelRegisterID`) REFERENCES `DistributorLevel` (`DistributorLevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DistributorCapacityPlanAttendance (
  DistributorCapacityPlanAttendanceID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorCapacityPlanID BIGINT NOT NULL,
  AttendanceID BIGINT NOT NULL,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY(DistributorCapacityPlanAttendanceID),
  UNIQUE UQ_DistributorCapacityPlanAttendance(DistributorCapacityPlanID, AttendanceID),
  CONSTRAINT `FK_DistributorCapacityPlanAttendance_DCP` FOREIGN KEY (`DistributorCapacityPlanID`) REFERENCES `DistributorCapacityPlan` (`DistributorCapacityPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlanAttendance_User` FOREIGN KEY (`AttendanceID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS DistributorCapacityPlanDetail;
CREATE TABLE DistributorCapacityPlanDetail (
  DistributorCapacityPlanDetailID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorCapacityPlanID BIGINT NOT NULL,
  Month INT NOT NULL,
  UNIQUE UQ_DistributorCapacityPlanDetail(DistributorCapacityPlanID, Month),
  PRIMARY KEY(DistributorCapacityPlanDetailID),
  CONSTRAINT `FK_DistributorCapacityPlanDetail_Plan` FOREIGN KEY (`DistributorCapacityPlanID`) REFERENCES `DistributorCapacityPlan` (`DistributorCapacityPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS DistributorCapacityPlanDetailKPI;
CREATE TABLE DistributorCapacityPlanDetailKPI (
  DistributorCapacityPlanDetailKPIID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorCapacityPlanDetailID BIGINT NOT NULL,
  AssessmentKPIID BIGINT NOT NULL,
  Score FLOAT,
  Weight FLOAT,
  LogisticCommitmentScore FLOAT,
  ValueAddedCommitmentScore FLOAT,
  StrategicCommitmentScore FLOAT,
  UNIQUE UQ_DistributorCapacityPlanDetail(DistributorCapacityPlanDetailID, AssessmentKPIID),
  PRIMARY KEY(DistributorCapacityPlanDetailKPIID),
  CONSTRAINT `FK_DistributorCapacityPlanDetailKPI_Plan` FOREIGN KEY (`DistributorCapacityPlanDetailID`) REFERENCES `DistributorCapacityPlanDetail` (`DistributorCapacityPlanDetailID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DistributorCapacityPlanDetailKPI_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE GlobalDayOff (
  GlobalDayOffID BIGINT NOT NULL AUTO_INCREMENT,
  Year INT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  DayOfWeek INT,
  DayOfMonth INT,
  MonthOfYear INT,
  PRIMARY KEY(GlobalDayOffID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PersonalDayOff (
  PersonalDayOffID BIGINT NOT NULL AUTO_INCREMENT,
  OwnerID BIGINT NOT NULL,
  Year INT NOT NULL,
  DayOfMonth INT,
  MonthOfYear INT,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  PRIMARY KEY(PersonalDayOffID),
  UNIQUE UQ_PersonalDayOff(OwnerID, DayOfMonth, MonthOfYear, Year),
  CONSTRAINT `FK_PersonalDayOff_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE WorkingPlan (
  WorkingPlanID BIGINT NOT NULL AUTO_INCREMENT,
  OwnerID BIGINT NOT NULL,
  Month INT,
  Year INT,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  Status INT,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  ApprovedBy BIGINT,
  ApprovedDate TIMESTAMP,
  PRIMARY KEY (WorkingPlanID),
  UNIQUE UQ_WorkingPlan(OwnerID, Month, Year),
  CONSTRAINT `FK_WorkingPlan_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlan_Approved` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE WorkingPlanDetail (
  WorkingPlanDetailID BIGINT NOT NULL AUTO_INCREMENT,
  WorkingPlanID BIGINT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  StartTime TIMESTAMP NOT NULL,
  EndTime TIMESTAMP,
  IsFieldDate TINYINT(4),
  AccompanyUserID BIGINT,
  BeLineManage INT,
  ParentID BIGINT NOT NULL,
  Status INT NOT NULL,
  PRIMARY KEY (WorkingPlanDetailID),
  CONSTRAINT `FK_WorkingPlanDetail_WP` FOREIGN KEY (`WorkingPlanID`) REFERENCES `WorkingPlan` (`WorkingPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanDetail_PA` FOREIGN KEY (`ParentID`) REFERENCES `WorkingPlanDetail` (`WorkingPlanDetailID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanDetail_Acc` FOREIGN KEY (`AccompanyUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE WorkingPlanFinal (
  WorkingPlanFinalID BIGINT NOT NULL AUTO_INCREMENT,
  WorkingPlanID BIGINT NOT NULL,
  OwnerID BIGINT NOT NULL,
  Month INT,
  Year INT,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  Status INT,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  ApprovedBy BIGINT,
  ApprovedDate TIMESTAMP,
  PRIMARY KEY (WorkingPlanFinalID),
  UNIQUE UQ_WorkingPlanFinal(OwnerID, Month, Year),
  CONSTRAINT `FK_WorkingPlanFinal_User` FOREIGN KEY (`OwnerID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanFinal_Approved` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanFinal_WP` FOREIGN KEY (`WorkingPlanID`) REFERENCES `WorkingPlan` (`WorkingPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE WorkingPlanDetailFinal (
  WorkingPlanDetailFinalID BIGINT NOT NULL AUTO_INCREMENT,
  WorkingPlanFinalID BIGINT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(512),
  StartTime TIMESTAMP NOT NULL,
  EndTime TIMESTAMP,
  IsFieldDate TINYINT(4),
  IsChange TINYINT(4),
  AccompanyUserID BIGINT,
  PRIMARY KEY (WorkingPlanDetailFinalID),
  CONSTRAINT `FK_WorkingPlanDetailFinal_WP` FOREIGN KEY (`WorkingPlanFinalID`) REFERENCES `WorkingPlanFinal` (`WorkingPlanFinalID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WorkingPlanDetailFinal_Acc` FOREIGN KEY (`AccompanyUserID`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ActionPlan (
  ActionPlanID BIGINT NOT NULL AUTO_INCREMENT,
  Year INT,
  Month INT,
  DistributorID BIGINT,
  AssessmentCapacityID BIGINT NOT NULL,
  Status INT,
  CreatedDate TIMESTAMP NOT NULL,
  CreatedBy BIGINT NOT NULL,
  ModifiedDate TIMESTAMP,
  ModifiedBy BIGINT,

  PRIMARY KEY (ActionPlanID),
  CONSTRAINT `FK_ActionPlan_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_AssCap` FOREIGN KEY (`AssessmentCapacityID`) REFERENCES `AssessmentCapacity` (`AssessmentCapacityID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlan_ModifiedBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE ActionPlanDetail(
  ActionPlanDetailID BIGINT NOT NULL AUTO_INCREMENT,
  ActionPlanID BIGINT NOT NULL,
  AssessmentKPIID BIGINT NOT NULL,
  Plan TEXT,
  Actors VARCHAR(512) NOT NULL,
  EvaluationCriteria TEXT,
  ResultNote TEXT,
  DueDate TIMESTAMP NOT NULL,
  ActualDate TIMESTAMP,
  Status INT,
  PRIMARY KEY (ActionPlanDetailID),
  CONSTRAINT `FK_ActionPlanDetail_ActionPlan` FOREIGN KEY (`ActionPlanID`) REFERENCES `ActionPlan` (`ActionPlanID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActionPlanDetail_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE User ADD COLUMN LiveManagerID BIGINT;
ALTER TABLE User ADD CONSTRAINT FK_User_LiveManager FOREIGN KEY (LiveManagerID) REFERENCES `User`(UserID) ON DELETE SET NULL ON UPDATE NO ACTION;


CREATE TABLE ScoreCardKPICategory (
  ScoreCardKPICategoryID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  Description TEXT,
  DisplayOrder INT,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY(ScoreCardKPICategoryID),
  UNIQUE (Name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCardKPI (
  ScoreCardKPIID BIGINT NOT NULL AUTO_INCREMENT,
  ScoreCardKPICategoryID BIGINT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description TEXT,
  DisplayOrder INT,
  CreatedDate TIMESTAMP  NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY(ScoreCardKPIID),
  UNIQUE (Name, ScoreCardKPICategoryID),
  CONSTRAINT `FK_ScoreCardKPI_Category` FOREIGN KEY (`ScoreCardKPICategoryID`) REFERENCES `ScoreCardKPICategory` (`ScoreCardKPICategoryID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCard (
  ScoreCardID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorID BIGINT NOT NULL,
  Year INT,
  Month INT,
  CreatedBy BIGINT NOT NULL,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedBy BIGINT,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY (ScoreCardID),
  UNIQUE UQ_ScoreCard(DistributorID, Year, Month),
  CONSTRAINT `FK_ScoreCard_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCardDetail (
  ScoreCardDetailID BIGINT NOT NULL AUTO_INCREMENT,
  ScoreCardID BIGINT NOT NULL,
  ScoreCardKPIID BIGINT NOT NULL,
  Target FLOAT,
  Result FLOAT,
  TargetInvestment FLOAT,
  TargetReturn FLOAT,
  ResultInvestment FLOAT,
  ResultReturn FLOAT,
  Field1 FLOAT COMMENT 'Friso in GT6/SE',
  Field2 FLOAT COMMENT 'DL IFT in GT6/NBH',
  Field3 FLOAT COMMENT 'RTDM in GT6 or Merchandisers',
  Field4 FLOAT COMMENT 'WTD of power SKUs (pts)',

  PRIMARY KEY (ScoreCardDetailID),
  UNIQUE UQ_ScoreCardDetail(ScoreCardID, ScoreCardKPIID),
  CONSTRAINT `FK_ScoreCardDetail_ScoreCard` FOREIGN KEY (`ScoreCardID`) REFERENCES `ScoreCard` (`ScoreCardID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardDetail_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCardBestEstimate (
  ScoreCardBestEstimateID BIGINT NOT NULL AUTO_INCREMENT,
  ScoreCardID BIGINT NOT NULL,
  ScoreCardKPIID BIGINT NOT NULL,
  Target FLOAT,
  Result FLOAT,
  TargetInvestment FLOAT,
  TargetReturn FLOAT,
  ResultInvestment FLOAT,
  ResultReturn FLOAT,
  Field1 FLOAT COMMENT 'Friso in GT6/SE',
  Field2 FLOAT COMMENT 'DL IFT in GT6/NBH',
  Field3 FLOAT COMMENT 'RTDM in GT6 or Merchandisers',
  Field4 FLOAT COMMENT 'WTD of power SKUs (pts)',

  PRIMARY KEY (ScoreCardBestEstimateID),
  UNIQUE UQ_ScoreCardBestEstimate(ScoreCardID, ScoreCardKPIID),
  CONSTRAINT `FK_ScoreCardBE_ScoreCard` FOREIGN KEY (`ScoreCardID`) REFERENCES `ScoreCard` (`ScoreCardID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardBE_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCardYear (
  ScoreCardYearID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorID BIGINT NOT NULL,
  Year INT,
  CreatedBy BIGINT NOT NULL,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedBy BIGINT,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY (ScoreCardYearID),
  UNIQUE UQ_ScoreCardYear(DistributorID, Year),
  CONSTRAINT `FK_ScoreCardYear_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ScoreCardYearDetail (
  ScoreCardYearDetailID BIGINT NOT NULL AUTO_INCREMENT,
  ScoreCardYearID BIGINT NOT NULL,
  ScoreCardKPIID BIGINT NOT NULL,
  Target FLOAT,
  Result FLOAT,
  TargetInvestment FLOAT,
  TargetReturn FLOAT,
  ResultInvestment FLOAT,
  ResultReturn FLOAT,
  Field1 FLOAT COMMENT 'Friso in GT6/SE',
  Field2 FLOAT COMMENT 'DL IFT in GT6/NBH',
  Field3 FLOAT COMMENT 'RTDM in GT6 or Merchandisers',
  Field4 FLOAT COMMENT 'WTD of power SKUs (pts)',

  PRIMARY KEY (ScoreCardYearDetailID),
  UNIQUE UQ_ScoreCardYearDetail(ScoreCardYearID, ScoreCardKPIID),
  CONSTRAINT `FK_ScoreCardYearDetail_Year` FOREIGN KEY (`ScoreCardYearID`) REFERENCES `ScoreCardYear` (`ScoreCardYearID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ScoreCardYearDetail_KPI` FOREIGN KEY (`ScoreCardKPIID`) REFERENCES `ScoreCardKPI` (`ScoreCardKPIID`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DistributorCapacityTarget (
  DistributorCapacityTargetID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) NULL,
  Year INT NOT NULL,
  Month INT NOT NULL,
  DistributorID BIGINT NOT NULL,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,

  UNIQUE UQ_DistributorCapacityTarget(DistributorID, Year, Month),
  PRIMARY KEY (DistributorCapacityTargetID),
  CONSTRAINT `FK_DistributorCapacityTarget_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DistributorCapacityTargetDetail (
  DistributorCapacityTargetDetailID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorCapacityTargetID BIGINT NOT NULL,
  AssessmentKPIID BIGINT NOT NULL,
  Score FLOAT,
  Weight FLOAT,

  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,

  UNIQUE UQ_DistributorCapacityTargetDetail(DistributorCapacityTargetID, AssessmentKPIID),
  PRIMARY KEY (DistributorCapacityTargetDetailID),
  CONSTRAINT `FK_TargetDetail_Target` FOREIGN KEY (`DistributorCapacityTargetID`) REFERENCES `DistributorCapacityTarget` (`DistributorCapacityTargetID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_TargetDetail_KPI` FOREIGN KEY (`AssessmentKPIID`) REFERENCES `AssessmentKPI` (`AssessmentKPIID`) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE User
ADD
(
	UserCode VARCHAR(100) NULL,
	CONSTRAINT UQ_UserCode UNIQUE(UserCode)
);

CREATE TABLE WorkingPlanConstant (
  WorkingPlanConstantID BIGINT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Code VARCHAR(100) NOT NULL,
  Value BIGINT NOT NULL,
  PRIMARY KEY (WorkingPlanConstantID)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Report4SAttribute;
CREATE TABLE Report4SAttribute (
  Report4SAttributeID BIGINT NOT NULL AUTO_INCREMENT,
  Field VARCHAR(255) NOT NULL,
  Label VARCHAR(255) NOT NULL,
  TargetValue FLOAT,
  DisplayOrder INT,
  UNIQUE UQ_Report4SAttribute(Field),
  PRIMARY KEY(Report4SAttributeID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Report4S;
CREATE TABLE Report4S (
  Report4SID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorID BIGINT NOT NULL,
  DayOfMonth INT,
  MonthOfYear INT,
  Year INT,
  SMCode VARCHAR(255),
  SECode VARCHAR(255),
  ASMCode VARCHAR(255),
  RSMCode VARCHAR(255),
  PRIMARY KEY (Report4SID),
  UNIQUE UQ_Report4S(DistributorID,SMCode, DayOfMonth, MonthOfYear, Year),
  CONSTRAINT `FK_Report4S_Distributor` FOREIGN KEY (`DistributorID`) REFERENCES `Distributor` (`DistributorID`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Report4SDetail;
CREATE TABLE Report4SDetail (
  Report4SDetailID BIGINT NOT NULL AUTO_INCREMENT,
  Report4SAttributeID BIGINT NOT NULL,
  Report4SID BIGINT NOT NULL,
  Value FLOAT,
  UNIQUE UQ_Report4SDetail(Report4SAttributeID, Report4SID),
  PRIMARY KEY (Report4SDetailID),
  CONSTRAINT FK_Report4SDetail_4S FOREIGN KEY(Report4SID) REFERENCES Report4S(Report4SID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT FK_Report4SDetail_Attribute FOREIGN KEY(Report4SAttributeID) REFERENCES Report4SAttribute(Report4SAttributeID) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS DistributorPerformanceAttribute;
CREATE TABLE DistributorPerformanceAttribute (
  DistributorPerformanceAttributeID BIGINT NOT NULL AUTO_INCREMENT,
  Field VARCHAR(255) NOT NULL,
  Label VARCHAR(255) NOT NULL,
  Weight INT,
  DisplayOrder INT,
  UNIQUE UQ_PerformanceAttribute(Field),
  PRIMARY KEY (DistributorPerformanceAttributeID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS DistributorPerformanceDetail;
CREATE TABLE DistributorPerformanceDetail (
  DistributorPerformanceDetailID BIGINT NOT NULL AUTO_INCREMENT,
  AssessmentCapacityID BIGINT NOT NULL,
  DistributorPerformanceAttributeID BIGINT NOT NULL,
  Value FLOAT,
  UNIQUE UQ_DistributorPerformanceDetail(AssessmentCapacityID, DistributorPerformanceAttributeID),
  PRIMARY KEY (DistributorPerformanceDetailID),
  CONSTRAINT FK_DistributorPerformanceDetail_PerformAtt FOREIGN KEY(DistributorPerformanceAttributeID) REFERENCES DistributorPerformanceAttribute(DistributorPerformanceAttributeID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT FK_DistributorPerformanceDetail_Assessment FOREIGN KEY(AssessmentCapacityID) REFERENCES AssessmentCapacity(AssessmentCapacityID) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS DistributorPerformanceTargetDetail;
CREATE TABLE DistributorPerformanceTargetDetail (
  DistributorPerformanceTargetDetailID BIGINT NOT NULL AUTO_INCREMENT,
  DistributorCapacityTargetID BIGINT NOT NULL,
  DistributorPerformanceAttributeID BIGINT NOT NULL,
  Value FLOAT,
  UNIQUE UQ_DistributorPerformanceTargetDetail(DistributorCapacityTargetID, DistributorPerformanceAttributeID),
  PRIMARY KEY (DistributorPerformanceTargetDetailID),
  CONSTRAINT FK_DistributorPerformanceTargetDetail_PerformAtt FOREIGN KEY(DistributorPerformanceAttributeID) REFERENCES DistributorPerformanceAttribute(DistributorPerformanceAttributeID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT FK_DistributorPerformanceTargetDetail_Assessment FOREIGN KEY(DistributorCapacityTargetID) REFERENCES DistributorCapacityTarget(DistributorCapacityTargetID) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS DistributorAssessmentKeyStrength;
CREATE TABLE DistributorAssessmentKeyStrength (
  DistributorAssessmentKeyStrengthID BIGINT NOT NULL AUTO_INCREMENT,
  AssessmentCapacityID BIGINT NOT NULL,
  DisplayOrder INT,
  Content Text,
  PRIMARY KEY (DistributorAssessmentKeyStrengthID),
  CONSTRAINT FK_DistributorKeyStrength_Assessment FOREIGN KEY(AssessmentCapacityID) REFERENCES AssessmentCapacity(AssessmentCapacityID) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS DistributorAssessmentKeyOpportunity;
CREATE TABLE DistributorAssessmentKeyOpportunity (
  DistributorAssessmentKeyOpportunityID BIGINT NOT NULL AUTO_INCREMENT,
  AssessmentCapacityID BIGINT NOT NULL,
  DisplayOrder INT,
  Content Text,
  PRIMARY KEY (DistributorAssessmentKeyOpportunityID),
  CONSTRAINT FK_DistributorKeyOpp_Assessment FOREIGN KEY(AssessmentCapacityID) REFERENCES AssessmentCapacity(AssessmentCapacityID) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `WorkingPlanLineManager`;
CREATE TABLE `WorkingPlanLineManager` (
  `WorkingPlanLineManagerID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Content` varchar(512) DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Period` int NOT NULL ,
  `CreatedBy` bigint(20) NOT NULL,
  PRIMARY KEY (`WorkingPlanLineManagerID`),
  KEY `FK_WorkingPlanLineManager_User` (`CreatedBy`),
  CONSTRAINT `FK_WorkingPlanLineManager_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `WorkingPlanLineManagerAttendance`;
CREATE TABLE `WorkingPlanLineManagerAttendance` (
  `WorkingPlanLineManagerAttendanceID` bigint(20) NOT NULL AUTO_INCREMENT,
  `InvitedUserID` bigint(20) NOT NULL,
  `WorkingPlanLineManagerID` bigint(20) NOT NULL,
  PRIMARY KEY (`WorkingPlanLineManagerAttendanceID`),
  UNIQUE KEY `UQ_WorkingPlanLineManagerAttendance` (`InvitedUserID`,`WorkingPlanLineManagerAttendanceID`),
  KEY `FK_WPLMA_WPL` (`WorkingPlanLineManagerID`),
  CONSTRAINT `FK_WPLMA_WPL` FOREIGN KEY (`WorkingPlanLineManagerID`) REFERENCES `WorkingPlanLineManager` (`WorkingPlanLineManagerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WPLMA_User` FOREIGN KEY (`InvitedUserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;

INSERT INTO `DistributorLevel` VALUES (1, 'Logistic', 'Lowest Level', NOW(), NULL);
INSERT INTO `DistributorLevel` VALUES (2, 'Value Added', 'Normal Level', NOW(), NULL);
INSERT INTO `DistributorLevel` VALUES (3, 'Strategic', 'Highest Level', NOW(), NULL);

ALTER TABLE `ScoreCardDetail` ADD COLUMN `TargetRolling` FLOAT DEFAULT NULL;
ALTER TABLE `ScoreCardBestEstimate` ADD COLUMN `TargetRolling` FLOAT DEFAULT NULL;
ALTER TABLE `ScoreCardYearDetail` ADD COLUMN `TargetRolling` FLOAT DEFAULT NULL;

ALTER TABLE `ScoreCard` ADD COLUMN `Status` INT DEFAULT NULL;
ALTER TABLE `ScoreCard` ADD COLUMN `ApprovedBy` BIGINT DEFAULT NULL;
ALTER TABLE `ScoreCard` ADD COLUMN `ApprovedDate` TIMESTAMP NULL;


ALTER TABLE `ScoreCard` ADD CONSTRAINT `FK_ScoreCard_Approved`
FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `ScoreCardYear` ADD COLUMN `Status` INT DEFAULT NULL;
ALTER TABLE `ScoreCardYear` ADD COLUMN `ApprovedBy` BIGINT DEFAULT NULL;
ALTER TABLE `ScoreCardYear` ADD COLUMN `ApprovedDate` TIMESTAMP NULL;

ALTER TABLE `ScoreCardYear` ADD CONSTRAINT `FK_ScoreCardYear_Approved`
FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `ScoreCard`
DROP INDEX `UQ_ScoreCard`
, ADD UNIQUE INDEX `UQ_ScoreCard` (`DistributorID`, `Year`,`Month`, `CreatedBy`) ;

ALTER TABLE `ScoreCardYear`
DROP INDEX `UQ_ScoreCardYear`
, ADD UNIQUE INDEX `UQ_ScoreCardYear` (`DistributorID`, `Year`, `CreatedBy`) ;

ALTER TABLE `UserRole` ADD COLUMN `IsInstructor` TINYINT DEFAULT NULL;

ALTER TABLE ScoreCardKPI ADD COLUMN EvaluationType VARCHAR(255) DEFAULT NULL,
ADD COLUMN CompareType VARCHAR(255) DEFAULT NULL;








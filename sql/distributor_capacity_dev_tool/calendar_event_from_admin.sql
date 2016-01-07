CREATE TABLE WorkingPlanLineManager (
  WorkingPlanLineManagerID BIGINT NOT NULL AUTO_INCREMENT,
  Title VARCHAR(255) NOT NULL,
  Content VARCHAR(512),
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,
  CreatedBy BIGINT NOT NULL,
  PRIMARY KEY (WorkingPlanLineManagerID),
  CONSTRAINT `FK_WorkingPlanLineManager_User` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE WorkingPlanLineManagerAttendance (
  WorkingPlanLineManagerAttendanceID BIGINT NOT NULL AUTO_INCREMENT,
  InvitedUserID BIGINT NOT NULL,
  WorkingPlanLineManagerID BIGINT NOT NULL,
  PRIMARY KEY (WorkingPlanLineManagerAttendanceID),
  UNIQUE UQ_WorkingPlanLineManagerAttendance(InvitedUserID, WorkingPlanLineManagerAttendanceID),
  CONSTRAINT `FK_WPLMA_WPL` FOREIGN KEY (`WorkingPlanLineManagerID`) REFERENCES `WorkingPlanLineManager` (`WorkingPlanLineManagerID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_WPLMA_User` FOREIGN KEY (`InvitedUserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8;
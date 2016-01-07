DELIMITER //

START TRANSACTION//

DROP PROCEDURE IF EXISTS `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`//
CREATE PROCEDURE `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`()
BEGIN
	DECLARE varOARFullRangeSKUID1, varOARFullRangeSKUID2, varFullRangeID, varOutletAuditResultID, varTempID BIGINT;
	DECLARE stopIndex1, stopIndex2, stopIndex3 INT;
	DECLARE tempOARID, tempOARResultID, tempFullRangeID BIGINT;
	DECLARE tempFacing INT;

	DECLARE cur_OARFullRangeSKUID1 CURSOR FOR
	SELECT r1.OARFullRangeSKUID FROM `FCVAuditData`.`OARFullRangeSKU` r1, `FCVAuditData`.`OARFullRangeSKU` r2
	WHERE r1.OARFullRangeSKUID <> r2.OARFullRangeSKUID and r1.FullRangeID = r2.FullRangeID and r1.OutletAuditResultID = r2.OutletAuditResultID;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET stopIndex1 = 1;
SET stopIndex1 = 0;

create table temp_tb__(
  OARFullRangeSKUID BIGINT,
  OutletAuditResultID BIGINT,
  FullRangeID BIGINT,
  Facing INT,
  PRIMARY KEY (OARFullRangeSKUID)
);
create TEMPORARY table temp_tb2__(
  OARFullRangeSKUID BIGINT

);

OPEN cur_OARFullRangeSKUID1;
REPEAT
	FETCH cur_OARFullRangeSKUID1 INTO varOARFullRangeSKUID1;
		SELECT FullRangeID INTO varFullRangeID FROM `FCVAuditData`.`OARFullRangeSKU` WHERE OARFullRangeSKUID = varOARFullRangeSKUID1;
		SELECT OutletAuditResultID INTO varOutletAuditResultID FROM `FCVAuditData`.`OARFullRangeSKU` WHERE OARFullRangeSKUID = varOARFullRangeSKUID1;
	IF stopIndex1 != 1 AND NOT EXISTS(SELECT 1 FROM temp_tb__ t WHERE t.OARFullRangeSKUID = varOARFullRangeSKUID1) AND varFullRangeID IS NOT NULL THEN
	BEGIN
		DECLARE cur_OARFullRangeSKUID2 CURSOR FOR
		SELECT r1.OARFullRangeSKUID FROM `FCVAuditData`.`OARFullRangeSKU` r1
		WHERE r1.OARFullRangeSKUID <> varOARFullRangeSKUID1 and r1.FullRangeID = varFullRangeID and r1.OutletAuditResultID = varOutletAuditResultID;
		DECLARE CONTINUE HANDLER FOR NOT FOUND
			SET stopIndex2 = 1;
		SET stopIndex2 = 0;

		insert into temp_tb2__(OARFullRangeSKUID) values(tempOARID); -- remain OARFullRangeSKUID
		OPEN cur_OARFullRangeSKUID2;
		REPEAT
			FETCH cur_OARFullRangeSKUID2 INTO varOARFullRangeSKUID2;
			IF stopIndex2 != 1 AND NOT EXISTS(SELECT 1 FROM temp_tb2__ t2 WHERE t2.OARFullRangeSKUID = varOARFullRangeSKUID2) THEN
			BEGIN
				SELECT OARFullRangeSKUID, OutletAuditResultID, FullRangeID, Facing  INTO tempOARID, tempOARResultID, tempFullRangeID, tempFacing FROM `FCVAuditData`.`OARFullRangeSKU` WHERE OARFullRangeSKUID = varOARFullRangeSKUID2;
				insert into temp_tb__(OARFullRangeSKUID, OutletAuditResultID, FullRangeID, Facing) values(tempOARID, tempOARResultID, tempFullRangeID, tempFacing); -- remain OARFullRangeSKUID
			END;
			END IF;
		UNTIL stopIndex2 = 1
		END REPEAT;
		CLOSE cur_OARFullRangeSKUID2;
	END;
	END IF;
UNTIL stopIndex1 = 1
END REPEAT;
CLOSE cur_OARFullRangeSKUID1;

DELETE FROM `FCVAuditData`.`OARFullRangeSKU` WHERE OARFullRangeSKUID IN(SELECT OARFullRangeSKUID FROM temp_tb__) AND OARFullRangeSKUID NOT IN (SELECT OARFullRangeSKUID FROM temp_tb2__);

DROP TEMPORARY table temp_tb2__;

END //
CALL `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`()//
DROP PROCEDURE `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`//

COMMIT//

DELIMITER ;